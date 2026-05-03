package sarthak.controller;

import sarthak.dao.JobDAO;
import sarthak.dao.InMemoryJobStore;
import sarthak.model.Job;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;
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

        List<Job> jobs = new ArrayList<>();
        int totalJobs = 0;

        try {
            jobs = jobDAO.getJobsByEmployer(employerId);
            totalJobs = jobDAO.countJobsByEmployer(employerId);
        } catch (Exception e) {
            jobs = InMemoryJobStore.getJobsByEmployer(employerId);
            totalJobs = jobs.size();
            req.setAttribute("databaseError", "Dashboard loaded, but MySQL is not connected with the configured user/password.");
        }

        req.setAttribute("jobs", jobs);
        req.setAttribute("totalJobs", totalJobs);
        req.setAttribute("employerName", session.getAttribute("name"));
        req.setAttribute("flash", session.getAttribute("flash"));
        session.removeAttribute("flash");

        req.getRequestDispatcher("/employer/employer-dashboard.jsp").forward(req, resp);
    }
}
