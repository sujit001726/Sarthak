package com.sarthak.sarthak.admin;

import com.sarthak.sarthak.util.DBConnection;
import java.io.IOException;
import java.sql.*;
import java.util.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

// This file is superseded by com.sarthak.sarthak.job.controller.AdminServlet
// @WebServlet("/admin")
public class AdminServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        if (action == null) action = "dashboard";

        try (Connection conn = DBConnection.getConnection()) {
            if (conn == null) {
                throw new SQLException("Could not establish database connection. Check DBConnection.java.");
            }
            
            switch (action) {
                case "users":
                    listUsers(conn, request, response);
                    break;
                case "jobs":
                    listJobs(conn, request, response);
                    break;
                case "logs":
                    listLogs(conn, request, response);
                    break;
                case "interviews":
                    listInterviews(conn, request, response);
                    break;
                case "jobBoard":
                    listApplications(conn, request, response);
                    break;
                case "categories":
                    listCategories(conn, request, response);
                    break;
                case "candidates":
                    listCandidates(conn, request, response);
                    break;
                case "shortlisted":
                    listShortlisted(conn, request, response);
                    break;
                case "addJob":
                    request.getRequestDispatcher("/pages/addJob.jsp").forward(request, response);
                    break;
                case "addCandidate":
                    request.getRequestDispatcher("/pages/addCandidate.jsp").forward(request, response);
                    break;
                case "addCategory":
                    request.getRequestDispatcher("/pages/addCategory.jsp").forward(request, response);
                    break;
                case "dashboard":
                default:
                    showDashboard(conn, request, response);
                    break;
            }
        } catch (Exception e) {
            handleError(e, request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");
        try (Connection conn = DBConnection.getConnection()) {
            if (conn == null) throw new SQLException("DB Connection is null");
            
            if ("updateUserStatus".equals(action)) {
                updateUserStatus(conn, request, response);
            } else if ("updateJobStatus".equals(action)) {
                updateJobStatus(conn, request, response);
            } else if ("saveJob".equals(action)) {
                saveJob(conn, request, response);
            } else if ("saveCandidate".equals(action)) {
                saveCandidate(conn, request, response);
            } else if ("saveCategory".equals(action)) {
                saveCategory(conn, request, response);
            }
        } catch (Exception e) {
            handleError(e, request, response);
        }
    }

    private void handleError(Exception e, HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        e.printStackTrace();
        String msg = e.getMessage();
        String detail = "Check server logs for stack trace.";
        
        if (msg != null && msg.contains("Table") && msg.contains("doesn't exist")) {
            detail = "The database tables are missing. Please execute the SQL commands in 'schema.sql' using your MySQL client.";
        } else if (msg != null && msg.contains("Access denied")) {
            detail = "Database login failed. Open 'src/main/java/com/sarthak/sarthak/util/DBConnection.java' and verify your MySQL password.";
        }
        
        request.setAttribute("errorMessage", msg);
        request.setAttribute("errorDetail", detail);
        request.getRequestDispatcher("/pages/error.jsp").forward(request, response);
    }

    private void showDashboard(Connection conn, HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        
        try (Statement stmt = conn.createStatement()) {
            ResultSet rs = stmt.executeQuery("SELECT COUNT(*) FROM users");
            if (rs.next()) request.setAttribute("userCount", rs.getInt(1));
            
            rs = stmt.executeQuery("SELECT COUNT(*) FROM jobs WHERE status='approved'");
            if (rs.next()) request.setAttribute("jobCount", rs.getInt(1));
        }
        
        List<Map<String, String>> recentJobs = new ArrayList<>();
        try (Statement stmt = conn.createStatement()) {
            ResultSet rs = stmt.executeQuery("SELECT * FROM jobs ORDER BY posted_at DESC LIMIT 4");
            while (rs.next()) {
                Map<String, String> job = new HashMap<>();
                job.put("title", rs.getString("title"));
                job.put("company", rs.getString("company_name"));
                recentJobs.add(job);
            }
        }
        request.setAttribute("recentJobs", recentJobs);
        
        List<Map<String, String>> recentLogs = new ArrayList<>();
        try (Statement stmt = conn.createStatement()) {
            ResultSet rs = stmt.executeQuery("SELECT * FROM system_logs ORDER BY timestamp DESC LIMIT 5");
            while (rs.next()) {
                Map<String, String> log = new HashMap<>();
                log.put("action", rs.getString("action"));
                log.put("time", rs.getTimestamp("timestamp").toString());
                recentLogs.add(log);
            }
        }
        request.setAttribute("recentLogs", recentLogs);
        
        request.getRequestDispatcher("/pages/dashboard.jsp").forward(request, response);
    }

    private void listUsers(Connection conn, HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        List<Map<String, String>> users = new ArrayList<>();
        String query = "SELECT * FROM users ORDER BY created_at DESC";
        try (Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                Map<String, String> u = new HashMap<>();
                u.put("id", String.valueOf(rs.getInt("id")));
                u.put("name", rs.getString("full_name") != null ? rs.getString("full_name") : "Anonymous");
                u.put("email", rs.getString("email") != null ? rs.getString("email") : "N/A");
                u.put("type", rs.getString("user_type") != null ? rs.getString("user_type") : "recruiter");
                u.put("status", rs.getString("status") != null ? rs.getString("status") : "active");
                users.add(u);
            }
        }
        request.setAttribute("users", users);
        request.getRequestDispatcher("/pages/users.jsp").forward(request, response);
    }

    private void listJobs(Connection conn, HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        List<Map<String, String>> jobs = new ArrayList<>();
        String query = "SELECT * FROM jobs ORDER BY posted_at DESC";
        try (Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                Map<String, String> job = new HashMap<>();
                job.put("id", rs.getString("id"));
                job.put("title", rs.getString("title"));
                job.put("company", rs.getString("company_name"));
                job.put("salary", rs.getString("salary"));
                job.put("status", rs.getString("status"));
                jobs.add(job);
            }
        }
        request.setAttribute("jobs", jobs);
        request.getRequestDispatcher("/pages/jobs.jsp").forward(request, response);
    }

    private void listLogs(Connection conn, HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        List<Map<String, String>> logs = new ArrayList<>();
        String query = "SELECT * FROM system_logs ORDER BY timestamp DESC";
        try (Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                Map<String, String> log = new HashMap<>();
                log.put("action", rs.getString("action"));
                log.put("user", rs.getString("performed_by"));
                log.put("time", rs.getTimestamp("timestamp").toString());
                logs.add(log);
            }
        }
        request.setAttribute("logs", logs);
        request.getRequestDispatcher("/pages/logs.jsp").forward(request, response);
    }

    private void listCandidates(Connection conn, HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        List<Map<String, String>> items = new ArrayList<>();
        String query = "SELECT * FROM candidates ORDER BY applied_date DESC";
        try (Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                Map<String, String> item = new HashMap<>();
                item.put("id", rs.getString("id"));
                item.put("name", rs.getString("name"));
                item.put("email", rs.getString("email"));
                item.put("phone", rs.getString("phone"));
                item.put("status", rs.getString("status"));
                item.put("level", rs.getString("experience_level"));
                items.add(item);
            }
        }
        request.setAttribute("candidates", items);
        request.getRequestDispatcher("/pages/candidates.jsp").forward(request, response);
    }

    private void listCategories(Connection conn, HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        List<Map<String, String>> items = new ArrayList<>();
        String query = "SELECT * FROM categories ORDER BY name ASC";
        try (Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                Map<String, String> item = new HashMap<>();
                item.put("name", rs.getString("name"));
                item.put("description", rs.getString("description"));
                item.put("date", rs.getTimestamp("created_at").toString());
                items.add(item);
            }
        }
        request.setAttribute("categories", items);
        request.getRequestDispatcher("/pages/categories.jsp").forward(request, response);
    }

    private void listInterviews(Connection conn, HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        List<Map<String, String>> items = new ArrayList<>();
        String query = "SELECT i.*, c.name as candidate_name FROM interviews i " +
                      "JOIN applications a ON i.application_id = a.id " +
                      "JOIN candidates c ON a.candidate_id = c.id ORDER BY scheduled_at DESC";
        try (Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                Map<String, String> item = new HashMap<>();
                item.put("id", rs.getString("id"));
                item.put("candidate", rs.getString("candidate_name"));
                item.put("time", rs.getTimestamp("scheduled_at") != null ? rs.getTimestamp("scheduled_at").toString() : "N/A");
                item.put("interviewer", rs.getString("interviewer"));
                item.put("status", rs.getString("status"));
                items.add(item);
            }
        }
        request.setAttribute("interviews", items);
        request.getRequestDispatcher("/pages/interviews.jsp").forward(request, response);
    }

    private void listApplications(Connection conn, HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        List<Map<String, String>> items = new ArrayList<>();
        String query = "SELECT a.*, c.name as candidate_name, j.title as job_title FROM applications a " +
                      "LEFT JOIN candidates c ON a.candidate_id = c.id " +
                      "LEFT JOIN jobs j ON a.job_id = j.id ORDER BY a.applied_at DESC";
        try (Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                Map<String, String> item = new HashMap<>();
                item.put("id", String.valueOf(rs.getInt("id")));
                String candName = rs.getString("candidate_name");
                String jobTitle = rs.getString("job_title");
                item.put("candidate", candName != null ? candName : "Unknown Candidate");
                item.put("job", jobTitle != null ? jobTitle : "Unknown Job");
                item.put("status", rs.getString("status") != null ? rs.getString("status") : "applied");
                Timestamp appliedAt = rs.getTimestamp("applied_at");
                item.put("date", appliedAt != null ? appliedAt.toString() : "N/A");
                items.add(item);
            }
        }
        request.setAttribute("applications", items);
        request.getRequestDispatcher("/pages/jobBoard.jsp").forward(request, response);
    }

    private void listShortlisted(Connection conn, HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        List<Map<String, String>> items = new ArrayList<>();
        String query = "SELECT * FROM candidates WHERE status = 'shortlisted' ORDER BY applied_date DESC";
        try (Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                Map<String, String> item = new HashMap<>();
                item.put("id", rs.getString("id"));
                item.put("name", rs.getString("name"));
                item.put("email", rs.getString("email"));
                item.put("status", rs.getString("status"));
                items.add(item);
            }
        }
        request.setAttribute("shortlisted", items);
        request.getRequestDispatcher("/pages/shortlisted.jsp").forward(request, response);
    }

    private void saveJob(Connection conn, HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, IOException {
        String title = request.getParameter("title");
        String company = request.getParameter("company");
        String location = request.getParameter("location");
        String salary = request.getParameter("salary");
        String status = request.getParameter("status");

        String query = "INSERT INTO jobs (title, company_name, location, salary, status) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setString(1, title);
            pstmt.setString(2, company);
            pstmt.setString(3, location);
            pstmt.setString(4, salary);
            pstmt.setString(5, status);
            pstmt.executeUpdate();
            logAction(conn, "Admin posted new Job: " + title + " at " + company, "admin");
        }
        response.sendRedirect("admin?action=jobs");
    }

    private void saveCandidate(Connection conn, HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String level = request.getParameter("level");
        String status = request.getParameter("status");

        String query = "INSERT INTO candidates (name, email, phone, experience_level, status) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setString(1, name);
            pstmt.setString(2, email);
            pstmt.setString(3, phone);
            pstmt.setString(4, level);
            pstmt.setString(5, status);
            pstmt.executeUpdate();
            logAction(conn, "Admin added new Candidate: " + name, "admin");
        }
        response.sendRedirect("admin?action=candidates");
    }

    private void saveCategory(Connection conn, HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, IOException {
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String query = "INSERT INTO categories (name, description) VALUES (?, ?)";
        try (PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setString(1, name);
            pstmt.setString(2, description);
            pstmt.executeUpdate();
            logAction(conn, "Admin created category: " + name, "admin");
        }
        response.sendRedirect("admin?action=categories");
    }

    private void updateUserStatus(Connection conn, HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("userId"));
        String status = request.getParameter("status");
        String query = "UPDATE users SET status = ? WHERE id = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setString(1, status);
            pstmt.setInt(2, id);
            pstmt.executeUpdate();
            logAction(conn, "Admin changed status of User #" + id + " to " + status, "admin");
        }
        response.sendRedirect("admin?action=users");
    }

    private void updateJobStatus(Connection conn, HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("jobId"));
        String status = request.getParameter("status");
        String query = "UPDATE jobs SET status = ? WHERE id = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setString(1, status);
            pstmt.setInt(2, id);
            pstmt.executeUpdate();
            logAction(conn, "Admin " + status + " Job #" + id, "admin");
        }
        response.sendRedirect("admin?action=jobs");
    }

    private void logAction(Connection conn, String action, String user) throws SQLException {
        String query = "INSERT INTO system_logs (action, performed_by) VALUES (?, ?)";
        try (PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setString(1, action);
            pstmt.setString(2, user);
            pstmt.executeUpdate();
        }
    }
}
