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

@WebServlet("/AddMedicineServlet")
@MultipartConfig
public class AddMedicineServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String medicineName = request.getParameter("name");
        String price = request.getParameter("price");
        String category = request.getParameter("category");
        String dosage = request.getParameter("dosage");
        Part filePart = request.getPart("photo"); // Retrieves the uploaded file
        InputStream inputStream = filePart.getInputStream();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/genmedz_db", "root", "Dinosaur4.");

            String sql = "INSERT INTO medicines (name, price, category, dosage, photo) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, medicineName);
            statement.setString(2, price);
            statement.setString(3, category);
            statement.setString(4, dosage);
            statement.setBlob(5, inputStream);  // setBlob should be at the last for the 'photo'
            statement.executeUpdate();

            connection.close();
            response.sendRedirect("admin.jsp");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
