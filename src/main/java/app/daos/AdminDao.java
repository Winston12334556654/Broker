package app.daos;

import app.helpers.DBHelper;
import app.model.Product;
import app.model.User;
import org.springframework.stereotype.Component;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;




@Component
public class AdminDao {


    public User getUserByUsername(String name, String password) {
        ResultSet rs;
        User user = new User();;
        Connection con = DBHelper.getInstance().getConnection();
        String query = "SELECT * FROM user WHERE name=? AND password=?";
        try {
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, name);
            ps.setString(2, password);

            rs = ps.executeQuery();
            if (rs.next()) {
                user.setId(rs.getInt("id"));
                user.setName(rs.getString("name"));
                user.setPassword(rs.getString("password"));
                user.setConfirmpassword(rs.getString("confirmpassword"));
                user.setMail(rs.getString("mail"));
                user.setPhone(rs.getString("phone"));
                user.setAddress(rs.getString("address"));
                // user.setCreated_date((LocalDate) rs.getObject("created_date"));
                user.setLocked(rs.getBoolean("locked"));
                user.setRole_id(rs.getInt("role_id"));

            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return user;
    }

    //view mr tone dr
    public List<User> getAllUser(){
        List<User> customers=new ArrayList<>();
        Connection connection=DBHelper.getInstance().getConnection();
        String query="SELECT * FROM user";
        ResultSet rs;
        try {
            PreparedStatement ps=connection.prepareStatement(query);
            rs=ps.executeQuery();
            while(rs.next()){
                User customer=new User();
                customer.setId(rs.getInt("id"));
                customer.setName(rs.getString("name"));
                customer.setMail(rs.getString("mail"));
                customer.setPhone(rs.getString("phone"));
                customer.setAddress(rs.getString("address"));

                Date createdDateSQL = rs.getDate("created_date");
                // Convert java.sql.Date to java.time.LocalDate
                LocalDate createdDate = createdDateSQL.toLocalDate();
                customer.setCreated_date(createdDate);

                customer.setLocked(rs.getBoolean("locked"));
                customer.setRole_id(rs.getInt("role_id"));
                customer.setUser_image_path(rs.getString("user_image_path"));
                customers.add(customer);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return customers;
    }


    //ban tae function mr tone
    public User getCustomerById(int id) {
        User customer = null;
        Connection con = DBHelper.getInstance().getConnection();
        String query = "SELECT * FROM user WHERE id=?";
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
                customer.setMail(rs.getString("email"));
                customer.setPhone(rs.getString("phone"));
                customer.setAddress(rs.getString("address"));
                customer.setCreated_date(rs.getObject("created_date", LocalDate.class));
                customer.setLocked(rs.getBoolean("locked"));
                customer.setRole_id(rs.getInt("role_id"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return customer;
    }

    // Update user information in the database
    public void updateUser(User user) {
        Connection con = DBHelper.getInstance().getConnection();
        String query = "UPDATE user SET name=?, mail=?, phone=?, address=?, locked=?, role_id=? WHERE id=?";
        try {
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, user.getName());
            ps.setString(2, user.getMail());
            ps.setString(3, user.getPhone());
            ps.setString(4, user.getAddress());
            ps.setBoolean(5, user.isLocked());
            ps.setInt(6, user.getRole_id());
            ps.setInt(7, user.getId());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    //Ban Unban or Locked column partially user updating dao method
    public void updateUserLockStatus(int id, boolean newLockStatus) {
        Connection con = DBHelper.getInstance().getConnection();
        String query = "UPDATE user SET locked=? WHERE id=?";
        try {
            PreparedStatement ps = con.prepareStatement(query);
            ps.setBoolean(1, newLockStatus);
            ps.setInt(2, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    //Ban Unban or Locked column partially product updating dao method
    public void updateProductLockStatus(int id, boolean newLockStatus) {
        Connection con = DBHelper.getInstance().getConnection();
        String query = "UPDATE ProductTable SET locked=? WHERE id=?";
        try {
            PreparedStatement ps = con.prepareStatement(query);
            ps.setBoolean(1, newLockStatus);
            ps.setInt(2, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    //Update password after clicking forget Password.
    public int updatePassword(String mail, String password, String confirmpassword) {
        System.out.println("Debug: mail = " + mail);
        System.out.println("Debug: password = " + password);
        System.out.println("Debug: confirmpassword = " + confirmpassword);

        int rowsAffected = 0;
        Connection con = DBHelper.getInstance().getConnection();

        // Check if the connection is null
        if (con == null) {
            // Handle the case where connection could not be established
            System.err.println("ERROR: Database connection could not be established.");
            return rowsAffected; // or throw an exception or return an error code
        }

        String query = "UPDATE user SET password=?, confirmpassword=? WHERE mail=?";
        try {
            con.setAutoCommit(false); // Disable autocommit to start a transaction

            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, password);
            ps.setString(2, confirmpassword);
            ps.setString(3, mail);

            rowsAffected = ps.executeUpdate(); // Return the number of rows affected

            // Commit the transaction
            con.commit();
        } catch (SQLException e) {
            e.printStackTrace();


        }
        return rowsAffected;
    }

    public List<Product> getAllProducts() {
        List<Product> products = new ArrayList<>();
        Connection connection = DBHelper.getInstance().getConnection();

        String sql = "SELECT * FROM ProductTable"; // Exclude locked products


        try (PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {
                Product product= new Product();
                product.setId(resultSet.getInt("id"));
                product.setProduct_item_id(resultSet.getString("product_item_id"));
                product.setProductName(resultSet.getString("productName"));
                product.setPrice(resultSet.getDouble("price"));
                product.setCategory(resultSet.getInt("category"));
                product.setProduct_status(resultSet.getByte("product_status"));
                product.setUser_id(resultSet.getInt("user_id"));
                product.setContact_info_for_product(resultSet.getString("contact_info_for_product"));
                product.setProduct_image_path(resultSet.getString("product_image_path"));

                product.setLocked(resultSet.getBoolean("locked"));
                // Get the Date object from the ResultSet
//                Date createdDateSQL = resultSet.getDate("created_date");
//                // Convert the Date object to LocalDate
//                LocalDate Created_date = createdDateSQL.toLocalDate();
//                product.setCreated_date(Created_date);



                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle the exception (e.g., log the error or throw a custom exception)
        }

        return products;
    }

    public List<User> viewAdminUsers() {
        List<User> admins = new ArrayList<>();
        Connection connection = DBHelper.getInstance().getConnection();
        String query = "SELECT * FROM user WHERE role_id = 1"; // Retrieve users with role_id = 1 (admins)
        ResultSet rs;
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                User admin = new User();

                admin.setId(rs.getInt("id"));
                admin.setName(rs.getString("name"));
                admin.setMail(rs.getString("mail"));
                admin.setPhone(rs.getString("phone"));
                admin.setAddress(rs.getString("address"));
                // Get the Date object from the ResultSet
                Date createdDateSQL = rs.getDate("created_date");
                // Convert the Date object to LocalDate
                LocalDate Created_date = createdDateSQL.toLocalDate();
                admin.setCreated_date(Created_date);

                admin.setLocked(rs.getBoolean("locked"));
                admin.setUser_image_path(rs.getString("user_image_path"));
                admin.setRole_id(rs.getInt("role_id"));
                admins.add(admin);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return admins;
    }

    public List<User> searchUsers(String searchTerm) {
        List<User> searchedUsers = new ArrayList<>();
        Connection connection = DBHelper.getInstance().getConnection();

        // Use a prepared statement with a LIKE clause to search for users
        String query = "SELECT * FROM user WHERE name LIKE ? OR mail LIKE ?";
        ResultSet rs;
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setString(1, "%" + searchTerm + "%"); // Search for name containing the searchTerm
            ps.setString(2, "%" + searchTerm + "%"); // Search for mail containing the searchTerm
            rs = ps.executeQuery();

            while (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setName(rs.getString("name"));
                user.setMail(rs.getString("mail"));
                user.setPhone(rs.getString("phone"));
                user.setAddress(rs.getString("address"));
                // Get the Date object from the ResultSet
                Date createdDateSQL = rs.getDate("created_date");
                // Convert the Date object to LocalDate
                LocalDate Created_date = createdDateSQL.toLocalDate();
                user.setCreated_date(Created_date);

                user.setLocked(rs.getBoolean("locked"));
                user.setRole_id(rs.getInt("role_id"));
                searchedUsers.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return searchedUsers;
    }








}
