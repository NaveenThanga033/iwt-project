<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Wishlist</title>
    <script src="https://kit.fontawesome.com/d9f0abd257.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="css/shop.css">
    <style>
        /* Your existing CSS here */
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
                    <li><a href="shop.jsp">Shop</a></li>
                    <li><a href="#">Wishlist</a></li>
                    <li><a href="../html/blog.html">Blog</a></li>
                    <li><a href="../html/contact.html">Contact</a></li>
                </ul>
            </div>
        </nav>
    </section>
    <header id="home">
        <h5>Your Wishlist</h5>
    </header>

    <main>
        <div class="product-grid">
            <c:forEach var="item" items="${wishlistItems}">
                <div class="product-card">
                    <div class="product-image">
                        <img src="ImageServlet?id=${item.medicine.id}" alt="${item.medicine.name}">
                    </div>
                    <div class="product-info">
                        <h2 class="product-title">${item.medicine.name}</h2>
                        <p class="product-price">$${item.medicine.price}</p>
                        <button class="add-to-cart">Add to Cart</button>
                        <button class="remove-from-wishlist" onclick="removeFromWishlist(${item.medicine.id})">Remove</button>
                    </div>
                </div>
            </c:forEach>
        </div>
    </main>

    <section class="footer">
        <!-- Your footer section here -->
    </section>

    <script>
        function removeFromWishlist(medicineId) {
            // AJAX call to remove from wishlist in the backend
            fetch(`WishlistServlet?action=remove&medicineId=${medicineId}`, {
                method: 'POST'
            })
            .then(response => response.json())
            .then(data => {
                // Handle response if needed, e.g., refresh the page or remove the item from the DOM
            });
        }
    </script>
</body>
</html>
