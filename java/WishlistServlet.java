import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/WishlistServlet")
public class WishlistServlet extends HttpServlet {
    // Assuming you have a method to get a database connection
    private Connection getConnection() throws SQLException {
        // Replace with your own database connection logic
        return Database.getConnection();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        int medicineId = Integer.parseInt(request.getParameter("medicineId"));

        try (Connection conn = getConnection()) {
            if ("add".equals(action)) {
                addToWishlist(conn, medicineId);
            } else if ("remove".equals(action)) {
                removeFromWishlist(conn, medicineId);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"status\": \"error\", \"message\": \"" + e.getMessage() + "\"}");
            return;
        }

        response.setContentType("application/json");
        response.getWriter().write("{\"status\": \"success\"}");
    }

    private void addToWishlist(Connection conn, int medicineId) throws SQLException {
        String query = "INSERT INTO wishlist (medicine_id) VALUES (?)"; // Assuming a simple structure; modify as needed
        try (PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, medicineId);
            pstmt.executeUpdate();
        }
    }

    private void removeFromWishlist(Connection conn, int medicineId) throws SQLException {
        String query = "DELETE FROM wishlist WHERE medicine_id = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, medicineId);
            pstmt.executeUpdate();
        }
    }
}
