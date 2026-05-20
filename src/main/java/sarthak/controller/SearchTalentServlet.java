package sarthak.controller;

import sarthak.dao.UserDAO;
import sarthak.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/employer/search-talent")
public class SearchTalentServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userId") == null || !"employer".equals(session.getAttribute("role"))) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        try {
            // Get all job seekers
            List<User> allUsers = userDAO.getAllUsers();
            List<User> talents = allUsers.stream()
                .filter(u -> "job_seeker".equals(u.getRole() != null ? u.getRole().name() : ""))
                .filter(u -> u.getFullName() != null && !u.getFullName().toLowerCase().contains("test") && !u.getFullName().toLowerCase().contains("demo"))
                .collect(Collectors.toList());
            
            req.setAttribute("talents", talents);
            req.getRequestDispatcher("/employer/search-talent.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException(e);
        }
    }
}
