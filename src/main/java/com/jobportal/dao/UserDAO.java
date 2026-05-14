package com.jobportal.dao;

import com.jobportal.model.User;
import com.jobportal.util.DBConnection;

import java.sql.*;

/**
 * Data Access Object for the users table.
 * Handles all database operations related to user authentication.
 */
public class UserDAO {

    private static final String SQL_INSERT = "INSERT INTO users (full_name, email, password_hash, role) VALUES (?, ?, ?, ?)";

    private static final String SQL_FIND_BY_EMAIL = "SELECT id, full_name, email, password_hash, role, created_at FROM users WHERE email = ?";

    private static final String SQL_EMAIL_EXISTS = "SELECT COUNT(*) FROM users WHERE email = ?";

    private static final String SQL_FIND_BY_ID = "SELECT id, full_name, email, role, created_at FROM users WHERE id = ?";

    /**
     * Inserts a new user into the database.
     */
    public boolean createUser(User user) {
        try (Connection conn = DBConnection.getConnection();
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

    /**
     * Fetches a user by their email address (used for login).
     */
    public User getUserByEmail(String email) {
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(SQL_FIND_BY_EMAIL)) {

            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return mapRow(rs, true);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Checks whether an email address is already registered.
     */
    public boolean emailExists(String email) {
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(SQL_EMAIL_EXISTS)) {

            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Fetches a user by their primary key ID (used for session validation).
     */
    public User getUserById(int id) {
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(SQL_FIND_BY_ID)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return mapRow(rs, false);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public java.util.List<Integer> getAllJobSeekerIds() {
        java.util.List<Integer> ids = new java.util.ArrayList<>();
        String sql = "SELECT id FROM users WHERE role = 'JOBSEEKER'";
        try (Connection conn = DBConnection.getConnection();
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

    public java.util.List<User> searchUsers(String query, int excludeUserId) {
        java.util.List<User> users = new java.util.ArrayList<>();
        String sql = "SELECT id, full_name, email, role, created_at FROM users WHERE full_name LIKE ? AND id != ? LIMIT 10";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "%" + query + "%");
            ps.setInt(2, excludeUserId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                users.add(mapRow(rs, false));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }

    private User mapRow(ResultSet rs, boolean includePassword) throws SQLException {
        User user = new User();
        user.setId(rs.getInt("id"));
        user.setFullName(rs.getString("full_name"));
        user.setEmail(rs.getString("email"));
        user.setRole(User.Role.valueOf(rs.getString("role")));

        if (includePassword) {
            user.setPasswordHash(rs.getString("password_hash"));
        }

        Timestamp ts = rs.getTimestamp("created_at");
        if (ts != null) {
            user.setCreatedAt(ts.toLocalDateTime());
        }
        return user;
    }
}
