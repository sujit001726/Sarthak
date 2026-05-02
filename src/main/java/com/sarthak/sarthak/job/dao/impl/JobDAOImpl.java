package com.sarthak.sarthak.job.dao.impl;

import com.sarthak.sarthak.job.dao.interfaces.JobDAOInterface;
import com.sarthak.sarthak.job.model.Job;
import com.sarthak.sarthak.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class JobDAOImpl implements JobDAOInterface {

    @Override
    public List<Job> getAllJobs() throws SQLException {
        List<Job> jobs = new ArrayList<>();
        String sql = "SELECT * FROM jobs ORDER BY posted_at DESC";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) jobs.add(mapRow(rs));
        }
        return jobs;
    }

    @Override
    public List<Job> getRecentJobs(int limit) throws SQLException {
        List<Job> jobs = new ArrayList<>();
        String sql = "SELECT * FROM jobs ORDER BY posted_at DESC LIMIT ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, limit);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) jobs.add(mapRow(rs));
            }
        }
        return jobs;
    }

    @Override
    public void saveJob(String title, String company, String location, String salary, String status) throws SQLException {
        String sql = "INSERT INTO jobs (title, company_name, location, salary, status) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, title);
            ps.setString(2, company);
            ps.setString(3, location);
            ps.setString(4, salary);
            ps.setString(5, status);
            ps.executeUpdate();
        }
    }

    @Override
    public void updateJobStatus(int id, String status) throws SQLException {
        String sql = "UPDATE jobs SET status = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, id);
            ps.executeUpdate();
        }
    }

    private Job mapRow(ResultSet rs) throws SQLException {
        return new Job(
            rs.getInt("id"),
            rs.getString("title"),
            rs.getString("company_name"),
            rs.getString("location"),
            rs.getString("salary"),
            rs.getString("status")
        );
    }
}
