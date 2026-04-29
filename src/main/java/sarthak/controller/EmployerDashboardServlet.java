package sarthak.controller;

import sarthak.dao.JobDAO;
import sarthak.model.Job;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/employer/dashboard")
public class EmployerDashboardServlet extends HttpServlet {

    private JobDAO jobDAO = new JobDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || !"employer".equals(session.getAttribute("role"))) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        int employerId = (int) session.getAttribute("userId");

        try {
            List<Job> jobs = jobDAO.getJobsByEmployer(employerId);
            int totalJobs = jobDAO.countJobsByEmployer(employerId);

            req.setAttribute("jobs", jobs);
            req.setAttribute("totalJobs", totalJobs);
            req.setAttribute("employerName", session.getAttribute("name"));

            req.getRequestDispatcher("/pages/employedashboard.jsp").forward(req, resp);
        } catch (Exception e) {
            // Log error, forward to error page
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}