package sarthak.dao;

import sarthak.model.Job;
import sarthak.utils.DbConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class JobDAO {

    public List<Job> getJobsByEmployer(int employerId) {
        List<Job> jobs = new ArrayList<>();
        String sql = "SELECT * FROM jobs WHERE employer_id = ? ORDER BY posted_at DESC";
        try (Connection conn = DbConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, employerId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Job job = mapResultSetToJob(rs);
                    jobs.add(job);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return jobs;
    }

    public Job getJobById(int jobId) {
        String sql = "SELECT * FROM jobs WHERE id = ?";
        try (Connection conn = DbConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, jobId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToJob(rs);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return null;
    }

    public boolean insertJob(Job job) {
        String sql = "INSERT INTO jobs (employer_id, title, description, location, salary_range, job_type, status, deadline) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DbConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, job.getEmployerId());
            stmt.setString(2, job.getTitle());
            stmt.setString(3, job.getDescription());
            stmt.setString(4, job.getLocation());
            stmt.setString(5, job.getSalaryRange());
            stmt.setString(6, job.getJobType());
            stmt.setString(7, job.getStatus());
            stmt.setDate(8, job.getDeadline());
            int rows = stmt.executeUpdate();
            if (rows > 0) {
                // Notify all job seekers
                sarthak.dao.UserDAO userDAO = new sarthak.dao.UserDAO();
                java.util.List<Integer> jobSeekerIds = userDAO.getAllJobSeekerIds();
                NotificationDAO.sendToAll(jobSeekerIds, "New Job Opening!", "A new job was posted: " + job.getTitle(), "job_post", "/jobseeker-dashboard.jsp");
            }
            return rows > 0;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public boolean updateJob(Job job) {
        String sql = "UPDATE jobs SET title = ?, description = ?, location = ?, salary_range = ?, job_type = ?, status = ?, deadline = ? WHERE id = ? AND employer_id = ?";
        try (Connection conn = DbConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, job.getTitle());
            stmt.setString(2, job.getDescription());
            stmt.setString(3, job.getLocation());
            stmt.setString(4, job.getSalaryRange());
            stmt.setString(5, job.getJobType());
            stmt.setString(6, job.getStatus());
            stmt.setDate(7, job.getDeadline());
            stmt.setInt(8, job.getId());
            stmt.setInt(9, job.getEmployerId());
            int rows = stmt.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public boolean deleteJob(int jobId, int employerId) {
        String sql = "DELETE FROM jobs WHERE id = ? AND employer_id = ?";
        try (Connection conn = DbConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, jobId);
            stmt.setInt(2, employerId);
            int rows = stmt.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public List<Job> getAllActiveJobs() {
        List<Job> jobs = new ArrayList<>();
        String sql = "SELECT j.*, u.full_name AS company_name FROM jobs j " +
                     "LEFT JOIN users u ON j.employer_id = u.id " +
                     "WHERE j.status = 'active' " +
                     "ORDER BY j.posted_at DESC";
        try (Connection conn = DbConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql);
                ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Job job = mapResultSetToJob(rs);
                jobs.add(job);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return jobs;
    }

    public List<Job> getActiveJobsByEmployerName(String employerName) {
        List<Job> jobs = new ArrayList<>();
        String sql = "SELECT j.*, u.full_name AS company_name FROM jobs j " +
                     "JOIN users u ON j.employer_id = u.id " +
                     "WHERE j.status = 'active' " +
                     "AND LOWER(u.full_name) LIKE ? " +
                     "ORDER BY j.posted_at DESC";
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, "%" + employerName.toLowerCase() + "%");
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    jobs.add(mapResultSetToJob(rs));
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return jobs;
    }

    public int countJobsByEmployer(int employerId) {
        String sql = "SELECT COUNT(*) FROM jobs WHERE employer_id = ?";
        try (Connection conn = DbConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, employerId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return 0;
    }

    // Helper method to map ResultSet to Job
    private Job mapResultSetToJob(ResultSet rs) throws SQLException {
        Job job = new Job();
        job.setId(rs.getInt("id"));
        job.setEmployerId(rs.getInt("employer_id"));
        job.setTitle(rs.getString("title"));
        job.setDescription(rs.getString("description"));
        job.setLocation(rs.getString("location"));
        job.setSalaryRange(rs.getString("salary_range"));
        job.setJobType(rs.getString("job_type"));
        job.setStatus(rs.getString("status"));
        job.setDeadline(rs.getDate("deadline"));
        job.setPostedAt(rs.getTimestamp("posted_at"));
        try {
            job.setCompanyName(rs.getString("company_name"));
        } catch (SQLException e) {
            job.setCompanyName("Top Employer");
        }
        return job;
    }
}