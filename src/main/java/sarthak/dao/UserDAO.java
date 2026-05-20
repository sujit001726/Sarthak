package sarthak.dao;

import sarthak.model.User;
import sarthak.utils.DbConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {
    private static final String SQL_INSERT = "INSERT INTO users (full_name, email, password_hash, role) VALUES (?, ?, ?, ?)";
    private static final String SQL_FIND_BY_EMAIL = "SELECT id, full_name, email, password_hash, role, user_type, status, created_at FROM users WHERE email = ?";
    private static final String SQL_EMAIL_EXISTS = "SELECT COUNT(*) FROM users WHERE email = ?";
    private static final String SQL_FIND_BY_ID = "SELECT id, full_name, email, password_hash, role, user_type, status, created_at FROM users WHERE id = ?";
    
    private static final int IMAGE_PACKET_BYTES = 64 * 1024 * 1024;
    private static volatile boolean packetSizeRaised = false;

    public boolean createUser(User user) {
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(SQL_INSERT)) {
            ps.setString(1, user.getFullName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPasswordHash());
            ps.setString(4, user.getRole().name());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public User getUserByEmail(String email) {
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(SQL_FIND_BY_EMAIL)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapRow(rs, true);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean emailExists(String email) {
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(SQL_EMAIL_EXISTS)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public User getUserById(int id) {
        try {
            ensureImageColumns();
            try (Connection conn = DbConnection.getConnection();
                 PreparedStatement ps = conn.prepareStatement(SQL_FIND_BY_ID)) {
                ps.setInt(1, id);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        return mapRow(rs, true);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Integer> getAllJobSeekerIds() {
        List<Integer> ids = new ArrayList<>();
        String sql = "SELECT id FROM users WHERE role = 'job_seeker'";
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                ids.add(rs.getInt("id"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return ids;
    }

    public List<User> getEmployers(int excludeUserId) {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM users WHERE role = 'employer' AND id != ? " +
                     "AND LOWER(full_name) NOT LIKE '%test%' " +
                     "AND LOWER(full_name) NOT LIKE '%demo%' " +
                     "AND LOWER(full_name) NOT LIKE '%antigravity%' " +
                     "ORDER BY created_at DESC";
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, excludeUserId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    users.add(mapRow(rs, false));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }

    public List<User> searchEmployers(String query) {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM users WHERE role = 'employer' " +
                     "AND LOWER(full_name) LIKE ? " +
                     "AND LOWER(full_name) NOT LIKE '%test%' " +
                     "AND LOWER(full_name) NOT LIKE '%demo%' " +
                     "AND LOWER(full_name) NOT LIKE '%antigravity%' " +
                     "ORDER BY created_at DESC";
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "%" + query.toLowerCase() + "%");
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    users.add(mapRow(rs, false));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }

    public List<User> searchUsers(String query, int excludeUserId) {
        List<User> users = new ArrayList<>();
        String sql = "SELECT id, full_name, email, role, user_type, status, created_at FROM users WHERE full_name LIKE ? AND id != ? LIMIT 10";
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "%" + query + "%");
            ps.setInt(2, excludeUserId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    users.add(mapRow(rs, false));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }

    public List<User> getAllUsers() throws SQLException {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM users ORDER BY created_at DESC";
        try (Connection conn = DbConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                users.add(mapRow(rs, false));
            }
        }
        return users;
    }

    public void updateBasicProfile(int id, String fullName, String email) throws SQLException {
        String sql = "UPDATE users SET full_name = ?, email = ? WHERE id = ?";
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, fullName);
            ps.setString(2, email);
            ps.setInt(3, id);
            ps.executeUpdate();
        }
    }

    public void updateProfile(int id, String fullName, String phone) throws SQLException {
        // Ensure phone column exists
        try (Connection conn = DbConnection.getConnection()) {
            String checkSql = "SELECT DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'users' AND COLUMN_NAME = 'phone'";
            try (PreparedStatement ps = conn.prepareStatement(checkSql);
                 ResultSet rs = ps.executeQuery()) {
                if (!rs.next()) {
                    try (Statement stmt = conn.createStatement()) {
                        stmt.executeUpdate("ALTER TABLE users ADD COLUMN phone VARCHAR(30) NULL");
                    }
                }
            }
        }
        String sql = "UPDATE users SET full_name = ?, phone = ? WHERE id = ?";
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, fullName);
            ps.setString(2, phone);
            ps.setInt(3, id);
            ps.executeUpdate();
        }
    }

    public String getPhone(int id) {
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement("SELECT phone FROM users WHERE id = ?")) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getString("phone");
            }
        } catch (SQLException ignored) {}
        return "";
    }

    public void updatePassword(int id, String newPasswordHash) throws SQLException {
        String sql = "UPDATE users SET password_hash = ? WHERE id = ?";
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, newPasswordHash);
            ps.setInt(2, id);
            ps.executeUpdate();
        }
    }

    public boolean deleteUser(int id) {
        String sql = "DELETE FROM users WHERE id = ?";
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public void updateUserStatus(int id, String status) throws SQLException {
        String sql = "UPDATE users SET status = ? WHERE id = ?";
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, id);
            ps.executeUpdate();
        }
    }

    public void updateProfileImage(int id, byte[] profileImage) throws SQLException {
        ensureLargePacketSize();
        ensureImageColumns();
        String sql = "UPDATE users SET profile_image = ? WHERE id = ?";
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setBytes(1, profileImage);
            ps.setInt(2, id);
            ps.executeUpdate();
        }
    }

    public void updateCoverImage(int id, byte[] coverImage) throws SQLException {
        ensureLargePacketSize();
        ensureImageColumns();
        String sql = "UPDATE users SET cover_image = ? WHERE id = ?";
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setBytes(1, coverImage);
            ps.setInt(2, id);
            ps.executeUpdate();
        }
    }

    private User mapRow(ResultSet rs, boolean includePassword) throws SQLException {
        User user = new User();
        user.setId(rs.getInt("id"));
        user.setFullName(rs.getString("full_name"));
        user.setEmail(rs.getString("email"));
        
        String roleStr = rs.getString("role");
        if (roleStr != null) {
            try {
                user.setRole(User.Role.valueOf(roleStr));
            } catch (IllegalArgumentException e) {
                user.setRole(User.Role.job_seeker);
            }
        }
        
        user.setUserType(rs.getString("user_type"));
        user.setStatus(rs.getString("status"));

        if (includePassword) {
            user.setPasswordHash(rs.getString("password_hash"));
        }

        try {
            user.setProfileImage(rs.getBytes("profile_image"));
            user.setCoverImage(rs.getBytes("cover_image"));
        } catch (SQLException ignored) {}

        Timestamp ts = rs.getTimestamp("created_at");
        if (ts != null) {
            user.setCreatedAt(ts.toLocalDateTime());
        }
        return user;
    }

    private void ensureImageColumns() throws SQLException {
        try (Connection conn = DbConnection.getConnection()) {
            ensureBlobColumn(conn, "profile_image");
            ensureBlobColumn(conn, "cover_image");
        }
    }

    private void ensureLargePacketSize() throws SQLException {
        if (packetSizeRaised) return;
        synchronized (UserDAO.class) {
            if (packetSizeRaised) return;
            try (Connection conn = DbConnection.getConnection();
                 Statement stmt = conn.createStatement()) {
                stmt.executeUpdate("SET GLOBAL max_allowed_packet = " + IMAGE_PACKET_BYTES);
                packetSizeRaised = true;
            } catch (SQLException e) {
                if (isPermissionError(e)) {
                    packetSizeRaised = true;
                    return;
                }
                throw e;
            }
        }
    }

    private boolean isPermissionError(SQLException e) {
        String sqlState = e.getSQLState();
        String message = e.getMessage() == null ? "" : e.getMessage().toLowerCase();
        return "42000".equals(sqlState)
                || message.contains("access denied")
                || message.contains("super")
                || message.contains("system_variables_admin");
    }

    private void ensureBlobColumn(Connection conn, String columnName) throws SQLException {
        String dataType = getColumnDataType(conn, columnName);
        if (dataType == null) {
            executeAlter(conn, "ALTER TABLE users ADD COLUMN " + columnName + " LONGBLOB NULL", "Duplicate column");
            return;
        }
        if (!"longblob".equalsIgnoreCase(dataType)) {
            executeAlter(conn, "ALTER TABLE users MODIFY COLUMN " + columnName + " LONGBLOB NULL", null);
        }
    }

    private String getColumnDataType(Connection conn, String columnName) throws SQLException {
        String sql = "SELECT DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'users' AND COLUMN_NAME = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, columnName);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("DATA_TYPE");
                }
            }
        }
        return null;
    }

    private void executeAlter(Connection conn, String sql, String ignoredMessagePart) throws SQLException {
        try (Statement stmt = conn.createStatement()) {
            stmt.executeUpdate(sql);
        } catch (SQLException e) {
            if (ignoredMessagePart != null && e.getMessage() != null
                    && e.getMessage().toLowerCase().contains(ignoredMessagePart.toLowerCase())) {
                return;
            }
            throw e;
        }
    }
}
