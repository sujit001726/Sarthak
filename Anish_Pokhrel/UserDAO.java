package com.jobportal.dao;

import com.jobportal.model.User;

public class UserDAO {
    public User getUserById(int id) {
        if (id == 2) {
            return new User(2, "Sarthak Employer");
        }
        if (id == 3) {
            return new User(3, "Hiring Manager");
        }
        return new User(id, "Demo User " + id);
    }
}
