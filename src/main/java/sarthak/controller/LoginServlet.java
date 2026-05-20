package sarthak.controller;

import sarthak.dao.UserDAO;
import sarthak.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

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

        User user = userDAO.getUserByEmail(email);
        if (user == null || !password.equals(user.getPasswordHash())) {
            req.setAttribute("error", "Invalid Login");
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
            return;
        }

        HttpSession session = req.getSession(true);
        session.setAttribute("userId",   user.getId());
        session.setAttribute("userName", user.getFullName());
        session.setMaxInactiveInterval(30 * 60);

        req.setAttribute("successMessage", "Login Successful");
        req.getRequestDispatcher("/login.jsp").forward(req, resp);
    }
}