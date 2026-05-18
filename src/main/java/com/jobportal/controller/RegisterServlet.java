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

        if (fullName.isEmpty()) {
            req.setAttribute("error", "Full Name is required");
        } else if (email.isEmpty() || !email.matches("^[\\w.+-]+@[\\w-]+\\.[\\w.]+$")) {
            req.setAttribute("error", "Valid Email is required");
        } else if (password.length() < 6) {
            req.setAttribute("error", "Password must be at least 6 characters long");
        } else if (!password.equals(confirmPassword)) {
            req.setAttribute("error", "Passwords do not match");
        } else if (userDAO.emailExists(email)) {
            req.setAttribute("error", "Email is already registered");
        }

        if (req.getAttribute("error") != null) {
            req.getRequestDispatcher("/register.jsp").forward(req, resp);
            return;
        }

        User.Role role;
        try {
            role = User.Role.valueOf(roleParam);
        } catch (IllegalArgumentException e) {
            role = User.Role.job_seeker;
        }

        String passwordHash = PasswordUtil.encrypt(password);
        User newUser = new User(fullName, email, passwordHash, role);

        String targetJsp = "/register.jsp";
        if (role == User.Role.job_seeker) targetJsp = "/register-seeker.jsp";
        else if (role == User.Role.employer) targetJsp = "/register-employer.jsp";

        try {
            boolean created = userDAO.createUser(newUser);
            if (created) {
                req.setAttribute("successMessage", "Registration Successful");
            } else {
                req.setAttribute("error", "Registration Failed: Database error");
            }
        } catch (SQLException e) {
            req.setAttribute("error", "Database Error: " + e.getMessage());
        } catch (Exception e) {
            req.setAttribute("error", "Error: " + e.getMessage());
        }
        req.getRequestDispatcher(targetJsp).forward(req, resp);
    }
}
