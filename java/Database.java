import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Database {
    // Database credentials
    private static final String URL = "jdbc:mysql://localhost:3306/genmedz_db"; // Change to your database URL
    private static final String USER = "root"; // Change to your database username
    private static final String PASSWORD = "Dinosaur4."; // Change to your database password

    // Method to establish a connection to the database
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}
