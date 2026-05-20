
DROP DATABASE IF EXISTS sarthak_db;
CREATE DATABASE sarthak_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE sarthak_db;

-- 1. USERS TABLE
CREATE TABLE users (
    id            INT AUTO_INCREMENT PRIMARY KEY,
    full_name     VARCHAR(150)  NOT NULL,
    email         VARCHAR(255)  NOT NULL UNIQUE,
    password_hash VARCHAR(255)  NOT NULL,
    role          ENUM('job_seeker','employer') NOT NULL DEFAULT 'job_seeker',
    user_type     VARCHAR(50)   NOT NULL DEFAULT 'job_seeker',
    status        VARCHAR(50)   NOT NULL DEFAULT 'active',
    created_at    TIMESTAMP     DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_email (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 2. ADMINS TABLE (Standalone Admin Panel)
-- This must be created before tables that reference it
CREATE TABLE admins (
    id         INT AUTO_INCREMENT PRIMARY KEY,
    username   VARCHAR(50)  NOT NULL UNIQUE,
    password   VARCHAR(255) NOT NULL,
    full_name  VARCHAR(100),
    last_login TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 3. CATEGORIES TABLE
CREATE TABLE categories (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    name        VARCHAR(100) NOT NULL UNIQUE,
    description TEXT         DEFAULT NULL,
    created_at  TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
    created_by_admin_id INT   DEFAULT NULL,
    FOREIGN KEY (created_by_admin_id) REFERENCES admins(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 4. INTERVIEW TEMPLATES TABLE
CREATE TABLE interview_templates (
    id         INT AUTO_INCREMENT PRIMARY KEY,
    name       VARCHAR(100) NOT NULL,
    stages     JSON         DEFAULT NULL,
    created_at TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
    created_by_admin_id INT DEFAULT NULL,
    FOREIGN KEY (created_by_admin_id) REFERENCES admins(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 5. JOBS TABLE
CREATE TABLE jobs (
    id           INT AUTO_INCREMENT PRIMARY KEY,
    employer_id  INT           DEFAULT NULL,
    title        VARCHAR(200)  NOT NULL,
    description  TEXT          DEFAULT NULL,
    company_name VARCHAR(150)  DEFAULT NULL,
    location     VARCHAR(100)  DEFAULT NULL,
    salary       VARCHAR(50)   DEFAULT NULL,
    salary_range VARCHAR(100)  DEFAULT NULL,
    job_type     VARCHAR(50)   DEFAULT NULL,
    status       VARCHAR(50)   NOT NULL DEFAULT 'pending',
    deadline     DATE          DEFAULT NULL,
    posted_at    TIMESTAMP     DEFAULT CURRENT_TIMESTAMP,
    category_id  INT           DEFAULT NULL,
    INDEX idx_employer (employer_id),
    INDEX idx_status   (status),
    FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 6. CANDIDATES TABLE
CREATE TABLE candidates (
    id               INT AUTO_INCREMENT PRIMARY KEY,
    name             VARCHAR(100) NOT NULL,
    email            VARCHAR(100) NOT NULL UNIQUE,
    phone            VARCHAR(20)  DEFAULT NULL,
    resume_path      VARCHAR(255) DEFAULT NULL,
    experience_level ENUM('entry_level','intermediate','senior','expert') DEFAULT 'entry_level',
    status           VARCHAR(50)  NOT NULL DEFAULT 'applied',
    video_url        VARCHAR(255) DEFAULT NULL,
    applied_date     TIMESTAMP    DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 7. APPLICATIONS TABLE
CREATE TABLE applications (
    id           INT AUTO_INCREMENT PRIMARY KEY,
    job_id       INT  DEFAULT NULL,
    candidate_id INT  DEFAULT NULL,
    status       ENUM('applied','screened','interviewed','hired','rejected') DEFAULT 'applied',
    notes        TEXT DEFAULT NULL,
    applied_at   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (job_id)       REFERENCES jobs(id)       ON DELETE SET NULL,
    FOREIGN KEY (candidate_id) REFERENCES candidates(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 8. INTERVIEWS TABLE
CREATE TABLE interviews (
    id             INT AUTO_INCREMENT PRIMARY KEY,
    application_id INT  DEFAULT NULL,
    scheduled_at   DATETIME DEFAULT NULL,
    interviewer    VARCHAR(100) DEFAULT NULL,
    status         ENUM('scheduled','completed','cancelled') DEFAULT 'scheduled',
    feedback       TEXT DEFAULT NULL,
    template_id    INT  DEFAULT NULL,
    FOREIGN KEY (application_id) REFERENCES applications(id) ON DELETE CASCADE,
    FOREIGN KEY (template_id)    REFERENCES interview_templates(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 9. SYSTEM_LOGS TABLE
CREATE TABLE system_logs (
    id           INT AUTO_INCREMENT PRIMARY KEY,
    action       TEXT         NOT NULL,
    performed_by VARCHAR(100) DEFAULT NULL,
    performed_by_id INT       DEFAULT NULL,
    performed_by_admin_id INT DEFAULT NULL,
    timestamp    TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (performed_by_id) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (performed_by_admin_id) REFERENCES admins(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- 11. NOTIFICATIONS TABLE
CREATE TABLE notifications (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    user_id     INT NOT NULL,
    from_user_id INT,
    type        VARCHAR(50) NOT NULL, 
    title       VARCHAR(200),
    body        TEXT,
    link_url    VARCHAR(500),
    is_read     BOOLEAN DEFAULT FALSE,
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ============================================================
--  SAMPLE DATA INSERTION
-- ============================================================

-- Admin User
INSERT INTO users (full_name, email, password_hash, role, user_type, status)
VALUES ('Admin', 'admin@gmail.com', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', 'job_seeker', 'admin', 'active');

INSERT INTO admins (id, username, password, full_name) VALUES (1, 'admin', 'admin123', 'Sarthak Admin');

-- Categories
INSERT INTO categories (id, name, description, created_by_admin_id) VALUES
(1, 'Information Technology', 'Software, hardware, and IT services', 1),
(2, 'Finance', 'Banking, accounting, and financial services', 1),
(3, 'Marketing', 'Digital marketing, branding, and advertising', 1);

-- Templates
INSERT INTO interview_templates (id, name, stages, created_by_admin_id) VALUES
(1, 'Standard Technical Round', '["Coding", "System Design", "HR"]', 1);

-- Jobs
INSERT INTO jobs (id, title, company_name, location, salary, status, category_id) VALUES
(1, 'Java Backend Developer', 'Sarthak IT Solutions', 'Kathmandu', 'Rs. 60,000 - 90,000', 'approved', 1),
(2, 'React Frontend Developer', 'Sarthak IT Solutions', 'Lalitpur', 'Rs. 50,000 - 80,000', 'approved', 1),
(3, 'DevOps Engineer', 'Sarthak IT Solutions', 'Kathmandu', 'Rs. 80,000 - 120,000', 'approved', 1);

-- Candidates
INSERT INTO candidates (id, name, email, phone, experience_level, status) VALUES
(1, 'Nischal giri', 'nischal@example.com', '9841000001', 'intermediate', 'applied'),
(2, 'Ashmit dev', 'ashmit@example.com', '9841000002', 'senior', 'shortlisted');

-- Applications
INSERT INTO applications (id, job_id, candidate_id, status) VALUES
(1, 1, 1, 'screened'),
(2, 1, 2, 'screened');

-- Interviews
INSERT INTO interviews (id, application_id, scheduled_at, interviewer, status, template_id) VALUES
(1, 1, '2026-05-10 10:00:00', 'Sujit Shah', 'scheduled', 1),
(2, 2, '2026-05-11 14:00:00', 'Samir Thapa', 'scheduled', 1);

-- Notifications
INSERT INTO notifications (user_id, title, body, type, link_url) VALUES
(1, 'System Boot', 'Database successfully initialized and synced.', 'system', 'admin?action=dashboard');

-- Log
INSERT INTO system_logs (action, performed_by, performed_by_id, performed_by_admin_id)
VALUES ('Database initialized — Sarthak Job Portal ready.', 'system', 1, 1);


-- FRIEND_SCHEMA --
USE sarthak_db;

CREATE TABLE IF NOT EXISTS friend_requests (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    sender_id   INT NOT NULL,
    receiver_id INT NOT NULL,
    status      VARCHAR(20) DEFAULT 'pending', -- 'pending', 'accepted', 'rejected'
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (sender_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (receiver_id) REFERENCES users(id) ON DELETE CASCADE,
    UNIQUE KEY unique_request (sender_id, receiver_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS friends (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    user_id1    INT NOT NULL,
    user_id2    INT NOT NULL,
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id1) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id2) REFERENCES users(id) ON DELETE CASCADE,
    UNIQUE KEY unique_friendship (user_id1, user_id2)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- MESSAGING_SCHEMA --
-- Schema for Real-time Messaging System
USE sarthak_db;

CREATE TABLE IF NOT EXISTS messages (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    sender_id   INT NOT NULL,
    receiver_id INT NOT NULL,
    job_id      INT DEFAULT NULL,
    subject     VARCHAR(200) DEFAULT 'Chat Message',
    body        TEXT NOT NULL,
    is_read     BOOLEAN DEFAULT FALSE,
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (sender_id)   REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (receiver_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_sender (sender_id),
    INDEX idx_receiver (receiver_id),
    INDEX idx_conversation (sender_id, receiver_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Sample messages for testing
INSERT INTO messages (sender_id, receiver_id, body) VALUES 
(1, 1, 'Welcome to Sarthak Messaging!'),
(1, 2, 'Hi, I saw your job posting for the Java Developer role.'),
(2, 1, 'Hello! Yes, we are still looking for candidates. Do you have any experience with Spring Boot?');


-- UPDATE_PROFILE_SCHEMA --
-- User profile persistence
-- Run this on sarthak_db if your tables were created before profile images/resumes were added.

-- Allow larger image/resume BLOB uploads for this MySQL server.
-- If this fails, run it as root/admin or set max_allowed_packet=64M in my.ini.
SET GLOBAL max_allowed_packet = 67108864;

-- Run ADD only when the column does not exist; run MODIFY when it already exists.
ALTER TABLE users ADD COLUMN profile_image LONGBLOB NULL;
ALTER TABLE users MODIFY COLUMN profile_image LONGBLOB NULL;

ALTER TABLE users ADD COLUMN cover_image LONGBLOB NULL;
ALTER TABLE users MODIFY COLUMN cover_image LONGBLOB NULL;

-- Create user_profiles table for extended profile data
CREATE TABLE IF NOT EXISTS user_profiles (
    user_id          INT PRIMARY KEY,
    dob              DATE,
    gender           VARCHAR(20),
    phone            VARCHAR(20),
    national_id      VARCHAR(50),
    employment_type  VARCHAR(50),
    address          TEXT,
    skills           TEXT,
    bio              TEXT,
    resume_path      VARCHAR(255),
    resume_file_name VARCHAR(255),
    resume_content_type VARCHAR(100),
    resume_file      LONGBLOB,
    resume_uploaded_at TIMESTAMP NULL,
    updated_at       TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- UPDATE_DATABASE_IMAGES --
USE sarthak_db;

-- Allow larger image BLOB uploads for this MySQL server.
-- If this fails in phpMyAdmin/MySQL Workbench, run it as root/admin or set max_allowed_packet=64M in my.ini.
SET GLOBAL max_allowed_packet = 67108864;

-- Update users table to store images in database as BLOB.
-- Run only the ADD statements for columns that do not already exist.
-- If a column already exists, run only the MODIFY statement for that column.
ALTER TABLE users ADD COLUMN profile_image LONGBLOB NULL;
ALTER TABLE users MODIFY COLUMN profile_image LONGBLOB NULL;

ALTER TABLE users ADD COLUMN cover_image LONGBLOB NULL;
ALTER TABLE users MODIFY COLUMN cover_image LONGBLOB NULL;

-- Ensure session persistence isn't literally about the session but the data being stored
-- The user mentioned "stored image in database"

SELECT * FROM admins;
SELECT * FROM system_logs;