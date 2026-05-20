package sarthak.controller;

import sarthak.dao.MessageDAO;
import sarthak.model.Message;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/messages/send")
public class MessageSendServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static final MessageDAO messageDAO = new MessageDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        int senderId = (int) session.getAttribute("userId");
        String receiverIdParam = request.getParameter("receiverId");
        String body = request.getParameter("body");

        if (receiverIdParam != null && body != null && !body.trim().isEmpty()) {
            try {
                int receiverId = Integer.parseInt(receiverIdParam);
                Message msg = new Message();
                msg.setSenderId(senderId);
                msg.setReceiverId(receiverId);
                msg.setBody(body);
                msg.setSubject("Direct Chat");
                
                boolean success = messageDAO.insertMessage(msg);
                if (success) {
                    response.setStatus(HttpServletResponse.SC_OK);
                    response.getWriter().print("{\"success\": true}");
                } else {
                    response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                }
            } catch (Exception e) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            }
        } else {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        }
    }
}
