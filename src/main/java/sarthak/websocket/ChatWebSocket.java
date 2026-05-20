package sarthak.websocket;

import jakarta.websocket.*;
import jakarta.websocket.server.ServerEndpoint;
import sarthak.dao.MessageDAO;
import sarthak.model.Message;
import java.io.IOException;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import org.json.JSONObject;

@ServerEndpoint(value = "/chat")
public class ChatWebSocket {

    private static final Map<Integer, Session> userSessions = new ConcurrentHashMap<>();
    private final MessageDAO messageDAO = new MessageDAO();

    @OnOpen
    public void onOpen(Session session) {
        String query = session.getQueryString();
        Integer userId = null;
        if (query != null && query.contains("userId=")) {
            try {
                String[] pairs = query.split("&");
                for (String pair : pairs) {
                    if (pair.startsWith("userId=")) {
                        userId = Integer.parseInt(pair.substring(7));
                        break;
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        if (userId != null) {
            userSessions.put(userId, session);
            session.getUserProperties().put("userId", userId);
            System.out.println("WebSocket opened for user: " + userId);
        } else {
            try {
                session.close(new CloseReason(CloseReason.CloseCodes.VIOLATED_POLICY, "Unauthorized"));
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    @OnMessage
    public void onMessage(String messageStr, Session session) {
        Integer senderId = (Integer) session.getUserProperties().get("userId");
        if (senderId == null) return;

        try {
            JSONObject json = new JSONObject(messageStr);
            int receiverId = json.getInt("receiverId");
            String body = json.getString("body");

            // Save to DB
            Message msg = new Message();
            msg.setSenderId(senderId);
            msg.setReceiverId(receiverId);
            msg.setBody(body);
            msg.setSubject("Chat Message");
            
            if (messageDAO.insertMessage(msg)) {
                // Send to receiver if online
                Session receiverSession = userSessions.get(receiverId);
                JSONObject response = new JSONObject();
                response.put("type", "message");
                response.put("senderId", senderId);
                response.put("body", body);
                response.put("timestamp", System.currentTimeMillis());

                if (receiverSession != null && receiverSession.isOpen()) {
                    receiverSession.getAsyncRemote().sendText(response.toString());
                }
                
                // Echo back to sender for confirmation
                session.getAsyncRemote().sendText(response.toString());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @OnClose
    public void onClose(Session session) {
        Integer userId = (Integer) session.getUserProperties().get("userId");
        if (userId != null) {
            userSessions.remove(userId);
            System.out.println("WebSocket closed for user: " + userId);
        }
    }

    @OnError
    public void onError(Session session, Throwable throwable) {
        throwable.printStackTrace();
    }
}
