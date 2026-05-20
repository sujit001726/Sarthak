package sarthak.dao;

import sarthak.model.Message;
import sarthak.utils.DbConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MessageDAO {

    public boolean insertMessage(Message message) {
        String sql = "INSERT INTO messages (sender_id, receiver_id, job_id, subject, body) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DbConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, message.getSenderId());
            stmt.setInt(2, message.getReceiverId());
            setNullableInt(stmt, 3, message.getJobId());
            stmt.setString(4, message.getSubject());
            stmt.setString(5, message.getBody());
            boolean success = stmt.executeUpdate() > 0;
            if (success) {
                NotificationDAO.send(message.getReceiverId(), "New Message", "You received a new message: " + message.getSubject(), "message", "/messages?chatWith=" + message.getSenderId());
            }
            return success;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public List<Message> getInboxMessages(int userId) {
        String sql = "SELECT m.*, u.full_name as sender_name FROM messages m " +
                "JOIN users u ON m.sender_id = u.id " +
                "WHERE m.receiver_id = ? ORDER BY m.created_at DESC";
        return getMessagesWithNames(sql, userId);
    }

    public List<Message> getChatHistory(int userA, int userB) {
        String sql = "SELECT m.*, u.full_name as sender_name FROM messages m " +
                "JOIN users u ON m.sender_id = u.id " +
                "WHERE (m.sender_id = ? AND m.receiver_id = ?) " +
                "OR (m.sender_id = ? AND m.receiver_id = ?) " +
                "ORDER BY m.created_at ASC";
        List<Message> messages = new ArrayList<>();
        try (Connection conn = DbConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userA);
            stmt.setInt(2, userB);
            stmt.setInt(3, userB);
            stmt.setInt(4, userA);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    messages.add(mapResultSetToMessageWithName(rs));
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return messages;
    }

    public List<Message> getConversations(int userId) {
        // This query gets the last message from each conversation
        String sql = "SELECT m.*, u.full_name as other_name, u.id as other_id FROM messages m " +
                "JOIN users u ON (m.sender_id = u.id OR m.receiver_id = u.id) " +
                "WHERE (m.sender_id = ? OR m.receiver_id = ?) AND u.id != ? " +
                "AND m.id IN (SELECT MAX(id) FROM messages WHERE sender_id = ? OR receiver_id = ? GROUP BY LEAST(sender_id, receiver_id), GREATEST(sender_id, receiver_id)) "
                +
                "ORDER BY m.created_at DESC";
        List<Message> conversations = new ArrayList<>();
        try (Connection conn = DbConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            for (int i = 1; i <= 5; i++)
                stmt.setInt(i, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Message msg = mapResultSetToMessageWithName(rs);
                    // Use subject field temporarily to store other person's name for simplicity in
                    // this DTO
                    msg.setSubject(rs.getString("other_name"));
                    conversations.add(msg);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return conversations;
    }

    public boolean markAsRead(int messageId, int receiverId) {
        String sql = "UPDATE messages SET is_read = TRUE WHERE id = ? AND receiver_id = ?";
        try (Connection conn = DbConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, messageId);
            stmt.setInt(2, receiverId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public int getUnreadMessageCount(int userId) {
        String sql = "SELECT COUNT(*) FROM messages WHERE receiver_id = ? AND is_read = FALSE";
        try (Connection conn = DbConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    private List<Message> getMessagesWithNames(String sql, int userId) {
        List<Message> messages = new ArrayList<>();
        try (Connection conn = DbConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    messages.add(mapResultSetToMessageWithName(rs));
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return messages;
    }

    private Message mapResultSetToMessageWithName(ResultSet rs) throws SQLException {
        Message message = mapResultSetToMessage(rs);
        // We reuse the subject field if needed or just handle it in the frontend
        // For real-time, we might need a dedicated MessageDTO
        return message;
    }

    private Message mapResultSetToMessage(ResultSet rs) throws SQLException {
        Message message = new Message();
        message.setId(rs.getInt("id"));
        message.setSenderId(rs.getInt("sender_id"));
        message.setReceiverId(rs.getInt("receiver_id"));
        int jobId = rs.getInt("job_id");
        message.setJobId(rs.wasNull() ? null : jobId);
        message.setSubject(rs.getString("subject"));
        message.setBody(rs.getString("body"));
        message.setRead(rs.getBoolean("is_read"));
        message.setCreatedAt(rs.getTimestamp("created_at"));
        return message;
    }

    private void setNullableInt(PreparedStatement stmt, int index, Integer value) throws SQLException {
        if (value == null) {
            stmt.setNull(index, Types.INTEGER);
        } else {
            stmt.setInt(index, value);
        }
    }
}
