-- ============================================================
--  JOB PORTAL DATABASE (MariaDB / XAMPP)
-- ============================================================

CREATE DATABASE IF NOT EXISTS sarthak_db
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE sarthak_db;

-- ============================================================
--  USERS TABLE
-- ============================================================
CREATE TABLE IF NOT EXISTS users (
                                     id INT AUTO_INCREMENT PRIMARY KEY,
                                     full_name VARCHAR(150) NOT NULL,
                                     email VARCHAR(255) NOT NULL UNIQUE,
                                     password VARCHAR(255) NOT NULL,
                                     role ENUM('job_seeker', 'employer') NOT NULL DEFAULT 'job_seeker',
                                     created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                                     INDEX idx_email (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ============================================================
--  AUTHENTICATION QUERIES (USE IN JAVA JDBC ONLY)
-- ============================================================

-- Register User
-- INSERT INTO users (full_name, email, password, role)
-- VALUES (?, ?, ?, ?);

-- Login User
-- SELECT id, full_name, email, password, role, created_at
-- FROM users
-- WHERE email = ?;

-- Check Email Exists
-- SELECT COUNT(*) FROM users WHERE email = ?;

-- Get User by ID
-- SELECT id, full_name, email, role, created_at
-- FROM users
-- WHERE id = ?;