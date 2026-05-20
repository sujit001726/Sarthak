package sarthak.model;

import java.sql.Date;
import java.sql.Timestamp;

public class Job {
    private int id;
    private int employerId;
    private String title;
    private String description;
    private String location;
    private String salaryRange;
    private String jobType;
    private String status;
    private Date deadline;
    private Timestamp postedAt;

    // No-arg constructor
    public Job() {}

    // Full-arg constructor
    public Job(int id, int employerId, String title, String description, String location, String salaryRange, String jobType, String status, Date deadline, Timestamp postedAt) {
        this.id = id;
        this.employerId = employerId;
        this.title = title;
        this.description = description;
        this.location = location;
        this.salaryRange = salaryRange;
        this.jobType = jobType;
        this.status = status;
        this.deadline = deadline;
        this.postedAt = postedAt;
    }

    // Getters and setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getEmployerId() {
        return employerId;
    }

    public void setEmployerId(int employerId) {
        this.employerId = employerId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getSalaryRange() {
        return salaryRange;
    }

    public void setSalaryRange(String salaryRange) {
        this.salaryRange = salaryRange;
    }

    public String getJobType() {
        return jobType;
    }

    public void setJobType(String jobType) {
        this.jobType = jobType;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Date getDeadline() {
        return deadline;
    }

    public void setDeadline(Date deadline) {
        this.deadline = deadline;
    }

    public Timestamp getPostedAt() {
        return postedAt;
    }

    private String companyName;

    public String getCompanyName() {
        return companyName != null ? companyName : "Top Employer";
    }

    public void setCompanyName(String companyName) {
        this.companyName = companyName;
    }

    public void setPostedAt(Timestamp postedAt) {
        this.postedAt = postedAt;
    }

    @Override
    public String toString() {
        return "Job{" +
                "id=" + id +
                ", employerId=" + employerId +
                ", title='" + title + '\'' +
                ", description='" + description + '\'' +
                ", location='" + location + '\'' +
                ", salaryRange='" + salaryRange + '\'' +
                ", jobType='" + jobType + '\'' +
                ", status='" + status + '\'' +
                ", deadline=" + deadline +
                ", postedAt=" + postedAt +
                '}';
    }
}
