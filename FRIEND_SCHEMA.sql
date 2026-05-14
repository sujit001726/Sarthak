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
