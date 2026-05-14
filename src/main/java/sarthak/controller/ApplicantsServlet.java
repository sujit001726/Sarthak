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
        jakarta.servlet.http.HttpSession session = req.getSession(false);
        if (session == null || !"employer".equals(session.getAttribute("role"))) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        int employerId = (int) session.getAttribute("userId");
        String jobIdParam = req.getParameter("jobId");
        
        // Fetch specific job if jobId is provided (legacy behavior)
        if (jobIdParam != null && !jobIdParam.isEmpty()) {
            try {
                int jobId = Integer.parseInt(jobIdParam);
                Job job = jobDAO.getJobById(jobId);
                if (job != null && job.getEmployerId() == employerId) {
                    req.setAttribute("job", job);
                }
            } catch (Exception e) {
                // Ignore or handle log
            }
        }

        // Fetch applications from DB
        sarthak.dao.ApplicationDAO appDAO = new sarthak.dao.ApplicationDAO();
        java.util.List<sarthak.model.ApplicationDTO> applications = appDAO.getApplicationsForEmployer(employerId);
        req.setAttribute("applications", applications);

        req.setAttribute("employerName", session.getAttribute("name"));
        req.getRequestDispatcher("/employer/manage-applicants.jsp").forward(req, resp);
    }
}
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
        jakarta.servlet.http.HttpSession session = req.getSession(false);
        if (session == null || !"employer".equals(session.getAttribute("role"))) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        int employerId = (int) session.getAttribute("userId");
        String jobIdParam = req.getParameter("jobId");
        
        // Fetch specific job if jobId is provided (legacy behavior)
        if (jobIdParam != null && !jobIdParam.isEmpty()) {
            try {
                int jobId = Integer.parseInt(jobIdParam);
                Job job = jobDAO.getJobById(jobId);
                if (job != null && job.getEmployerId() == employerId) {
                    req.setAttribute("job", job);
                }
            } catch (Exception e) {
                // Ignore or handle log
            }
        }

        // Fetch applications from DB
        sarthak.dao.ApplicationDAO appDAO = new sarthak.dao.ApplicationDAO();
        java.util.List<sarthak.model.ApplicationDTO> applications = appDAO.getApplicationsForEmployer(employerId);
        req.setAttribute("applications", applications);

        req.setAttribute("employerName", session.getAttribute("name"));
        req.getRequestDispatcher("/employer/manage-applicants.jsp").forward(req, resp);
    }
}
