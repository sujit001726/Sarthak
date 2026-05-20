package sarthak.controller;

import sarthak.dao.ProfileDAO;
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

@WebServlet("/upload-resume")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,
    maxFileSize = 1024 * 1024 * 10,
    maxRequestSize = 1024 * 1024 * 12
)
public class ResumeUploadServlet extends HttpServlet {

    private final ProfileDAO profileDAO = new ProfileDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        Part resumePart = request.getPart("resume");
        if (resumePart == null || resumePart.getSize() == 0) {
            sendJson(response, HttpServletResponse.SC_BAD_REQUEST, "{\"success\":false,\"message\":\"Please choose a resume file.\"}");
            return;
        }

        String fileName = getSubmittedFileName(resumePart);
        String contentType = resumePart.getContentType();
        if (!isAllowedResume(fileName, contentType)) {
            sendJson(response, HttpServletResponse.SC_BAD_REQUEST, "{\"success\":false,\"message\":\"Only PDF or DOCX resumes are allowed.\"}");
            return;
        }

        int userId = (int) session.getAttribute("userId");
        byte[] data = resumePart.getInputStream().readAllBytes();

        try {
            profileDAO.saveResume(userId, fileName, normalizeContentType(fileName, contentType), data);
            String downloadUrl = request.getContextPath() + "/resume?userId=" + userId + "&t=" + System.currentTimeMillis();
            sendJson(response, HttpServletResponse.SC_OK,
                    "{\"success\":true,\"fileName\":\"" + escapeJson(fileName) + "\",\"downloadUrl\":\"" + downloadUrl + "\"}");
        } catch (SQLException e) {
            e.printStackTrace();
            sendJson(response, HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "{\"success\":false,\"message\":\"Could not save resume.\"}");
        }
    }

    private boolean isAllowedResume(String fileName, String contentType) {
        String lowerName = fileName == null ? "" : fileName.toLowerCase();
        return lowerName.endsWith(".pdf") || lowerName.endsWith(".docx")
                || "application/pdf".equalsIgnoreCase(contentType)
                || "application/vnd.openxmlformats-officedocument.wordprocessingml.document".equalsIgnoreCase(contentType);
    }

    private String normalizeContentType(String fileName, String contentType) {
        String lowerName = fileName == null ? "" : fileName.toLowerCase();
        if (lowerName.endsWith(".pdf")) {
            return "application/pdf";
        }
        if (lowerName.endsWith(".docx")) {
            return "application/vnd.openxmlformats-officedocument.wordprocessingml.document";
        }
        return contentType != null ? contentType : "application/octet-stream";
    }

    private String getSubmittedFileName(Part part) {
        String submitted = part.getSubmittedFileName();
        if (submitted == null || submitted.trim().isEmpty()) {
            return "resume.pdf";
        }
        return submitted.replace("\\", "/").replaceAll(".*/", "");
    }

    private void sendJson(HttpServletResponse response, int status, String body) throws IOException {
        response.setStatus(status);
        response.setContentType("application/json");
        response.getWriter().write(body);
    }

    private String escapeJson(String value) {
        return value == null ? "" : value.replace("\\", "\\\\").replace("\"", "\\\"");
    }
}
