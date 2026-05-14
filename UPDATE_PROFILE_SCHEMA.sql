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
