<%@ page import="sarthak.utils.DbConnection" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%
    try (Connection conn = DbConnection.getConnection()) {
        String sql = "DELETE FROM users WHERE full_name IN ('Test Company', 'Antigravity Corp', 'Tech0306') OR email LIKE '%test%'";
        PreparedStatement ps = conn.prepareStatement(sql);
        int rows = ps.executeUpdate();
        out.println("Deleted " + rows + " demo users.");
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    }
%>
