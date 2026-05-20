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
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/employer/export-jobs")
public class ExportJobsServlet extends HttpServlet {

    private final JobDAO jobDAO = new JobDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || !"employer".equals(session.getAttribute("userRole"))) {
            resp.sendError(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }


        int employerId = (int) session.getAttribute("userId");

        resp.setContentType("text/csv");
        resp.setHeader("Content-Disposition", "attachment; filename=\"active-postings.csv\"");

        try (PrintWriter writer = resp.getWriter()) {
            writer.println("ID,Title,Location,JobType,SalaryRange,Status,CreatedAt");
            
            List<Job> jobs = jobDAO.getJobsByEmployer(employerId);
            for (Job job : jobs) {
                writer.printf("%d,\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\"\n",
                        job.getId(),
                        job.getTitle() != null ? job.getTitle().replace("\"", "\"\"") : "",
                        job.getLocation() != null ? job.getLocation().replace("\"", "\"\"") : "",
                        job.getJobType() != null ? job.getJobType() : "",
                        job.getSalaryRange() != null ? job.getSalaryRange() : "",
                        job.getStatus() != null ? job.getStatus() : "",
                        job.getPostedAt() != null ? job.getPostedAt() : "");
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException(e);
        }
    }
}
