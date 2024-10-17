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
@WebServlet("/RemoveCartServlet")
public class RemoveCartServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String medicineId = request.getParameter("medicineId");
        HttpSession session = request.getSession();
        int userId = (int) session.getAttribute("id");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/genmedz_db", "root", "Dinosaur4.");

            String sql = "DELETE FROM cart WHERE user_id = ? AND medicine_id = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, userId);
            statement.setString(2, medicineId);
            statement.executeUpdate();

            connection.close();
            response.sendRedirect("addtocartpage.jsp");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
