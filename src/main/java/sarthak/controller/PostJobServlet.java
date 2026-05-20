package sarthak.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import sarthak.dao.InMemoryJobStore;
import sarthak.dao.JobDAO;
import sarthak.model.Job;

import java.io.IOException;
import java.sql.Date;

@WebServlet("/employer/post-job")
public class PostJobServlet extends HttpServlet {
    private final JobDAO jobDAO = new JobDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (!isEmployer(req, resp)) {
            return;
        }
        req.setAttribute("formTitle", "Post New Job");
        req.setAttribute("submitLabel", "Post Job");
        req.setAttribute("formAction", req.getContextPath() + "/employer/post-job");
        req.getRequestDispatcher("/pages/form/job-posting.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession(false);
        if (session == null || !"employer".equals(session.getAttribute("role"))) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        Job job = buildJob(req, (int) session.getAttribute("userId"));
        try {
            jobDAO.insertJob(job);
        } catch (RuntimeException e) {
            InMemoryJobStore.save(job);
            session.setAttribute("flash", "Job saved in demo mode because MySQL is not connected.");
        }

        resp.sendRedirect(req.getContextPath() + "/employer/dashboard");
    }

    static Job buildJob(HttpServletRequest req, int employerId) {
        Job job = new Job();
        job.setEmployerId(employerId);
        job.setTitle(req.getParameter("title"));
        job.setDescription(req.getParameter("description"));
        job.setLocation(req.getParameter("location"));
        job.setSalaryRange(req.getParameter("salaryRange"));
        job.setJobType(req.getParameter("jobType"));
        job.setStatus(req.getParameter("status"));
        String deadline = req.getParameter("deadline");
        if (deadline != null && !deadline.isBlank()) {
            job.setDeadline(Date.valueOf(deadline));
        }
        return job;
    }

    static boolean isEmployer(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession(false);
        if (session == null || !"employer".equals(session.getAttribute("role"))) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return false;
        }
        return true;
    }
}
