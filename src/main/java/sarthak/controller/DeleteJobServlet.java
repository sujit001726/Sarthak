package sarthak.controller;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import sarthak.dao.InMemoryJobStore;
import sarthak.dao.JobDAO;

import java.io.IOException;

@WebServlet("/employer/delete-job")
public class DeleteJobServlet extends HttpServlet {
    private final JobDAO jobDAO = new JobDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession(false);
        if (session == null || !"employer".equals(session.getAttribute("role"))) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        int employerId = (int) session.getAttribute("userId");
        int jobId = Integer.parseInt(req.getParameter("jobId"));
        try {
            jobDAO.deleteJob(jobId, employerId);
        } catch (RuntimeException e) {
            InMemoryJobStore.delete(jobId, employerId);
            session.setAttribute("flash", "Job deleted in demo mode because MySQL is not connected.");
        }

        resp.sendRedirect(req.getContextPath() + "/employer/dashboard");
    }
}
