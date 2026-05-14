USE sarthak_db;

CREATE TABLE IF NOT EXISTS notifications (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    user_id     INT NOT NULL,
    from_user_id INT,
    type        VARCHAR(50) NOT NULL, -- 'friend_request', 'message', 'job_alert'
    title       VARCHAR(200),
    body        TEXT,
    content     TEXT, -- Alias for body
    link_url    VARCHAR(500),
    is_read     BOOLEAN DEFAULT FALSE,
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (from_user_id) REFERENCES users(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
