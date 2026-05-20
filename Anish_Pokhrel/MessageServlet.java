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

    private static final long serialVersionUID = 1L;
    private static final MessageDAO messageDAO = new MessageDAO();

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
            req.setAttribute("sessionUserId", userId);
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
                    
                    com.jobportal.dao.UserDAO userDAO = new com.jobportal.dao.UserDAO();
                    com.jobportal.model.User otherUser = userDAO.getUserById(otherUserId);
                    if (otherUser != null) {
                        req.setAttribute("activeChatName", otherUser.getFullName());
                    }
                    
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

            renderMessages(req, resp);
        } catch (Exception e) {
            e.printStackTrace(); 
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

    private void renderMessages(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.setContentType("text/html;charset=UTF-8");
        int sessionUserId = (int) req.getAttribute("sessionUserId");
        Integer activeChatId = (Integer) req.getAttribute("activeChatId");
        String activeChatName = (String) req.getAttribute("activeChatName");
        List<Message> conversations = castMessages(req.getAttribute("conversations"));
        List<Message> chatHistory = castMessages(req.getAttribute("chatHistory"));
        String contextPath = req.getContextPath();

        try (var out = resp.getWriter()) {
            out.println("""
                    <!DOCTYPE html>
                    <html lang="en">
                    <head>
                        <meta charset="UTF-8">
                        <meta name="viewport" content="width=device-width, initial-scale=1.0">
                        <title>Sarthak | Messages</title>
                        <script src="https://cdn.tailwindcss.com"></script>
                    </head>
                    <body class="bg-gray-100">
                    <main class="max-w-6xl mx-auto p-6">
                        <nav class="flex gap-4 mb-6 text-sm font-bold">
                            <a class="text-emerald-800" href="%s/job-market">Job Market</a>
                            <a class="text-emerald-800" href="%s/messages">Messages</a>
                        </nav>
                        <div class="grid md:grid-cols-[280px_1fr] gap-5">
                            <aside class="bg-white rounded-2xl shadow-sm overflow-hidden">
                                <h1 class="p-5 text-xl font-black border-b">Messages</h1>
                    """.formatted(contextPath, contextPath));

            for (Message conversation : conversations) {
                int otherId = conversation.getSenderId() == sessionUserId ? conversation.getReceiverId() : conversation.getSenderId();
                out.println("""
                        <a class="block p-4 border-b hover:bg-gray-50" href="%s/messages?userId=%d">
                            <div class="font-black">%s</div>
                            <div class="text-sm text-gray-500 truncate">%s</div>
                        </a>
                        """.formatted(contextPath, otherId, escape(conversation.getSubject()), escape(conversation.getBody())));
            }

            out.println("""
                            </aside>
                            <section class="bg-white rounded-2xl shadow-sm min-h-[520px] flex flex-col">
                    """);

            if (activeChatId == null) {
                out.println("<div class=\"m-auto text-center text-gray-500 font-bold\">Select a conversation.</div>");
            } else {
                out.println("<header class=\"p-5 border-b font-black\">" + escape(activeChatName) + "</header>");
                out.println("<div id=\"messages-container\" class=\"flex-1 p-5 space-y-3 overflow-y-auto\">");
                for (Message message : chatHistory) {
                    boolean sent = message.getSenderId() == sessionUserId;
                    String alignment = sent ? "text-right" : "text-left";
                    String color = sent ? "bg-emerald-900 text-white" : "bg-gray-100 text-gray-900";
                    out.println("<div class=\"" + alignment + "\"><span class=\"inline-block rounded-2xl px-4 py-2 " + color + "\">" + escape(message.getBody()) + "</span></div>");
                }
                out.println("</div>");
                out.println("""
                        <form method="post" action="%s/messages" class="p-5 border-t flex gap-2">
                            <input type="hidden" name="receiverId" value="%d">
                            <input name="body" class="flex-1 border rounded-xl px-4 py-3" placeholder="Type your message...">
                            <button class="bg-emerald-900 text-white px-5 py-3 rounded-xl font-bold">Send</button>
                        </form>
                        """.formatted(contextPath, activeChatId));
            }

            out.println("""
                            </section>
                        </div>
                    </main>
                    </body>
                    </html>
                    """);
        }
    }

    @SuppressWarnings("unchecked")
    private List<Message> castMessages(Object value) {
        return value instanceof List<?> ? (List<Message>) value : List.of();
    }

    private String escape(String value) {
        if (value == null) {
            return "";
        }
        return value
                .replace("&", "&amp;")
                .replace("<", "&lt;")
                .replace(">", "&gt;")
                .replace("\"", "&quot;");
    }
}
