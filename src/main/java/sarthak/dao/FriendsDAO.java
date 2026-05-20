package sarthak.dao;

import sarthak.utils.DbConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class FriendsDAO {

    public String getFriendStatus(int userId, int targetId) {
        String sql = "SELECT status, sender_id FROM friend_requests WHERE (sender_id = ? AND receiver_id = ?) OR (sender_id = ? AND receiver_id = ?)";
        try (Connection conn = DbConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, targetId);
            ps.setInt(3, targetId);
            ps.setInt(4, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                String status = rs.getString("status");
                int senderId = rs.getInt("sender_id");
                if (status.equals("pending")) {
                    return senderId == userId ? "sent_pending" : "received_pending";
                }
                return status;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return "none";
    }

    public void sendFriendRequest(int fromUserId, int toUserId) {
        String senderName = "Someone";
        try (Connection conn = DbConnection.getConnection();
              PreparedStatement psName = conn.prepareStatement("SELECT full_name FROM users WHERE id = ?")) {
            psName.setInt(1, fromUserId);
            ResultSet rs = psName.executeQuery();
            if (rs.next()) senderName = rs.getString("full_name");
        } catch (SQLException e) { e.printStackTrace(); }

        String sql = "INSERT INTO friend_requests (sender_id, receiver_id, status) VALUES (?, ?, 'pending') " +
                "ON DUPLICATE KEY UPDATE status = 'pending'";
        try (Connection conn = DbConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, fromUserId);
            ps.setInt(2, toUserId);
            ps.executeUpdate();

            // Notify the receiver with the specific sender name
            NotificationDAO.send(toUserId, "Friend Request", senderName + " sent you a friend request.", "friend_request", "/friends");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public boolean acceptFriendRequest(int receiverId, int senderId) {
        String updateRequestSql = "UPDATE friend_requests SET status = 'accepted' WHERE sender_id = ? AND receiver_id = ?";
        String insertFriendSql = "INSERT IGNORE INTO friends (user_id1, user_id2) VALUES (?, ?)";
        
        try (Connection conn = DbConnection.getConnection()) {
            conn.setAutoCommit(false);
            try {
                try (PreparedStatement ps1 = conn.prepareStatement(updateRequestSql)) {
                    ps1.setInt(1, senderId);
                    ps1.setInt(2, receiverId);
                    ps1.executeUpdate();
                }
                
                try (PreparedStatement ps2 = conn.prepareStatement(insertFriendSql)) {
                    int id1 = Math.min(senderId, receiverId);
                    int id2 = Math.max(senderId, receiverId);
                    ps2.setInt(1, id1);
                    ps2.setInt(2, id2);
                    ps2.executeUpdate();
                }
                
                conn.commit();
                NotificationDAO.send(senderId, "Request Accepted", "Someone accepted your friend request.", "friend_accepted", "/profile?userId=" + receiverId);
                return true;
            } catch (SQLException e) {
                conn.rollback();
                e.printStackTrace();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteFriendRequest(int userId1, int userId2) {
        String sql = "DELETE FROM friend_requests WHERE (sender_id = ? AND receiver_id = ?) OR (sender_id = ? AND receiver_id = ?)";
        try (Connection conn = DbConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId1);
            ps.setInt(2, userId2);
            ps.setInt(3, userId2);
            ps.setInt(4, userId1);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Friend> getFriends(int userId) {
        List<Friend> friends = new ArrayList<>();
        String sql = "SELECT u.id, u.full_name, u.email, u.role FROM users u " +
                "JOIN friends f ON (f.user_id1 = u.id OR f.user_id2 = u.id) " +
                "WHERE (f.user_id1 = ? OR f.user_id2 = ?) AND u.id != ?";

        try (Connection conn = DbConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, userId);
            ps.setInt(3, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Friend f = new Friend();
                f.setId(rs.getInt("id"));
                f.setName(rs.getString("full_name"));
                f.setEmail(rs.getString("email"));
                f.setRole(rs.getString("role"));
                friends.add(f);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return friends;
    }

    public List<Friend> getPendingRequests(int userId) {
        List<Friend> requests = new ArrayList<>();
        String sql = "SELECT u.id, u.full_name, u.role FROM friend_requests fr " +
                     "JOIN users u ON fr.sender_id = u.id " +
                     "WHERE fr.receiver_id = ? AND fr.status = 'pending'";
        try (Connection conn = DbConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Friend f = new Friend();
                    f.setId(rs.getInt("id"));
                    f.setName(rs.getString("full_name"));
                    f.setRole(rs.getString("role"));
                    requests.add(f);
                }
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return requests;
    }

    public java.util.List<sarthak.model.Notification> getNotifications(int userId) {
        java.util.List<sarthak.model.Notification> list = new java.util.ArrayList<>();
        String sql = "SELECT * FROM notifications WHERE user_id = ? ORDER BY created_at DESC LIMIT 5";
        try (Connection conn = DbConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                sarthak.model.Notification n = new sarthak.model.Notification();
                n.setId(rs.getInt("id"));
                n.setType(rs.getString("type"));
                n.setContent(rs.getString("content"));
                n.setRead(rs.getBoolean("is_read"));
                n.setCreatedAt(rs.getTimestamp("created_at"));
                list.add(n);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public static class Friend {
        private int id;
        private String name;
        private String email;
        private String role;
        private boolean online;

        // Getters and Setters
        public int getId() {
            return id;
        }

        public void setId(int id) {
            this.id = id;
        }

        public String getName() {
            return name;
        }

        public void setName(String name) {
            this.name = name;
        }

        public String getEmail() {
            return email;
        }

        public void setEmail(String email) {
            this.email = email;
        }

        public String getRole() {
            return role;
        }

        public void setRole(String role) {
            this.role = role;
        }

        public boolean isOnline() {
            return online;
        }

        public void setOnline(boolean online) {
            this.online = online;
        }
    }
}
