package sarthak.model;

import java.sql.Timestamp;

public class Notification {
    private int id;
    private int userId;
    private Integer fromUserId;
    private String type;
    private String title;
    private String body;
    private String content; // Keep content as a alias or main field
    private String linkUrl;
    private boolean read;
    private Timestamp createdAt;

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    public Integer getFromUserId() { return fromUserId; }
    public void setFromUserId(Integer fromUserId) { this.fromUserId = fromUserId; }
    public String getType() { return type; }
    public void setType(String type) { this.type = type; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public String getBody() { return body; }
    public void setBody(String body) { this.body = body; }
    public String getContent() { return content != null ? content : body; }
    public void setContent(String content) { this.content = content; this.body = content; }
    public String getLinkUrl() { return linkUrl; }
    public void setLinkUrl(String linkUrl) { this.linkUrl = linkUrl; }
    public boolean isRead() { return read; }
    public void setRead(boolean read) { this.read = read; }
    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
}
