
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.foodie.model.Restaurant" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Foodie - Restaurants</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/navbar.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/restaurant.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/footer.css">
</head>
<body>

    <%@ include file="navbar.jsp" %>

    <main class="main-content">

        <section class="title-section">
            <h1>Explore Restaurants</h1>
            <p>Discover amazing restaurants near you</p>
        </section>

        <div class="search-box">
            <input type="text"
                   id="searchInput"
                   placeholder="Search restaurants, cuisine..."
                   onkeyup="searchRestaurants()">
            <span class="search-icon">🔍</span>
        </div>

        <div class="filters">
            <button class="filter active"
                    onclick="filterRestaurants('all', this)">All</button>
            <button class="filter"
                    onclick="filterRestaurants('indian', this)">Indian</button>
            <button class="filter"
                    onclick="filterRestaurants('chinese', this)">Chinese</button>
            <button class="filter"
                    onclick="filterRestaurants('italian', this)">Italian</button>
            <button class="filter"
                    onclick="filterRestaurants('fast food', this)">Fast Food</button>
            <button class="filter"
                    onclick="filterRestaurants('south indian', this)">South Indian</button>
            <button class="filter"
                    onclick="filterRestaurants('desserts', this)">Desserts</button>
        </div>

        <%
            List<Restaurant> allrestaurants =
                (List<Restaurant>) request.getAttribute("restaurants");
        %>

        <div class="restaurant-grid" id="restaurantGrid">

            <%
                if (allrestaurants != null && !allrestaurants.isEmpty()) {
                    for (Restaurant restaurant : allrestaurants) {
            %>

            <div class="restaurant-card"
                 data-cuisine="<%= restaurant.getCuisineType() %>"
                 data-name="<%= restaurant.getName() %>">

                <div class="image-container">
                    <%
                        String imagePath = restaurant.getImagePath();

                        if (imagePath == null || imagePath.trim().isEmpty()) {
                            imagePath = "https://images.unsplash.com/photo-1504674900247-0877df9cc836?auto=format&fit=crop&w=900&q=80";
                        }
                    %>

                    <img class="restaurant-image"
                         src="<%= imagePath %>"
                         alt="<%= restaurant.getName() %>">

                    <span class="discount">20% OFF</span>
                </div>

                <div class="card-body">

                    <div class="restaurant-name">
                        <%= restaurant.getName() %>
                    </div>

                    <div class="cuisine">
                        <%= restaurant.getCuisineType() %>
                    </div>

                    <div class="details">
                        <span class="rating">
                            ⭐ <%= restaurant.getRating() %>
                        </span>

                        <span class="delivery">
                            🕒 <%= restaurant.getDeliveryTime() %>
                        </span>
                    </div>

                    <div class="location">
                        <img src="${pageContext.request.contextPath}/images/location.png"
                             alt="Location">
                        <%= restaurant.getAddress() %>
                    </div>

                    <div class="menu-button-container">
                        <a href="${pageContext.request.contextPath}/menu?restaurantId=<%= restaurant.getRestaurantId() %>"
                           class="view-menu-btn">
                            View Menu
                        </a>
                    </div>

                    <%
                        if (restaurant.isActive()) {
                    %>
                        <div class="status">● Open</div>
                    <%
                        } else {
                    %>
                        <div class="closed">● Closed</div>
                    <%
                        }
                    %>

                </div>
            </div>

            <%
                    }
                } else {
            %>

            <div class="no-restaurants">
                No restaurants available.
            </div>

            <%
                }
            %>

        </div>
    </main>

    <%@ include file="footer.jsp" %>

    <script>
        function searchRestaurants() {
            const input = document.getElementById("searchInput")
                .value.toLowerCase().trim();

            const cards = document.querySelectorAll(".restaurant-card");

            cards.forEach(function(card) {
                const name = (card.getAttribute("data-name") || "")
                    .toLowerCase();

                const cuisine = (card.getAttribute("data-cuisine") || "")
                    .toLowerCase();

                card.style.display =
                    name.includes(input) || cuisine.includes(input)
                        ? ""
                        : "none";
            });
        }

        function filterRestaurants(category, button) {
            document.querySelectorAll(".filter").forEach(function(btn) {
                btn.classList.remove("active");
            });

            button.classList.add("active");

            document.querySelectorAll(".restaurant-card").forEach(function(card) {
                const cuisine = (card.getAttribute("data-cuisine") || "")
                    .toLowerCase();

                card.style.display =
                    category === "all" || cuisine.includes(category)
                        ? ""
                        : "none";
            });
        }
    </script>

</body>
</html>
