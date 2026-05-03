package com.sarthak.sarthak.job.dto;

/**
 * DTO for displaying job + candidate info together (e.g. on the job board / applications view).
 */
public class JobCandidateDTO {
    private int applicationId;
    private String candidateName;
    private String jobTitle;
    private String status;
    private String appliedAt;

    public JobCandidateDTO() {}

    public JobCandidateDTO(int applicationId, String candidateName, String jobTitle, String status, String appliedAt) {
        this.applicationId = applicationId;
        this.candidateName = candidateName;
        this.jobTitle = jobTitle;
        this.status = status;
        this.appliedAt = appliedAt;
    }

    public int getApplicationId() { return applicationId; }
    public void setApplicationId(int applicationId) { this.applicationId = applicationId; }

    public String getCandidateName() { return candidateName; }
    public void setCandidateName(String candidateName) { this.candidateName = candidateName; }

    public String getJobTitle() { return jobTitle; }
    public void setJobTitle(String jobTitle) { this.jobTitle = jobTitle; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getAppliedAt() { return appliedAt; }
    public void setAppliedAt(String appliedAt) { this.appliedAt = appliedAt; }
}
