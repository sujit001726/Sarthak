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


