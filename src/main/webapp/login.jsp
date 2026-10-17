<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Foodie - Sign In</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/login.css">
</head>

<body>

    <div class="page">

        <!-- LEFT SIDE: FOOD ANIMATION -->

        <section class="left">

            <div class="glow"></div>

            <!-- Floating food items -->

            <div class="food food1">🍅</div>
            <div class="food food2">🌶️</div>
            <div class="food food3">🥬</div>
            <div class="food food4">🧅</div>
            <div class="food food5">🫑</div>

            <!-- Floating particles -->

            <div class="particle particle1"></div>
            <div class="particle particle2"></div>
            <div class="particle particle3"></div>
            <div class="particle particle4"></div>
            <div class="particle particle5"></div>

            <!-- Main food image -->

            <img
                src="${pageContext.request.contextPath}/images/signin/burgerNobgr.png"
                class="chef"
                alt="Delicious food">

            <div class="food-text">
                <h1>
                    Good Food
                    <br>
                    <span>Good Mood</span>
                </h1>

                <p>Fresh food. Great taste. Made with love.</p>
            </div>

        </section>

        <!-- RIGHT SIDE: LOGIN FORM -->

        <section class="right">

            <div class="login-card">

                <div class="logo">
                    Food<span>ie</span>
                </div>

                <h2 class="title">
                    Welcome <span>Back!</span>
                </h2>

                <p class="subtitle">
                    Sign in to continue your delicious journey
                </p>

                <!-- ERROR MESSAGE -->

                <% if (request.getAttribute("error") != null) { %>
                    <div class="error">
                        <%= request.getAttribute("error") %>
                    </div>
                <% } %>

                <!-- LOGIN FORM -->

                <form
                    action="${pageContext.request.contextPath}/login"
                    method="post">

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
                        <label for="password">Password</label>

                        <input
                            type="password"
                            id="password"
                            name="password"
                            placeholder="Enter your password"
                            autocomplete="current-password"
                            required>
                    </div>

                    <div class="forgot">
                        <a href="${pageContext.request.contextPath}/forgot-password.jsp">
                            Forgot Password?
                        </a>
                    </div>

                    <button type="submit" class="login-btn">
                        Sign In
                    </button>

                </form>

                <div class="divider">
                    OR
                </div>

                <!-- SOCIAL BUTTONS: VISUAL ONLY -->

                <div class="social">
                    <button type="button" disabled>Google</button>
                    <button type="button" disabled>Facebook</button>
                </div>

                <div class="signup-text">
                    Don't have an account?

                    <a href="${pageContext.request.contextPath}/signup.jsp">
                        Sign Up
                    </a>
                </div>

            </div>

        </section>

    </div>

</body>
</html>