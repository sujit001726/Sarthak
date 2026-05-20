package sarthak.model;

import java.sql.Timestamp;

public class ApplicationDTO {
    private int applicationId;
    private int jobId;
    private String jobTitle;
    private String candidateName;
    private String candidateEmail;
    private Integer candidateUserId;
    private String coverNote;
    private String status;
    private Timestamp appliedAt;

    public ApplicationDTO() {}

    public Integer getCandidateUserId() { return candidateUserId; }
    public void setCandidateUserId(Integer candidateUserId) { this.candidateUserId = candidateUserId; }

    public int getApplicationId() { return applicationId; }
    public void setApplicationId(int applicationId) { this.applicationId = applicationId; }

    public int getJobId() { return jobId; }
    public void setJobId(int jobId) { this.jobId = jobId; }

    public String getJobTitle() { return jobTitle; }
    public void setJobTitle(String jobTitle) { this.jobTitle = jobTitle; }

    public String getCandidateName() { return candidateName; }
    public void setCandidateName(String candidateName) { this.candidateName = candidateName; }

    public String getCandidateEmail() { return candidateEmail; }
    public void setCandidateEmail(String candidateEmail) { this.candidateEmail = candidateEmail; }

    public String getCoverNote() { return coverNote; }
    public void setCoverNote(String coverNote) { this.coverNote = coverNote; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public Timestamp getAppliedAt() { return appliedAt; }
    public void setAppliedAt(Timestamp appliedAt) { this.appliedAt = appliedAt; }
}
