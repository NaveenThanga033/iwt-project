<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GenMedzz</title>
    <script src="https://kit.fontawesome.com/d9f0abd257.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="css/shop.css">
    <style>
        /* Search Bar Styles */
        .search-container {
            text-align: center;
            margin: 20px 0;
        }

        .search-container input[type="text"] {
            width: 300px;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .search-container button {
            padding: 10px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin-left: 10px;
        }

        .search-container button:hover {
            background-color: #0056b3;
        }

        /* Filter Styles */
        .filter-container {
            text-align: center;
            margin: 20px 0;
        }

        .filter-container select {
            padding: 10px;
            margin: 0 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .product-card {
            display: flex;
            flex-direction: column;
            border: 1px solid #ccc;
            border-radius: 8px;
            margin: 15px;
            padding: 10px;
            text-align: center;
            transition: box-shadow 0.3s;
        }

        .product-card:hover {
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        .product-image img {
            width: 100%; /* Adjusted for better responsiveness */
            height: auto; /* Maintain aspect ratio */
            border-radius: 8px 8px 0 0;
        }

        .product-title {
            font-size: 1.5em;
            margin: 10px 0;
        }

        .product-price {
            font-size: 1.2em;
            color: #28a745; /* Green color for price */
            margin: 10px 0;
        }

        .add-to-cart {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 10px;
            border-radius: 5px;
            cursor: pointer;
        }

        .add-to-cart:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <section class="navi">
        <div class="free">
            <p>FREE SHIPPING ON ALL ORDERS OVER ?599.LEARN MORE ?</p>
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
    <header id="home">
        <h5>Products</h5>
    </header>

    <div class="search-container">
        <input type="text" id="searchBar" placeholder="Search for medicines...">
        <button onclick="searchMedicine()">Search</button>
    </div>

    <div class="filter-container">
        <select id="categoryFilter" onchange="filterMedicines()">
            <option value="">Select Category</option>
            <option value="Antibiotics">Antibiotics</option>
            <option value="Antidepressants">Antidepressants</option>
            <option value="Personal Care">Personal Care</option>
            <option value="First Aid">First Aid</option>
            <option value="Medical Devices">Medical Devices</option>
            <option value="Health Supplements">Health Supplements</option>
        </select>
        <select id="priceFilter" onchange="filterMedicines()">
            <option value="">Select Price Range</option>
            <option value="low">Low to High</option>
            <option value="high">High to Low</option>
        </select>
        <select id="dosageFilter" onchange="filterMedicines()">
            <option value="">Select Dosage</option>
            <option value="10mg">10mg</option>
            <option value="20mg">20mg</option>
            <option value="50mg">50mg</option>
            <option value="100mg">100mg</option>
        </select>
    </div>

    <main>
<div class="product-grid">
    <%
        String url = "jdbc:mysql://localhost:3306/genmedz_db"; // Replace with your DB URL
        String user = "root"; // Replace with your DB username
        String password = "Dinosaur4."; // Replace with your DB password
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;

        // List of categories
        List<String> categories = Arrays.asList("Antibiotics", "Antidepressants", "Personal Care", "First Aid", "Medical Devices", "Health Supplements");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(url, user, password);
            stmt = conn.createStatement();
            String sql = "SELECT * FROM medicines"; // Fetch all medicines
            rs = stmt.executeQuery(sql);

            while (rs.next()) {
                String name = rs.getString("name");
                String price = rs.getString("price");
                String category = rs.getString("category");
                String dosage = rs.getString("dosage");
                int id = rs.getInt("id");
    %>
                <div class="product-card" data-category="<%= category %>" data-price="<%= price %>" data-dosage="<%= dosage %>">
                    <div class="product-image">
                        <img src="ImageServlet?id=<%= id %>" alt="<%= name %>">
                    </div>
                    <div class="product-info">
                        <h2 class="product-title"><%= name %></h2>
                        <p class="product-price">$<%= price %></p>

                        <!-- Add to Cart Form -->
                        <form action="CartServlet" method="post">
                            <input type="hidden" name="medicineId" value="<%= id %>">
                            <input type="hidden" name="medicineName" value="<%= name %>">
                            <input type="hidden" name="price" value="<%= price %>">
                            <label for="quantity">Quantity:</label>
                            <select name="quantity" id="quantity">
                                <option value="1">1</option>
                                <option value="2">2</option>
                                <option value="3">3</option>
                                <option value="4">4</option>
                                <option value="5">5</option>
                            </select>
                            <br>
                            <button type="submit" class="add-to-cart">Add to Cart</button>
                        </form>

                        <div class="wishlist-container">
                            <i class="fa-regular fa-heart heart" onclick="toggleWishlist(<%= id %>, this)"></i>
                            <p class="wishlist-text" onclick="toggleWishlist(<%= id %>, this.previousElementSibling)">Add to Wishlist</p>
                        </div>
                    </div>
                </div>
    <%
            }
        } catch (Exception e) {
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
</div>



    </main>

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
                    <li>Blog</li>
                    <li>Contact</li>
                </ul>
            </div>
            <div class="f-sec">
                <h3 class="footer-title">Our Products</h3>
                <hr>
                <ul class="products-list">
                    <% for (String category : categories) { %>
                        <li><%= category %></li>
                    <% } %>
                </ul>
            </div>
        </div>
    </section>

    <script>
        function searchMedicine() {
            var input, filter, cards, title, i, txtValue;
            input = document.getElementById("searchBar");
            filter = input.value.toLowerCase();
            cards = document.getElementsByClassName("product-card");

            for (i = 0; i < cards.length; i++) {
                title = cards[i].getElementsByClassName("product-title")[0];
                txtValue = title.textContent || title.innerText;
                cards[i].style.display = txtValue.toLowerCase().indexOf(filter) > -1 ? "" : "none";
            }
        }

        function filterMedicines() {
            var categoryFilter = document.getElementById("categoryFilter").value;
            var priceFilter = document.getElementById("priceFilter").value;
            var dosageFilter = document.getElementById("dosageFilter").value;
            var cards = document.getElementsByClassName("product-card");

            for (var i = 0; i < cards.length; i++) {
                var card = cards[i];
                var categoryMatch = !categoryFilter || card.getAttribute("data-category") === categoryFilter;
                var priceMatch = !priceFilter || (priceFilter === "low" && parseFloat(card.getAttribute("data-price")) < 50) || (priceFilter === "high" && parseFloat(card.getAttribute("data-price")) >= 50);
                var dosageMatch = !dosageFilter || card.getAttribute("data-dosage") === dosageFilter;

                if (categoryMatch && priceMatch && dosageMatch) {
                    card.style.display = "";
                } else {
                    card.style.display = "none";
                }
            }
        }
        
       function toggleWishlist(medicineId, element) {
            var action = element.classList.contains('added') ? 'remove' : 'add';
            var xhr = new XMLHttpRequest();
            xhr.open("POST", "WishlistServlet", true);
            xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
            xhr.onreadystatechange = function () {
                if (xhr.readyState === XMLHttpRequest.DONE && xhr.status === 200) {
                    if (action === 'add') {
                        element.classList.add('added');
                        element.classList.remove('fa-regular');
                        element.classList.add('fa-solid');
                    } else {
                        element.classList.remove('added');
                        element.classList.remove('fa-solid');
                        element.classList.add('fa-regular');
                    }
                }
            };
            xhr.send("action=" + action + "&medicineId=" + medicineId);
        }
    </script>
</body>
</html>
