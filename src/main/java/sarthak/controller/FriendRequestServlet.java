package sarthak.controller;

import sarthak.dao.FriendsDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/friends/request")
public class FriendRequestServlet extends HttpServlet {
    
    private FriendsDAO friendsDAO = new FriendsDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        int fromUserId = (int) session.getAttribute("userId");
        String receiverIdParam = request.getParameter("receiverId");
        String action = request.getParameter("action");

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        if (receiverIdParam != null && action != null) {
            try {
                int toUserId = Integer.parseInt(receiverIdParam);
                
                if (action.equals("toggle")) {
                    String status = friendsDAO.getFriendStatus(fromUserId, toUserId);
                    
                    if (status.equals("none")) {
                        friendsDAO.sendFriendRequest(fromUserId, toUserId);
                        out.print("{\"success\": true, \"message\": \"Friend request sent!\", \"text\": \"Cancel Request\", \"icon\": \"fa-xmark\", \"class\": \"bg-red-500\", \"action\": \"cancel\"}");
                    } else if (status.equals("sent_pending")) {
                        // Already pending, but if they click again, maybe we treat it as cancel?
                        // For now let's just keep it as is or show cancel
                        out.print("{\"success\": true, \"message\": \"Request already pending\", \"text\": \"Cancel Request\", \"icon\": \"fa-xmark\", \"class\": \"bg-red-500\", \"action\": \"cancel\"}");
                    } else if (status.equals("received_pending")) {
                        out.print("{\"success\": true, \"message\": \"They sent you a request!\", \"text\": \"Accept Request\", \"icon\": \"fa-user-check\", \"class\": \"bg-accent animate-pulse\", \"action\": \"accept\"}");
                    } else {
                        out.print("{\"success\": true, \"message\": \"You are already friends!\", \"text\": \"Friends\", \"icon\": \"fa-user-check\", \"class\": \"bg-accent\", \"action\": \"none\"}");
                    }
                } else if (action.equals("accept")) {
                    boolean success = friendsDAO.acceptFriendRequest(fromUserId, toUserId);
                    if (success) {
                        out.print("{\"success\": true, \"message\": \"Request accepted!\", \"text\": \"Friends\", \"icon\": \"fa-user-check\", \"class\": \"bg-accent\", \"action\": \"none\"}");
                    } else {
                        out.print("{\"success\": false, \"message\": \"Could not accept request.\"}");
                    }
                } else if (action.equals("cancel") || action.equals("reject")) {
                    boolean success = friendsDAO.deleteFriendRequest(fromUserId, toUserId);
                    if (success) {
                        out.print("{\"success\": true, \"message\": \"Request " + action + "ed!\", \"text\": \"Add Friend\", \"icon\": \"fa-user-plus\", \"class\": \"bg-primary\", \"action\": \"toggle\"}");
                    } else {
                        out.print("{\"success\": false, \"message\": \"Could not " + action + " request.\"}");
                    }
                }
            } catch (Exception e) {
                out.print("{\"success\": false, \"message\": \"" + e.getMessage() + "\"}");
            }
        }
        out.flush();
    }
}
