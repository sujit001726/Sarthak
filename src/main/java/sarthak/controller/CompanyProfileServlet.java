package sarthak.controller;

import sarthak.dao.ProfileDAO;
import sarthak.dao.UserDAO;
import sarthak.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/employer/company-profile")
public class CompanyProfileServlet extends HttpServlet {
    
    private UserDAO userDAO = new UserDAO();
    private ProfileDAO profileDAO = new ProfileDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        int userId = (int) session.getAttribute("userId");
        String userRole = (String) session.getAttribute("role");
        if (userRole == null) {
            userRole = (String) session.getAttribute("userRole");
        }

        if (!"employer".equalsIgnoreCase(userRole)) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }

        try {
            User user = userDAO.getUserById(userId);
            if (user != null) {
                request.setAttribute("companyName", user.getFullName());
                request.setAttribute("email", user.getEmail());
            }

            try (ResultSet rs = profileDAO.getProfile(userId)) {
                if (rs.next()) {
                    request.setAttribute("industry", rs.getString("industry"));
                    request.setAttribute("websiteUrl", rs.getString("website"));
                    request.setAttribute("companySize", rs.getString("company_size"));
                    
                    int foundedYear = rs.getInt("founded_year");
                    if (rs.wasNull()) {
                        request.setAttribute("foundedYear", "");
                    } else {
                        request.setAttribute("foundedYear", foundedYear);
                    }
                    
                    request.setAttribute("location", rs.getString("location"));
                    request.setAttribute("description", rs.getString("bio"));
                } else {
                    request.setAttribute("industry", "");
                    request.setAttribute("websiteUrl", "");
                    request.setAttribute("companySize", "");
                    request.setAttribute("foundedYear", "");
                    request.setAttribute("location", "");
                    request.setAttribute("description", "");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        request.getRequestDispatcher("/employer/company-profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        int userId = (int) session.getAttribute("userId");

        String companyName = trim(request.getParameter("companyName"));
        String industry = trim(request.getParameter("industry"));
        String websiteUrl = trim(request.getParameter("websiteUrl"));
        String companySize = trim(request.getParameter("companySize"));
        String foundedYearStr = trim(request.getParameter("foundedYear"));
        String location = trim(request.getParameter("location"));
        String description = trim(request.getParameter("description"));

        if (companyName.isEmpty()) {
            sendJson(response, HttpServletResponse.SC_BAD_REQUEST, "{\"success\": false, \"message\": \"Company name is required.\"}");
            return;
        }

        Integer foundedYear = null;
        if (!foundedYearStr.isEmpty()) {
            try {
                foundedYear = Integer.parseInt(foundedYearStr);
            } catch (NumberFormatException e) {
                sendJson(response, HttpServletResponse.SC_BAD_REQUEST, "{\"success\": false, \"message\": \"Founded year must be a number.\"}");
                return;
            }
        }

        try {
            User user = userDAO.getUserById(userId);
            String email = user != null ? user.getEmail() : "";
            
            userDAO.updateBasicProfile(userId, companyName, email);
            profileDAO.saveOrUpdateCompanyProfile(userId, industry, websiteUrl, companySize, foundedYear, location, description);
            
            session.setAttribute("userName", companyName);
            session.setAttribute("name", companyName);
            
            sendJson(response, HttpServletResponse.SC_OK, "{\"success\": true}");
        } catch (SQLException e) {
            e.printStackTrace();
            sendJson(response, HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "{\"success\": false, \"message\": \"Failed to save company profile changes.\"}");
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
