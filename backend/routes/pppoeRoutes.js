import express from 'express';
import pool from '../db.js';
import mikrotikApi from '../mikrotik-api.js';

const router = express.Router();

const formatActivePppoeUsers = (users) => {
    if (!Array.isArray(users)) return [];
    return users.map(user => ({
        id: user['.id'],
        name: user.name,
        service: user.service,
        callerId: user['caller-id'],
        address: user.address,
        uptime: user.uptime,
    }));
};

// --- PPPoE Active Connections (Live from Router) ---
router.get('/active', async (req, res) => {
    try {
        const activeUsers = await mikrotikApi.fetchActivePppoeConnections();
        res.json(formatActivePppoeUsers(activeUsers));
    } catch (error) {
        res.status(500).json({ message: error.message || 'Failed to fetch active PPPoE connections.' });
    }
});

router.post('/active/:id/kick', async (req, res) => {
    try {
        const activeId = decodeURIComponent(req.params.id || '');

        if (typeof mikrotikApi.removeActivePppoeConnection === 'function') {
            await mikrotikApi.removeActivePppoeConnection(activeId);
        } else {
            // Fallback for older runtime build: resolve session by id, then reconnect by username.
            const activeSessions = await mikrotikApi.fetchActivePppoeConnections();
            const session = Array.isArray(activeSessions)
                ? activeSessions.find(s => String(s['.id'] || s.id || '') === activeId)
                : null;

            if (!session?.name) {
                throw new Error('Active PPPoE session not found.');
            }

            await mikrotikApi.reconnectPppoeUser(session.name);
        }

        // Give router a moment to update its list
        await new Promise(resolve => setTimeout(resolve, 1000));
        const activeUsers = await mikrotikApi.fetchActivePppoeConnections();
        res.json(formatActivePppoeUsers(activeUsers));
    } catch (error) {
        res.status(500).json({ message: error.message || 'Failed to kick user.' });
    }
});


// --- PPPoE Users (Cached in DB, actions are live) ---

// GET all users from the local database
router.get('/users', async (req, res) => {
    try {
        // 1. Fetch cached users from the DB.
        const [dbUsers] = await pool.query('SELECT * FROM pppoe_users');
        
        // 2. Fetch live active connections from the router.
        const activeConnections = await mikrotikApi.fetchActivePppoeConnections();
        const activeUsernames = new Set(activeConnections.map(c => c.name));

        // 3. Merge live status with cached data.
        const mergedUsers = dbUsers.map(user => ({
            ...user,
            disabled: user.disabled === 1, // Convert TINYINT to boolean
            active: activeUsernames.has(user.name)
        }));

        res.json(mergedUsers);
    } catch (error) {
        console.error("Get PPPoE Users from DB Error:", error);
        res.status(500).json({ message: error.message || 'Failed to fetch PPPoE users from database.' });
    }
});

// POST a new user (Router and DB)
router.post('/users', async (req, res) => {
    const connection = await pool.getConnection();
    try {
        await connection.beginTransaction();
        const mikrotikResponse = await mikrotikApi.addPppoeUser(req.body);
        const newUserId = mikrotikResponse[0].ret;

        const newUser = {
            id: newUserId,
            name: req.body.name,
            password: req.body.password,
            service: 'pppoe',
            profile: req.body.profile,
            comment: req.body.comment || '',
            disabled: 0,
        };
        await connection.query('INSERT INTO pppoe_users SET ?', newUser);
        await connection.commit();
        
        const [allUsers] = await pool.query('SELECT * FROM pppoe_users');
        res.status(201).json(allUsers.map(u => ({ ...u, disabled: u.disabled === 1 })));
    } catch (error) {
        await connection.rollback();
        console.error("Add PPPoE User Error:", error);
        res.status(500).json({ message: error.message || 'Failed to add PPPoE user.' });
    } finally {
        connection.release();
    }
});

// PUT update a user (Router and DB)
router.put('/users/:id', async (req, res) => {
    try {
        await mikrotikApi.updatePppoeUser(req.params.id, req.body);
        const { name, password, profile, comment } = req.body;
        const fieldsToUpdate = { name, profile, comment };
        if (password) fieldsToUpdate.password = password;
        
        await pool.query('UPDATE pppoe_users SET ? WHERE id = ?', [fieldsToUpdate, req.params.id]);

        const [allUsers] = await pool.query('SELECT * FROM pppoe_users');
        res.json(allUsers.map(u => ({ ...u, disabled: u.disabled === 1 })));
    } catch (error) {
        res.status(500).json({ message: error.message || 'Failed to update PPPoE user.' });
    }
});

// DELETE a single user (Router and DB)
router.delete('/users/:id', async (req, res) => {
    try {
        await mikrotikApi.deletePppoeUser(req.params.id);
        await pool.query('DELETE FROM pppoe_users WHERE id = ?', [req.params.id]);
        
        const [allUsers] = await pool.query('SELECT * FROM pppoe_users');
        res.json(allUsers.map(u => ({ ...u, disabled: u.disabled === 1 })));
    } catch (error) {
        res.status(500).json({ message: error.message || 'Failed to delete PPPoE user.' });
    }
});


// POST reconnect a user (Router only, then refetch from DB)
router.post('/users/:username/reconnect', async (req, res) => {
    try {
        await mikrotikApi.reconnectPppoeUser(req.params.username);
        await new Promise(resolve => setTimeout(resolve, 1500));
        
        // After action, send back the updated state from the DB + Live status
        const [dbUsers] = await pool.query('SELECT * FROM pppoe_users');
        const activeConnections = await mikrotikApi.fetchActivePppoeConnections();
        const activeUsernames = new Set(activeConnections.map(c => c.name));
        const mergedUsers = dbUsers.map(user => ({
            ...user,
            disabled: user.disabled === 1,
            active: activeUsernames.has(user.name)
        }));
        res.json(mergedUsers);
    } catch (error) {
        res.status(500).json({ message: error.message || 'Failed to reconnect user.' });
    }
});


// POST enable/disable a single user (Router and DB)
router.post('/users/:id/:action(enable|disable)', async (req, res) => {
    const { id, action } = req.params;
    try {
        const isDisabled = action === 'disable';
        if (isDisabled) {
            await mikrotikApi.disablePppoeUser(id);
        } else if (action === 'enable') {
            await mikrotikApi.enablePppoeUser(id);
        } else {
            return res.status(400).json({ message: 'Invalid action.' });
        }
        await pool.query('UPDATE pppoe_users SET disabled = ? WHERE id = ?', [isDisabled ? 1 : 0, id]);
        
        const [allUsers] = await pool.query('SELECT * FROM pppoe_users');
        res.json(allUsers.map(u => ({ ...u, disabled: u.disabled === 1 })));
    } catch (error) {
        res.status(500).json({ message: error.message || `Failed to ${action} user.` });
    }
});


// POST bulk action (enable/disable on Router and DB)
router.post('/users/bulk-action', async (req, res) => {
    const { action, ids } = req.body;
    if (!['enable', 'disable'].includes(action) || !Array.isArray(ids) || ids.length === 0) {
        return res.status(400).json({ message: 'A valid action and an array of user IDs are required.' });
    }
    try {
        const isDisabled = action === 'disable';
        for (const id of ids) {
            if (isDisabled) {
                await mikrotikApi.disablePppoeUser(id);
            } else {
                await mikrotikApi.enablePppoeUser(id);
            }
        }
        await pool.query('UPDATE pppoe_users SET disabled = ? WHERE id IN (?)', [isDisabled ? 1 : 0, ids]);
        
        const [allUsers] = await pool.query('SELECT * FROM pppoe_users');
        res.json(allUsers.map(u => ({ ...u, disabled: u.disabled === 1 })));
    } catch (error) {
        res.status(500).json({ message: error.message || `Failed to perform bulk ${action}.` });
    }
});

// POST for bulk-delete users (Router and DB)
router.post('/users/bulk-delete', async (req, res) => {
    const { ids } = req.body;
    if (!Array.isArray(ids) || ids.length === 0) {
        return res.status(400).json({ message: 'An array of user IDs is required for bulk deletion.' });
    }
    try {
        for (const id of ids) {
            await mikrotikApi.deletePppoeUser(id);
        }
        await pool.query('DELETE FROM pppoe_users WHERE id IN (?)', [ids]);
        
        const [allUsers] = await pool.query('SELECT * FROM pppoe_users');
        res.json(allUsers.map(u => ({ ...u, disabled: u.disabled === 1 })));
    } catch (error) {
        res.status(500).json({ message: error.message || 'Failed to perform bulk delete.' });
    }
});

// --- Sync (The core of the new logic) ---
router.post('/sync', async (req, res) => {
    console.log("[PPPoE Sync] Starting sync with router...");
    const connection = await pool.getConnection();
    try {
        const routerUsers = await mikrotikApi.fetchPppoeUsers();
        if (!Array.isArray(routerUsers)) {
            throw new Error("Failed to fetch a valid user list from the router.");
        }

        await connection.beginTransaction();
        // A simple and robust strategy: clear the cache and repopulate it.
        await connection.query('TRUNCATE TABLE pppoe_users');
        
        if (routerUsers.length > 0) {
            const usersToInsert = routerUsers.map(u => ({
                id: u.id,
                name: u.name,
                password: u.password,
                service: u.service,
                profile: u.profile,
                comment: u.comment,
                disabled: u.disabled ? 1 : 0,
            }));
            const columns = Object.keys(usersToInsert[0]);
            const values = usersToInsert.map(item => columns.map(col => item[col]));
            await connection.query(`INSERT INTO pppoe_users (${columns.join(',')}) VALUES ?`, [values]);
        }
        
        await connection.commit();
        console.log(`[PPPoE Sync] Sync complete. Synced ${routerUsers.length} users.`);
        res.json({ success: true, message: `Synced ${routerUsers.length} users successfully.` });
    } catch (error) {
        await connection.rollback();
        console.error("[PPPoE Sync] Error:", error);
        res.status(500).json({ success: false, message: error.message });
    } finally {
        connection.release();
    }
});

// --- PPPoE Profiles (These can remain live as they are small and rarely change) ---
router.get('/profiles', async (req, res) => {
    try {
        const profiles = await mikrotikApi.fetchPppoeProfiles();
        res.json(profiles);
    } catch (error) {
        res.status(500).json({ message: error.message || 'Failed to fetch PPPoE profiles.' });
    }
});

router.post('/profiles', async (req, res) => {
    try {
        await mikrotikApi.addPppoeProfile(req.body);
        res.status(201).json(await mikrotikApi.fetchPppoeProfiles());
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
});

router.put('/profiles/:id', async (req, res) => {
    try {
        await mikrotikApi.updatePppoeProfile(req.params.id, req.body);
        res.json(await mikrotikApi.fetchPppoeProfiles());
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
});

router.delete('/profiles/:id', async (req, res) => {
    try {
        await mikrotikApi.deletePppoeProfile(req.params.id);
        res.json(await mikrotikApi.fetchPppoeProfiles());
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
});


export default router;
