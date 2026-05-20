package sarthak.controller;

import sarthak.dao.UserDAO;
import sarthak.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/companies")
public class CompaniesServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String searchQuery = req.getParameter("q");
        List<User> companies;

        try {
            if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                companies = userDAO.searchEmployers(searchQuery.trim());
            } else {
                companies = userDAO.getEmployers(0);
            }
            req.setAttribute("companies", companies);
            req.setAttribute("searchQuery", searchQuery);
            req.getRequestDispatcher("/companies.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "An error occurred while loading companies.");
            req.getRequestDispatcher("/companies.jsp").forward(req, resp);
        }
    }
}
