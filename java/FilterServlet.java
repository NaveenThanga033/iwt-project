import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/FilterServlet")
public class FilterServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String category = request.getParameter("category");
        String dosage = request.getParameter("dosage");
        String price = request.getParameter("price");
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/genmedz_db", "root", "Dinosaur4.");

            StringBuilder sql = new StringBuilder("SELECT * FROM medicines WHERE 1=1");
            if (category != null && !category.isEmpty()) {
                sql.append(" AND category = ?");
            }
            if (dosage != null && !dosage.isEmpty()) {
                sql.append(" AND dosage = ?");
            }
            if (price != null && !price.isEmpty()) {
                sql.append(" AND price <= ?");
            }

            PreparedStatement statement = connection.prepareStatement(sql.toString());

            int index = 1;
            if (category != null && !category.isEmpty()) {
                statement.setString(index++, category);
            }
            if (dosage != null && !dosage.isEmpty()) {
                statement.setString(index++, dosage);
            }
            if (price != null && !price.isEmpty()) {
                statement.setString(index++, price);
            }

            ResultSet resultSet = statement.executeQuery();

            request.setAttribute("resultSet", resultSet);
            request.getRequestDispatcher("shop.jsp").include(request, response);
            
            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            out.close();
        }
    }
}
