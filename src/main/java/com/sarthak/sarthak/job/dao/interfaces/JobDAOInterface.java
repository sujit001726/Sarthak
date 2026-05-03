package com.sarthak.sarthak.job.dao.interfaces;

import com.sarthak.sarthak.job.model.Job;
import java.sql.SQLException;
import java.util.List;

public interface JobDAOInterface {
    List<Job> getAllJobs() throws SQLException;
    List<Job> getRecentJobs(int limit) throws SQLException;
    void saveJob(String title, String company, String location, String salary, String status) throws SQLException;
    void updateJobStatus(int id, String status) throws SQLException;
}
