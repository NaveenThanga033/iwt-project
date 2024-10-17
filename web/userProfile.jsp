<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Profile</title>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
    <h1>User Profile</h1>

    <%
        String url = "jdbc:mysql://localhost:3306/genmedz_db";
        String user = "root"; 
        String password = "Dinosaur4."; 
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        HttpSession session = request.getSession();
        if (session == null) {
            // Session does not exist, redirect to login page
            response.sendRedirect("login.jsp");
            return; // Stop further processing
        }

        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            // userId is not present in the session, redirect to login page
            response.sendRedirect("login.jsp");
            return; // Stop further processing
        }

        try {
            // Now userId is guaranteed to be not null
            conn = DriverManager.getConnection(url, user, password);
            String sql = "SELECT * FROM user_profile WHERE user_account_id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userId);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                // User details found
                String firstName = rs.getString("first_name");
                String lastName = rs.getString("last_name");
                String phoneNumber = rs.getString("phone_number");
                String emailAddress = rs.getString("email");
                String address = rs.getString("address");
    %>
                <div>
                    <h2>Your Details</h2>
                    <p><strong>First Name:</strong> <%= firstName %></p>
                    <p><strong>Last Name:</strong> <%= lastName %></p>
                    <p><strong>Phone Number:</strong> <%= phoneNumber %></p>
                    <p><strong>Email:</strong> <%= emailAddress %></p>
                    <p><strong>Address:</strong> <%= address %></p>
                </div>

    <%
            } else {
    %>
                <form action="saveUserProfile.jsp" method="post">
                    <h2>Enter Your Details</h2>
                    <label for="firstName">First Name:</label>
                    <input type="text" name="firstName" required><br>
                    <label for="lastName">Last Name:</label>
                    <input type="text" name="lastName" required><br>
                    <label for="phoneNumber">Phone Number:</label>
                    <input type="text" name="phoneNumber" required><br>
                    <label for="email">Email:</label>
                    <input type="email" name="email" required><br>
                    <label for="address">Address:</label>
                    <textarea name="address" required></textarea><br>
                    <input type="submit" value="Save">
                </form>
    <%
            }
        } catch (SQLException e) {
            out.println("<p>Error: " + e.getMessage() + "</p>");
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    %>
</body>
</html>

