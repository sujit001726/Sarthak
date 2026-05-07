package com.sarthak.jobseeker.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

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
        
        // Mock data for dashboard
        request.setAttribute("totalApplications", 0);
        request.setAttribute("savedJobs", 0);
        request.setAttribute("upcomingInterviews", 0);
        request.setAttribute("profileViews", 0);
        
        // Forward to the JSP page
        request.getRequestDispatcher("/jobseeker-dashboard.jsp").forward(request, response);
    }
}
