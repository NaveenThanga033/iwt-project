import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/registerServlet")
public class registerServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            // Database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/genmedz_db", "root", "Dinosaur4.");

            // Insert new user
            PreparedStatement ps = con.prepareStatement("INSERT INTO users (username, email, password) VALUES (?, ?, ?)");
            ps.setString(1, username);
            ps.setString(2, email);
            ps.setString(3, password);

            int result = ps.executeUpdate();

            if (result > 0) {
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Registration successful! Please login.');");
                out.println("location='login.jsp';");
                out.println("</script>");
            }

            con.close();
        } catch (Exception e) {
            out.println(e);
        }
    }
}
