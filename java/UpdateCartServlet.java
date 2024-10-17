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

@WebServlet("/UpdateCartServlet")
public class UpdateCartServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String medicineId = request.getParameter("medicineId");
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        HttpSession session = request.getSession();
        int userId = (int) session.getAttribute("id");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/genmedz_db", "root", "Dinosaur4.");

            // Update quantity and total price for the medicine in the cart
            String sql = "UPDATE cart SET quantity = ?, total = price * ? WHERE user_id = ? AND medicine_id = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, quantity);
            statement.setInt(2, quantity);
            statement.setInt(3, userId);
            statement.setString(4, medicineId);
            statement.executeUpdate();

            connection.close();
            response.sendRedirect("addtocartpage.jsp");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
