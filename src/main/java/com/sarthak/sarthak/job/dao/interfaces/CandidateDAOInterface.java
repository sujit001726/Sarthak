package com.sarthak.sarthak.job.dao.interfaces;

import com.sarthak.sarthak.job.model.Candidate;
import java.sql.SQLException;
import java.util.List;

public interface CandidateDAOInterface {
    List<Candidate> getAllCandidates() throws SQLException;
    List<Candidate> getShortlisted() throws SQLException;
    void saveCandidate(String name, String email, String phone, String level, String status) throws SQLException;
}
