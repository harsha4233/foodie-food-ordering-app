<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.foodie.model.User" %>

<%
    User user = (User) session.getAttribute("user");

    if (user == null) {
        response.sendRedirect("signin.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>My Profile - Foodie</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/profile.css">

</head>

<body>

    <!-- COMMON NAVBAR -->
    <%@ include file="navbar.jsp" %>


    <!-- PROFILE PAGE -->

    <main class="profile-page">

        <div class="profile-wrapper">

            <!-- TOP DECORATION -->
            <div class="profile-glow"></div>


            <!-- PROFILE HEADER -->

            <div class="profile-header">

                <div class="avatar">
                    <%= user.getName().substring(0, 1).toUpperCase() %>
                </div>

                <div class="profile-heading">

                    <span class="welcome-text">
                        WELCOME BACK
                    </span>

                    <h1>
                       <%= user.getName() %>
                    </h1>

                    <p>
                        Manage your Foodie account
                    </p>

                </div>

            </div>


            <!-- USER INFORMATION -->

            <div class="profile-info">

                <!-- NAME -->

                <div class="info-card">

                    <div class="info-icon">
                        👤
                    </div>

                    <div class="info-content">

                        <span class="info-label">
                            FULL NAME
                        </span>

                        <h3>
                            <%= user.getName() %>
                        </h3>

                    </div>

                </div>


                <!-- EMAIL -->

                <div class="info-card">

                    <div class="info-icon">
                        ✉
                    </div>

                    <div class="info-content">

                        <span class="info-label">
                            EMAIL ADDRESS
                        </span>

                        <h3>
                            <%= user.getEmail() %>
                        </h3>

                    </div>

                </div>


                <!-- PHONE -->

                <div class="info-card">

                    <div class="info-icon">
                        ☎
                    </div>

                    <div class="info-content">

                        <span class="info-label">
                            PHONE NUMBER
                        </span>

                        <h3>
                            <%= user.getPhoneNumber() %>
                        </h3>

                    </div>

                </div>


                <!-- ADDRESS -->

                <div class="info-card address-card">

                    <div class="info-icon">
                        📍
                    </div>

                    <div class="info-content">

                        <span class="info-label">
                            DELIVERY ADDRESS
                        </span>

                        <h3>
                            <%= user.getAddress() %>
                        </h3>

                    </div>

                </div>

            </div>


            <!-- ACCOUNT STATUS -->

            <div class="account-status">

                <div class="status-dot"></div>

                <div>
                    <strong>Account Active</strong>
                    <span>Your Foodie account is ready to order.</span>
                </div>

            </div>


            <!-- LOGOUT -->

            <a href="${pageContext.request.contextPath}/logout"
               class="logout-btn">

                <span>Logout</span>

                <span class="logout-arrow">
                    →
                </span>

            </a>

        </div>

    </main>


</body>

</html>