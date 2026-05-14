package com.sarthak.sarthak.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    // Ensure this matches your MySQL database name
    private static final String URL = "jdbc:mysql://localhost:3306/sarthak_db?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
    private static final String USER = "root";
    
    // IMPORTANT: Change this to your actual MySQL password (e.g., "", "root", "admin123")
    private static final String PASS = "";

    public static Connection getConnection() throws SQLException {
        try {
            // Explicitly load the driver for Tomcat
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(URL, USER, PASS);
        } catch (ClassNotFoundException e) {
            throw new SQLException("MySQL Connector Driver not found in Classpath!", e);
        }
    }
}
