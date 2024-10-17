import java.io.IOException;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ImageServlet")
public class ImageServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int medicineId = Integer.parseInt(request.getParameter("id"));
        
        response.setContentType("image/jpeg"); // Change this based on your image type

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/genmedz_db", "root", "Dinosaur4.");

            String sql = "SELECT photo FROM medicines WHERE id = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, medicineId);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                byte[] imgBytes = resultSet.getBytes("photo");
                OutputStream out = response.getOutputStream();
                out.write(imgBytes);
                out.flush();
                out.close();
            }

            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
