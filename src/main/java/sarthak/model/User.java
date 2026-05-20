package sarthak.model;

import java.time.LocalDateTime;

public class User {
    public enum Role {
        job_seeker, employer
    }

    private int id;
    private String fullName;
    private String email;
    private String passwordHash;
    private Role role;
    private String userType;
    private String status;
    private LocalDateTime createdAt;
    private byte[] profileImage;
    private byte[] coverImage;

    public User() {}

    public User(int id, String fullName, String email, String userType, String status, byte[] profileImage, byte[] coverImage) {
        this.id = id;
        this.fullName = fullName;
        this.email = email;
        this.userType = userType;
        this.status = status;
        this.profileImage = profileImage;
        this.coverImage = coverImage;
    }

    public User(String fullName, String email, String passwordHash, Role role) {
        this.fullName = fullName;
        this.email = email;
        this.passwordHash = passwordHash;
        this.role = role;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPasswordHash() { return passwordHash; }
    public void setPasswordHash(String passwordHash) { this.passwordHash = passwordHash; }

    public Role getRole() { return role; }
    public void setRole(Role role) { this.role = role; }

    public String getUserType() { return userType; }
    public void setUserType(String userType) { this.userType = userType; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }

    public byte[] getProfileImage() { return profileImage; }
    public void setProfileImage(byte[] profileImage) { this.profileImage = profileImage; }

    public byte[] getCoverImage() { return coverImage; }
    public void setCoverImage(byte[] coverImage) { this.coverImage = coverImage; }

    @Override
    public String toString() {
        return "User{id=" + id + ", fullName='" + fullName + "', email='" + email +
               "', role=" + role + ", userType='" + userType + "', status='" + status + "', createdAt=" + createdAt + "}";
    }
}
