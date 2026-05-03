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
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public List<Message> getInboxMessages(int userId) {
        String sql = "SELECT * FROM messages WHERE receiver_id = ? ORDER BY created_at DESC";
        return getMessagesByUser(sql, userId);
    }

    public List<Message> getSentMessages(int userId) {
        String sql = "SELECT * FROM messages WHERE sender_id = ? ORDER BY created_at DESC";
        return getMessagesByUser(sql, userId);
    }

    public int countUnreadMessages(int userId) {
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
            throw new RuntimeException(e);
        }
        return 0;
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

    private List<Message> getMessagesByUser(String sql, int userId) {
        List<Message> messages = new ArrayList<>();
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    messages.add(mapResultSetToMessage(rs));
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return messages;
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
