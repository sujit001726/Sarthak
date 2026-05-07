package com.jobportal.controller;

import com.jobportal.dao.UserDAO;
import com.jobportal.model.User;
import com.jobportal.util.PasswordUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

/**
 * Handles user login (POST /login).
 */
@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        String email    = req.getParameter("email")    != null ? req.getParameter("email").trim().toLowerCase() : "";
        String password = req.getParameter("password") != null ? req.getParameter("password")                   : "";

        if (email.isEmpty() || password.isEmpty()) {
            req.setAttribute("error", "Email and password are required");
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
            return;
        }

        // Check if admin login
        if ("admin@gmail.com".equals(email) && "admin123".equals(password)) {
            // Admin login - create admin session
            HttpSession session = req.getSession(true);
            session.setAttribute("userId",   999);
            session.setAttribute("userName", "Admin");
            session.setAttribute("userRole", "admin");
            session.setAttribute("admin",    "Admin"); // for AuthFilter compatibility
            session.setMaxInactiveInterval(30 * 60);
            
            // Redirect to admin dashboard
            resp.sendRedirect(req.getContextPath() + "/admin?action=dashboard");
            return;
        }

        // Regular user login (job seeker or employer)
        User user = userDAO.getUserByEmail(email);

        if (user == null) {
            // User not found
            System.out.println("Login failed: User not found for email: " + email);
            req.setAttribute("error", "Invalid email or password");
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
            return;
        }

        // Verify password
        boolean passwordValid = PasswordUtil.verifyPassword(password, user.getPasswordHash());
        System.out.println("Login attempt for: " + email);
        System.out.println("Password valid: " + passwordValid);
        System.out.println("User role: " + user.getRole());

        if (!passwordValid) {
            // Password incorrect
            System.out.println("Login failed: Invalid password for email: " + email);
            req.setAttribute("error", "Invalid email or password");
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
            return;
        }

        // Create session for regular user
        HttpSession session = req.getSession(true);
        session.setAttribute("userId",   user.getId());
        session.setAttribute("userName", user.getFullName());
        session.setAttribute("userRole", user.getRole().name());
        session.setMaxInactiveInterval(30 * 60);

        System.out.println("Login successful for: " + email + " with role: " + user.getRole().name());

        // Redirect based on role
        String role = user.getRole().name();
        if ("employer".equals(role)) {
            // Set attributes needed by employer dashboard
            session.setAttribute("role", "employer");
            session.setAttribute("name", user.getFullName());
            resp.sendRedirect(req.getContextPath() + "/employer/dashboard");
        } else if ("job_seeker".equals(role)) {
            // Redirect to job seeker dashboard
            session.setAttribute("role", "job_seeker");
            session.setAttribute("name", user.getFullName());
            resp.sendRedirect(req.getContextPath() + "/jobseeker/dashboard");
        } else {
            // Unknown role
            req.setAttribute("error", "Invalid user role");
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
        }
    }
}
