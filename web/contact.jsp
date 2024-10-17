<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GenMedzz</title>
    <link rel="stylesheet" href="css/contactstyle.css">
    <script src="https://kit.fontawesome.com/d9f0abd257.js" crossorigin="anonymous"></script>
</head>
<body>
    <section class="navi" id="#home">
        <nav class="navbar">
            <a href="../html/genmedz.html"><div class="cmpname">GenMedzz</div></a>
            <div class="services">
                <ul class="list">
                    <li><a href="home1.html">Home</a></li>
                    <li><a href="shop.html">Shop</a></li>
                    <li><a href="wishlist.html">Wishlist</a></li>
                    <li><a href="blog.html">Blog</a></li>
                    <li><a href="#">Contact</a></li>
                </ul>
                <div class="main-icons">
                    <i class="fa-solid fa-magnifying-glass" style="color: #74C0FC;"></i>
                    <i class="fa-regular fa-user" style="color: #74C0FC;"></i>
                    <i class="fa-solid fa-cart-shopping" style="color: #74C0FC;"></i>
                </div>
            </div>
        </nav>
    </section>
    <div class="contact-page">
        <div class="contact-header">
            <h1>Contact Us</h1>
            <p>We're here to help and answer any question you might have. We look forward to hearing from you.</p>
        </div>
        <div class="contact-container">
            <div class="contact-info">
                <h2>Contact Information</h2>
                <p><strong>Address:</strong> 1234 Street Name, City, Country</p>
                <p><strong>Phone:</strong> +123 456 7890</p>
                <p><strong>Email:</strong> genmedzz@example.com</p>
                <button class="feedback"><strong>Feedback</strong></button>
                <div class="social-media">
                    <a href="#"><i class="fab fa-facebook-f"></i></a>
                    <a href="#"><i class="fab fa-twitter"></i></a>
                    <a href="#"><i class="fab fa-linkedin-in"></i></a>
                    <a href="#"><i class="fab fa-instagram"></i></a>
                </div>
            </div>
            <div class="contact-form">
                <h2>Send Us a Message</h2>
                <form action="sendMessage" method="post"> <!-- Change the action to your servlet URL -->
                    <label for="name">Name</label>
                    <input type="text" id="name" name="name" required>
                    <label for="email">Email</label>
                    <input type="email" id="email" name="email" required>
                    <label for="message">Message</label>
                    <textarea id="message" name="message" rows="5" required></textarea>
                    <button type="submit">Send Message</button>
                </form>
            </div>
        </div>
    </div>
</body>
</html>
