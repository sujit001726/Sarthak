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
import java.util.List;

@WebServlet("/employer/manage-jobs")
public class EmployerManageJobsServlet extends HttpServlet {

    private JobDAO jobDAO = new JobDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || !"employer".equals(session.getAttribute("role"))) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        int employerId = (int) session.getAttribute("userId");
        List<Job> jobs;
        
        try {
            jobs = jobDAO.getJobsByEmployer(employerId);
        } catch (Exception e) {
            jobs = InMemoryJobStore.getJobsByEmployer(employerId);
            req.setAttribute("databaseError", "MySQL is not connected. Showing demo data.");
        }

        req.setAttribute("jobs", jobs);
        req.setAttribute("employerName", session.getAttribute("name"));
        req.getRequestDispatcher("/employer/manage-jobs.jsp").forward(req, resp);
    }
}
