-- Check and Fix Database for Login Issues
-- Run this in phpMyAdmin or MySQL command line

-- 1. Check if database exists
SHOW DATABASES LIKE 'sarthak_db';

-- 2. Use the database
USE sarthak_db;

-- 3. Check if users table exists
SHOW TABLES LIKE 'users';

-- 4. Check table structure
DESCRIBE users;

-- 5. Check if any users exist
SELECT COUNT(*) as total_users FROM users;

-- 6. Check for specific user
SELECT id, full_name, email, role, 
       LEFT(password_hash, 20) as hash_preview,
       created_at
FROM users 
WHERE email = 'shahsujit502@gmail.com';

-- 7. List all users
SELECT id, full_name, email, role, created_at 
FROM users 
ORDER BY created_at DESC;

-- 8. If users table doesn't exist, create it
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role ENUM('job_seeker', 'employer') NOT NULL DEFAULT 'job_seeker',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_email (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 9. Test insert (will fail if user already exists)
-- Uncomment and modify if you want to manually create a test user
-- INSERT INTO users (full_name, email, password_hash, role) 
-- VALUES ('Test User', 'test@example.com', '$2a$10$abcdefghijklmnopqrstuvwxyz', 'job_seeker');

-- 10. Check for duplicate emails (case-insensitive)
SELECT email, COUNT(*) as count 
FROM users 
GROUP BY LOWER(email) 
HAVING count > 1;

-- 11. Verify password hash format
SELECT 
    email,
    CASE 
        WHEN password_hash LIKE '$2a$%' THEN 'BCrypt (OK)'
        WHEN password_hash LIKE '$2b$%' THEN 'BCrypt (OK)'
        ELSE 'INVALID - Not BCrypt!'
    END as hash_status,
    LENGTH(password_hash) as hash_length
FROM users;
