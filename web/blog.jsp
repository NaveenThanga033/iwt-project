<%@page import="java.sql.SQLException"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.io.ByteArrayOutputStream"%>
<%@ page import="java.io.InputStream"%>
<%@ page import="java.util.Base64"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/blogstyle.css">
    <script src="https://kit.fontawesome.com/d9f0abd257.js" crossorigin="anonymous"></script>
    <title>Genmedzz</title>
</head>
<body>
<section class="navi">
    <nav class="navbar">
        <a href="../html/genmedz.html"><div class="cmpname">GenMedzz</div></a>
        <div class="services">
            <ul class="list">
                <li><a href="home1.html">Home</a></li>
                <li><a href="shop.html">Shop</a></li>
                <li><a href="wishlist.html">Wishlist</a></li>
                <li><a href="blog.jsp">Blog</a></li>
                <li><a href="contact.html">Contact</a></li>
            </ul>
            <div class="main-icons">
                <i class="fa-solid fa-magnifying-glass" style="color: #74C0FC;"></i>
                <i class="fa-regular fa-user" style="color: #74C0FC;"></i>
                <i class="fa-solid fa-cart-shopping" style="color: #74C0FC;"></i>
            </div>
        </div>
    </nav>
</section>
<div class="title-sec" id="home">
    <p>Blog</p>
</div>
<section class="blog-sec">
    <%
        String url = "jdbc:mysql://localhost:3306/genmedz_db"; // Replace with your DB URL
        String user = "root"; // Replace with your DB username
        String password = "Dinosaur4."; // Replace with your DB password
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(url, user, password);
            stmt = conn.createStatement();
            String sql = "SELECT * FROM blogs"; // Fetch all blog entries
            rs = stmt.executeQuery(sql);

            if (!rs.isBeforeFirst()) { // Check if ResultSet is empty
                out.println("<p>No blog entries found.</p>");
            } else {
                while (rs.next()) {
                    String title = rs.getString("title");
                    String content = rs.getString("content");
                    InputStream is = rs.getBinaryStream("photo"); // Get the BLOB as an InputStream
                    
                    // Convert InputStream to Base64
                    ByteArrayOutputStream os = new ByteArrayOutputStream();
                    byte[] buffer = new byte[1024];
                    int bytesRead;

                    while ((bytesRead = is.read(buffer)) != -1) {
                        os.write(buffer, 0, bytesRead);
                    }

                    String base64Image = Base64.getEncoder().encodeToString(os.toByteArray());
                    String imageSrc = "data:image/jpeg;base64," + base64Image; // Adjust MIME type if necessary

    %>
                    <section class="cont-sec">
                        <div class="cont1-img" style="background-image: url('<%= imageSrc %>');"></div>
                        <div class="cont1-cont">
                            <h2><%= title %></h2>
                            <p><%= content %></p>
                        </div>
                    </section>
    <%
                }
            }
        } catch (Exception e) {
            out.println("<p>Error fetching blog entries: " + e.getMessage() + "</p>");
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    %>
</section>

<section class="footer">
    <div class="footer-section">
        <div class="f-sec">
            <h3 class="footer-title">GenMedzz</h3>
            <div class="our-mission">
                <p>Our mission is to offer you the best and high-quality healthcare products to all.</p>
            </div>
            <div class="social-media">
                <i class="fa-brands fa-square-whatsapp"></i>
                <i class="fa-brands fa-linkedin"></i>
                <i class="fa-brands fa-square-instagram"></i>
                <i class="fa-brands fa-facebook-messenger"></i>
            </div>
        </div>
        <div class="f-sec">
            <h3 class="footer-title">Navigate</h3>
            <hr>
            <ul class="navigation-list">
                <li>Home</li>
                <li>Catalog</li>
                <li>About</li>
                <li>Contact</li>
                <li>Journal</li>
            </ul>
        </div>
        <div class="f-sec">
            <h3 class="footer-title">Informations</h3>
            <hr>
            <ul class="navigation-list">
                <li>Delivery</li>
                <li>Return Policy</li>
                <li>Team</li>
                <li>Store Locations</li>
                <li>F.A.Qs</li>
            </ul>
        </div>
        <div class="f-sec">
            <h3 class="footer-title">Company</h3>
            <hr>
            <ul class="navigation-list">
                <li>Delivery</li>
                <li>Return Policy</li>
                <li>Team</li>
                <li>Store Locations</li>
                <li>F.A.Qs</li>
            </ul>
        </div>
    </div>
    <a href="#home"><div class="arrow">
        <p>↑</p>
    </div></a>
</section>
</body>
</html>

