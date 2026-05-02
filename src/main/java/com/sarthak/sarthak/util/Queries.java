package com.sarthak.sarthak.util;

/**
 * Central place for all SQL query strings.
 */
public final class Queries {

    private Queries() {}

    // Users
    public static final String COUNT_USERS        = "SELECT COUNT(*) FROM users";
    public static final String COUNT_APPROVED_JOBS= "SELECT COUNT(*) FROM jobs WHERE status='approved'";

    // Categories
    public static final String ALL_CATEGORIES     = "SELECT * FROM categories ORDER BY name ASC";
    public static final String INSERT_CATEGORY    = "INSERT INTO categories (name, description) VALUES (?, ?)";

    // Interviews
    public static final String ALL_INTERVIEWS     =
        "SELECT i.*, c.name AS candidate_name FROM interviews i " +
        "JOIN applications a ON i.application_id = a.id " +
        "JOIN candidates c ON a.candidate_id = c.id ORDER BY scheduled_at DESC";

    // Logs
    public static final String ALL_LOGS           = "SELECT * FROM system_logs ORDER BY timestamp DESC";
    public static final String INSERT_LOG         = "INSERT INTO system_logs (action, performed_by) VALUES (?, ?)";
}
