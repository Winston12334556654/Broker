package app.daos;

import app.helpers.DBHelper;
import app.model.Reaction;
import org.springframework.stereotype.Component;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@Component
public class ReactionDao {

    // Add a method to save a Reaction to the database
    public int saveReaction(Reaction reaction) {
        int status = 0;
        Connection connection = DBHelper.getInstance().getConnection();
        String query = "INSERT INTO reactions (user_id, product_id, reaction_type) VALUES (?, ?, ?)";

        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, reaction.getUserId());
            ps.setInt(2, reaction.getProductId());
            ps.setString(3, reaction.getType());

            status = ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return status;
    }

    // Add a method to check if the user has already poked the product
    public boolean hasUserPokedProduct(int userId, int productId) {
        boolean hasPoked = false;
        Connection connection = DBHelper.getInstance().getConnection();
        String query = "SELECT COUNT(*) FROM reactions WHERE user_id = ? AND product_id = ? AND reaction_type = 'poke'";

        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, userId);
            ps.setInt(2, productId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                int count = rs.getInt(1);
                // If count is greater than 0, it means the user has already poked the product
                hasPoked = count > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return hasPoked;
    }


}
