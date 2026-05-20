package sarthak.dao;

import sarthak.utils.DbConnection;
import java.sql.*;

public class ProfileDAO {

    public static class ResumeFile {
        private final String fileName;
        private final String contentType;
        private final byte[] data;

        public ResumeFile(String fileName, String contentType, byte[] data) {
            this.fileName = fileName;
            this.contentType = contentType;
            this.data = data;
        }

        public String getFileName() { return fileName; }
        public String getContentType() { return contentType; }
        public byte[] getData() { return data; }
    }

    public void saveOrUpdateProfile(int userId, String dob, String gender, String phone, String nationalId, 
                                   String employmentType, String address, String skills, String bio) throws SQLException {
        ensureProfileTable();
        
        String checkSql = "SELECT user_id FROM user_profiles WHERE user_id = ?";
        String insertSql = "INSERT INTO user_profiles (user_id, dob, gender, phone, national_id, employment_type, address, skills, bio) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        String updateSql = "UPDATE user_profiles SET dob=?, gender=?, phone=?, national_id=?, employment_type=?, address=?, skills=?, bio=? WHERE user_id=?";

        try (Connection conn = DbConnection.getConnection()) {
            boolean exists = false;
            try (PreparedStatement ps = conn.prepareStatement(checkSql)) {
                ps.setInt(1, userId);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) exists = true;
                }
            }

            if (exists) {
                try (PreparedStatement ps = conn.prepareStatement(updateSql)) {
                    if (dob == null || dob.trim().isEmpty()) {
                        ps.setNull(1, Types.DATE);
                    } else {
                        ps.setString(1, dob.trim());
                    }
                    ps.setString(2, gender);
                    ps.setString(3, phone);
                    ps.setString(4, nationalId);
                    ps.setString(5, employmentType);
                    ps.setString(6, address);
                    ps.setString(7, skills);
                    ps.setString(8, bio);
                    ps.setInt(9, userId);
                    ps.executeUpdate();
                }
            } else {
                try (PreparedStatement ps = conn.prepareStatement(insertSql)) {
                    ps.setInt(1, userId);
                    if (dob == null || dob.trim().isEmpty()) {
                        ps.setNull(2, Types.DATE);
                    } else {
                        ps.setString(2, dob.trim());
                    }
                    ps.setString(3, gender);
                    ps.setString(4, phone);
                    ps.setString(5, nationalId);
                    ps.setString(6, employmentType);
                    ps.setString(7, address);
                    ps.setString(8, skills);
                    ps.setString(9, bio);
                    ps.executeUpdate();
                }
            }
        }
    }

    public ResultSet getProfile(int userId) throws SQLException {
        ensureProfileTable();
        String sql = "SELECT * FROM user_profiles WHERE user_id = ?";
        Connection conn = DbConnection.getConnection();
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, userId);
        return ps.executeQuery();
    }

    public void saveOrUpdateCompanyProfile(int userId, String industry, String website, String companySize, 
                                           Integer foundedYear, String location, String bio) throws SQLException {
        ensureProfileTable();
        
        String checkSql = "SELECT user_id FROM user_profiles WHERE user_id = ?";
        String insertSql = "INSERT INTO user_profiles (user_id, industry, website, company_size, founded_year, location, bio) VALUES (?, ?, ?, ?, ?, ?, ?)";
        String updateSql = "UPDATE user_profiles SET industry=?, website=?, company_size=?, founded_year=?, location=?, bio=? WHERE user_id=?";

        try (Connection conn = DbConnection.getConnection()) {
            boolean exists = false;
            try (PreparedStatement ps = conn.prepareStatement(checkSql)) {
                ps.setInt(1, userId);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) exists = true;
                }
            }

            if (exists) {
                try (PreparedStatement ps = conn.prepareStatement(updateSql)) {
                    ps.setString(1, industry);
                    ps.setString(2, website);
                    ps.setString(3, companySize);
                    if (foundedYear != null) {
                        ps.setInt(4, foundedYear);
                    } else {
                        ps.setNull(4, Types.INTEGER);
                    }
                    ps.setString(5, location);
                    ps.setString(6, bio);
                    ps.setInt(7, userId);
                    ps.executeUpdate();
                }
            } else {
                try (PreparedStatement ps = conn.prepareStatement(insertSql)) {
                    ps.setInt(1, userId);
                    ps.setString(2, industry);
                    ps.setString(3, website);
                    ps.setString(4, companySize);
                    if (foundedYear != null) {
                        ps.setInt(5, foundedYear);
                    } else {
                        ps.setNull(5, Types.INTEGER);
                    }
                    ps.setString(6, location);
                    ps.setString(7, bio);
                    ps.executeUpdate();
                }
            }
        }
    }

    public void saveResume(int userId, String fileName, String contentType, byte[] data) throws SQLException {
        ensureProfileTable();
        String checkSql = "SELECT user_id FROM user_profiles WHERE user_id = ?";
        String insertSql = "INSERT INTO user_profiles (user_id, resume_file_name, resume_content_type, resume_file, resume_uploaded_at) VALUES (?, ?, ?, ?, CURRENT_TIMESTAMP)";
        String updateSql = "UPDATE user_profiles SET resume_file_name=?, resume_content_type=?, resume_file=?, resume_uploaded_at=CURRENT_TIMESTAMP WHERE user_id=?";

        try (Connection conn = DbConnection.getConnection()) {
            boolean exists;
            try (PreparedStatement ps = conn.prepareStatement(checkSql)) {
                ps.setInt(1, userId);
                try (ResultSet rs = ps.executeQuery()) {
                    exists = rs.next();
                }
            }

            if (exists) {
                try (PreparedStatement ps = conn.prepareStatement(updateSql)) {
                    ps.setString(1, fileName);
                    ps.setString(2, contentType);
                    ps.setBytes(3, data);
                    ps.setInt(4, userId);
                    ps.executeUpdate();
                }
            } else {
                try (PreparedStatement ps = conn.prepareStatement(insertSql)) {
                    ps.setInt(1, userId);
                    ps.setString(2, fileName);
                    ps.setString(3, contentType);
                    ps.setBytes(4, data);
                    ps.executeUpdate();
                }
            }
        }
    }

    public ResumeFile getResume(int userId) throws SQLException {
        ensureProfileTable();
        String sql = "SELECT resume_file_name, resume_content_type, resume_file FROM user_profiles WHERE user_id = ?";
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    byte[] data = rs.getBytes("resume_file");
                    if (data != null && data.length > 0) {
                        String fileName = rs.getString("resume_file_name");
                        String contentType = rs.getString("resume_content_type");
                        return new ResumeFile(fileName, contentType, data);
                    }
                }
            }
        }
        return null;
    }

    private void ensureProfileTable() throws SQLException {
        try (Connection conn = DbConnection.getConnection();
             Statement stmt = conn.createStatement()) {
            stmt.executeUpdate(
                "CREATE TABLE IF NOT EXISTS user_profiles (" +
                "user_id INT PRIMARY KEY, " +
                "dob DATE NULL, " +
                "gender VARCHAR(20) NULL, " +
                "phone VARCHAR(20) NULL, " +
                "national_id VARCHAR(50) NULL, " +
                "employment_type VARCHAR(50) NULL, " +
                "address TEXT NULL, " +
                "skills TEXT NULL, " +
                "bio TEXT NULL, " +
                "resume_path VARCHAR(255) NULL, " +
                "resume_file_name VARCHAR(255) NULL, " +
                "resume_content_type VARCHAR(100) NULL, " +
                "resume_file LONGBLOB NULL, " +
                "resume_uploaded_at TIMESTAMP NULL, " +
                "updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, " +
                "FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE" +
                ") ENGINE=InnoDB DEFAULT CHARSET=utf8mb4"
            );

            addColumnIfMissing(conn, "resume_file_name", "ALTER TABLE user_profiles ADD COLUMN resume_file_name VARCHAR(255) NULL");
            addColumnIfMissing(conn, "resume_content_type", "ALTER TABLE user_profiles ADD COLUMN resume_content_type VARCHAR(100) NULL");
            addColumnIfMissing(conn, "resume_file", "ALTER TABLE user_profiles ADD COLUMN resume_file LONGBLOB NULL");
            addColumnIfMissing(conn, "resume_uploaded_at", "ALTER TABLE user_profiles ADD COLUMN resume_uploaded_at TIMESTAMP NULL");
            
            // Company columns
            addColumnIfMissing(conn, "industry", "ALTER TABLE user_profiles ADD COLUMN industry VARCHAR(100) NULL");
            addColumnIfMissing(conn, "website", "ALTER TABLE user_profiles ADD COLUMN website VARCHAR(255) NULL");
            addColumnIfMissing(conn, "company_size", "ALTER TABLE user_profiles ADD COLUMN company_size VARCHAR(50) NULL");
            addColumnIfMissing(conn, "founded_year", "ALTER TABLE user_profiles ADD COLUMN founded_year INT NULL");
            addColumnIfMissing(conn, "location", "ALTER TABLE user_profiles ADD COLUMN location VARCHAR(150) NULL");
        }
    }

    private void addColumnIfMissing(Connection conn, String columnName, String alterSql) throws SQLException {
        try (ResultSet rs = conn.getMetaData().getColumns(conn.getCatalog(), null, "user_profiles", columnName)) {
            if (!rs.next()) {
                try (Statement stmt = conn.createStatement()) {
                    stmt.executeUpdate(alterSql);
                }
            }
        }
    }
}
