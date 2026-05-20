package sarthak.dao;

import sarthak.model.Job;

import java.sql.Timestamp;
import java.time.Instant;
import java.util.ArrayList;
import java.util.List;

public class JobDAO {
    public List<Job> getAllActiveJobs() {
        List<Job> jobs = new ArrayList<>();
        jobs.add(job(1, 2, "Junior Java Developer", "Build servlet and JSP features for a growing job portal team.", "Kathmandu", "NPR 45k-70k", "Full-Time"));
        jobs.add(job(2, 3, "Frontend Intern", "Work on responsive dashboards using HTML, CSS, JavaScript, and Tailwind CSS.", "Lalitpur", "NPR 18k-25k", "Internship"));
        jobs.add(job(3, 2, "QA Analyst", "Create test cases, verify user workflows, and report release-blocking issues.", "Remote", "NPR 35k-55k", "Full-Time"));
        return jobs;
    }

    private Job job(int id, int employerId, String title, String description, String location, String salaryRange, String jobType) {
        Job job = new Job();
        job.setId(id);
        job.setEmployerId(employerId);
        job.setTitle(title);
        job.setDescription(description);
        job.setLocation(location);
        job.setSalaryRange(salaryRange);
        job.setJobType(jobType);
        job.setPostedAt(Timestamp.from(Instant.now()));
        return job;
    }
}
