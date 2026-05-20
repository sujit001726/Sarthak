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

@WebServlet("/employer/edit-job")
public class EditJobServlet extends HttpServlet {
    private final JobDAO jobDAO = new JobDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (!PostJobServlet.isEmployer(req, resp)) {
            return;
        }

        int employerId = (int) req.getSession(false).getAttribute("userId");
        int jobId = parseJobId(req);
        Job job;
        try {
            job = jobDAO.getJobById(jobId);
            if (job != null && job.getEmployerId() != employerId) {
                job = null;
            }
        } catch (RuntimeException e) {
            job = InMemoryJobStore.getJobById(jobId, employerId);
            req.setAttribute("databaseError", "Editing in demo mode because MySQL is not connected.");
        }

        if (job == null) {
            resp.sendRedirect(req.getContextPath() + "/employer/dashboard");
            return;
        }

        req.setAttribute("job", job);
        req.setAttribute("formTitle", "Edit Job");
        req.setAttribute("submitLabel", "Save Changes");
        req.setAttribute("formAction", req.getContextPath() + "/employer/edit-job?id=" + jobId);
        req.getRequestDispatcher("/pages/form/job-posting.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession(false);
        if (session == null || !"employer".equals(session.getAttribute("role"))) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        int employerId = (int) session.getAttribute("userId");
        Job job = PostJobServlet.buildJob(req, employerId);
        job.setId(parseJobId(req));

        try {
            jobDAO.updateJob(job);
        } catch (RuntimeException e) {
            Job existing = InMemoryJobStore.getJobById(job.getId(), employerId);
            if (existing != null) {
                job.setPostedAt(existing.getPostedAt());
            }
            InMemoryJobStore.save(job);
            session.setAttribute("flash", "Job updated in demo mode because MySQL is not connected.");
        }

        resp.sendRedirect(req.getContextPath() + "/employer/dashboard");
    }

    private static int parseJobId(HttpServletRequest req) {
        return Integer.parseInt(req.getParameter("id"));
    }
}
