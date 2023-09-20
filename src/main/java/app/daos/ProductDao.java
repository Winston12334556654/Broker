package app.daos;

import app.helpers.DBHelper;
import app.model.Product;
import org.springframework.stereotype.Component;


import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Component
public class ProductDao {

    public int createProduct(Product product) {
        int status = 0;
        Connection connection = DBHelper.getInstance().getConnection();

        // Generate the next product_item_id
        String nextProductId = generateNextProductItemId(connection);

        String query = "INSERT INTO ProductTable (product_item_id, productName, price, category, product_status, user_id, contact_info_for_product, product_image_path,locked,created_date) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, nextProductId);
            ps.setString(2, product.getProductName());
            ps.setDouble(3, product.getPrice());
            ps.setInt(4, product.getCategory());
            ps.setByte(5, product.getProduct_status());
            ps.setInt(6, product.getUser_id());
            ps.setString(7, product.getContact_info_for_product());

            // Get the product image path from the Product object and set it in the query
            ps.setString(8, product.getProduct_image_path());
            ps.setBoolean(9, false);
            ps.setObject(10, product.getCreated_date());

            status = ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return status;
    }

    private String generateNextProductItemId(Connection connection) {
        String nextProductId = null;

        // Start a transaction to ensure atomicity
        try {
            connection.setAutoCommit(false);

            // Retrieve the last counter value from the product_item_counter table
            String query = "SELECT counter FROM product_item_counter ORDER BY id DESC LIMIT 1";
            try (Statement stmt = connection.createStatement();
                 ResultSet rs = stmt.executeQuery(query)) {
                int lastCounter = 0;
                if (rs.next()) {
                    lastCounter = rs.getInt("counter");
                }

                // Increment the counter and update it in the product_item_counter table
                int nextCounter = lastCounter + 1;
                String updateQuery = "UPDATE product_item_counter SET counter = " + nextCounter + " WHERE id = (SELECT MAX(id) FROM product_item_counter)";
                stmt.executeUpdate(updateQuery);

                // Generate the next product_item_id
                nextProductId = "PD-" + String.format("%04d", nextCounter);

                // Commit the transaction
                connection.commit();
            }
        } catch (SQLException e) {
            // Rollback the transaction in case of an exception
            try {
                connection.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
        } finally {
            try {
                // Reset the auto-commit to true for future queries
                connection.setAutoCommit(true);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return nextProductId;
    }

    //product getall method

    public List<Product> getAllProducts() {
        List<Product> products = new ArrayList<>();
        Connection connection = DBHelper.getInstance().getConnection();

        String sql = "SELECT * FROM ProductTable WHERE locked = false"; // Exclude locked products


        try (PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {
                Product product = new Product();
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

    public List<Product> getProductsByCategory(int category) {
        List<Product> products = new ArrayList<>();
        Connection connection = DBHelper.getInstance().getConnection();
        System.out.println("Category ID being used in query: " + category); // Print the category ID for debugging

        String sql = "SELECT * FROM ProductTable WHERE category = ? AND locked = false"; // Exclude locked products

        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, category);
            System.out.println("Query being executed: " + sql); // Print the query for debugging


            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    Product product = new Product();
                    product.setId(resultSet.getInt("id"));
                    product.setProduct_item_id(resultSet.getString("product_item_id"));
                    product.setProductName(resultSet.getString("productName"));
                    product.setPrice(resultSet.getDouble("price"));
                    product.setCategory(resultSet.getInt("category"));
                    product.setProduct_status(resultSet.getByte("product_status"));
                    product.setUser_id(resultSet.getInt("user_id"));
                    product.setContact_info_for_product(resultSet.getString("contact_info_for_product"));
                    product.setProduct_image_path(resultSet.getString("product_image_path"));


                    products.add(product);
                    System.out.println("Found product: " + product.getProductName()); // Print the product name for debugging
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle the exception (e.g., log the error or throw a custom exception)
        }

        return products;
    }



//    public List<Product> getProductsPostedByUser(int userId) {
//        List<Product> products = new ArrayList<>();
//        String query = "SELECT * FROM ProductTable WHERE user_id = ? AND locked = false"; // Exclude locked products
//
//        try (Connection connection = DBHelper.getInstance().getConnection();
//             PreparedStatement preparedStatement = connection.prepareStatement(query)) {
//
//            preparedStatement.setInt(1, userId);
//
//            try (ResultSet resultSet = preparedStatement.executeQuery()) {
//                while (resultSet.next()) {
//                    Product product = new Product();
//                    // Populate the product object from the ResultSet
//                    product.setId(resultSet.getInt("id"));
//                    product.setProductName(resultSet.getString("productName"));
//                    product.setCategory(resultSet.getInt("category"));
//                    product.setPrice(resultSet.getDouble("price"));
//                    // Set other product attributes as needed
//                    products.add(product);
//                }
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//
//        return products;
//    }

    //product search
    public List<Product> searchProductsByName(String productName) {
        List<Product> products = new ArrayList<>();
        Connection connection = DBHelper.getInstance().getConnection();

        String sql = "SELECT * FROM ProductTable WHERE productName LIKE ? AND locked = false"; // Exclude locked products


        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, "%" + productName + "%");

            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    Product product = new Product();
                    // Populate the product object from the ResultSet
                    product.setId(resultSet.getInt("id"));
                    product.setProduct_item_id(resultSet.getString("product_item_id"));
                    product.setProductName(resultSet.getString("productName"));
                    product.setPrice(resultSet.getDouble("price"));
                    product.setCategory(resultSet.getInt("category"));
                    product.setProduct_status(resultSet.getByte("product_status"));
                    product.setUser_id(resultSet.getInt("user_id"));
                    product.setContact_info_for_product(resultSet.getString("contact_info_for_product"));
                    product.setProduct_image_path(resultSet.getString("product_image_path"));

                    products.add(product);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return products;
    }


    // Method to retrieve products by user ID
    public List<Product> getProductsByUserId(int userId) {
        List<Product> userProducts = new ArrayList<>();
        Connection connection = DBHelper.getInstance().getConnection();

        String sql = "SELECT * FROM ProductTable WHERE user_id = ? AND locked = false"; // or locked = 0

        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setLong(1, userId);

            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    Product product = new Product();
                    // Populate the product object from the ResultSet
                    product.setId(resultSet.getInt("id"));
                    product.setProduct_item_id(resultSet.getString("product_item_id"));
                    product.setProductName(resultSet.getString("productName"));
                    product.setPrice(resultSet.getDouble("price"));
                    product.setCategory(resultSet.getInt("category"));
                    product.setProduct_status(resultSet.getByte("product_status"));
                    product.setUser_id(resultSet.getInt("user_id"));
                    product.setContact_info_for_product(resultSet.getString("contact_info_for_product"));
                    product.setProduct_image_path(resultSet.getString("product_image_path"));

                    userProducts.add(product);
                }

                // Debug statement
                System.out.println("Number of user products for user ID " + userId + ": " + userProducts.size());
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle the exception (e.g., log the error or throw a custom exception)
        }

        return userProducts;
    }


    // Accepting product id For Updating product
    public Product getProductById(int id) {
        Product product = null;
        Connection connection = DBHelper.getInstance().getConnection();

        String sql = "SELECT * FROM ProductTable WHERE id = ?";

        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, id);

            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    product = new Product();
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
                    // Set other product attributes as needed
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle the exception (e.g., log the error or throw a custom exception)
        }

        return product;
    }

    //Update Products
    public int updateProduct(Product product) {
        int status = 0;
        Connection connection = DBHelper.getInstance().getConnection();

        String query = "UPDATE ProductTable SET productName = ?, price = ?, category = ?, product_status = ?, contact_info_for_product = ?, product_image_path = ? WHERE id = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, product.getProductName());
            ps.setDouble(2, product.getPrice());
            ps.setInt(3, product.getCategory());
            ps.setByte(4, product.getProduct_status());
            ps.setString(5, product.getContact_info_for_product());
            ps.setString(6, product.getProduct_image_path());
            ps.setInt(7, product.getId());

            status = ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return status;
    }


    public List<Product> getRandomProducts(int limit) {
        List<Product> randomProducts = new ArrayList<>();
        Connection connection = DBHelper.getInstance().getConnection();

        String sql = "SELECT id, productName, price, category, product_status, user_id, contact_info_for_product, product_image_path FROM ProductTable WHERE locked = false ORDER BY RAND() LIMIT ?";

        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, limit);
            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()) {
                Product product = new Product();
                product.setId(resultSet.getInt("id"));
                product.setProductName(resultSet.getString("productName"));
                product.setPrice(resultSet.getDouble("price"));
                product.setCategory(resultSet.getInt("category"));
                product.setProduct_status(resultSet.getByte("product_status"));
                product.setUser_id(resultSet.getInt("user_id"));
                product.setContact_info_for_product(resultSet.getString("contact_info_for_product"));
                product.setProduct_image_path(resultSet.getString("product_image_path"));

                randomProducts.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle the exception (e.g., log the error or throw a custom exception)
        }

        return randomProducts;
    }

    public List<Product> getRandomProductsByRole(int roleId) {
        List<Product> products = new ArrayList<>();
        Connection con = DBHelper.getInstance().getConnection();

        String query = "SELECT p.* FROM ProductTable p " +
                "JOIN user u ON p.user_id = u.id " +
                "WHERE u.role_id = ? " +
                "AND p.locked != 1 " +
                "ORDER BY RAND()"; // Remove the LIMIT clause to retrieve all results

        try {
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, roleId);
            System.out.println("Executing query: " + ps.toString()); // Print the query being executed
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Product product = new Product();
                product.setId(rs.getInt("id"));
                product.setProductName(rs.getString("productName"));
                product.setPrice(rs.getDouble("price"));
                product.setCategory(rs.getInt("category"));
                product.setProduct_status(rs.getByte("product_status"));
                product.setUser_id(rs.getInt("user_id"));
                product.setContact_info_for_product(rs.getString("contact_info_for_product"));
                product.setProduct_image_path(rs.getString("product_image_path"));

                products.add(product);
            }

            System.out.println("Retrieved " + products.size() + " random products."); // Print the number of retrieved products
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return products;
    }





}

