
CREATE TABLE employer (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT UNIQUE NOT NULL,
    company_name VARCHAR(150),
    industry VARCHAR(100),
    website VARCHAR(200),
    contact_phone VARCHAR(20),
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE jobs (
    id INT PRIMARY KEY AUTO_INCREMENT,
    employer_id INT NOT NULL,
    title VARCHAR(150) NOT NULL,
    description TEXT,
    location VARCHAR(100),
    salary_range VARCHAR(50),
    job_type ENUM('full-time','part-time','contract','internship'),
    status ENUM('active','closed','draft') DEFAULT 'active',
    deadline DATE,
    posted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (employer_id) REFERENCES employer(id)
);

CREATE INDEX idx_jobs_employer_id ON jobs(employer_id);
CREATE INDEX idx_jobs_status ON jobs(status);

INSERT INTO employer (user_id, company_name, industry, website, contact_phone, description) VALUES
(1, 'Tech Solutions Inc.', 'Technology', 'https://techsolutions.com', '+1234567890', 'Leading tech company specializing in software development.');

INSERT INTO jobs (employer_id, title, description, location, salary_range, job_type, status, deadline) VALUES
(1, 'Software Engineer', 'Develop and maintain software applications.', 'New York', '80000-100000', 'full-time', 'active', '2024-12-31'),
(1, 'Data Analyst', 'Analyze data and provide insights.', 'Remote', '60000-80000', 'part-time', 'active', '2024-11-30'),
(1, 'Intern Developer', 'Assist in development tasks.', 'London', '20000-30000', 'internship', 'draft', '2024-10-15');