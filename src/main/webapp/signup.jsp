<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Foodie - Sign Up</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/signup.css">
</head>

<body>

    <div class="signup-page">

        <!-- LEFT SIDE: ANIMATED BURGER -->

        <section class="burger-section">

            <div class="glow"></div>

            <img
                src="${pageContext.request.contextPath}/images/signin/signin.png.png"
                class="burger"
                alt="Delicious Burger">

            <div class="food-text">
                <h1>
                    Good Food
                    <br>
                    <span>Good Mood</span>
                </h1>

                <p>Delicious food is waiting for you!</p>
            </div>

        </section>

        <!-- RIGHT SIDE: SIGNUP FORM -->

        <section class="form-section">

            <div class="signup-card">

                <div class="logo">
                    Food<span>ie</span>
                </div>

                <h2 class="title">
                    Create Your <span>Account</span>
                </h2>

                <p class="subtitle">
                    Join Foodie and start your delicious journey!
                </p>

                <!-- ERROR MESSAGE -->

                <% if (request.getAttribute("error") != null) { %>

                    <div class="error">
                        <%= request.getAttribute("error") %>
                    </div>

                <% } %>

                <!-- SIGNUP FORM -->

                <form
                    action="${pageContext.request.contextPath}/signup"
                    method="post">

                    <div class="input-group">
                        <label for="name">Full Name</label>
                        <input
                            type="text"
                            id="name"
                            name="name"
                            placeholder="Enter your full name"
                            autocomplete="name"
                            required>
                    </div>

                    <div class="input-group">
                        <label for="email">Email Address</label>
                        <input
                            type="email"
                            id="email"
                            name="email"
                            placeholder="Enter your email"
                            autocomplete="email"
                            required>
                    </div>

                    <div class="input-group">
                        <label for="phone">Phone Number</label>
                        <input
                            type="tel"
                            id="phone"
                            name="phone"
                            placeholder="Enter your phone number"
                            autocomplete="tel"
                            required>
                    </div>

                    <div class="input-group">
                        <label for="address">Address</label>
                        <textarea
                            id="address"
                            name="address"
                            placeholder="Enter your address"
                            autocomplete="street-address"
                            required></textarea>
                    </div>

                    <div class="input-group">
                        <label for="password">Password</label>
                        <input
                            type="password"
                            id="password"
                            name="password"
                            placeholder="Create a password"
                            autocomplete="new-password"
                            required>
                    </div>

                    <div class="input-group">
                        <label for="confirmPassword">Confirm Password</label>
                        <input
                            type="password"
                            id="confirmPassword"
                            name="confirmPassword"
                            placeholder="Confirm your password"
                            autocomplete="new-password"
                            required>
                    </div>

                    <button type="submit" class="signup-btn">
                        Create Account
                    </button>

                </form>

                <div class="login">
                    Already have an account?
                    <a href="${pageContext.request.contextPath}/login.jsp">
                        Sign In
                    </a>
                </div>

            </div>

        </section>

    </div>

</body>
</html>