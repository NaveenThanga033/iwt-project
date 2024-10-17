<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<%
    int userId = (int) session.getAttribute("id"); // Assuming user is logged in

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
    double total = 0;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/genmedz_db", "root", "Dinosaur4.");

        String sql = "SELECT * FROM cart WHERE user_id = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setInt(1, userId);
        rs = stmt.executeQuery();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Your Cart</title>
    <link rel="stylesheet" href="css/shop.css">
    <style>
        body {
            background-color: white;
            font-family: 'Poppins', sans-serif;
        }
        header {
            background-color: #C6E6EA;
            padding: 20px;
            text-align: center;
            color: black;
            font-size: 24px;
            border-bottom: 1px solid rgba(0, 0, 0, 0.1);
        }
        h1 {
            margin: 20px 0;
            color: #333;
        }
        table {
            width: 90%;
            margin: 20px auto;
            border-collapse: collapse;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        th, td {
            padding: 10px;
            text-align: center;
            border: 1px solid #ddd;
        }
        th {
            background-color: #C6E6EA;
            color: #333;
        }
        tr:hover {
            background-color: #f2f2f2;
        }
        .total {
            font-size: 20px;
            font-weight: bold;
            text-align: right;
            margin-right: 10%;
        }
        .buy-button {
            display: block;
            margin: 20px auto;
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.2s ease-in-out;
        }
        .buy-button:hover {
            background-color: #45a049;
        }
        footer {
            background-color: #C6E6EA;
            padding: 10px;
            text-align: center;
            color: black;
            margin-top: 20px;
        }
        .navi {
            margin-top: 0px;
            width: 100%;
            height: auto;
            position: sticky;
        }
        .free {
            background-color: #C6E6EA;
            height: auto;
            padding: 5px;
            text-align: center;
            color: black;
            font-size: 17px;
        }
        .navbar {
            background-color: white;
            width: 100%;
            height: auto;
            display: flex;
            align-items: center;
            justify-content: space-around;
            padding: 10px;
        }
        .cmpname {
            font-size: 20px;
        }
        .services {
            display: flex;
            align-items: center;
            justify-content: space-around;
        }
        .list {
            display: flex;
            align-items: center;
            justify-content: space-around;
            list-style-type: none;
        }
        .list li {
            margin: 8px;
        }
        .main-icons {
            margin-left: 5px;
        }
        .main-icons i {
            margin: 3px;
            cursor: pointer;
        }
    </style>
</head>
<body>
<section class="navi">
    <div class="free">
        <p>FREE SHIPPING ON ALL ORDERS OVER ?599. LEARN MORE ?</p>
    </div>
    <nav class="navbar">
        <a href="#"><div class="cmpname">GenMedzz</div></a>
        <div class="services">
            <ul class="list">
                <li><a href="../html/genmedz.html">Home</a></li>
                <li><a href="#">Shop</a></li>
                <li><a href="wishlist.jsp">Wishlist</a></li>
                <li><a href="../html/blog.html">Blog</a></li>
                <li><a href="../html/contact.html">Contact</a></li>
            </ul>
            <div class="main-icons">
                <i class="fa-solid fa-magnifying-glass" style="color: #74C0FC;"></i>
                <i class="fa-regular fa-user" style="color: #74C0FC;"></i>
                <a href="cart.html">
                    <i class="fa-solid fa-cart-shopping" style="color: #74C0FC; position: relative;">
                        <span id="cart-count" style="
                            position: absolute;
                            top: -10px;
                            right: -10px;
                            background-color: red;
                            color: white;
                            border-radius: 50%;
                            padding: 2px 6px;
                            font-size: 12px;
                            display: none;
                        ">0</span>
                    </i>
                </a>
            </div>
        </div>
    </nav>
</section>

<header>
    <h1>Your Cart</h1>
</header>

<% if (rs != null && rs.next()) { %>
    <table>
        <thead>
            <tr>
                <th>Medicine</th>
                <th>Quantity</th>
                <th>Price</th>
                <th>Total</th>
                <th>Remove</th>
            </tr>
        </thead>
        <tbody>
            <% do {
                total += rs.getDouble("price") * rs.getInt("quantity");
            %>
            <tr>
                <td><%= rs.getString("medicine_name") %></td>
                <td>
                    <form action="UpdateCartServlet" method="post">
                        <input type="hidden" name="medicineId" value="<%= rs.getString("medicine_id") %>">
                        <select name="quantity">
                            <% for (int i = 1; i <= 5; i++) { %>
                                <option value="<%= i %>" <%= rs.getInt("quantity") == i ? "selected" : "" %>><%= i %></option>
                            <% } %>
                        </select>
                        <button type="submit">Update</button>
                    </form>
                </td>
                <td>$<%= rs.getDouble("price") %></td>
                <td>$<%= rs.getDouble("price") * rs.getInt("quantity") %></td>
                <td>
                    <form action="RemoveCartServlet" method="post">
                        <input type="hidden" name="medicineId" value="<%= rs.getString("medicine_id") %>">
                        <button type="submit">X</button>
                    </form>
                </td>
            </tr>
            <% } while (rs.next()); %>
        </tbody>
    </table>
    <div class="total">Total: $<%= total %></div>
    <form action="BuyServlet" method="post">
        <button type="submit" class="buy-button">Buy</button>
    </form>
<% } else { %>
    <p>Your cart is empty.</p>
<% } %>

<footer>
    <p>&copy; 2024 GenMedz. All rights reserved.</p>
</footer>

<%
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) rs.close();
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    }
%>
</body>
</html>
