<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, sarthak.utils.DbConnection" %>
<%
    String userIdStr = request.getParameter("userId");
    if (userIdStr != null && !userIdStr.trim().isEmpty()) {
        int id = Integer.parseInt(userIdStr);
        try (Connection conn = DbConnection.getConnection()) {
            // Forcefully delete all related foreign key dependencies just in case the DB is missing ON DELETE CASCADE
            try { conn.prepareStatement("DELETE FROM user_profiles WHERE user_id = " + id).executeUpdate(); } catch(Exception e) {}
            try { conn.prepareStatement("DELETE FROM messages WHERE sender_id = " + id + " OR receiver_id = " + id).executeUpdate(); } catch(Exception e) {}
            try { conn.prepareStatement("DELETE FROM friend_requests WHERE sender_id = " + id + " OR receiver_id = " + id).executeUpdate(); } catch(Exception e) {}
            try { conn.prepareStatement("DELETE FROM friends WHERE user_id1 = " + id + " OR user_id2 = " + id).executeUpdate(); } catch(Exception e) {}
            try { conn.prepareStatement("DELETE FROM jobs WHERE employer_id = " + id).executeUpdate(); } catch(Exception e) {}
            try { conn.prepareStatement("DELETE FROM notifications WHERE user_id = " + id).executeUpdate(); } catch(Exception e) {}
            try { conn.prepareStatement("DELETE FROM system_logs WHERE performed_by_id = " + id).executeUpdate(); } catch(Exception e) {}
            
            int rows = conn.prepareStatement("DELETE FROM users WHERE id = " + id).executeUpdate();
            
            if (rows > 0) {
                try (PreparedStatement logStmt = conn.prepareStatement("INSERT INTO system_logs (action, performed_by) VALUES (?, 'admin')")) {
                    logStmt.setString(1, "Admin permanently deleted User #" + id);
                    logStmt.executeUpdate();
                }
            }
            // Instantly redirect back to users list
            response.sendRedirect("admin?action=users");
            
        } catch (Exception e) {
            e.printStackTrace();
            // If anything fails, alert the user rather than failing silently
            out.println("<script>alert('Error deleting user: " + e.getMessage().replace("'", "\\'") + "'); window.location.href='admin?action=users';</script>");
        }
    } else {
        response.sendRedirect("admin?action=users");
    }
%>
