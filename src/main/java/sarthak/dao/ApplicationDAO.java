package sarthak.dao;

import sarthak.model.ApplicationDTO;
import sarthak.utils.DbConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ApplicationDAO {

    public boolean applyForJob(int jobId, String name, String email, String coverNote) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            conn = DbConnection.getConnection();
            conn.setAutoCommit(false); // Transaction start
            
            int candidateId = -1;
            // Check if candidate exists
            String checkCandidate = "SELECT id FROM candidates WHERE email = ?";
            stmt = conn.prepareStatement(checkCandidate);
            stmt.setString(1, email);
            rs = stmt.executeQuery();
            if (rs.next()) {
                candidateId = rs.getInt("id");
            } else {
                // Insert new candidate
                String insertCandidate = "INSERT INTO candidates (name, email) VALUES (?, ?)";
                stmt.close(); // close previous
                stmt = conn.prepareStatement(insertCandidate, Statement.RETURN_GENERATED_KEYS);
                stmt.setString(1, name);
                stmt.setString(2, email);
                stmt.executeUpdate();
                rs = stmt.getGeneratedKeys();
                if (rs.next()) {
                    candidateId = rs.getInt(1);
                }
            }
            
            if (candidateId == -1) {
                conn.rollback();
                return false;
            }
            
            // Insert application
            String insertApplication = "INSERT INTO applications (job_id, candidate_id, status, notes) VALUES (?, ?, 'applied', ?)";
            stmt.close(); // close previous
            stmt = conn.prepareStatement(insertApplication);
            stmt.setInt(1, jobId);
            stmt.setInt(2, candidateId);
            stmt.setString(3, coverNote);
            stmt.executeUpdate();
            
            conn.commit();
            return true;
        } catch (SQLException e) {
            if (conn != null) {
                try { conn.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
            }
            e.printStackTrace();
            return false;
        } finally {
            if (rs != null) try { rs.close(); } catch(SQLException ignore) {}
            if (stmt != null) try { stmt.close(); } catch(SQLException ignore) {}
            if (conn != null) {
                try { 
                    conn.setAutoCommit(true);
                    conn.close(); 
                } catch(SQLException ignore) {}
            }
        }
    }

    public List<ApplicationDTO> getApplicationsForEmployer(int employerId) {
        List<ApplicationDTO> apps = new ArrayList<>();
        String sql = "SELECT a.id, a.job_id, j.title AS job_title, c.name AS candidate_name, c.email AS candidate_email, a.notes, a.status, a.applied_at, u.id AS candidate_user_id " +
                     "FROM applications a " +
                     "JOIN jobs j ON a.job_id = j.id " +
                     "JOIN candidates c ON a.candidate_id = c.id " +
                     "LEFT JOIN users u ON c.email = u.email " +
                     "WHERE j.employer_id = ? " +
                     "ORDER BY a.applied_at DESC";
                     
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, employerId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    ApplicationDTO dto = new ApplicationDTO();
                    dto.setApplicationId(rs.getInt("id"));
                    dto.setJobId(rs.getInt("job_id"));
                    dto.setJobTitle(rs.getString("job_title"));
                    dto.setCandidateName(rs.getString("candidate_name"));
                    dto.setCandidateEmail(rs.getString("candidate_email"));
                    dto.setCoverNote(rs.getString("notes"));
                    dto.setStatus(rs.getString("status"));
                    dto.setAppliedAt(rs.getTimestamp("applied_at"));
                    
                    int userId = rs.getInt("candidate_user_id");
                    if (!rs.wasNull()) {
                        dto.setCandidateUserId(userId);
                    } else {
                        dto.setCandidateUserId(null);
                    }
                    
                    apps.add(dto);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return apps;
    }

    public boolean updateApplicationStatus(int applicationId, String status) {
        String sql = "UPDATE applications SET status = ? WHERE id = ?";
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, status);
            stmt.setInt(2, applicationId);
            int rows = stmt.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
