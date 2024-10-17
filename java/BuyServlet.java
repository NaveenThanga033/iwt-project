import com.stripe.Stripe;
import com.stripe.model.PaymentIntent;
import com.stripe.param.PaymentIntentCreateParams;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/BuyServlet")
public class BuyServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            double totalAmount = Double.parseDouble(request.getParameter("total")); // Get total from request

            // Initialize Stripe with your secret key
            Stripe.apiKey = "sk_test_YOUR_SECRET_KEY"; // Replace with your actual secret key

            // Create payment intent
            PaymentIntentCreateParams params = PaymentIntentCreateParams.builder()
                    .setAmount((long) (totalAmount * 100)) // Convert to cents
                    .setCurrency("usd")
                    .build();
            PaymentIntent intent = PaymentIntent.create(params);

            // Redirect to the Stripe checkout
            response.sendRedirect("stripe_checkout.jsp?clientSecret=" + intent.getClientSecret());
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Payment processing failed.");
        }
    }
}


