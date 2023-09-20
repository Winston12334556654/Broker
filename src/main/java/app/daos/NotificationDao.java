package app.daos;

import app.helpers.DBHelper;
import app.model.Notification;
import org.springframework.stereotype.Component;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@Component
public class NotificationDao {

    private Connection connection;

    public NotificationDao() {
        this.connection = DBHelper.getInstance().getConnection();
    }

    // Method to save a notification in the database
    // Method to save a notification in the database with sender's name
    public int saveNotification(Notification notification) {
        int status = 0;

        String query = "INSERT INTO notification (sender_id, sender_name, recipient_id, content, status) VALUES (?, ?, ?, ?, ?)";

        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, notification.getSenderId());
            ps.setString(2, notification.getSenderName()); // Set sender's name
            ps.setInt(3, notification.getReceiverId());
            ps.setString(4, notification.getContent());
            ps.setString(5, notification.getStatus());

            status = ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return status;
    }


    // Method to mark a notification as read
    public void markAsRead(int notificationId) {
        String query = "UPDATE notification SET status = 'read' WHERE id = ?";

        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, notificationId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Method to retrieve notifications for a specific user
    // Method to retrieve notifications for a specific user with sender's name
    public List<Notification> getNotificationsByUserId(int userId) {
        List<Notification> notifications = new ArrayList<>();
        String query = "SELECT n.*, u.name AS sender_name FROM notification n " +
                "INNER JOIN user u ON n.sender_id = u.id " +
                "WHERE n.recipient_id = ?";

        System.out.println("get Notification by user id: " + userId);

        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Notification notification = new Notification();
                notification.setId(rs.getInt("id"));
                notification.setSenderId(rs.getInt("sender_id"));

                // Set sender's name from the result set
                notification.setSenderName(rs.getString("sender_name"));

                notification.setReceiverId(rs.getInt("recipient_id"));
                notification.setContent(rs.getString("content"));
                notification.setStatus(rs.getString("status"));



                notifications.add(notification);

            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return notifications;
    }







    // Add other methods as needed
}
