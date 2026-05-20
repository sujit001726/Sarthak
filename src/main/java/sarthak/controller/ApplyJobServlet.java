package sarthak.controller;

import sarthak.dao.NotificationDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/apply-job")
public class ApplyJobServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        try {
            int jobId = Integer.parseInt(req.getParameter("jobId"));
            int employerId = Integer.parseInt(req.getParameter("employerId"));
            String applicantName = req.getParameter("applicantName");
            String applicantEmail = req.getParameter("applicantEmail");
            String coverNote = req.getParameter("coverNote");

            // Save to Database
            sarthak.dao.ApplicationDAO appDAO = new sarthak.dao.ApplicationDAO();
            boolean success = appDAO.applyForJob(jobId, applicantName, applicantEmail, coverNote);

            if (success) {
                // Send Notification
                String title = "New Job Application!";
                String message = applicantName + " (" + applicantEmail + ") has applied for your job! Cover Note: " + (coverNote != null && !coverNote.isEmpty() ? coverNote : "None");
                String type = "new_applicant";
                String link = "/employer/applicants?jobId=" + jobId;

                NotificationDAO.send(employerId, title, message, type, link);

                session.setAttribute("flash", "Application submitted successfully to employer!");
            } else {
                session.setAttribute("flashError", "Failed to submit application. Please try again.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            if(session != null) {
                session.setAttribute("flashError", "An unexpected error occurred. Please try again.");
            }
        }

        // Redirect back to job market
        resp.sendRedirect(req.getContextPath() + "/job-market");
    }
}
