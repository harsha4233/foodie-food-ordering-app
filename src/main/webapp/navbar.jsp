<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<%@ page import="com.foodie.model.User" %>
<%@ page import="com.foodie.model.Cart" %>
<%@ page import="com.foodie.model.CartItem" %>


<%
    /* =========================================
       LOGGED-IN USER
       ========================================= */

    User loggedInUser =
        (User) session.getAttribute("user");


    /* =========================================
       GET CART FROM SESSION
       ========================================= */

    Cart navbarCart =
        (Cart) session.getAttribute("cart");


    /* =========================================
       CALCULATE TOTAL CART QUANTITY
       ========================================= */

    int cartCount = 0;


    if (navbarCart != null &&
        !navbarCart.getItems().isEmpty()) {


        for (CartItem item :
             navbarCart.getItems().values()) {

            cartCount += item.getQuantity();

        }

    }
%>


<!-- =========================================
     NAVBAR CSS
     ========================================= -->

<link rel="stylesheet"
      href="${pageContext.request.contextPath}/css/navbar.css">


<header class="foodie-navbar">


    <!-- =========================================
         LOGO
         ========================================= -->

    <a class="logo"
       href="${pageContext.request.contextPath}/home.html">

        🍴 Food<span>ie</span>

    </a>


    <!-- =========================================
         MOBILE MENU BUTTON
         ========================================= -->

    <button class="menu-toggle"
            type="button"
            aria-label="Toggle navigation"
            aria-expanded="false"
            onclick="toggleFoodieMenu(this)">

        ☰

    </button>


    <!-- =========================================
         NAVIGATION LINKS
         ========================================= -->

    <nav class="nav-links"
         id="foodieNavLinks">


        <!-- =====================================
             RESTAURANTS
             ===================================== -->

        <a href="${pageContext.request.contextPath}/restaurant">

            Restaurants

        </a>


        <!-- =====================================
             CART
             ===================================== -->

        <a class="cart-link"
           href="${pageContext.request.contextPath}/cart">


            <span class="cart-text">

                Cart

            </span>


            <% if (cartCount > 0) { %>


                <!-- INSTAGRAM STYLE NOTIFICATION -->

                <span class="cart-notification">

                    <%= cartCount %>

                </span>


            <% } %>


        </a>


        <!-- =====================================
             ORDERS
             ===================================== -->

        <a href="${pageContext.request.contextPath}/orders">

            Orders

        </a>


        <!-- =====================================
             CONTACT
             ===================================== -->

        <a href="${pageContext.request.contextPath}/contact.jsp">

            Contact

        </a>


    </nav>


    <!-- =========================================
         RIGHT SIDE
         ========================================= -->

    <div class="nav-right">


        <% if (loggedInUser == null) { %>


            <!-- SIGN IN -->

            <a class="signin"
               href="${pageContext.request.contextPath}/login.jsp">

                Sign In

            </a>


            <!-- SIGN UP -->

            <a class="signup"
               href="${pageContext.request.contextPath}/signup.jsp">

                Sign Up

            </a>


        <% } else { %>


            <!-- PROFILE -->

            <a class="profile"
               href="${pageContext.request.contextPath}/profile.jsp"
               title="Profile"
               aria-label="Profile">

                👤

            </a>


        <% } %>


    </div>


</header>


<!-- =========================================
     MOBILE MENU SCRIPT
     ========================================= -->

<script>

function toggleFoodieMenu(button) {

    const menu =
        document.getElementById("foodieNavLinks");


    const isOpen =
        menu.classList.toggle("open");


    button.setAttribute(
        "aria-expanded",
        String(isOpen)
    );


    button.textContent =
        isOpen ? "✕" : "☰";

}

</script>