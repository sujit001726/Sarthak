package com.sarthak.sarthak.user.dao.impl;

import com.sarthak.sarthak.user.dao.interfaces.UserDAOInterface;
import com.sarthak.sarthak.user.model.User;
import com.sarthak.sarthak.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAOImpl implements UserDAOInterface {

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
    public void updateUserStatus(int id, String status) throws SQLException {
        String sql = "UPDATE users SET status = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, id);
            ps.executeUpdate();
        }
    }

    private User mapRow(ResultSet rs) throws SQLException {
        return new User(
            rs.getInt("id"),
            rs.getString("full_name"),
            rs.getString("email"),
            rs.getString("user_type"),
            rs.getString("status")
        );
    }
}
