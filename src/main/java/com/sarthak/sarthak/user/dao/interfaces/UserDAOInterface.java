package com.sarthak.sarthak.user.dao.interfaces;

import com.sarthak.sarthak.user.model.User;
import java.sql.SQLException;
import java.util.List;

public interface UserDAOInterface {
    List<User> getAllUsers() throws SQLException;
    User getUserById(int id) throws SQLException;
    void updateBasicProfile(int id, String fullName, String email) throws SQLException;
    void updateUserStatus(int id, String status) throws SQLException;
    void updateProfileImage(int id, byte[] profileImage) throws SQLException;
    void updateCoverImage(int id, byte[] coverImage) throws SQLException;
}
