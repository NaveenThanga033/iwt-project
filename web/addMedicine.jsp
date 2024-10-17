<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Medicine - GenMedzz</title>
    <link rel="stylesheet" href="css/shop.css"> <!-- Assuming your main stylesheet for consistency -->
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        h1 {
            text-align: center;
            color: #007bff;
            margin-top: 30px;
            font-size: 2em;
        }

        form {
            background-color: #ffffff;
            max-width: 600px;
            margin: 40px auto;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        label {
            font-size: 1.1em;
            color: #333;
            margin-bottom: 10px;
            display: block;
        }

        input[type="text"],
        input[type="file"] {
            width: 100%;
            padding: 12px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 1em;
        }

        input[type="submit"] {
            width: 100%;
            padding: 12px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 1.1em;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        input[type="submit"]:hover {
            background-color: #0056b3;
        }

        /* Header and Navigation */
        .navi {
            background-color: #007bff;
            padding: 15px;
        }

        .navi .cmpname {
            font-size: 2em;
            color: white;
            text-align: center;
            font-weight: bold;
        }

        .navi .services {
            text-align: center;
            margin-top: 10px;
        }

        .navi .list li {
            display: inline-block;
            margin: 0 15px;
        }

        .navi .list li a {
            color: white;
            text-decoration: none;
            font-size: 1.1em;
            padding: 10px;
        }

        .navi .list li a:hover {
            background-color: #0056b3;
            border-radius: 5px;
        }

        /* Adjusting for a better footer alignment */
        footer {
            text-align: center;
            padding: 20px;
            background-color: #f4f4f4;
            margin-top: 40px;
        }
    </style>
</head>
<body>
    <!-- Navigation Section -->
    <section class="navi">
        <div class="cmpname">GenMedzz</div>
        <div class="services">
            <ul class="list">
                <li><a href="../html/genmedz.html">Home</a></li>
                <li><a href="#">Shop</a></li>
                <li><a href="#">Wishlist</a></li>
                <li><a href="blog.jsp">Blog</a></li>
                <li><a href="contact.jsp">Contact</a></li>
            </ul>
        </div>
    </section>

    <!-- Form Section -->
    <h1>Add Medicine</h1>
    <form action="AddMedicineServlet" method="post" enctype="multipart/form-data">
        <label for="name">Medicine Name:</label>
        <input type="text" id="name" name="name" required>

        <label for="price">Price:</label>
        <input type="text" id="price" name="price" required>

        <label for="category">Category:</label>
        <input type="text" id="category" name="category" required>

        <label for="dosage">Dosage:</label>
        <input type="text" id="dosage" name="dosage" required>

        <label for="photo">Photo:</label>
        <input type="file" id="photo" name="photo" required>

        <input type="submit" value="Add Medicine">
    </form>

    <footer>
        <p>&copy; 2024 GenMedzz. All rights reserved.</p>
    </footer>
</body>
</html>
