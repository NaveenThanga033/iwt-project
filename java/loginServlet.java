import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/loginServlet")
public class loginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Admin credentials
    private static final String ADMIN_USERNAME = "admin";
    private static final String ADMIN_PASSWORD = "admin123";

    // Database connection parameters
    private static final String DB_URL = "jdbc:mysql://localhost:3306/genmedz_db"; // Update with your database URL
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "Dinosaur4."; // Update with your database password

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Check for admin login
        if (ADMIN_USERNAME.equals(username) && ADMIN_PASSWORD.equals(password)) {
            HttpSession session = request.getSession();
            session.setAttribute("admin", ADMIN_USERNAME);
            response.sendRedirect("admin.jsp"); // Redirect to admin page
            return;
        } 

        // Check for user login via database
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            // SQL query to check user credentials
            String sql = "SELECT id FROM users WHERE username = ? AND password = ?"; // Fetch only user ID
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, username);
            statement.setString(2, password);

            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                // Valid user login
                int userId = resultSet.getInt("id"); // Get user ID
                HttpSession session = request.getSession();
                session.setAttribute("id", userId); // Set user ID in session
                response.sendRedirect("home.jsp"); // Redirect to user home page
            } else {
                // Invalid credentials
                request.setAttribute("errorMessage", "Invalid username or password");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }

            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database connection error");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
