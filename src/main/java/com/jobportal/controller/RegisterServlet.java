package com.jobportal.controller;

import com.jobportal.dao.UserDAO;
import com.jobportal.model.User;
import com.jobportal.util.PasswordUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.SQLException;

/**
 * Handles user registration (POST /register).
 */
@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        String fullName        = req.getParameter("fullName")        != null ? req.getParameter("fullName").trim()               : "";
        String email           = req.getParameter("email")           != null ? req.getParameter("email").trim().toLowerCase()     : "";
        String password        = req.getParameter("password")        != null ? req.getParameter("password")                      : "";
        String confirmPassword = req.getParameter("confirmPassword") != null ? req.getParameter("confirmPassword")                : "";
        String roleParam       = req.getParameter("role")            != null ? req.getParameter("role")                          : "job_seeker";

        System.out.println("=== Registration Attempt ===");
        System.out.println("Full Name: " + fullName);
        System.out.println("Email: " + email);
        System.out.println("Role: " + roleParam);

        // Validation
        if (fullName.isEmpty()) {
            System.out.println("Registration failed: Full name is empty");
            req.setAttribute("error", "Full name is required");
            req.getRequestDispatcher("/register.jsp").forward(req, resp);
            return;
        }

        if (email.isEmpty() || !email.matches("^[\\w.+-]+@[\\w-]+\\.[\\w.]+$")) {
            System.out.println("Registration failed: Invalid email format");
            req.setAttribute("error", "Valid email is required");
            req.getRequestDispatcher("/register.jsp").forward(req, resp);
            return;
        }

        if (password.isEmpty() || password.length() < 6) {
            System.out.println("Registration failed: Password too short");
            req.setAttribute("error", "Password must be at least 6 characters");
            req.getRequestDispatcher("/register.jsp").forward(req, resp);
            return;
        }

        if (!password.equals(confirmPassword)) {
            System.out.println("Registration failed: Passwords don't match");
            req.setAttribute("error", "Passwords do not match");
            req.getRequestDispatcher("/register.jsp").forward(req, resp);
            return;
        }

        if (userDAO.emailExists(email)) {
            System.out.println("Registration failed: Email already exists - " + email);
            req.setAttribute("error", "Email already registered");
            req.getRequestDispatcher("/register.jsp").forward(req, resp);
            return;
        }

        User.Role role;
        try {
            role = User.Role.valueOf(roleParam);
        } catch (IllegalArgumentException e) {
            role = User.Role.job_seeker;
        }

        String passwordHash = PasswordUtil.hashPassword(password);
        System.out.println("Password hashed: " + passwordHash.substring(0, 20) + "...");

        User newUser = new User(fullName, email, passwordHash, role);

        String targetJsp = "/register.jsp";
        if (role == User.Role.job_seeker) targetJsp = "/register-seeker.jsp";
        else if (role == User.Role.employer) targetJsp = "/register-employer.jsp";

        try {
            boolean created = userDAO.createUser(newUser);
            if (created) {
                System.out.println("Registration successful for: " + email);
                req.setAttribute("successMessage", "Registration successful! You can now login.");
                req.setAttribute("registeredEmail", email);
            } else {
                System.out.println("Registration failed: Database insert returned false");
                req.setAttribute("error", "Registration failed. Please try again.");
            }
        } catch (Exception e) {
            System.out.println("Registration failed with exception: " + e.getMessage());
            e.printStackTrace();
            req.setAttribute("error", "Error: " + e.getMessage());
        }
        req.getRequestDispatcher(targetJsp).forward(req, resp);
    }
}
