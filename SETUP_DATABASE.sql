
DROP DATABASE IF EXISTS sarthak_db;
CREATE DATABASE sarthak_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE sarthak_db;

-- 1. USERS TABLE (for login/registration)
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

-- 2. ADMINS TABLE
CREATE TABLE admins (
    id         INT AUTO_INCREMENT PRIMARY KEY,
    username   VARCHAR(50)  NOT NULL UNIQUE,
    password   VARCHAR(255) NOT NULL,
    full_name  VARCHAR(100),
    last_login TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 3. JOBS TABLE
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
    INDEX idx_employer (employer_id),
    INDEX idx_status   (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 4. CANDIDATES TABLE
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

-- 5. APPLICATIONS TABLE
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

-- 6. INTERVIEWS TABLE
CREATE TABLE interviews (
    id             INT AUTO_INCREMENT PRIMARY KEY,
    application_id INT  DEFAULT NULL,
    scheduled_at   DATETIME DEFAULT NULL,
    interviewer    VARCHAR(100) DEFAULT NULL,
    status         ENUM('scheduled','completed','cancelled') DEFAULT 'scheduled',
    feedback       TEXT DEFAULT NULL,
    FOREIGN KEY (application_id) REFERENCES applications(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 7. CATEGORIES TABLE
CREATE TABLE categories (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    name        VARCHAR(100) NOT NULL UNIQUE,
    description TEXT         DEFAULT NULL,
    created_at  TIMESTAMP    DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 8. SYSTEM_LOGS TABLE
CREATE TABLE system_logs (
    id           INT AUTO_INCREMENT PRIMARY KEY,
    action       TEXT         NOT NULL,
    performed_by VARCHAR(100) DEFAULT NULL,
    timestamp    TIMESTAMP    DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 9. QUIZZES TABLE
CREATE TABLE quizzes (
    id         INT AUTO_INCREMENT PRIMARY KEY,
    title      VARCHAR(200) NOT NULL,
    questions  JSON         DEFAULT NULL,
    quiz_type  VARCHAR(50)  DEFAULT NULL,
    created_at TIMESTAMP    DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 10. ASSESSMENTS TABLE
CREATE TABLE assessments (
    id           INT AUTO_INCREMENT PRIMARY KEY,
    candidate_id INT          DEFAULT NULL,
    quiz_id      INT          DEFAULT NULL,
    score        DECIMAL(5,2) DEFAULT NULL,
    completed_at DATETIME     DEFAULT NULL,
    FOREIGN KEY (candidate_id) REFERENCES candidates(id) ON DELETE CASCADE,
    FOREIGN KEY (quiz_id)      REFERENCES quizzes(id)    ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;



-- 12. INTERVIEW TEMPLATES TABLE
CREATE TABLE interview_templates (
    id         INT AUTO_INCREMENT PRIMARY KEY,
    name       VARCHAR(100) NOT NULL,
    stages     JSON         DEFAULT NULL,
    created_at TIMESTAMP    DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ============================================================
--  INSERT ADMIN USER
--  Email: admin@gmail.com  |  Password: admin123
--  BCrypt hash generated with cost=10
-- ============================================================
INSERT INTO users (full_name, email, password_hash, role, user_type, status)
VALUES (
    'Admin',
    'admin@gmail.com',
    '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy',
    'job_seeker',
    'admin',
    'active'
);

-- Default admin for old admin panel
INSERT INTO admins (username, password, full_name)
VALUES ('admin', 'admin123', 'Sarthak Admin');

-- Sample categories
INSERT INTO categories (name, description) VALUES
('Information Technology', 'Software, hardware, and IT services'),
('Finance', 'Banking, accounting, and financial services'),
('Marketing', 'Digital marketing, branding, and advertising'),
('Healthcare', 'Medical, nursing, and health services'),
('Engineering', 'Civil, mechanical, and electrical engineering');

-- Sample jobs
INSERT INTO jobs (id, title, company_name, location, salary, status) VALUES
(1, 'Java Backend Developer', 'Sarthak IT Solutions', 'Kathmandu', 'Rs. 60,000 - 90,000', 'approved'),
(2, 'React Frontend Developer', 'Sarthak IT Solutions', 'Lalitpur', 'Rs. 50,000 - 80,000', 'approved'),
(3, 'DevOps Engineer', 'Sarthak IT Solutions', 'Kathmandu', 'Rs. 80,000 - 120,000', 'approved'),
(4, 'UI/UX Designer', 'Sarthak IT Solutions', 'Bhaktapur', 'Rs. 45,000 - 70,000', 'approved'),
(5, 'QA Engineer', 'Sarthak IT Solutions', 'Kathmandu', 'Rs. 40,000 - 65,000', 'pending');

-- Sample candidates
INSERT INTO candidates (id, name, email, phone, experience_level, status) VALUES
(1, 'Aarav Sharma', 'aarav@example.com', '9841000001', 'intermediate', 'applied'),
(2, 'Bipana Thapa', 'bipana@example.com', '9841000002', 'senior', 'shortlisted'),
(3, 'Chirag Adhikari', 'chirag@example.com', '9841000003', 'entry_level', 'applied'),
(4, 'Deepa Karki', 'deepa@example.com', '9841000004', 'expert', 'shortlisted'),
(5, 'Eshan Pokhrel', 'eshan@example.com', '9841000005', 'intermediate', 'applied'),
(6, 'Fiona Rai', 'fiona@example.com', '9841000006', 'senior', 'applied');

-- Sample applications
INSERT INTO applications (id, job_id, candidate_id, status) VALUES
(1, 1, 1, 'screened'),
(2, 1, 2, 'screened'),
(3, 2, 3, 'applied'),
(4, 2, 4, 'screened'),
(5, 3, 5, 'applied'),
(6, 4, 6, 'screened'),
(7, 3, 1, 'applied'),
(8, 5, 2, 'applied');

-- Sample interviews
INSERT INTO interviews (id, application_id, scheduled_at, interviewer, status) VALUES
(1, 1, '2026-05-10 10:00:00', 'Sujit Shah', 'scheduled'),
(2, 2, '2026-05-11 14:00:00', 'Samir Thapa', 'scheduled');

-- System log
INSERT INTO system_logs (action, performed_by)
VALUES ('Database initialized — Sarthak Job Portal ready.', 'system');



SELECT * FROM users WHERE email = 'shahsujit502@gmail.com';
