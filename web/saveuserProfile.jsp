<%@page import="java.sql.*"%>
<%@page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String url = "jdbc:mysql://localhost:3306/genmedz_db"; 
    String user = "root"; 
    String password = "Dinosaur4."; 
    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        conn = DriverManager.getConnection(url, user, password);
        
        // Retrieve form data
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String phoneNumber = request.getParameter("phoneNumber");
        String email = request.getParameter("email");
        String address = request.getParameter("address");
        
        // Assuming you have a way to get the logged-in user's ID
        int userId = (Integer) session.getAttribute("userId");

        // Insert user details into the user_profile table
        String sql = "INSERT INTO user_profile (first_name, last_name, phone_number, email, address, user_account_id) VALUES (?, ?, ?, ?, ?, ?)";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, firstName);
        pstmt.setString(2, lastName);
        pstmt.setString(3, phoneNumber);
        pstmt.setString(4, email);
        pstmt.setString(5, address);
        pstmt.setInt(6, userId);
        pstmt.executeUpdate();
        
        // Redirect to the profile page after saving
        response.sendRedirect("userProfile.jsp");
    } catch (SQLException e) {
        out.println("<p>Error: " + e.getMessage() + "</p>");
        e.printStackTrace();
    } finally {
        try {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
