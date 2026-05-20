package sarthak.model;

import java.sql.Timestamp;

public class Employer {
    private int id;
    private int userId;
    private String companyName;
    private String industry;
    private String website;
    private String contactPhone;
    private String description;
    private Timestamp createdAt;

    // No-arg constructor
    public Employer() {}

    // Full-arg constructor
    public Employer(int id, int userId, String companyName, String industry, String website, String contactPhone, String description, Timestamp createdAt) {
        this.id = id;
        this.userId = userId;
        this.companyName = companyName;
        this.industry = industry;
        this.website = website;
        this.contactPhone = contactPhone;
        this.description = description;
        this.createdAt = createdAt;
    }

    // Getters and setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getCompanyName() {
        return companyName;
    }

    public void setCompanyName(String companyName) {
        this.companyName = companyName;
    }

    public String getIndustry() {
        return industry;
    }

    public void setIndustry(String industry) {
        this.industry = industry;
    }

    public String getWebsite() {
        return website;
    }

    public void setWebsite(String website) {
        this.website = website;
    }

    public String getContactPhone() {
        return contactPhone;
    }

    public void setContactPhone(String contactPhone) {
        this.contactPhone = contactPhone;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    // getDisplayName() method that returns companyName or "Unknown Company" if null
    public String getDisplayName() {
        return companyName != null ? companyName : "Unknown Company";
    }

    @Override
    public String toString() {
        return "Employer{" +
                "id=" + id +
                ", userId=" + userId +
                ", companyName='" + companyName + '\'' +
                ", industry='" + industry + '\'' +
                ", website='" + website + '\'' +
                ", contactPhone='" + contactPhone + '\'' +
                ", description='" + description + '\'' +
                ", createdAt=" + createdAt +
                '}';
    }
}
