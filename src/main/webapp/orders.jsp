
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.LinkedHashMap" %>
<%@ page import="com.foodie.model.Orders" %>

<%
    List<Orders> orders =
        (List<Orders>) request.getAttribute("orders");

    Map<Integer, List<Orders>> groupedOrders = new LinkedHashMap<>();

    if (orders != null) {
        for (Orders order : orders) {
            groupedOrders.computeIfAbsent(
                order.getOrderId(),
                k -> new ArrayList<>()
            ).add(order);
        }
    }

    String ctx = request.getContextPath();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>My Orders | Foodie</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/navbar.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/orders.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/footer.css">
</head>

<body>

    <%@ include file="navbar.jsp" %>

    <main class="orders-container">

        <section class="page-heading">
            <h1>My <span class="highlight">Orders</span></h1>
            <p>All your favourite meals, together in one place.</p>
        </section>

        <% if (groupedOrders.isEmpty()) { %>

            <section class="empty-state">
                <div class="empty-icon">🍽️</div>

                <h2>No orders <span class="highlight">yet!</span></h2>

                <p>
                    Your delicious journey starts here.
                    Explore restaurants and order your favourite food.
                </p>

                <a class="primary-btn"
                   href="<%= ctx %>/restaurant">
                    Explore Restaurants
                </a>
            </section>

        <% } else { %>

            <% for (Map.Entry<Integer, List<Orders>> entry
                    : groupedOrders.entrySet()) {

                List<Orders> items = entry.getValue();
                Orders first = items.get(0);

                String restaurantImage = first.getRestaurantImage();

                if (restaurantImage != null &&
                    !restaurantImage.trim().isEmpty() &&
                    !restaurantImage.startsWith("http://") &&
                    !restaurantImage.startsWith("https://")) {

                    restaurantImage = ctx + "/" +
                        restaurantImage.replaceFirst("^/+", "");
                }
            %>

                <article class="order-card">

                    <!-- RESTAURANT DETAILS -->

                    <div class="restaurant-header">

                        <% if (restaurantImage != null &&
                               !restaurantImage.trim().isEmpty()) { %>

                            <img class="restaurant-image"
                                 src="<%= restaurantImage %>"
                                 alt="Restaurant"
                                 onerror="this.style.display='none';">

                        <% } else { %>

                            <div class="restaurant-image image-placeholder">
                                🍴
                            </div>

                        <% } %>

                        <div class="restaurant-info">

                            <h2>
                                <%= first.getRestaurantName() == null
                                    ? "Restaurant"
                                    : first.getRestaurantName() %>
                            </h2>

                            <div class="order-meta">
                                <span>
                                    Order ID: <%= first.getOrderId() %>
                                </span>

                                <span>
                                    <%= first.getOrderDate() == null
                                        ? ""
                                        : first.getOrderDate() %>
                                </span>
                            </div>

                            <span class="status">
                                <%= first.getStatus() == null
                                    ? "UNKNOWN"
                                    : first.getStatus() %>
                            </span>

                        </div>
                    </div>

                    <!-- ORDERED FOOD ITEMS -->

                    <h3 class="items-title">
                        Ordered <span class="highlight">Items</span>
                    </h3>

                    <% for (Orders item : items) {

                        String menuImage = item.getMenuImage();

                        if (menuImage != null &&
                            !menuImage.trim().isEmpty() &&
                            !menuImage.startsWith("http://") &&
                            !menuImage.startsWith("https://")) {

                            menuImage = ctx + "/" +
                                menuImage.replaceFirst("^/+", "");
                        }
                    %>

                        <div class="food-item">

                            <% if (menuImage != null &&
                                   !menuImage.trim().isEmpty()) { %>

                                <img class="food-image"
                                     src="<%= menuImage %>"
                                     alt="<%= item.getItemName() == null
                                         ? "Food item"
                                         : item.getItemName() %>"
                                     onerror="this.style.display='none';">

                            <% } else { %>

                                <div class="food-image image-placeholder">
                                    🍛
                                </div>

                            <% } %>

                            <div class="food-details">

                                <h3>
                                    <%= item.getItemName() == null
                                        ? "Food item"
                                        : item.getItemName() %>
                                </h3>

                                <p>
                                    Quantity: <%= item.getQuantity() %>
                                </p>

                            </div>

                            <div class="item-price">
                                ₹<%= String.format("%.2f",
                                    item.getItemTotal()) %>
                            </div>

                        </div>

                    <% } %>

                    <!-- ORDER TOTAL -->

                    <div class="total-section">
                        <span class="total-label">Order Total</span>

                        <span class="total-amount">
                            ₹<%= String.format("%.2f",
                                first.getOrderTotal()) %>
                        </span>
                    </div>

                </article>

            <% } %>

        <% } %>

    </main>

    <%@ include file="footer.jsp" %>

</body>
</html>
