package sarthak.controller;

import sarthak.utils.DbConnection;
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

        try (Connection conn = DbConnection.getConnection()) {
            if (conn == null) {
                throw new SQLException("Could not establish database connection. Check DbConnection.java.");
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
        try (Connection conn = DbConnection.getConnection()) {
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
            } else if ("deleteCategory".equals(action)) {
                deleteCategory(conn, request, response);
            } else if ("deleteCandidate".equals(action)) {
                deleteCandidate(conn, request, response);
            } else if ("deleteUser".equals(action)) {
                deleteUser(conn, request, response);
            } else if ("scheduleInterview".equals(action)) {
                scheduleInterview(conn, request, response);
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
            detail = "Database login failed. Open 'src/main/java/sarthak/utils/DbConnection.java' and verify your MySQL password.";
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
            String query = "SELECT j.title, j.company_name as old_company_name, u.full_name as employer_name " +
                           "FROM jobs j LEFT JOIN users u ON j.employer_id = u.id " +
                           "ORDER BY j.posted_at DESC LIMIT 4";
            ResultSet rs = stmt.executeQuery(query);
            while (rs.next()) {
                Map<String, String> job = new HashMap<>();
                job.put("title", rs.getString("title"));
                String companyName = rs.getString("employer_name");
                if (companyName == null || companyName.isEmpty()) {
                    companyName = rs.getString("old_company_name");
                }
                job.put("companyName", companyName != null ? companyName : "N/A");
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
                u.put("fullName", rs.getString("full_name") != null ? rs.getString("full_name") : "Anonymous");
                u.put("email", rs.getString("email") != null ? rs.getString("email") : "N/A");
                u.put("userType", rs.getString("user_type") != null ? rs.getString("user_type") : "recruiter");
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
        String query = "SELECT j.id, j.title, j.salary, j.salary_range, j.company_name as old_company_name, u.full_name as employer_name, j.status " +
                       "FROM jobs j LEFT JOIN users u ON j.employer_id = u.id " +
                       "ORDER BY j.posted_at DESC";
        try (Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                Map<String, String> job = new HashMap<>();
                job.put("id", rs.getString("id"));
                job.put("title", rs.getString("title"));
                
                String companyName = rs.getString("employer_name");
                if (companyName == null || companyName.isEmpty()) {
                    companyName = rs.getString("old_company_name");
                }
                job.put("companyName", companyName != null ? companyName : "N/A");
                
                String salary = rs.getString("salary_range");
                if (salary == null || salary.trim().isEmpty()) {
                    salary = rs.getString("salary");
                }
                job.put("salary", (salary != null && !salary.trim().isEmpty()) ? salary : "Not specified");
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
                item.put("id", String.valueOf(rs.getInt("id")));
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
        String query = "SELECT i.*, c.name as candidate_name, j.company_name as company_name FROM interviews i " +
                      "JOIN applications a ON i.application_id = a.id " +
                      "JOIN candidates c ON a.candidate_id = c.id " +
                      "JOIN jobs j ON a.job_id = j.id ORDER BY scheduled_at DESC";
        try (Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                Map<String, String> item = new HashMap<>();
                item.put("id", rs.getString("id"));
                item.put("candidate", rs.getString("candidate_name"));
                item.put("companyName", rs.getString("company_name"));
                item.put("time", rs.getTimestamp("scheduled_at") != null ? rs.getTimestamp("scheduled_at").toString() : "N/A");
                item.put("interviewer", rs.getString("interviewer"));
                item.put("status", rs.getString("status"));
                items.add(item);
            }
        }
        // Also fetch applications for the "New Interview" dropdown
        List<Map<String, String>> apps = new ArrayList<>();
        String appQuery = "SELECT a.id, c.name as candidate_name, j.title as job_title, j.company_name " +
                          "FROM applications a " +
                          "JOIN candidates c ON a.candidate_id = c.id " +
                          "JOIN jobs j ON a.job_id = j.id " +
                          "ORDER BY a.applied_at DESC";
        try (Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(appQuery)) {
            while (rs.next()) {
                Map<String, String> app = new HashMap<>();
                app.put("id", String.valueOf(rs.getInt("id")));
                app.put("candidate", rs.getString("candidate_name"));
                app.put("job", rs.getString("job_title"));
                app.put("company", rs.getString("company_name"));
                apps.add(app);
            }
        }
        // Fetch jobs for the dropdown
        List<Map<String, String>> jobs = new ArrayList<>();
        try (Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery("SELECT id, title, company_name FROM jobs ORDER BY title ASC")) {
            while (rs.next()) {
                Map<String, String> j = new HashMap<>();
                j.put("id", String.valueOf(rs.getInt("id")));
                j.put("title", rs.getString("title"));
                j.put("company", rs.getString("company_name"));
                jobs.add(j);
            }
        }
        
        // Fetch candidates for the dropdown
        List<Map<String, String>> cands = new ArrayList<>();
        try (Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery("SELECT id, name FROM candidates ORDER BY name ASC")) {
            while (rs.next()) {
                Map<String, String> c = new HashMap<>();
                c.put("id", String.valueOf(rs.getInt("id")));
                c.put("name", rs.getString("name"));
                cands.add(c);
            }
        }

        request.setAttribute("jobs", jobs);
        request.setAttribute("candidates", cands);
        request.setAttribute("interviews", items);
        request.getRequestDispatcher("/pages/interviews.jsp").forward(request, response);
    }

    private void listApplications(Connection conn, HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        List<Map<String, String>> items = new ArrayList<>();
        String query = "SELECT a.*, c.name as candidate_name, j.title as job_title, j.company_name as company_name FROM applications a " +
                      "LEFT JOIN candidates c ON a.candidate_id = c.id " +
                      "LEFT JOIN jobs j ON a.job_id = j.id ORDER BY a.applied_at DESC";
        try (Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                Map<String, String> item = new HashMap<>();
                item.put("id", String.valueOf(rs.getInt("id")));
                String candName = rs.getString("candidate_name");
                String jobTitle = rs.getString("job_title");
                item.put("candidateName", candName != null ? candName : "Unknown Candidate");
                item.put("jobTitle", jobTitle != null ? jobTitle : "Unknown Job");
                item.put("companyName", rs.getString("company_name") != null ? rs.getString("company_name") : "N/A");
                item.put("status", rs.getString("status") != null ? rs.getString("status") : "applied");
                Timestamp appliedAt = rs.getTimestamp("applied_at");
                item.put("appliedAt", appliedAt != null ? appliedAt.toString() : "N/A");
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

    private void deleteCategory(Connection conn, HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("categoryId"));
        String query = "DELETE FROM categories WHERE id = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, id);
            pstmt.executeUpdate();
            logAction(conn, "Admin deleted Category #" + id, "admin");
        }
        response.sendRedirect("admin?action=categories");
    }

    private void scheduleInterview(Connection conn, HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, IOException {
        int jobId = Integer.parseInt(request.getParameter("jobId"));
        String candidateName = request.getParameter("candidateName");
        String interviewer = request.getParameter("interviewer");
        String scheduledAt = request.getParameter("scheduledAt").replace("T", " ") + ":00";
        String status = request.getParameter("status");

        // 1. Find or create candidate
        int candidateId = -1;
        String findCand = "SELECT id FROM candidates WHERE name = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(findCand)) {
            pstmt.setString(1, candidateName);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    candidateId = rs.getInt("id");
                }
            }
        }

        if (candidateId == -1) {
            String createCand = "INSERT INTO candidates (name, email, status) VALUES (?, ?, 'applied')";
            try (PreparedStatement pstmt = conn.prepareStatement(createCand, Statement.RETURN_GENERATED_KEYS)) {
                pstmt.setString(1, candidateName);
                pstmt.setString(2, candidateName.toLowerCase().replaceAll("\\s+", ".") + "@example.com");
                pstmt.executeUpdate();
                try (ResultSet keys = pstmt.getGeneratedKeys()) {
                    if (keys.next()) candidateId = keys.getInt(1);
                }
            }
        }

        // 2. Find or create application_id
        int applicationId = -1;
        String findApp = "SELECT id FROM applications WHERE job_id = ? AND candidate_id = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(findApp)) {
            pstmt.setInt(1, jobId);
            pstmt.setInt(2, candidateId);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    applicationId = rs.getInt("id");
                }
            }
        }

        if (applicationId == -1) {
            String createApp = "INSERT INTO applications (job_id, candidate_id, status) VALUES (?, ?, 'screened')";
            try (PreparedStatement pstmt = conn.prepareStatement(createApp, Statement.RETURN_GENERATED_KEYS)) {
                pstmt.setInt(1, jobId);
                pstmt.setInt(2, candidateId);
                pstmt.executeUpdate();
                try (ResultSet keys = pstmt.getGeneratedKeys()) {
                    if (keys.next()) applicationId = keys.getInt(1);
                }
            }
        }

        // 2. Insert interview
        String insertQuery = "INSERT INTO interviews (application_id, scheduled_at, interviewer, status) VALUES (?, ?, ?, ?)";
        try (PreparedStatement pstmt = conn.prepareStatement(insertQuery)) {
            pstmt.setInt(1, applicationId);
            pstmt.setString(2, scheduledAt);
            pstmt.setString(3, interviewer);
            pstmt.setString(4, status);
            pstmt.executeUpdate();
            
            logAction(conn, "Scheduled interview for Candidate #" + candidateId + " for Job #" + jobId, "admin");
        }
        response.sendRedirect("admin?action=interviews");
    }

    private void deleteCandidate(Connection conn, HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("candidateId"));
        String query = "DELETE FROM candidates WHERE id = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, id);
            pstmt.executeUpdate();
            logAction(conn, "Admin deleted Candidate #" + id, "admin");
        }
        response.sendRedirect("admin?action=candidates");
    }

    private void deleteUser(Connection conn, HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("userId"));
        
        // 1. Delete associated jobs (if user is an employer) to avoid foreign key constraint blocks
        try (PreparedStatement pstmt = conn.prepareStatement("DELETE FROM jobs WHERE employer_id = ?")) {
            pstmt.setInt(1, id);
            pstmt.executeUpdate();
        }
        
        // 2. Permanently delete the user
        String query = "DELETE FROM users WHERE id = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, id);
            pstmt.executeUpdate();
            logAction(conn, "Admin deleted User #" + id, "admin");
        }
        response.sendRedirect("admin?action=users");
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
