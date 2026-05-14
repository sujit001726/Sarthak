package sarthak.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DbConnection {
    private static final String DEFAULT_URL = "jdbc:mysql://localhost:3306/sarthak_db?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
    private static final String DEFAULT_USER = "root";
    private static final String DEFAULT_PASSWORD = "";

    static String URL = getConfig("DB_URL", DEFAULT_URL);
    static String USER = getConfig("DB_USER", DEFAULT_USER);
    static String PASSWORD = getConfig("DB_PASSWORD", DEFAULT_PASSWORD);

    // Method to get database connection
    public static Connection getConnection() throws SQLException {

        try {
            // Load MySQL JDBC Driver (required for older versions / explicit loading)
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (Exception e) {
            // Print error if driver is not found
            System.out.println(e.getMessage());
        }

        // Return connection object using DriverManager
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }

    private static String getConfig(String key, String defaultValue) {
        String value = System.getenv(key);
        if (value == null || value.isBlank()) {
            value = System.getProperty(key);
        }
        return value == null || value.isBlank() ? defaultValue : value;
    }
}
