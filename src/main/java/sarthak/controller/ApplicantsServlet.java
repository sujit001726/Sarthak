package sarthak.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import sarthak.dao.InMemoryJobStore;
import sarthak.dao.JobDAO;
import sarthak.model.Job;

import java.io.IOException;

@WebServlet("/employer/applicants")
public class ApplicantsServlet extends HttpServlet {
    private final JobDAO jobDAO = new JobDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (!PostJobServlet.isEmployer(req, resp)) {
            return;
        }

        int employerId = (int) req.getSession(false).getAttribute("userId");
        int jobId = Integer.parseInt(req.getParameter("jobId"));
        Job job;
        try {
            job = jobDAO.getJobById(jobId);
            if (job != null && job.getEmployerId() != employerId) {
                job = null;
            }
        } catch (RuntimeException e) {
            job = InMemoryJobStore.getJobById(jobId, employerId);
            req.setAttribute("databaseError", "Applicants are shown in demo mode because MySQL is not connected.");
        }

        if (job == null) {
            resp.sendRedirect(req.getContextPath() + "/employer/dashboard");
            return;
        }

        req.setAttribute("job", job);
        req.getRequestDispatcher("/pages/components/applicant-lists.jsp").forward(req, resp);
    }
}
