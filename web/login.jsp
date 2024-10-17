<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/genlogin.css">
    <script src="https://kit.fontawesome.com/d9f0abd257.js"></script>
    <title>Login - GenMedzz</title>
</head>
<body>
    <div class="container">
        <div class="forms-container">
            <div class="signin-signup">
                <!-- Sign In Form -->
                <form action="loginServlet" method="post" class="sign-in-form">
                    <h2 class="title">Sign in</h2>

                    <div class="input-field">
                        <i class="fas fa-user"></i>
                        <input type="text" placeholder="Username" name="username" required>
                    </div>

                    <div class="input-field">
                        <i class="fas fa-lock"></i>
                        <input type="password" placeholder="Password" name="password" required>
                    </div>

                    <input type="submit" value="Login" class="btn solid">

                    <p class="social-text">Or Sign in with social platforms</p>
                    <div class="social-media">
                        <a href="#" class="social-icon">
                            <i class="fab fa-facebook-f"></i>
                        </a>
                        <a href="#" class="social-icon">
                            <i class="fab fa-twitter"></i>
                        </a>
                        <a href="#" class="social-icon">
                            <i class="fab fa-google"></i>
                        </a>
                        <a href="#" class="social-icon">
                            <i class="fab fa-linkedin-in"></i>
                        </a>
                    </div>
                </form>

                <!-- Sign Up Form -->
                <form action="registerServlet" method="post" class="sign-up-form">
                    <h2 class="title">Sign up</h2>

                    <div class="input-field">
                        <i class="fas fa-user"></i>
                        <input type="text" placeholder="Username" name="username" required>
                    </div>

                    <div class="input-field">
                        <i class="fas fa-envelope"></i>
                        <input type="email" placeholder="Email" name="email" required>
                    </div>

                    <div class="input-field">
                        <i class="fas fa-lock"></i>
                        <input type="password" placeholder="Password" name="password" required>
                    </div>

                    <input type="submit" class="btn" value="Sign up">

                    <p class="social-text">Or Sign up with social platforms</p>
                    <div class="social-media">
                        <a href="#" class="social-icon">
                            <i class="fab fa-facebook-f"></i>
                        </a>
                        <a href="#" class="social-icon">
                            <i class="fab fa-twitter"></i>
                        </a>
                        <a href="#" class="social-icon">
                            <i class="fab fa-google"></i>
                        </a>
                        <a href="#" class="social-icon">
                            <i class="fab fa-linkedin-in"></i>
                        </a>
                    </div>
                </form>
            </div>
        </div>

        <div class="panels-container">
            <div class="panel left-panel">
                <div class="content">
                    <h3>New here?</h3>
                    <p>Sign up and get the best deals on healthcare products.</p>
                    <button class="btn transparent" id="sign-up-btn">Sign up</button>
                </div>
                <img src="images/log.svg" class="image" alt="Login Image">
            </div>

            <div class="panel right-panel">
                <div class="content">
                    <h3>One of us?</h3>
                    <p>If you already have an account, sign in and continue shopping.</p>
                    <button class="btn transparent" id="sign-in-btn">Sign in</button>
                </div>
                <img src="images/register.svg" class="image" alt="Sign Up Image">
            </div>
        </div>
    </div>

    <script src="js/genlogin.js"></script>
</body>
</html>
