package sarthak.controller;

import sarthak.dao.MessageDAO;
import sarthak.model.Message;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/messages")
public class MessageServlet extends HttpServlet {

    private final MessageDAO messageDAO = new MessageDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        try {
            int userId = (int) session.getAttribute("userId");
            String userRole = (String) session.getAttribute("role");
            req.setAttribute("userId", userId);
            req.setAttribute("userRole", userRole);
            
            String otherUserIdStr = req.getParameter("userId");

            // Load all conversations for the sidebar
            List<Message> conversations = messageDAO.getConversations(userId);
            req.setAttribute("conversations", conversations);

            if (otherUserIdStr != null && !otherUserIdStr.isEmpty()) {
                try {
                    int otherUserId = Integer.parseInt(otherUserIdStr);
                    List<Message> chatHistory = messageDAO.getChatHistory(userId, otherUserId);
                    req.setAttribute("chatHistory", chatHistory);
                    req.setAttribute("activeChatId", otherUserId);
                    
                    // Mark messages as read
                    for (Message msg : chatHistory) {
                        if (msg.getReceiverId() == userId && !msg.isRead()) {
                            messageDAO.markAsRead(msg.getId(), userId);
                        }
                    }
                } catch (NumberFormatException e) {
                    // Ignore invalid ID
                }
            }

            req.getRequestDispatcher("/messages.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace(); // This will show the error in your console
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            resp.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        int senderId = (int) session.getAttribute("userId");
        String receiverIdStr = req.getParameter("receiverId");
        String body = req.getParameter("body");

        if (receiverIdStr != null && body != null && !body.trim().isEmpty()) {
            try {
                int receiverId = Integer.parseInt(receiverIdStr);
                Message msg = new Message();
                msg.setSenderId(senderId);
                msg.setReceiverId(receiverId);
                msg.setBody(body);
                msg.setSubject("Chat Message"); // Default subject
                
                if (messageDAO.insertMessage(msg)) {
                    resp.setStatus(HttpServletResponse.SC_OK);
                    // In real-time, WebSocket would handle the push
                } else {
                    resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                }
            } catch (NumberFormatException e) {
                resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            }
        } else {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        }
    }
}
