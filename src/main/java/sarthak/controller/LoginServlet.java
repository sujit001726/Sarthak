package sarthak.controller;

import sarthak.dao.UserDAO;
import sarthak.model.User;
import sarthak.utils.PasswordUtil;
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
            req.setAttribute("error", "Invalid Login");
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
            return;
        }

        // Hardcoded Admin Check
        if ("admin@gmail.com".equals(email) && "admin123".equals(password)) {
            HttpSession session = req.getSession(true);
            session.setAttribute("userId", 999);
            session.setAttribute("userName", "Admin");
            session.setAttribute("name", "Admin");
            session.setAttribute("userRole", "admin");
            session.setAttribute("role", "admin");
            session.setAttribute("admin", "Admin");
            session.setMaxInactiveInterval(7 * 24 * 60 * 60);
            resp.sendRedirect(req.getContextPath() + "/admin?action=dashboard");
            return;
        }

        User user = userDAO.getUserByEmail(email);

        if (user == null || !PasswordUtil.verifyPassword(password, user.getPasswordHash())) {
            req.setAttribute("error", "Invalid Login");
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
            return;
        }

        // Create session
        HttpSession session = req.getSession(true);
        session.setAttribute("userId",   user.getId());
        session.setAttribute("userName", user.getFullName());
        session.setAttribute("name",     user.getFullName());
        session.setAttribute("userRole", user.getRole().name());
        session.setAttribute("role", user.getRole().name());
        session.setMaxInactiveInterval(30 * 60);

        req.setAttribute("successMessage", "Login Successful");
        req.getRequestDispatcher("/login.jsp").forward(req, resp);
    }
}

// commit iteration 4: Create LoginServlet for handling login requests
