package com.sarthak.sarthak.user.dao.impl;

import com.sarthak.sarthak.user.dao.interfaces.UserDAOInterface;
import com.sarthak.sarthak.user.model.User;
import com.sarthak.sarthak.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAOImpl implements UserDAOInterface {
    private static final int IMAGE_PACKET_BYTES = 64 * 1024 * 1024;
    private static volatile boolean packetSizeRaised = false;

    @Override
    public List<User> getAllUsers() throws SQLException {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM users ORDER BY created_at DESC";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                users.add(mapRow(rs));
            }
        }
        return users;
    }

    @Override
    public User getUserById(int id) throws SQLException {
        ensureImageColumns();
        String sql = "SELECT * FROM users WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }
        }
        return null;
    }

    @Override
    public void updateBasicProfile(int id, String fullName, String email) throws SQLException {
        String sql = "UPDATE users SET full_name = ?, email = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, fullName);
            ps.setString(2, email);
            ps.setInt(3, id);
            ps.executeUpdate();
        }
    }

    @Override
    public void updateUserStatus(int id, String status) throws SQLException {
        String sql = "UPDATE users SET status = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, id);
            ps.executeUpdate();
        }
    }

    @Override
    public void updateProfileImage(int id, byte[] profileImage) throws SQLException {
        ensureLargePacketSize();
        ensureImageColumns();
        String sql = "UPDATE users SET profile_image = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setBytes(1, profileImage);
            ps.setInt(2, id);
            ps.executeUpdate();
        }
    }

    @Override
    public void updateCoverImage(int id, byte[] coverImage) throws SQLException {
        ensureLargePacketSize();
        ensureImageColumns();
        String sql = "UPDATE users SET cover_image = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setBytes(1, coverImage);
            ps.setInt(2, id);
            ps.executeUpdate();
        }
    }

    private User mapRow(ResultSet rs) throws SQLException {
        User user = new User(
            rs.getInt("id"),
            rs.getString("full_name"),
            rs.getString("email"),
            getStringSafe(rs, "user_type"),
            getStringSafe(rs, "status"),
            null, // Temporary placeholder for profile_image
            null  // Temporary placeholder for cover_image
        );
        
        try {
            user.setProfileImage(rs.getBytes("profile_image"));
            user.setCoverImage(rs.getBytes("cover_image"));
        } catch (SQLException ignored) {
            // Columns might not exist yet
        }
        
        return user;
    }

    private String getStringSafe(ResultSet rs, String column) {
        try {
            return rs.getString(column);
        } catch (SQLException e) {
            return null;
        }
    }

    private void ensureImageColumns() throws SQLException {
        try (Connection conn = DBConnection.getConnection()) {
            ensureBlobColumn(conn, "profile_image");
            ensureBlobColumn(conn, "cover_image");
        }
    }

    private void ensureLargePacketSize() throws SQLException {
        if (packetSizeRaised) {
            return;
        }

        synchronized (UserDAOImpl.class) {
            if (packetSizeRaised) {
                return;
            }

            try (Connection conn = DBConnection.getConnection();
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
        String sql = "SELECT DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS " +
                "WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'users' AND COLUMN_NAME = ?";
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
