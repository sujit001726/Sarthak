package com.jobportal.model;

import java.time.LocalDateTime;

/**
 * User model representing both job_seeker and employer roles.
 */
public class User {

    public enum Role {
        job_seeker, employer
    }

    private int id;
    private String fullName;
    private String email;
    private String passwordHash;
    private Role role;
    private LocalDateTime createdAt;

    // ── Constructors ──────────────────────────────────────────
    public User() {}

    public User(String fullName, String email, String passwordHash, Role role) {
        this.fullName     = fullName;
        this.email        = email;
        this.passwordHash = passwordHash;
        this.role         = role;
    }

    // ── Getters & Setters ─────────────────────────────────────
    public int getId()                        { return id; }
    public void setId(int id)                 { this.id = id; }

    public String getFullName()               { return fullName; }
    public void setFullName(String fullName)  { this.fullName = fullName; }

    public String getEmail()                  { return email; }
    public void setEmail(String email)        { this.email = email; }

    public String getPasswordHash()                       { return passwordHash; }
    public void setPasswordHash(String passwordHash)      { this.passwordHash = passwordHash; }

    public Role getRole()                     { return role; }
    public void setRole(Role role)            { this.role = role; }

    public LocalDateTime getCreatedAt()                   { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt)     { this.createdAt = createdAt; }

    @Override
    public String toString() {
        return "User{id=" + id + ", fullName='" + fullName + "', email='" + email +
               "', role=" + role + ", createdAt=" + createdAt + "}";
    }
}
