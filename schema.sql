-- Sarthak Job Portal | Production-Ready Schema
CREATE DATABASE IF NOT EXISTS sarthak_db;
USE sarthak_db;

-- 1. Admins Table
CREATE TABLE IF NOT EXISTS admins (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    full_name VARCHAR(100),
    last_login TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. Users Table
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    user_type ENUM('seeker', 'employer') NOT NULL,
    status ENUM('active', 'suspended') DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3. Jobs Table
CREATE TABLE IF NOT EXISTS jobs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    company_name VARCHAR(100) NOT NULL,
    salary VARCHAR(50),
    status ENUM('pending', 'approved', 'rejected') DEFAULT 'pending',
    posted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 4. Audit Logs
CREATE TABLE IF NOT EXISTS system_logs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    action TEXT NOT NULL,
    performed_by VARCHAR(50),
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 5. ONLY INITIAL ADMIN (No Demo Users)
INSERT INTO admins (username, password, full_name) VALUES 
('admin', 'admin123', 'Sarthak Head Office');

INSERT INTO system_logs (action, performed_by) VALUES 
('System Initialized - Ready for Real Users', 'system');
