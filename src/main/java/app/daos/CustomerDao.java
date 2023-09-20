package app.daos;

import app.helpers.DBHelper;
import app.model.Product;
import app.model.User;
import org.springframework.stereotype.Component;

import java.sql.*;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;


@Component
public class CustomerDao {

    public int getUserIdByEmail(String email) {
        ResultSet rs;
        int userId = -1; // Initialize with a default value, like -1, to indicate no user found
        Connection con = DBHelper.getInstance().getConnection();
        String query = "SELECT id FROM user WHERE mail=? AND locked = false"; // Exclude locked customers
        try {
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, email);
            rs = ps.executeQuery();
            if (rs.next()) {
                userId = rs.getInt("id");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return userId;
    }


    //create
    public int createCustomer(User customer) {
        int status = 0;
        Connection connection = DBHelper.getInstance().getConnection();
        String query = "INSERT INTO user (name, password, confirmpassword, mail, phone, address, created_date, locked, role_id, user_image_path) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setString(1, customer.getName());
            ps.setString(2, customer.getPassword());
            ps.setString(3, customer.getConfirmpassword());
            ps.setString(4, customer.getMail());
            ps.setString(5, customer.getPhone());
            ps.setString(6, customer.getAddress());
            ps.setObject(7, customer.getCreated_date());
            ps.setBoolean(8, false);
            ps.setInt(9, customer.getRole_id());
            ps.setString(10, customer.getUser_image_path()); // Set image path

            status = ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        System.out.println("Status updation  :  "+ status);
        return status;
    }






public User getCustomerByName(String name) {
    ResultSet rs;
    User customer = null;
    Connection con = DBHelper.getInstance().getConnection();
    String query = "SELECT * FROM user WHERE name=? AND locked = false"; // Exclude locked customers
    try {
        PreparedStatement ps = con.prepareStatement(query);
        ps.setString(1, name);
        rs = ps.executeQuery();
        if (rs.next()) {
            customer = new User();
            customer.setId(rs.getInt("id"));
            customer.setName(rs.getString("name"));
            customer.setPassword(rs.getString("password"));
            customer.setConfirmpassword(rs.getString("confirmpassword"));
            customer.setMail(rs.getString("email"));
            customer.setPhone(rs.getString("phone"));
            customer.setAddress(rs.getString("address"));
            customer.setCreated_date((LocalDate) rs.getObject("created_date"));
            customer.setLocked(rs.getBoolean("locked"));
            customer.setRole_id(rs.getInt("role_id"));
            customer.setUser_image_path(rs.getString("user_image_path")); // Set image path
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return customer;
}
    //Login sitt dr
    public User getCustomerNamePass(String name,String password) {
        ResultSet rs;
        User customer = null;
        Connection con = DBHelper.getInstance().getConnection();
        String query = "SELECT * FROM user WHERE name=? AND password=? AND locked = false"; // Exclude locked customers
        try {
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, name);
            ps.setString(2, password);
            rs = ps.executeQuery();
            if (rs.next()) {
                customer = new User();
                customer.setId(rs.getInt("id"));
                customer.setName(rs.getString("name"));
                customer.setPassword(rs.getString("password"));
                customer.setRole_id(rs.getInt("role_id"));

            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return customer;
    }


    //Login sitt dr by email and password
    public User getUserEmailPassword(String email,String password) {
        ResultSet rs;
        User customer = null;
        Connection con = DBHelper.getInstance().getConnection();
        String query = "SELECT * FROM user WHERE mail=? AND password=?"; // Exclude locked customers
        try {
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, email);
            ps.setString(2, password);
            rs = ps.executeQuery();
            if (rs.next()) {
                customer = new User();
                customer.setId(rs.getInt("id"));
                customer.setMail(rs.getString("mail"));
                customer.setPassword(rs.getString("password"));
                customer.setRole_id(rs.getInt("role_id"));
                customer.setLocked(rs.getBoolean("locked"));

            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        System.out.println("Dao Result of Returning Email and address   : "+customer);
        return customer;
    }


    /*
       public int deleteCustomer(int id) {
            int status=0;
            Connection con=DBHelper.getInstance().getConnection();
            String query="DELETE FROM user WHERE id=?";
            try {
                PreparedStatement ps=con.prepareStatement(query);
                ps.setInt(1, id);
                status=ps.executeUpdate();

            } catch (SQLException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
            return status;
        }
    */
    //ban tae function mr tone
    public User getCustomerById(int id) {
        User customer = null;
        Connection con = DBHelper.getInstance().getConnection();
        String query = "SELECT * FROM user WHERE id=? AND locked = false"; // Exclude locked customers
        try {
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                customer = new User();
                customer.setId(rs.getInt("id"));
                customer.setName(rs.getString("name"));
                customer.setPassword(rs.getString("password"));
                customer.setConfirmpassword(rs.getString("confirmpassword"));
                customer.setMail(rs.getString("mail"));
                customer.setPhone(rs.getString("phone"));
                customer.setAddress(rs.getString("address"));
                customer.setCreated_date(rs.getObject("created_date", LocalDate.class));
                customer.setLocked(rs.getBoolean("locked"));
                customer.setRole_id(rs.getInt("role_id"));
                customer.setUser_image_path(rs.getString("user_image_path"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return customer;
    }


    public int updateCustomer(User customer) {
        int status = 0;
        Connection con = DBHelper.getInstance().getConnection();
        String query = "UPDATE user SET name=?, password=?, confirmpassword=?, mail=?, phone=?, address=?,  locked=?, role_id=?, user_image_path=? WHERE id=? AND locked = false"; // Exclude locked customers
        try {
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, customer.getName());
            ps.setString(2, customer.getPassword());
            ps.setString(3, customer.getPassword()); // Update the confirm password field
            ps.setString(4, customer.getMail());
            ps.setString(5, customer.getPhone());
            ps.setString(6, customer.getAddress());

            ps.setBoolean(7, customer.isLocked());
            ps.setInt(8, customer.getRole_id());
            ps.setString(9, customer.getUser_image_path()); // Set user_image_path
            ps.setInt(10, customer.getId()); // Set ID
            status = ps.executeUpdate();

            System.out.println("Update Status: " + status); // Print the update status
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return status;
    }


    //servlet Request kaw na Rim da ai name hte seng ai id hpe la mayu na
    public int getUserIdByName(String name) {
        int userId = 0; // Initialize with a default value, or choose a meaningful default

        Connection connection = DBHelper.getInstance().getConnection();

        String sql = "SELECT id FROM user WHERE name = ? AND locked = false"; // Exclude locked customers

        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, name);

            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    userId = resultSet.getInt("id");
                }
            }
            // Debug statement
            System.out.println("User ID for username " + name + ": " + userId);
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle the exception (e.g., log the error or throw a custom exception)
        }

        return userId;
    }


    //User Email Existing checking in the database after clicking forget password
    public boolean doesEmailExist(String mail) {
        boolean emailExists = false;
        Connection con = DBHelper.getInstance().getConnection();
        String query = "SELECT COUNT(*) FROM user WHERE mail = ? AND locked = false"; // Exclude locked customers

        // Check if the connection is null
        if (con == null) {
            // Handle the case where connection could not be established
            System.err.println("ERROR: Database connection could not be established.");
            return emailExists;
        }

        try {
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, mail);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                int count = rs.getInt(1);
                System.out.println("Count from database: " + count); // Add this line
                emailExists = count > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return emailExists;
    }

    //Checking email and password method after resetting password
    public User getCustomerByEmailPass(String mail, String password) {
        ResultSet rs;
        User customer = null;
        Connection con = DBHelper.getInstance().getConnection();
        String query = "SELECT * FROM user WHERE mail=? AND password=? AND locked = false"; // Exclude locked customers
        try {
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, mail);
            ps.setString(2, password);

            rs = ps.executeQuery();
            if (rs.next()) {
                customer = new User();
                customer.setId(rs.getInt("id"));
                customer.setName(rs.getString("name"));
                customer.setPassword(rs.getString("password"));
                customer.setConfirmpassword(rs.getString("confirmpassword"));
                customer.setMail(rs.getString("email"));
                customer.setPhone(rs.getString("phone"));
                customer.setAddress(rs.getString("address"));
                customer.setCreated_date(rs.getObject("created_date", LocalDate.class));
                customer.setLocked(rs.getBoolean("locked"));
                customer.setRole_id(rs.getInt("role_id"));
                customer.setUser_image_path(rs.getString("user_image_path"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return customer;
    }

    public User getUserById(int userId) {
        Connection con = DBHelper.getInstance().getConnection();
        String query = "SELECT * FROM user WHERE id = ?";
        User user = null;

        try {
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                user = new User();
                user.setId(rs.getInt("id"));
                user.setName(rs.getString("name"));
                user.setPassword(rs.getString("password"));
                user.setConfirmpassword(rs.getString("confirmpassword"));
                user.setMail(rs.getString("mail"));
                user.setPhone(rs.getString("phone"));
                user.setAddress(rs.getString("address"));

//                user.setCreated_date(rs.getObject("created_date", LocalDate.class));

                user.setLocked(rs.getBoolean("locked"));
                user.setRole_id(rs.getInt("role_id"));
                user.setUser_image_path(rs.getString("user_image_path"));
            }

            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return user;
    }



    public int updateRoleToPremiumAndSetExpiration(int userId) {
        int status = 0;
        Connection connection = DBHelper.getInstance().getConnection();
        String query = "UPDATE user SET role_id = 3, subscription_expiration = ? WHERE id = ?";


        LocalDateTime currentDateTime = LocalDateTime.now();
        LocalDateTime expirationDateTime = currentDateTime.plusMinutes(59);

        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setTimestamp(1, Timestamp.valueOf(expirationDateTime));
            ps.setInt(2, userId);
            status = ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return status;
    }


    public int updatePremiumUserToNormalAfterExpiration(int userId) {
        int status = 0;
        Connection connection = DBHelper.getInstance().getConnection();
        String query = "UPDATE user SET role_id = 2 WHERE id = ? AND role_id = 3 AND subscription_expiration <= ?";

        LocalDateTime currentDateTime = LocalDateTime.now();

        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, userId);
            ps.setTimestamp(2, Timestamp.valueOf(currentDateTime));
            status = ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        System.out.println("Update Premium Preeeeee status :  "+ status);
        return status;


    }

    public List<User> getUsersWithExpiredSubscriptions() {
        List<User> usersWithExpiredSubscriptions = new ArrayList<>();
        Connection connection = DBHelper.getInstance().getConnection();
        String query = "SELECT id, name, role_id, subscription_expiration FROM user WHERE role_id = 3 AND subscription_expiration <= ?";

        LocalDateTime currentDateTime = LocalDateTime.now();
        System.out.println("Current DateTime: " + currentDateTime); // Debug statement

        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setTimestamp(1, Timestamp.valueOf(currentDateTime));
            ResultSet resultSet = ps.executeQuery();

            while (resultSet.next()) {
                int id = resultSet.getInt("id");
                String name = resultSet.getString("name");
                int roleId = resultSet.getInt("role_id");
                LocalDateTime expirationDateTime = resultSet.getTimestamp("subscription_expiration").toLocalDateTime();

                System.out.println("User ID: " + id + " | Expiration: " + expirationDateTime); // Debug statement

                User user = new User(id, name, roleId, expirationDateTime);
                usersWithExpiredSubscriptions.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return usersWithExpiredSubscriptions;
    }


    public int getUserIdByProductId(int productId) {
        int userId = -1; // Initialize with a default value, like -1, to indicate no user found
        Connection connection = DBHelper.getInstance().getConnection();
        String query = "SELECT user_id FROM ProductTable WHERE id = ? AND locked = false"; // Exclude locked products

        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, productId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    userId = rs.getInt("user_id");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return userId;
    }
    // UserDao.java
    public String getUserNameById(int userId) {
        String userName = null;
        String query = "SELECT username FROM user WHERE id = ?";
        Connection connection = DBHelper.getInstance().getConnection();

        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                userName = rs.getString("username");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return userName;
    }



}




