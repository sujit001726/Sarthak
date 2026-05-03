package com.sarthak.sarthak.job.dao.impl;

import com.sarthak.sarthak.job.dao.interfaces.CandidateDAOInterface;
import com.sarthak.sarthak.job.model.Candidate;
import com.sarthak.sarthak.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CandidateDAOImpl implements CandidateDAOInterface {

    @Override
    public List<Candidate> getAllCandidates() throws SQLException {
        List<Candidate> list = new ArrayList<>();
        String sql = "SELECT * FROM candidates ORDER BY applied_date DESC";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) list.add(mapRow(rs));
        }
        return list;
    }

    @Override
    public List<Candidate> getShortlisted() throws SQLException {
        List<Candidate> list = new ArrayList<>();
        String sql = "SELECT * FROM candidates WHERE status = 'shortlisted' ORDER BY applied_date DESC";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) list.add(mapRow(rs));
        }
        return list;
    }

    @Override
    public void saveCandidate(String name, String email, String phone, String level, String status) throws SQLException {
        String sql = "INSERT INTO candidates (name, email, phone, experience_level, status) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, phone);
            ps.setString(4, level);
            ps.setString(5, status);
            ps.executeUpdate();
        }
    }

    private Candidate mapRow(ResultSet rs) throws SQLException {
        return new Candidate(
            rs.getInt("id"),
            rs.getString("name"),
            rs.getString("email"),
            rs.getString("phone"),
            rs.getString("experience_level"),
            rs.getString("status")
        );
    }
}
