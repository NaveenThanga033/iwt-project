import java.io.IOException;
import java.io.InputStream;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

@WebServlet("/AddBlogServlet")
@MultipartConfig
public class AddBlogServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String title = request.getParameter("title");  // Retrieve the title
        String blogContent = request.getParameter("content"); // Retrieve the content
        Part filePart = request.getPart("photo"); // Retrieves the uploaded file
        InputStream inputStream = filePart.getInputStream(); // Get input stream for the photo

        Connection connection = null;
        PreparedStatement statement = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/genmedz_db", "root", "Dinosaur4.");

            String sql = "INSERT INTO blogs (title, content, photo) VALUES (?, ?, ?)";
            statement = connection.prepareStatement(sql);
            statement.setString(1, title); // Set title
            statement.setString(2, blogContent); // Set content
            statement.setBlob(3, inputStream); // Set photo

            int row = statement.executeUpdate(); // Execute the update
            if (row > 0) {
                // Blog added successfully
                response.sendRedirect("admin.jsp");
            } else {
                // Error in adding blog
                response.getWriter().println("Failed to add blog");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        } finally {
            // Close resources
            try {
                if (statement != null) statement.close();
                if (connection != null) connection.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
