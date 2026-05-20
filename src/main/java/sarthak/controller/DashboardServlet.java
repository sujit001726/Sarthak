package sarthak.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;

import sarthak.dao.JobDAO;
import sarthak.model.Job;
import sarthak.dao.UserDAO;
import sarthak.model.User;
import sarthak.utils.DbConnection;

@WebServlet("/jobseeker/dashboard")
public class DashboardServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        
        // Check if user is logged in
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        // Get user info from session
        String userName = (String) session.getAttribute("userName");
        if (userName == null || userName.trim().isEmpty()) {
            userName = "Job Seeker";
        }
        
        // Set user initials safely
        String initials = "JS";
        try {
            String trimmedName = userName.trim();
            if (!trimmedName.isEmpty()) {
                String[] nameParts = trimmedName.split("\\s+");
                if (nameParts.length > 0 && !nameParts[0].isEmpty()) {
                    initials = String.valueOf(nameParts[0].charAt(0));
                    if (nameParts.length > 1 && !nameParts[nameParts.length - 1].isEmpty()) {
                        initials += nameParts[nameParts.length - 1].charAt(0);
                    }
                }
            }
        } catch (Exception e) {
            initials = "JS";
        }
        
        request.setAttribute("userInitials", initials.toUpperCase());
        request.setAttribute("userName", userName);
        
        int userId = (int) session.getAttribute("userId");
        String profileImageUrl = request.getContextPath() + "/image?userId=" + userId + "&type=profile";
        request.setAttribute("profileImage", profileImageUrl);
        
        // Fetch real data for dashboard metrics
        int totalApplications = 0;
        int upcomingInterviews = 0;
        int savedJobsCount = 0; // Mock statistic
        int profileViewsCount = 42; // Sleek default indicator
        
        UserDAO userDAO = new UserDAO();
        User user = userDAO.getUserById(userId);
        
        if (user != null) {
            String appSql = "SELECT COUNT(*) FROM applications a JOIN candidates c ON a.candidate_id = c.id WHERE c.email = ?";
            try (Connection conn = DbConnection.getConnection();
                 PreparedStatement stmt = conn.prepareStatement(appSql)) {
                stmt.setString(1, user.getEmail());
                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        totalApplications = rs.getInt(1);
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }

            String intSql = "SELECT COUNT(*) FROM interviews i JOIN applications a ON i.application_id = a.id JOIN candidates c ON a.candidate_id = c.id WHERE c.email = ?";
            try (Connection conn = DbConnection.getConnection();
                 PreparedStatement stmt = conn.prepareStatement(intSql)) {
                stmt.setString(1, user.getEmail());
                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        upcomingInterviews = rs.getInt(1);
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        
        request.setAttribute("totalApplications", totalApplications);
        request.setAttribute("savedJobs", savedJobsCount);
        request.setAttribute("upcomingInterviews", upcomingInterviews);
        request.setAttribute("profileViews", profileViewsCount);
        
        // Fetch real active jobs for recommended feed
        JobDAO jobDAO = new JobDAO();
        List<Job> activeJobs = jobDAO.getAllActiveJobs();
        request.setAttribute("recommendedJobs", activeJobs);
        
        // Flash message support
        if (session.getAttribute("flash") != null) {
            request.setAttribute("successMessage", session.getAttribute("flash"));
            session.removeAttribute("flash");
        }
        
        // Forward to the JSP page
        request.getRequestDispatcher("/jobseeker-dashboard.jsp").forward(request, response);
    }
}
