package com.sarthak.jobseeker.controller;

import com.sarthak.sarthak.user.dao.impl.UserDAOImpl;
import com.sarthak.sarthak.user.dao.interfaces.UserDAOInterface;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/upload-image")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 25,      // 25MB
    maxRequestSize = 1024 * 1024 * 30    // 30MB
)
public class ProfileUploadServlet extends HttpServlet {
    
    private UserDAOInterface userDAO = new UserDAOImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }
        
        int userId = (int) session.getAttribute("userId");
        String type = request.getParameter("type"); // "profile" or "cover"
        Part filePart = request.getPart("image");
        
        if (filePart == null) {
            // Fallback for old parameter names
            filePart = request.getPart("profileImage");
            if (type == null) type = "profile";
        }
        
        if (filePart != null && filePart.getSize() > 0) {
            String contentType = filePart.getContentType();
            if (contentType == null || !contentType.toLowerCase().startsWith("image/")) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.setContentType("application/json");
                response.getWriter().write("{\"success\": false, \"message\": \"Only image files are allowed.\"}");
                return;
            }

            byte[] imageData = filePart.getInputStream().readAllBytes();
            
            try {
                if ("cover".equals(type)) {
                    userDAO.updateCoverImage(userId, imageData);
                } else {
                    userDAO.updateProfileImage(userId, imageData);
                }
                
                String imageUrl = request.getContextPath() + "/image?userId=" + userId + "&type=" + type + "&t=" + System.currentTimeMillis();
                
                response.setContentType("application/json");
                response.getWriter().write("{\"success\": true, \"imageUrl\": \"" + imageUrl + "\"}");
            } catch (SQLException e) {
                e.printStackTrace();
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                response.setContentType("application/json");
                response.getWriter().write("{\"success\": false, \"message\": \"Image could not be saved: " + escapeJson(getUsefulMessage(e)) + "\"}");
            }
        } else {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.setContentType("application/json");
            response.getWriter().write("{\"success\": false, \"message\": \"Please choose an image.\"}");
        }
    }

    private String getUsefulMessage(SQLException e) {
        String message = e.getMessage();
        if (message == null || message.trim().isEmpty()) {
            return "database error";
        }
        return message;
    }

    private String escapeJson(String value) {
        return value.replace("\\", "\\\\").replace("\"", "\\\"");
    }
}
