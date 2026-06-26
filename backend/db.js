import mysql from 'mysql2/promise';
import dotenv from 'dotenv';
import path from 'path';
import { fileURLToPath } from 'url';

// Explicitly load .env here to ensure process.env is populated before creating the pool.
// This fixes issues where imports are hoisted before dotenv.config() in the entry file.
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
dotenv.config({ path: path.join(__dirname, '.env') });

// Create a connection pool. This is more efficient than creating a new connection for every query.
const pool = mysql.createPool({
  host: process.env.DB_HOST || 'localhost',
  user: process.env.DB_USER || 'root',
  password: process.env.DB_PASSWORD || '',
  database: process.env.DB_NAME || 'rizkitechbill',
  port: process.env.DB_PORT || 3306,
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0
});

// We removed the immediate connection test here to allow migrate.js to handle 
// database creation if the database doesn't exist yet.

export default pool;