package com.sarthak.jobseeker.controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class DashboardServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        
        // Mock user session for demonstration
        if(session.getAttribute("userName") == null) {
            session.setAttribute("userName", "Alex Johnson");
            session.setAttribute("userInitials", "AJ");
        }
        
        // Mocking DAO data fetching
        request.setAttribute("totalApplications", 14);
        request.setAttribute("savedJobs", 8);
        request.setAttribute("upcomingInterviews", 2);
        request.setAttribute("profileViews", 120);
        
        // Forward to the JSP page
        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }
}
