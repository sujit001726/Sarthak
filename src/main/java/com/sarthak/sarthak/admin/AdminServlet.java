package com.sarthak.sarthak.admin;

import com.sarthak.sarthak.util.DBConnection;
import java.io.IOException;
import java.sql.*;
import java.util.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/admin")
public class AdminServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        if (action == null) action = "dashboard";

        try (Connection conn = DBConnection.getConnection()) {
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
                    request.getRequestDispatcher("/pages/interviews.jsp").forward(request, response);
                    break;
                case "jobBoard":
                    request.getRequestDispatcher("/pages/jobBoard.jsp").forward(request, response);
                    break;
                case "quizzes":
                    request.getRequestDispatcher("/pages/quizzes.jsp").forward(request, response);
                    break;
                case "interviewDesigner":
                    request.getRequestDispatcher("/pages/interviewDesigner.jsp").forward(request, response);
                    break;
                case "traits":
                    request.getRequestDispatcher("/pages/traits.jsp").forward(request, response);
                    break;
                case "categories":
                    request.getRequestDispatcher("/pages/categories.jsp").forward(request, response);
                    break;
                case "candidates":
                    request.getRequestDispatcher("/pages/candidates.jsp").forward(request, response);
                    break;
                case "videoResume":
                    request.getRequestDispatcher("/pages/videoResume.jsp").forward(request, response);
                    break;
                case "shortlisted":
                    request.getRequestDispatcher("/pages/shortlisted.jsp").forward(request, response);
                    break;
                case "dashboard":
                default:
                    showDashboard(conn, request, response);
                    break;
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");
        try (Connection conn = DBConnection.getConnection()) {
            if ("updateUserStatus".equals(action)) {
                updateUserStatus(conn, request, response);
            } else if ("updateJobStatus".equals(action)) {
                updateJobStatus(conn, request, response);
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    private void showDashboard(Connection conn, HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        
        // 1. Fetch Basic Stats
        try (Statement stmt = conn.createStatement()) {
            ResultSet rs = stmt.executeQuery("SELECT COUNT(*) FROM users");
            if (rs.next()) request.setAttribute("userCount", rs.getInt(1));
            
            rs = stmt.executeQuery("SELECT COUNT(*) FROM jobs WHERE status='approved'");
            if (rs.next()) request.setAttribute("jobCount", rs.getInt(1));

            rs = stmt.executeQuery("SELECT COUNT(*) FROM jobs WHERE status='pending'");
            if (rs.next()) request.setAttribute("pendingCount", rs.getInt(1));
            
            // Set Admin Name (In real app, fetch from session)
            request.setAttribute("adminName", "Sarthak Admin");
        }
        
        // 2. Fetch Recent Job Ads for the table
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
        
        // 3. Fetch Recent Activity Logs
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
                Map<String, String> user = new HashMap<>();
                user.put("id", rs.getString("id"));
                user.put("name", rs.getString("full_name"));
                user.put("email", rs.getString("email"));
                user.put("type", rs.getString("user_type"));
                user.put("status", rs.getString("status"));
                users.add(user);
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
