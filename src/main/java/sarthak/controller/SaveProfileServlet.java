package sarthak.controller;

import sarthak.dao.ProfileDAO;
import sarthak.dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/save-profile")
public class SaveProfileServlet extends HttpServlet {
    
    private ProfileDAO profileDAO = new ProfileDAO();
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }
        
        int userId = (int) session.getAttribute("userId");
        
        String fullName = trim(request.getParameter("fullName"));
        String email = trim(request.getParameter("email")).toLowerCase();
        String dob = request.getParameter("dob");
        String gender = request.getParameter("gender");
        String phone = request.getParameter("phone");
        String nationalId = request.getParameter("nationalId");
        String employmentType = request.getParameter("employmentType");
        String address = request.getParameter("address");
        String skills = request.getParameter("skills");
        String bio = request.getParameter("bio");

        if (fullName.isEmpty() || email.isEmpty() || !email.matches("^[\\w.+-]+@[\\w-]+\\.[\\w.]+$")) {
            sendJson(response, HttpServletResponse.SC_BAD_REQUEST, "{\"success\": false, \"message\": \"Full name and a valid email are required.\"}");
            return;
        }

        try {
            userDAO.updateBasicProfile(userId, fullName, email);
            profileDAO.saveOrUpdateProfile(userId, dob, gender, phone, nationalId, employmentType, address, skills, bio);
            session.setAttribute("userName", fullName);
            session.setAttribute("name", fullName);
            sendJson(response, HttpServletResponse.SC_OK, "{\"success\": true}");
        } catch (SQLException e) {
            e.printStackTrace();
            String message = e.getMessage() != null && e.getMessage().toLowerCase().contains("duplicate")
                    ? "This email is already registered."
                    : "Profile could not be saved.";
            sendJson(response, HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "{\"success\": false, \"message\": \"" + message + "\"}");
        }
    }

    private String trim(String value) {
        return value == null ? "" : value.trim();
    }

    private void sendJson(HttpServletResponse response, int status, String body) throws IOException {
        response.setStatus(status);
        response.setContentType("application/json");
        response.getWriter().write(body);
    }
}
