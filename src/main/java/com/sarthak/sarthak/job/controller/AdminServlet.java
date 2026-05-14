package com.sarthak.sarthak.job.controller;

import com.sarthak.sarthak.job.dao.impl.CandidateDAOImpl;
import com.sarthak.sarthak.job.dao.impl.JobDAOImpl;
import com.sarthak.sarthak.job.dao.interfaces.CandidateDAOInterface;
import com.sarthak.sarthak.job.dao.interfaces.JobDAOInterface;
import com.sarthak.sarthak.job.dto.JobCandidateDTO;
import com.sarthak.sarthak.job.model.Candidate;
import com.sarthak.sarthak.job.model.Job;
import com.sarthak.sarthak.user.dao.impl.UserDAOImpl;
import com.sarthak.sarthak.user.dao.interfaces.UserDAOInterface;
import com.sarthak.sarthak.user.model.User;
import com.sarthak.sarthak.util.DBConnection;
import com.sarthak.sarthak.util.Queries;

import java.io.IOException;
import java.sql.*;
import java.util.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

// @WebServlet("/admin")
public class AdminServlet extends HttpServlet {

    private final JobDAOInterface jobDAO           = new JobDAOImpl();
    private final CandidateDAOInterface candidateDAO = new CandidateDAOImpl();
    private final UserDAOInterface userDAO          = new UserDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) action = "dashboard";

        try {
            switch (action) {
                case "users":       showUsers(request, response);       break;
                case "jobs":        showJobs(request, response);        break;
                case "candidates":  showCandidates(request, response);  break;
                case "shortlisted": showShortlisted(request, response); break;
                case "downloadResume": downloadResume(request, response); break;
                case "jobBoard":    showJobBoard(request, response);    break;
                case "categories":  showCategories(request, response);  break;
                case "interviews":  showInterviews(request, response);  break;
                case "logs":        showLogs(request, response);        break;
                case "addJob":      request.getRequestDispatcher("/pages/addJob.jsp").forward(request, response); break;
                case "addCandidate":request.getRequestDispatcher("/pages/addCandidate.jsp").forward(request, response); break;
                case "addCategory": request.getRequestDispatcher("/pages/addCategory.jsp").forward(request, response); break;
                default:            showDashboard(request, response);   break;
            }
        } catch (Exception e) {
            handleError(e, request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        try {
            switch (action != null ? action : "") {
                case "saveJob":           saveJob(request, response);           break;
                case "saveCandidate":     saveCandidate(request, response);     break;
                case "deleteCandidate":  deleteCandidate(request, response);  break;
                case "saveCategory":      saveCategory(request, response);      break;
                case "updateJobStatus":   updateJobStatus(request, response);   break;
                case "updateUserStatus":  updateUserStatus(request, response);  break;
                case "scheduleInterview": scheduleInterview(request, response); break;
                default: response.sendRedirect("admin?action=dashboard");
            }
        } catch (Exception e) {
            handleError(e, request, response);
        }
    }

    // ── Dashboard ────────────────────────────────────────────────────────────

    private void showDashboard(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement()) {

            ResultSet rs = stmt.executeQuery("SELECT COUNT(*) FROM candidates");
            if (rs.next()) request.setAttribute("userCount", rs.getInt(1));

            rs = stmt.executeQuery("SELECT COUNT(*) FROM jobs WHERE status='approved'");
            if (rs.next()) request.setAttribute("jobCount", rs.getInt(1));

            rs = stmt.executeQuery("SELECT COUNT(*) FROM applications");
            if (rs.next()) request.setAttribute("appCount", rs.getInt(1));

            rs = stmt.executeQuery("SELECT COUNT(*) FROM interviews");
            if (rs.next()) request.setAttribute("interviewCount", rs.getInt(1));

            rs = stmt.executeQuery("SELECT COUNT(*) FROM candidates WHERE status='hired'");
            if (rs.next()) request.setAttribute("hiredCount", rs.getInt(1));

            rs = stmt.executeQuery("SELECT COUNT(*) FROM candidates WHERE status='rejected'");
            if (rs.next()) request.setAttribute("rejectedCount", rs.getInt(1));
        }
        request.setAttribute("recentJobs", jobDAO.getRecentJobs(4));
        request.getRequestDispatcher("/pages/dashboard.jsp").forward(request, response);
    }

    // ── Users ────────────────────────────────────────────────────────────────

    private void showUsers(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        List<User> users = userDAO.getAllUsers();
        request.setAttribute("users", users);
        request.getRequestDispatcher("/pages/users.jsp").forward(request, response);
    }

    private void updateUserStatus(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        int id = Integer.parseInt(request.getParameter("userId"));
        String status = request.getParameter("status");
        userDAO.updateUserStatus(id, status);
        logAction("Admin changed status of User #" + id + " to " + status);
        response.sendRedirect("admin?action=users");
    }

    // ── Jobs ─────────────────────────────────────────────────────────────────

    private void showJobs(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        request.setAttribute("jobs", jobDAO.getAllJobs());
        request.getRequestDispatcher("/pages/jobs.jsp").forward(request, response);
    }

    private void saveJob(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        String title   = request.getParameter("title");
        String company = request.getParameter("company");
        String location= request.getParameter("location");
        String salary  = request.getParameter("salary");
        String status  = request.getParameter("status");
        jobDAO.saveJob(title, company, location, salary, status);
        logAction("Admin posted new Job: " + title + " at " + company);
        response.sendRedirect("admin?action=jobs");
    }

    private void updateJobStatus(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        int id = Integer.parseInt(request.getParameter("jobId"));
        String status = request.getParameter("status");
        jobDAO.updateJobStatus(id, status);
        logAction("Admin " + status + " Job #" + id);
        response.sendRedirect("admin?action=jobs");
    }

    // ── Candidates ───────────────────────────────────────────────────────────

    private void showCandidates(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        request.setAttribute("candidates", candidateDAO.getAllCandidates());
        request.getRequestDispatcher("/pages/candidates.jsp").forward(request, response);
    }

    private void showShortlisted(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        request.setAttribute("shortlisted", candidateDAO.getShortlisted());
        request.getRequestDispatcher("/pages/shortlisted.jsp").forward(request, response);
    }

    private void deleteCandidate(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        int id = Integer.parseInt(request.getParameter("candidateId"));
        // Remove dependent applications first to avoid FK constraint
        try (Connection conn = DBConnection.getConnection()) {
            try (PreparedStatement ps = conn.prepareStatement(
                    "DELETE FROM interviews WHERE application_id IN (SELECT id FROM applications WHERE candidate_id = ?)")) {
                ps.setInt(1, id); ps.executeUpdate();
            }
            try (PreparedStatement ps = conn.prepareStatement(
                    "DELETE FROM applications WHERE candidate_id = ?")) {
                ps.setInt(1, id); ps.executeUpdate();
            }
            try (PreparedStatement ps = conn.prepareStatement(
                    "DELETE FROM candidates WHERE id = ?")) {
                ps.setInt(1, id); ps.executeUpdate();
            }
        }
        logAction("Admin deleted Candidate #" + id);
        response.sendRedirect("admin?action=candidates");
    }

    private void downloadResume(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        int id = Integer.parseInt(request.getParameter("id"));
        String resumePath = null;
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement("SELECT resume_path FROM candidates WHERE id = ?")) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) resumePath = rs.getString("resume_path");
            }
        }
        if (resumePath == null || resumePath.isBlank()) {
            request.setAttribute("errorMessage", "No resume uploaded for this candidate.");
            request.setAttribute("errorDetail", "Ask the candidate to upload their resume first.");
            request.getRequestDispatcher("/pages/error.jsp").forward(request, response);
            return;
        }
        response.sendRedirect(request.getContextPath() + "/" + resumePath);
    }

    private void saveCandidate(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        String name   = request.getParameter("name");
        String email  = request.getParameter("email");
        String phone  = request.getParameter("phone");
        String level  = request.getParameter("level");
        String status = request.getParameter("status");
        candidateDAO.saveCandidate(name, email, phone, level, status);
        logAction("Admin added new Candidate: " + name);
        response.sendRedirect("admin?action=candidates");
    }

    // ── Job Board (Applications) ──────────────────────────────────────────────

    private void showJobBoard(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        List<JobCandidateDTO> applications = new ArrayList<>();
        String sql = "SELECT a.id, c.name, j.title, a.status, a.applied_at " +
                     "FROM applications a " +
                     "JOIN candidates c ON a.candidate_id = c.id " +
                     "JOIN jobs j ON a.job_id = j.id ORDER BY a.applied_at DESC";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                applications.add(new JobCandidateDTO(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getString("title"),
                    rs.getString("status"),
                    rs.getTimestamp("applied_at").toString()
                ));
            }
        }
        request.setAttribute("applications", applications);
        request.getRequestDispatcher("/pages/jobBoard.jsp").forward(request, response);
    }

    // ── Categories ───────────────────────────────────────────────────────────

    private void showCategories(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        List<Map<String, String>> items = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(Queries.ALL_CATEGORIES)) {
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

    private void saveCategory(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        String name = request.getParameter("name");
        String desc = request.getParameter("description");
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(Queries.INSERT_CATEGORY)) {
            ps.setString(1, name);
            ps.setString(2, desc);
            ps.executeUpdate();
        }
        logAction("Admin created category: " + name);
        response.sendRedirect("admin?action=categories");
    }

    // ── Interviews ───────────────────────────────────────────────────────────

    private void showInterviews(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        List<Map<String, String>> items = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(Queries.ALL_INTERVIEWS)) {
            while (rs.next()) {
                Map<String, String> item = new HashMap<>();
                item.put("id", rs.getString("id"));
                item.put("candidate", rs.getString("candidate_name"));
                item.put("time", rs.getTimestamp("scheduled_at") != null
                        ? rs.getTimestamp("scheduled_at").toString() : "N/A");
                item.put("interviewer", rs.getString("interviewer"));
                item.put("status", rs.getString("status"));
                items.add(item);
            }
        }
        request.setAttribute("interviews", items);

        // Load applications for the schedule modal dropdown
        List<JobCandidateDTO> apps = new ArrayList<>();
        String sql = "SELECT a.id, c.name, j.title, a.status, a.applied_at " +
                     "FROM applications a " +
                     "JOIN candidates c ON a.candidate_id = c.id " +
                     "JOIN jobs j ON a.job_id = j.id ORDER BY c.name ASC";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                apps.add(new JobCandidateDTO(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getString("title"),
                    rs.getString("status"),
                    rs.getTimestamp("applied_at").toString()
                ));
            }
        }
        request.setAttribute("applications", apps);
        request.getRequestDispatcher("/pages/interviews.jsp").forward(request, response);
    }

    private void scheduleInterview(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        int applicationId  = Integer.parseInt(request.getParameter("applicationId"));
        String interviewer = request.getParameter("interviewer");
        String scheduledAt = request.getParameter("scheduledAt"); // "yyyy-MM-ddTHH:mm"
        String status      = request.getParameter("status");

        String sql = "INSERT INTO interviews (application_id, scheduled_at, interviewer, status) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, applicationId);
            ps.setString(2, scheduledAt.replace("T", " ") + ":00");
            ps.setString(3, interviewer);
            ps.setString(4, status);
            ps.executeUpdate();
        }
        logAction("Admin scheduled interview with interviewer: " + interviewer);
        response.sendRedirect("admin?action=interviews");
    }

    // ── Logs ─────────────────────────────────────────────────────────────────

    private void showLogs(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        List<Map<String, String>> logs = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(Queries.ALL_LOGS)) {
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

    // ── Helpers ───────────────────────────────────────────────────────────────

    private void logAction(String action) {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(Queries.INSERT_LOG)) {
            ps.setString(1, action);
            ps.setString(2, "admin");
            ps.executeUpdate();
        } catch (SQLException ignored) {}
    }

    private void handleError(Exception e, HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        e.printStackTrace();
        String msg = e.getMessage();
        String detail = "Check server logs for stack trace.";
        if (msg != null && msg.contains("doesn't exist")) {
            detail = "Database tables are missing. Run schema.sql in your MySQL client.";
        } else if (msg != null && msg.contains("Access denied")) {
            detail = "Database login failed. Check credentials in DBConnection.java.";
        }
        request.setAttribute("errorMessage", msg);
        request.setAttribute("errorDetail", detail);
        request.getRequestDispatcher("/pages/error.jsp").forward(request, response);
    }
}
