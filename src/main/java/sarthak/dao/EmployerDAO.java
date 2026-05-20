package sarthak.dao;

import sarthak.model.Employer;
import sarthak.utils.DbConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EmployerDAO {

    // Get employer by user_id
    public Employer getEmployerByUserId(int userId) {
        String sql = "SELECT * FROM employer WHERE user_id = ?";
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToEmployer(rs);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return null;
    }

    // Insert new employer
    public boolean insertEmployer(Employer employer) {
        String sql = "INSERT INTO employer (user_id, company_name, industry, website, contact_phone, description) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, employer.getUserId());
            stmt.setString(2, employer.getCompanyName());
            stmt.setString(3, employer.getIndustry());
            stmt.setString(4, employer.getWebsite());
            stmt.setString(5, employer.getContactPhone());
            stmt.setString(6, employer.getDescription());
            int rows = stmt.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    // Update employer
    public boolean updateEmployer(Employer employer) {
        String sql = "UPDATE employer SET company_name = ?, industry = ?, website = ?, contact_phone = ?, description = ? WHERE id = ? AND user_id = ?";
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, employer.getCompanyName());
            stmt.setString(2, employer.getIndustry());
            stmt.setString(3, employer.getWebsite());
            stmt.setString(4, employer.getContactPhone());
            stmt.setString(5, employer.getDescription());
            stmt.setInt(6, employer.getId());
            stmt.setInt(7, employer.getUserId());
            int rows = stmt.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    // Get all employers (if needed)
    public List<Employer> getAllEmployers() {
        List<Employer> employers = new ArrayList<>();
        String sql = "SELECT * FROM employer";
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Employer employer = mapResultSetToEmployer(rs);
                employers.add(employer);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return employers;
    }

    // Helper method
    private Employer mapResultSetToEmployer(ResultSet rs) throws SQLException {
        Employer employer = new Employer();
        employer.setId(rs.getInt("id"));
        employer.setUserId(rs.getInt("user_id"));
        employer.setCompanyName(rs.getString("company_name"));
        employer.setIndustry(rs.getString("industry"));
        employer.setWebsite(rs.getString("website"));
        employer.setContactPhone(rs.getString("contact_phone"));
        employer.setDescription(rs.getString("description"));
        employer.setCreatedAt(rs.getTimestamp("created_at"));
        return employer;
    }
}