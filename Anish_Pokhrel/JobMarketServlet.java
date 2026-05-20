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

    private static final long serialVersionUID = 1L;
    private static final JobDAO jobDAO = new JobDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String searchQuery = req.getParameter("q");
        List<Job> jobs = jobDAO.getAllActiveJobs();

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

        req.setAttribute("jobs", jobs);
        renderJobMarket(req, resp, jobs, searchQuery);
    }

    private void renderJobMarket(HttpServletRequest req, HttpServletResponse resp, List<Job> jobs, String searchQuery)
            throws IOException {
        resp.setContentType("text/html;charset=UTF-8");
        String contextPath = req.getContextPath();
        try (var out = resp.getWriter()) {
            out.println("""
                    <!DOCTYPE html>
                    <html lang="en">
                    <head>
                        <meta charset="UTF-8">
                        <meta name="viewport" content="width=device-width, initial-scale=1.0">
                        <title>Sarthak | Job Market</title>
                        <script src="https://cdn.tailwindcss.com"></script>
                        <style>body{font-family:Arial,sans-serif;background:#f4f7f6}.card{transition:.2s}.card:hover{transform:translateY(-2px)}</style>
                    </head>
                    <body>
                    <main class="max-w-6xl mx-auto p-6">
                        <nav class="flex gap-4 mb-6 text-sm font-bold">
                            <a class="text-emerald-800" href="%s/job-market">Job Market</a>
                            <a class="text-emerald-800" href="%s/messages">Messages</a>
                        </nav>
                        <section class="bg-white rounded-2xl p-6 shadow-sm mb-6">
                            <h1 class="text-3xl font-black text-emerald-950 mb-2">Job Market</h1>
                            <form method="get" action="%s/job-market" class="flex gap-2 mt-4">
                                <input name="q" value="%s" placeholder="Search jobs..." class="flex-1 border rounded-xl px-4 py-3">
                                <button class="bg-emerald-900 text-white px-6 py-3 rounded-xl font-bold">Search</button>
                            </form>
                        </section>
                        <div class="grid md:grid-cols-2 lg:grid-cols-3 gap-5">
                    """.formatted(contextPath, contextPath, contextPath, escape(searchQuery)));

            if (jobs.isEmpty()) {
                out.println("<div class=\"bg-white rounded-2xl p-8 shadow-sm\">No jobs found.</div>");
            }

            for (Job job : jobs) {
                out.println("""
                        <article class="card bg-white rounded-2xl p-5 shadow-sm border border-gray-100">
                            <div class="text-xs font-black uppercase text-emerald-700">%s</div>
                            <h2 class="text-xl font-black mt-2">%s</h2>
                            <p class="text-sm text-gray-500 mt-1">%s | %s</p>
                            <p class="text-sm mt-4">%s</p>
                            <button class="mt-5 bg-emerald-900 text-white rounded-xl px-4 py-2 font-bold">Apply Now</button>
                        </article>
                        """.formatted(
                        escape(job.getJobType()),
                        escape(job.getTitle()),
                        escape(job.getLocation()),
                        escape(job.getSalaryRange()),
                        escape(job.getDescription())));
            }

            out.println("""
                        </div>
                    </main>
                    </body>
                    </html>
                    """);
        }
    }

    private String escape(String value) {
        if (value == null) {
            return "";
        }
        return value
                .replace("&", "&amp;")
                .replace("<", "&lt;")
                .replace(">", "&gt;")
                .replace("\"", "&quot;");
    }
}
