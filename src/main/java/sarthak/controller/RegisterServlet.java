package sarthak.controller;

import sarthak.dao.UserDAO;
import sarthak.model.User;
import sarthak.utils.PasswordUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

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

        User.Role role;
        try {
            role = User.Role.valueOf(roleParam);
        } catch (IllegalArgumentException e) {
            role = User.Role.job_seeker;
        }

        String targetJsp = "/register.jsp";
        if (role == User.Role.job_seeker) targetJsp = "/register-seeker.jsp";
        else if (role == User.Role.employer) targetJsp = "/register-employer.jsp";

        // Precise input validation
        String errorMsg = null;
        if (fullName.isEmpty()) {
            errorMsg = "Full Name / Company Name is required.";
        } else if (email.isEmpty()) {
            errorMsg = "Email address is required.";
        } else if (!email.matches("^[\\w.+-]+@[\\w-]+\\.[\\w.]+$")) {
            errorMsg = "Please enter a valid email address.";
        } else if (userDAO.emailExists(email)) {
            errorMsg = "Email is already registered! Please log in instead.";
        } else if (password.isEmpty()) {
            errorMsg = "Password is required.";
        } else if (password.length() < 6) {
            errorMsg = "Password must be at least 6 characters long.";
        } else if (!password.equals(confirmPassword)) {
            errorMsg = "Passwords do not match.";
        }

        if (errorMsg != null) {
            req.setAttribute("error", errorMsg);
            req.setAttribute("fullName", fullName);
            req.setAttribute("email", email);
            req.getRequestDispatcher(targetJsp).forward(req, resp);
            return;
        }

        String passwordHash = PasswordUtil.hashPassword(password);
        User newUser = new User(fullName, email, passwordHash, role);

        try {
            boolean created = userDAO.createUser(newUser);
            if (created) {
                // Fetch the newly created user to retrieve their auto-generated ID
                User registeredUser = userDAO.getUserByEmail(email);
                if (registeredUser != null) {
                    HttpSession session = req.getSession(true);
                    session.setAttribute("userId", registeredUser.getId());
                    session.setAttribute("userName", registeredUser.getFullName());
                    session.setAttribute("name", registeredUser.getFullName());
                    session.setAttribute("userRole", registeredUser.getRole().name());
                    session.setAttribute("role", registeredUser.getRole().name());
                    session.setMaxInactiveInterval(30 * 60);

                    // Redirect directly to their dashboard for a smooth onboarding UX
                    if (role == User.Role.employer) {
                        resp.sendRedirect(req.getContextPath() + "/employer/dashboard");
                    } else {
                        resp.sendRedirect(req.getContextPath() + "/jobseeker/dashboard");
                    }
                    return;
                } else {
                    req.setAttribute("successMessage", "Registration Successful. Please log in.");
                    req.getRequestDispatcher("/login.jsp").forward(req, resp);
                    return;
                }
            } else {
                req.setAttribute("error", "Registration Failed. Please try again.");
            }
        } catch (Exception e) {
            req.setAttribute("error", "Error: " + e.getMessage());
        }
        req.getRequestDispatcher(targetJsp).forward(req, resp);
    }
}

// commit iteration 5: Create RegisterServlet for user registration

// commit iteration 10: Enhance UI for index.jsp header

// commit iteration 15: Format login form input fields
