package sarthak.dao;

import sarthak.model.Notification;

import java.sql.Timestamp;
import java.time.Instant;
import java.util.List;
import java.util.concurrent.CopyOnWriteArrayList;
import java.util.concurrent.atomic.AtomicInteger;

public class NotificationDAO {
    private static final AtomicInteger NEXT_ID = new AtomicInteger(1);
    private static final List<Notification> NOTIFICATIONS = new CopyOnWriteArrayList<>();

    public static void send(int userId, String title, String body, String type, String linkUrl) {
        Notification notification = new Notification();
        notification.setId(NEXT_ID.getAndIncrement());
        notification.setUserId(userId);
        notification.setTitle(title);
        notification.setBody(body);
        notification.setType(type);
        notification.setLinkUrl(linkUrl);
        notification.setRead(false);
        notification.setCreatedAt(Timestamp.from(Instant.now()));
        NOTIFICATIONS.add(notification);
    }

    public static void sendToAll(java.util.List<Integer> userIds, String title, String body, String type, String linkUrl) {
        for (int userId : userIds) {
            send(userId, title, body, type, linkUrl);
        }
    }

    public boolean insertNotification(Notification notification) {
        send(
                notification.getUserId(),
                notification.getTitle(),
                notification.getBody(),
                notification.getType(),
                notification.getLinkUrl());
        return true;
    }

    public List<Notification> getNotificationsByUser(int userId) {
        return NOTIFICATIONS.stream()
                .filter(notification -> notification.getUserId() == userId)
                .sorted((left, right) -> right.getCreatedAt().compareTo(left.getCreatedAt()))
                .toList();
    }

    public int countUnreadNotifications(int userId) {
        return (int) NOTIFICATIONS.stream()
                .filter(notification -> notification.getUserId() == userId && !notification.isRead())
                .count();
    }

    public boolean markAsRead(int notificationId, int userId) {
        for (Notification notification : NOTIFICATIONS) {
            if (notification.getId() == notificationId && notification.getUserId() == userId) {
                notification.setRead(true);
                return true;
            }
        }
        return false;
    }

    public boolean markAllAsRead(int userId) {
        boolean changed = false;
        for (Notification notification : NOTIFICATIONS) {
            if (notification.getUserId() == userId) {
                notification.setRead(true);
                changed = true;
            }
        }
        return changed;
    }

    public boolean clearAllByUser(int userId) {
        return NOTIFICATIONS.removeIf(notification -> notification.getUserId() == userId);
    }
}
