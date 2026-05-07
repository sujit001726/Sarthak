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
