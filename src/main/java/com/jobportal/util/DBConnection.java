package com.jobportal.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Provides JDBC connections to the MySQL sarthak_db database.
 * Update DB_URL, DB_USER, and DB_PASSWORD to match your local setup.
 */
public class DBConnection {

    private static final String DB_URL      = "jdbc:mysql://localhost:3306/sarthak_db?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
    private static final String DB_USER     = "root";
    private static final String DB_PASSWORD = "";  // ← XAMPP default is empty string; change if you set a password

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("MySQL JDBC Driver not found.", e);
        }
    }

    /**
     * Opens and returns a new JDBC connection.
     */
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
    }
}
