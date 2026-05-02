package com.sarthak.sarthak.user.model;

public class User {
    private int id;
    private String fullName;
    private String email;
    private String userType;
    private String status;

    public User() {}

    public User(int id, String fullName, String email, String userType, String status) {
        this.id = id;
        this.fullName = fullName;
        this.email = email;
        this.userType = userType;
        this.status = status;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getUserType() { return userType; }
    public void setUserType(String userType) { this.userType = userType; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}
