import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/CartServlet")
public class CartServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String medicineId = request.getParameter("medicineId");
        String medicineName = request.getParameter("medicineName");
        String price = request.getParameter("price");
        int quantity = Integer.parseInt(request.getParameter("quantity")); // Get selected quantity

        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("id"); // Use Integer to handle null

        if (userId == null) {
            // Handle the case when the user is not logged in
            response.sendRedirect("login.jsp"); // Redirect to login or show an error message
            return;
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/genmedz_db", "root", "Dinosaur4.");
            
            // Insert into cart table
            String sql = "INSERT INTO cart (user_id, medicine_id, medicine_name, price, quantity, total) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, userId);
            statement.setString(2, medicineId);
            statement.setString(3, medicineName);
            statement.setDouble(4, Double.parseDouble(price));
            statement.setInt(5, quantity);
            statement.setDouble(6, Double.parseDouble(price) * quantity);
            statement.executeUpdate();

            connection.close();
            response.sendRedirect("addtocartpage.jsp");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
