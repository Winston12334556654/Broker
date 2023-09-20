package app.controller;

import app.daos.CustomerDao;
import app.daos.NotificationDao;
import app.model.Notification;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class NotificationService {

    private final NotificationDao notificationDao;
    private final CustomerDao userDao;

    @Autowired
    public NotificationService(NotificationDao notificationDao, CustomerDao userDao) {
        this.notificationDao = notificationDao;
        this.userDao = userDao;
    }

    public void generatePokeNotification(int senderId, int productId, int sellerUserId) {
        // Fetch the owner of the product
        int recipientId = userDao.getUserIdByProductId(productId);

        // Get the sender's name from the userDao
        String senderName = userDao.getUserNameById(senderId);

        // Generate the notification message
        String notificationContent = senderName + " poked your product with ID " + productId;

        // Create a new notification
        Notification notification = new Notification();
        notification.setSenderId(senderId);
        notification.setSenderName(senderName); // Set sender's name
        notification.setReceiverId(recipientId);
        notification.setContent(notificationContent);
        notification.setStatus("unread");

        // Save the notification
        saveNotification(notification);
    }


    public void saveNotification(Notification notification) {
        // Use the notificationDao to save the notification
        notificationDao.saveNotification(notification);
    }

    // Add other methods as needed
}
