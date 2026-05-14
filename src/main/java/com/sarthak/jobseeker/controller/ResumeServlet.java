package com.sarthak.jobseeker.controller;

import com.sarthak.jobseeker.dao.ProfileDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.sql.SQLException;

@WebServlet("/resume")
public class ResumeServlet extends HttpServlet {

    private final ProfileDAO profileDAO = new ProfileDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        int sessionUserId = (int) session.getAttribute("userId");
        int userId = sessionUserId;
        String userIdParam = request.getParameter("userId");
        if (userIdParam != null && !userIdParam.trim().isEmpty()) {
            try {
                userId = Integer.parseInt(userIdParam);
            } catch (NumberFormatException e) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST);
                return;
            }
        }

        try {
            ProfileDAO.ResumeFile resume = profileDAO.getResume(userId);
            if (resume == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
                return;
            }

            String fileName = resume.getFileName() != null ? resume.getFileName() : "resume.pdf";
            String encodedName = URLEncoder.encode(fileName, StandardCharsets.UTF_8).replace("+", "%20");
            response.setContentType(resume.getContentType() != null ? resume.getContentType() : "application/octet-stream");
            response.setHeader("Content-Disposition", "inline; filename=\"" + fileName.replace("\"", "") + "\"; filename*=UTF-8''" + encodedName);
            response.setContentLength(resume.getData().length);
            response.getOutputStream().write(resume.getData());
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}
