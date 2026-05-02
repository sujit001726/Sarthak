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

-- 2. Users Table (Team members)
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    user_type VARCHAR(50) NOT NULL,
    status VARCHAR(50) DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3. Jobs Table
CREATE TABLE IF NOT EXISTS jobs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    company_name VARCHAR(100) NOT NULL,
    salary VARCHAR(50),
    location VARCHAR(100),
    status ENUM('pending', 'approved', 'rejected', 'new', 'waiting', 'closed', 'archived') DEFAULT 'pending',
    posted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 4. Candidates Table
CREATE TABLE IF NOT EXISTS candidates (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(20),
    resume_path VARCHAR(255),
    experience_level ENUM('entry_level', 'intermediate', 'senior', 'expert'),
    status VARCHAR(50) DEFAULT 'applied',
    video_url VARCHAR(255),
    applied_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- 5. Applications Table
CREATE TABLE IF NOT EXISTS applications (
    id INT AUTO_INCREMENT PRIMARY KEY,
    job_id INT,
    candidate_id INT,
    status ENUM('applied', 'screened', 'interviewed', 'hired', 'rejected') DEFAULT 'applied',
    notes TEXT,
    applied_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (job_id) REFERENCES jobs(id),
    FOREIGN KEY (candidate_id) REFERENCES candidates(id)
);

-- 6. Interviews Table
CREATE TABLE IF NOT EXISTS interviews (
    id INT AUTO_INCREMENT PRIMARY KEY,
    application_id INT,
    scheduled_at DATETIME,
    interviewer VARCHAR(100),
    status ENUM('scheduled', 'completed', 'cancelled') DEFAULT 'scheduled',
    feedback TEXT,
    FOREIGN KEY (application_id) REFERENCES applications(id)
);

-- 7. Quizzes Table
CREATE TABLE IF NOT EXISTS quizzes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    questions JSON,
    quiz_type VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 8. Assessments Table
CREATE TABLE IF NOT EXISTS assessments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    candidate_id INT,
    quiz_id INT,
    score DECIMAL(5,2),
    completed_at DATETIME,
    FOREIGN KEY (candidate_id) REFERENCES candidates(id),
    FOREIGN KEY (quiz_id) REFERENCES quizzes(id)
);

-- 9. Categories Table
CREATE TABLE IF NOT EXISTS categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 10. Traits Table
CREATE TABLE IF NOT EXISTS traits (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 11. Interview Templates
CREATE TABLE IF NOT EXISTS interview_templates (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    stages JSON,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 12. Audit Logs
CREATE TABLE IF NOT EXISTS system_logs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    action TEXT NOT NULL,
    performed_by VARCHAR(50),
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- INITIAL DATA
INSERT INTO admins (username, password, full_name) VALUES 
('admin', 'admin123', 'Sarthak Head Office');

INSERT INTO system_logs (action, performed_by) VALUES 
('System Initialized - Ready for Recruitment Management', 'system');




ALTER TABLE users MODIFY COLUMN user_type VARCHAR(50) NOT NULL;
ALTER TABLE users MODIFY COLUMN status VARCHAR(50) DEFAULT 'active';


INSERT INTO users (full_name, email, user_type, status) VALUES
                                                            ('Sujit Shah', 'sujit@sarthak.com', 'admin', 'active'),
                                                            ('Samir Jung Thapa', 'samir@sarthak.com', 'manager', 'active'),
                                                            ('Anish Pokhrel', 'anish@sarthak.com', 'recruiter', 'active'),
                                                            ('Aakriti Nepal', 'aakriti@sarthak.com', 'recruiter', 'active'),
                                                            ('Kashmira Karki', 'kashmira@sarthak.com', 'recruiter', 'active');




DELETE FROM users WHERE full_name IN ('Sandeep Shrestha', 'Priya Thapa', 'Binod Chaudhary');



CREATE TABLE IF NOT EXISTS categories (
                                          id INT AUTO_INCREMENT PRIMARY KEY,
                                          name VARCHAR(100) NOT NULL UNIQUE,
                                          description TEXT,
                                          created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE jobs ADD COLUMN location VARCHAR(100) AFTER salary;



-- ── Sample Seed Data ─────────────────────────────────────────────────────────

-- Sample Jobs
INSERT IGNORE INTO jobs (id, title, company_name, salary, location, status) VALUES
(1, 'Java Backend Developer',  'Sarthak IT Solutions', 'Rs. 60,000 - 90,000',  'Kathmandu', 'approved'),
(2, 'React Frontend Developer','Sarthak IT Solutions', 'Rs. 50,000 - 80,000',  'Lalitpur',  'approved'),
(3, 'DevOps Engineer',         'Sarthak IT Solutions', 'Rs. 80,000 - 120,000', 'Kathmandu', 'approved'),
(4, 'UI/UX Designer',          'Sarthak IT Solutions', 'Rs. 45,000 - 70,000',  'Bhaktapur', 'approved'),
(5, 'QA Engineer',             'Sarthak IT Solutions', 'Rs. 40,000 - 65,000',  'Kathmandu', 'pending');

-- Sample Candidates
INSERT IGNORE INTO candidates (id, name, email, phone, experience_level, status) VALUES
(1, 'Aarav Sharma',    'aarav@example.com',   '9841000001', 'intermediate', 'applied'),
(2, 'Bipana Thapa',    'bipana@example.com',  '9841000002', 'senior',       'shortlisted'),
(3, 'Chirag Adhikari', 'chirag@example.com',  '9841000003', 'entry_level',  'applied'),
(4, 'Deepa Karki',     'deepa@example.com',   '9841000004', 'expert',       'shortlisted'),
(5, 'Eshan Pokhrel',   'eshan@example.com',   '9841000005', 'intermediate', 'applied'),
(6, 'Fiona Rai',       'fiona@example.com',   '9841000006', 'senior',       'applied');

-- Sample Applications (candidate → job)
INSERT IGNORE INTO applications (id, job_id, candidate_id, status) VALUES
(1, 1, 1, 'screened'),
(2, 1, 2, 'screened'),
(3, 2, 3, 'applied'),
(4, 2, 4, 'screened'),
(5, 3, 5, 'applied'),
(6, 4, 6, 'screened'),
(7, 3, 1, 'applied'),
(8, 5, 2, 'applied');



INSERT IGNORE INTO jobs (id, title, company_name, salary, location, status) VALUES
                                                                                (1, 'Java Backend Developer',  'Sarthak IT Solutions', 'Rs. 60,000 - 90,000',  'Kathmandu', 'approved'),
                                                                                (2, 'React Frontend Developer','Sarthak IT Solutions', 'Rs. 50,000 - 80,000',  'Lalitpur',  'approved'),
                                                                                (3, 'DevOps Engineer',         'Sarthak IT Solutions', 'Rs. 80,000 - 120,000', 'Kathmandu', 'approved'),
                                                                                (4, 'UI/UX Designer',          'Sarthak IT Solutions', 'Rs. 45,000 - 70,000',  'Bhaktapur', 'approved'),
                                                                                (5, 'QA Engineer',             'Sarthak IT Solutions', 'Rs. 40,000 - 65,000',  'Kathmandu', 'pending');

INSERT IGNORE INTO candidates (id, name, email, phone, experience_level, status) VALUES
                                                                                     (1, 'Ujjwal Rupakheti',    'ujjwal@gmail.com',   '9841000001', 'expert', 'applied'),
                                                                                     (2, 'Nischal Giri',    'Nischal@gmail.com',  '9841000002', 'senior',       'shortlisted'),
                                                                                     (3, 'Pritam Rai', 'Pritam@gmail.com',  '9841000003', 'entry_level',  'applied'),
                                                                                     (4, 'Ashmit Dev',     'Ashmit@gmail.com',   '9841000004', 'intermediate',       'shortlisted'),
                                                                                     (5, 'Abhishek Kumar Dev',   'Abhishek@gmail.com',   '9841000005', 'intermediate', 'applied');

INSERT IGNORE INTO applications (id, job_id, candidate_id, status) VALUES
                                                                       (1, 1, 1, 'screened'),
                                                                       (2, 1, 2, 'screened'),
                                                                       (3, 2, 3, 'applied'),
                                                                       (4, 2, 4, 'screened'),
                                                                       (5, 3, 5, 'applied'),
                                                                       (6, 4, 6, 'screened'),
                                                                       (7, 3, 1, 'applied'),
                                                                       (8, 5, 2, 'applied');
