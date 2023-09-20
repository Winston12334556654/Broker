package app.scheduler;

import app.daos.CustomerDao;
import app.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public class SubscriptionExpirationScheduler {

    @Autowired
    private CustomerDao customerDao;

    @Scheduled(fixedDelay = 60000) // Run every 1 minute
    public void checkSubscriptionExpirations() {
        System.out.println("Checking subscription expirations..."); // Debug statement

        // Get the list of users with expired subscriptions
        List<User> usersWithExpiredSubscriptions = customerDao.getUsersWithExpiredSubscriptions();

        for (User user : usersWithExpiredSubscriptions) {
            System.out.println("Updating user: " + user.getId()); // Debug statement

            // Revert the user's role back to normal
            customerDao.updatePremiumUserToNormalAfterExpiration(user.getId());
        }
    }
}
