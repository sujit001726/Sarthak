package sarthak.utils;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class Cleanup {
    public static void main(String[] args) {
        try (Connection conn = DbConnection.getConnection()) {
            String sql = "DELETE FROM users WHERE full_name IN ('Test Company', 'Antigravity Corp', 'Tech0306') OR email LIKE '%test%' OR email LIKE '%antigravity%'";
            PreparedStatement ps = conn.prepareStatement(sql);
            int rows = ps.executeUpdate();
            System.out.println("Deleted " + rows + " demo users.");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
