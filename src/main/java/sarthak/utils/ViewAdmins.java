package sarthak.utils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class ViewAdmins {
    public static void main(String[] args) {
        try (Connection conn = DbConnection.getConnection()) {
            String sql = "SELECT * FROM admins";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            
            System.out.println("--- ADMINS TABLE DATA ---");
            while (rs.next()) {
                System.out.printf("ID: %d | Username: %s | Full Name: %s | Last Login: %s%n",
                        rs.getInt("id"),
                        rs.getString("username"),
                        rs.getString("full_name"),
                        rs.getTimestamp("last_login"));
            }
            System.out.println("-------------------------");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
