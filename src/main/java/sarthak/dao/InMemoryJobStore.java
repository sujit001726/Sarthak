package sarthak.dao;

import sarthak.model.Job;

import java.sql.Date;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.stream.Collectors;

public final class InMemoryJobStore {
    private static final AtomicInteger NEXT_ID = new AtomicInteger(4);
    private static final Map<Integer, Job> JOBS = new ConcurrentHashMap<>();

    static {
        addSeedJob(1, "Software Engineer", "Develop and maintain web applications.", "Kathmandu", "80000-100000", "full-time", "active", "2026-12-31");
        addSeedJob(1, "Data Analyst", "Analyze job portal data and prepare reports.", "Remote", "60000-80000", "part-time", "active", "2026-11-30");
        addSeedJob(1, "Intern Developer", "Assist with Java servlet development tasks.", "Lalitpur", "20000-30000", "internship", "draft", "2026-10-15");
    }

    private InMemoryJobStore() {
    }

    public static List<Job> getJobsByEmployer(int employerId) {
        return JOBS.values().stream()
                .filter(job -> job.getEmployerId() == employerId)
                .sorted(Comparator.comparing(Job::getPostedAt, Comparator.nullsLast(Comparator.reverseOrder())))
                .map(InMemoryJobStore::copy)
                .collect(Collectors.toCollection(ArrayList::new));
    }

    public static Job getJobById(int jobId, int employerId) {
        Job job = JOBS.get(jobId);
        if (job == null || job.getEmployerId() != employerId) {
            return null;
        }
        return copy(job);
    }

    public static void save(Job job) {
        if (job.getId() == 0) {
            job.setId(NEXT_ID.getAndIncrement());
            job.setPostedAt(new Timestamp(System.currentTimeMillis()));
        }
        JOBS.put(job.getId(), copy(job));
    }

    public static boolean delete(int jobId, int employerId) {
        Job job = JOBS.get(jobId);
        if (job == null || job.getEmployerId() != employerId) {
            return false;
        }
        JOBS.remove(jobId);
        return true;
    }

    private static void addSeedJob(int employerId, String title, String description, String location, String salaryRange,
                                   String jobType, String status, String deadline) {
        Job job = new Job();
        job.setId(NEXT_ID.getAndIncrement());
        job.setEmployerId(employerId);
        job.setTitle(title);
        job.setDescription(description);
        job.setLocation(location);
        job.setSalaryRange(salaryRange);
        job.setJobType(jobType);
        job.setStatus(status);
        job.setDeadline(Date.valueOf(LocalDate.parse(deadline)));
        job.setPostedAt(new Timestamp(System.currentTimeMillis()));
        JOBS.put(job.getId(), job);
    }

    private static Job copy(Job source) {
        Job job = new Job();
        job.setId(source.getId());
        job.setEmployerId(source.getEmployerId());
        job.setTitle(source.getTitle());
        job.setDescription(source.getDescription());
        job.setLocation(source.getLocation());
        job.setSalaryRange(source.getSalaryRange());
        job.setJobType(source.getJobType());
        job.setStatus(source.getStatus());
        job.setDeadline(source.getDeadline());
        job.setPostedAt(source.getPostedAt());
        return job;
    }
}
