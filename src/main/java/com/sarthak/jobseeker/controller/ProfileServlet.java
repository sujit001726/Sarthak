package com.sarthak.jobseeker.controller;

import com.sarthak.jobseeker.dao.ProfileDAO;
import com.sarthak.sarthak.user.dao.impl.UserDAOImpl;
import com.sarthak.sarthak.user.dao.interfaces.UserDAOInterface;
import com.sarthak.sarthak.user.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Renders the job seeker profile page for the current user or another user.
 */
@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {
    
    private UserDAOInterface userDAO = new UserDAOImpl();
    private ProfileDAO profileDAO = new ProfileDAO();
    private sarthak.dao.FriendsDAO friendsDAO = new sarthak.dao.FriendsDAO();
    
    /**
     * Loads the basic account record, profile details, and media URLs used by the profile page.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        Integer currentUserId = (Integer) session.getAttribute("userId");
        String userName = (String) session.getAttribute("userName");
        request.setAttribute("skills", "");
        request.setAttribute("bio", "");
        request.setAttribute("resumeFileName", "");
        request.setAttribute("resumeUploadedAt", "");
        
        String viewedUserIdParam = request.getParameter("userId");
        boolean isOwnProfile = true;
        int targetUserId = currentUserId;
        
        if (viewedUserIdParam != null && !viewedUserIdParam.isEmpty()) {
            try {
                int viewedId = Integer.parseInt(viewedUserIdParam);
                if (viewedId != currentUserId) {
                    isOwnProfile = false;
                    targetUserId = viewedId;
                }
            } catch (NumberFormatException e) { }
        }
        
        try {
            // Fetch User Basic Info
            User targetUser = userDAO.getUserById(targetUserId);
            if (targetUser != null) {
                request.setAttribute("profileName", targetUser.getFullName());
                request.setAttribute("profileEmail", targetUser.getEmail());
                
                String profileImageUrl = request.getContextPath() + "/image?userId=" + targetUserId + "&type=profile";
                request.setAttribute("profileImage", profileImageUrl);
                
                String coverImageUrl = request.getContextPath() + "/image?userId=" + targetUserId + "&type=cover";
                request.setAttribute("coverImage", coverImageUrl);
            }

            // Fetch Extended Profile Info
            try (ResultSet rs = profileDAO.getProfile(targetUserId)) {
                if (rs.next()) {
                    request.setAttribute("dob", rs.getString("dob"));
                    request.setAttribute("gender", rs.getString("gender"));
                    request.setAttribute("phone", rs.getString("phone"));
                    request.setAttribute("nationalId", rs.getString("national_id"));
                    request.setAttribute("employmentType", rs.getString("employment_type"));
                    request.setAttribute("address", rs.getString("address"));
                    request.setAttribute("skills", safeString(rs.getString("skills")));
                    request.setAttribute("bio", safeString(rs.getString("bio")));
                    request.setAttribute("resumeFileName", safeString(getStringSafe(rs, "resume_file_name")));
                    request.setAttribute("resumeUploadedAt", safeString(getStringSafe(rs, "resume_uploaded_at")));
                    if (hasResume(rs)) {
                        request.setAttribute("resumeUrl", request.getContextPath() + "/resume?userId=" + targetUserId);
                    }
                }
            }

            // Fetch Social Info
            request.setAttribute("friends", friendsDAO.getFriends(targetUserId));
            request.setAttribute("notifications", friendsDAO.getNotifications(currentUserId));
            
            if (!isOwnProfile) {
                request.setAttribute("friendStatus", friendsDAO.getFriendStatus(currentUserId, targetUserId));
                
                // Fetch Chat History for the floating widget
                sarthak.dao.MessageDAO messageDAO = new sarthak.dao.MessageDAO();
                request.setAttribute("chatHistory", messageDAO.getChatHistory(currentUserId, targetUserId));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        request.setAttribute("isOwnProfile", isOwnProfile);
        request.setAttribute("targetUserId", targetUserId);
        request.setAttribute("userName", userName);
        
        request.getRequestDispatcher("/profile.jsp").forward(request, response);
    }

    private String safeString(String value) {
        return value == null ? "" : value;
    }

    private String getStringSafe(ResultSet rs, String columnName) {
        try {
            return rs.getString(columnName);
        } catch (SQLException e) {
            return "";
        }
    }

    private boolean hasResume(ResultSet rs) {
        try {
            byte[] data = rs.getBytes("resume_file");
            return data != null && data.length > 0;
        } catch (SQLException e) {
            return false;
        }
    }
}
