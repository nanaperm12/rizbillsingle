import React from 'react';
import { AdminUser, TechnicianPage } from '~/types';

// Mock components for demonstration
const ComplaintsPage = () => <div>Technician Complaints Page</div>;
const MapPage = () => <div>Technician Map Page</div>;
const Dashboard = () => <div>Technician Dashboard</div>;

interface TechnicianDashboardProps {
    user: AdminUser;
    page: TechnicianPage;
    setPage: (page: TechnicianPage) => void;
    onLogout: () => void;
}

const TechnicianDashboard: React.FC<TechnicianDashboardProps> = ({ user, page, onLogout }) => {
    const renderPage = () => {
        switch (page) {
            case 'complaints': return <ComplaintsPage />;
            case 'map': return <MapPage />;
            default: return <Dashboard />;
        }
    };

    return <div><h1>Technician Dashboard for {user.username}</h1><button onClick={onLogout}>Logout</button>{renderPage()}</div>;
};

export default TechnicianDashboard;