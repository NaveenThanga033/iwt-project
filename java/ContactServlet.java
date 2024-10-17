import javax.mail.*;
import javax.mail.internet.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Properties;

@WebServlet("/sendMessage")
public class ContactServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String senderEmail = request.getParameter("email"); // Get sender's email from the form
        String message = request.getParameter("message");

        String to = "thanganaveen3@gmail.com"; 
        String from = senderEmail; 
        String host = "smtp.example.com"; 
        Properties properties = System.getProperties();
        properties.setProperty("mail.smtp.host", host);
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.port", "587");
        properties.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(properties, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication("thanganaveen3@example.com", "ethanwinters3."); 
            }
        });
        try {
            MimeMessage mimeMessage = new MimeMessage(session);
            mimeMessage.setFrom(new InternetAddress(from)); // Set the sender's email
            mimeMessage.addRecipient(Message.RecipientType.TO, new InternetAddress(to)); 
            mimeMessage.setSubject("Contact Form Message from " + name);
            mimeMessage.setText("You have received a new message:\n\n" +
                    "Name: " + name + "\n" +
                    "Email: " + senderEmail + "\n" + 
                    "Message:\n" + message);

            Transport.send(mimeMessage);
            response.sendRedirect("success.html");
        } catch (MessagingException e) {
            e.printStackTrace();
            response.sendRedirect("error.html");
        }
    }
}
