package sarthak.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import sarthak.dao.NotificationDAO;
import sarthak.model.Notification;

import java.io.IOException;
import java.util.List;

@WebServlet("/notifications")
public class NotificationServlet extends HttpServlet {
    private final NotificationDAO notificationDAO = new NotificationDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        // Fallback for demo/admin if session is missing but we are on admin page
        if (userId == null) {
            userId = 1; // Default to admin ID 1 if not set
        }

        String action = request.getParameter("action");

        if ("count".equals(action)) {
            int count = notificationDAO.countUnreadNotifications(userId);
            response.getWriter().write("{\"count\":" + count + "}");
        } else {
            List<Notification> notifications = notificationDAO.getNotificationsByUser(userId);
            StringBuilder sb = new StringBuilder();
            sb.append("[");
            for (int i = 0; i < notifications.size(); i++) {
                Notification n = notifications.get(i);
                sb.append("{");
                sb.append("\"id\":").append(n.getId()).append(",");
                sb.append("\"title\":\"").append(escapeJson(n.getTitle())).append("\",");
                sb.append("\"body\":\"").append(escapeJson(n.getBody())).append("\",");
                sb.append("\"type\":\"").append(escapeJson(n.getType())).append("\",");
                sb.append("\"linkUrl\":\"").append(escapeJson(n.getLinkUrl())).append("\",");
                sb.append("\"read\":").append(n.isRead()).append(",");
                sb.append("\"createdAt\":\"").append(n.getCreatedAt()).append("\"");
                sb.append("}");
                if (i < notifications.size() - 1) sb.append(",");
            }
            sb.append("]");
            response.getWriter().write(sb.toString());
        }
    }

    private String escapeJson(String str) {
        if (str == null) return "";
        return str.replace("\"", "\\\"").replace("\n", "\\n").replace("\r", "\\r");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) userId = 1;

        String action = request.getParameter("action");
        if ("markRead".equals(action)) {
            String idStr = request.getParameter("id");
            if (idStr != null) {
                try {
                    int id = Integer.parseInt(idStr);
                    notificationDAO.markAsRead(id, userId);
                } catch (NumberFormatException e) { }
            }
        } else if ("markAllRead".equals(action)) {
            notificationDAO.markAllAsRead(userId);
        } else if ("clearAll".equals(action)) {
            notificationDAO.clearAllByUser(userId);
        }
        
        response.setStatus(HttpServletResponse.SC_OK);
    }
}
