package sarthak.controller;

import sarthak.dao.UserDAO;
import sarthak.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/image")
public class ImageServlet extends HttpServlet {
    
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String idStr = request.getParameter("userId");
        String type = request.getParameter("type"); // "profile" or "cover"
        
        if (idStr == null || type == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
        
        int userId;
        try {
            userId = Integer.parseInt(idStr);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
        
        try {
            User user = userDAO.getUserById(userId);
            if (user == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
                return;
            }
            
            byte[] imageData = null;
            if ("profile".equals(type)) {
                imageData = user.getProfileImage();
            } else if ("cover".equals(type)) {
                imageData = user.getCoverImage();
            }
            
            if (imageData == null || imageData.length == 0) {
                // Return default image or error
                response.sendRedirect(request.getContextPath() + "/images/default-" + type + ".png");
                return;
            }
            
            response.setContentType(detectContentType(imageData));
            response.setHeader("Cache-Control", "private, max-age=3600");
            response.setContentLength(imageData.length);
            response.getOutputStream().write(imageData);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    private String detectContentType(byte[] data) {
        if (data.length >= 4) {
            if ((data[0] & 0xff) == 0x89 && data[1] == 0x50 && data[2] == 0x4e && data[3] == 0x47) {
                return "image/png";
            }
            if ((data[0] & 0xff) == 0xff && (data[1] & 0xff) == 0xd8) {
                return "image/jpeg";
            }
            if (data[0] == 'G' && data[1] == 'I' && data[2] == 'F') {
                return "image/gif";
            }
            if (data[0] == 'R' && data[1] == 'I' && data[2] == 'F' && data[3] == 'W') {
                return "image/webp";
            }
        }
        return "application/octet-stream";
    }
}
