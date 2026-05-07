package com.sarthak.sarthak.user.controller.auth;

import com.sarthak.sarthak.util.DBConnection;
import java.io.IOException;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

// Superseded by com.jobportal.controller.LoginServlet
// @WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        String sql = "SELECT * FROM admins WHERE username = ? AND password = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, username);
            ps.setString(2, password);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    HttpSession session = request.getSession();
                    session.setAttribute("admin", username);
                    response.sendRedirect("admin?action=dashboard");
                } else {
                    response.sendRedirect("login.jsp?error=invalid");
                }
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
