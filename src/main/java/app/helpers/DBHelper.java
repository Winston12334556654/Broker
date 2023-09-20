package app.helpers;

import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBHelper {

    private final String  DRIVER = "com.mysql.cj.jdbc.Driver";
    private final String  URL = "jdbc:mysql://localhost:3308/Broker";
    private final String  USERNAME = "root";
    private final String  PASSWORD = "";

    private  Connection connection ;
    private static DBHelper instance = null ;

    private DBHelper() {
        try {
            Class.forName(DRIVER);
            connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Failed to establish a database connection.");
        }
    }

    public  Connection getConnection(){
        return connection;
    }

    public static DBHelper getInstance() {
        if (instance == null){
            instance = new DBHelper();
        }
        return instance;
    }
    public void closeConnection(Connection connection) {
        try {
            if (connection != null) {
                connection.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle the exception (e.g., log the error or throw a custom exception)
        }
    }


}
