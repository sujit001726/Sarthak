package sarthak.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.json.JSONArray;
import org.json.JSONObject;
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
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write("{\"error\": \"Not logged in\"}");
            return;
        }

        String action = request.getParameter("action");

        if ("count".equals(action)) {
            int count = notificationDAO.countUnreadNotifications(userId);
            JSONObject json = new JSONObject();
            json.put("count", count);
            response.getWriter().write(json.toString());
        } else {
            List<Notification> notifications = notificationDAO.getNotificationsByUser(userId);
            JSONArray jsonArray = new JSONArray();
            for (Notification n : notifications) {
                JSONObject obj = new JSONObject();
                obj.put("id", n.getId());
                obj.put("title", n.getTitle());
                obj.put("body", n.getBody());
                obj.put("type", n.getType());
                obj.put("linkUrl", n.getLinkUrl());
                obj.put("read", n.isRead());
                obj.put("createdAt", n.getCreatedAt().toString());
                jsonArray.put(obj);
            }
            response.getWriter().write(jsonArray.toString());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        String action = request.getParameter("action");
        if ("markRead".equals(action)) {
            String idStr = request.getParameter("id");
            if (idStr != null) {
                int id = Integer.parseInt(idStr);
                notificationDAO.markAsRead(id, userId);
            }
        } else if ("markAllRead".equals(action)) {
            notificationDAO.markAllAsRead(userId);
        } else if ("clearAll".equals(action)) {
            notificationDAO.clearAllByUser(userId);
        }
        
        response.setStatus(HttpServletResponse.SC_OK);
    }
}
