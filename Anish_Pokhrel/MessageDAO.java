package sarthak.dao;

import sarthak.model.Message;

import java.sql.Timestamp;
import java.time.Instant;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.concurrent.CopyOnWriteArrayList;
import java.util.concurrent.atomic.AtomicInteger;

public class MessageDAO {
    private static final AtomicInteger NEXT_ID = new AtomicInteger(1);
    private static final List<Message> MESSAGES = new CopyOnWriteArrayList<>();

    static {
        addSeedMessage(2, 1, "Thanks for checking our Java Developer opening.");
        addSeedMessage(1, 2, "I am interested. Could you share the next step?");
        addSeedMessage(3, 1, "We reviewed your frontend profile and would like to talk.");
    }

    public boolean insertMessage(Message message) {
        message.setId(NEXT_ID.getAndIncrement());
        message.setCreatedAt(Timestamp.from(Instant.now()));
        message.setRead(false);
        MESSAGES.add(message);
        NotificationDAO.send(
                message.getReceiverId(),
                "New Message",
                "You received a new message: " + message.getSubject(),
                "message",
                "/messages?userId=" + message.getSenderId());
        return true;
    }

    public List<Message> getInboxMessages(int userId) {
        return MESSAGES.stream()
                .filter(message -> message.getReceiverId() == userId)
                .sorted(Comparator.comparing(Message::getCreatedAt).reversed())
                .map(this::copy)
                .toList();
    }

    public List<Message> getChatHistory(int userA, int userB) {
        return MESSAGES.stream()
                .filter(message -> (message.getSenderId() == userA && message.getReceiverId() == userB)
                        || (message.getSenderId() == userB && message.getReceiverId() == userA))
                .sorted(Comparator.comparing(Message::getCreatedAt))
                .map(this::copy)
                .toList();
    }

    public List<Message> getConversations(int userId) {
        List<Message> conversations = new ArrayList<>();
        for (Message message : MESSAGES) {
            if (message.getSenderId() != userId && message.getReceiverId() != userId) {
                continue;
            }

            int otherId = message.getSenderId() == userId ? message.getReceiverId() : message.getSenderId();
            int existingIndex = findConversation(conversations, userId, otherId);
            if (existingIndex < 0 || message.getCreatedAt().after(conversations.get(existingIndex).getCreatedAt())) {
                Message copy = copy(message);
                copy.setSubject(displayName(otherId));
                if (existingIndex >= 0) {
                    conversations.set(existingIndex, copy);
                } else {
                    conversations.add(copy);
                }
            }
        }

        conversations.sort(Comparator.comparing(Message::getCreatedAt).reversed());
        return conversations;
    }

    public boolean markAsRead(int messageId, int receiverId) {
        for (Message message : MESSAGES) {
            if (message.getId() == messageId && message.getReceiverId() == receiverId) {
                message.setRead(true);
                return true;
            }
        }
        return false;
    }

    private int findConversation(List<Message> conversations, int userId, int otherId) {
        for (int i = 0; i < conversations.size(); i++) {
            Message message = conversations.get(i);
            int conversationOtherId = message.getSenderId() == userId ? message.getReceiverId() : message.getSenderId();
            if (conversationOtherId == otherId) {
                return i;
            }
        }
        return -1;
    }

    private static void addSeedMessage(int senderId, int receiverId, String body) {
        Message message = new Message();
        message.setSenderId(senderId);
        message.setReceiverId(receiverId);
        message.setSubject("Chat Message");
        message.setBody(body);
        message.setId(NEXT_ID.getAndIncrement());
        message.setCreatedAt(Timestamp.from(Instant.now().minusSeconds((long) NEXT_ID.get() * 90)));
        MESSAGES.add(message);
    }

    private String displayName(int userId) {
        if (userId == 2) {
            return "Sarthak Employer";
        }
        if (userId == 3) {
            return "Hiring Manager";
        }
        return "Demo User " + userId;
    }

    private Message copy(Message source) {
        Message message = new Message();
        message.setId(source.getId());
        message.setSenderId(source.getSenderId());
        message.setReceiverId(source.getReceiverId());
        message.setJobId(source.getJobId());
        message.setSubject(source.getSubject());
        message.setBody(source.getBody());
        message.setRead(source.isRead());
        message.setCreatedAt(source.getCreatedAt());
        return message;
    }
}
