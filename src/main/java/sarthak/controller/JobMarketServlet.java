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
import java.util.stream.Collectors;

@WebServlet("/job-market")
public class JobMarketServlet extends HttpServlet {

    private final JobDAO jobDAO = new JobDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String searchQuery = req.getParameter("q");
        String companyFilter = req.getParameter("company");
        List<Job> jobs;

        if (companyFilter != null && !companyFilter.trim().isEmpty()) {
            // Filter by specific company name (from Companies page "View Jobs" button)
            jobs = jobDAO.getActiveJobsByEmployerName(companyFilter.trim());
            req.setAttribute("companyFilter", companyFilter.trim());
            req.setAttribute("searchQuery", companyFilter.trim());
        } else {
            jobs = jobDAO.getAllActiveJobs();
            if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                String lowerCaseQuery = searchQuery.toLowerCase().trim();
                jobs = jobs.stream()
                    .filter(job ->
                        (job.getTitle() != null && job.getTitle().toLowerCase().contains(lowerCaseQuery)) ||
                        (job.getDescription() != null && job.getDescription().toLowerCase().contains(lowerCaseQuery)) ||
                        (job.getLocation() != null && job.getLocation().toLowerCase().contains(lowerCaseQuery))
                    )
                    .collect(Collectors.toList());
                req.setAttribute("searchQuery", searchQuery);
            }
        }

        req.setAttribute("jobs", jobs);
        req.getRequestDispatcher("/job-market.jsp").forward(req, resp);
    }
}
