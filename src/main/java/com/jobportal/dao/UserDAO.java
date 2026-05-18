package com.jobportal.dao;

import com.jobportal.model.User;
import com.jobportal.util.DBConnection;

import java.sql.*;

/**
 * Data Access Object for the users table.
 * Handles all database operations related to user authentication.
 */
public class UserDAO {

    private static final String SQL_INSERT =
            "INSERT INTO users (full_name, email, password, role) VALUES (?, ?, ?, ?)";

    private static final String SQL_FIND_BY_EMAIL =
            "SELECT id, full_name, email, password, role, created_at FROM users WHERE email = ?";

    private static final String SQL_EMAIL_EXISTS =
            "SELECT COUNT(*) FROM users WHERE email = ?";

    private static final String SQL_FIND_BY_ID =
            "SELECT id, full_name, email, role, created_at FROM users WHERE id = ?";

    /**
     * Inserts a new user into the database.
     */
    public boolean createUser(User user) throws SQLException {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(SQL_INSERT)) {

            ps.setString(1, user.getFullName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());
            ps.setString(4, user.getRole().name());

            return ps.executeUpdate() > 0;
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

    private User mapRow(ResultSet rs, boolean includePassword) throws SQLException {
        User user = new User();
        user.setId(rs.getInt("id"));
        user.setFullName(rs.getString("full_name"));
        user.setEmail(rs.getString("email"));
        String roleStr = rs.getString("role");
        if (roleStr != null) {
            try {
                user.setRole(User.Role.valueOf(roleStr.toLowerCase()));
            } catch (IllegalArgumentException e) {
                user.setRole(User.Role.job_seeker); // Default fallback
            }
        }

        if (includePassword) {
            user.setPassword(rs.getString("password"));
        }

        Timestamp ts = rs.getTimestamp("created_at");
        if (ts != null) {
            user.setCreatedAt(ts.toLocalDateTime());
        }
        return user;
    }
}
