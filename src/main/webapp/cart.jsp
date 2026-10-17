<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="com.foodie.model.Cart" %>
<%@ page import="com.foodie.model.CartItem" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="com.foodie.model.Restaurant" %>
<%@ page import="com.foodie.daoimpl.RestaurantDAOImpl" %>

<%
    Cart cart = (Cart) session.getAttribute("cart");
    Restaurant restaurant = null;
    int restaurantId = 0;

    if (cart != null && !cart.getItems().isEmpty()) {
        CartItem firstItem = cart.getItems().values().iterator().next();
        restaurantId = firstItem.getMenu().getRestaurantId();

        RestaurantDAOImpl restaurantDAO = new RestaurantDAOImpl();
        restaurant = restaurantDAO.getRestaurantById(restaurantId);
    }

    NumberFormat indianFormat =
        NumberFormat.getNumberInstance(new Locale("en", "IN"));
    indianFormat.setMaximumFractionDigits(2);
    indianFormat.setMinimumFractionDigits(0);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Foodie - Cart</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/navbar.css">
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/cart.css">
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/footer.css">
</head>
<body>

    <%@ include file="navbar.jsp" %>

    <section class="cart-section">

        <div class="cart-title">
            <h1>Your <span>Cart</span></h1>
            <p>Review your selected food items</p>
        </div>

        <% if (cart != null && !cart.getItems().isEmpty()) { %>

            <div class="cart-container">

                <div class="cart-items-box">

                    <% if (restaurant != null) {
                        String restaurantImage = restaurant.getImagePath();

                        if (restaurantImage == null ||
                            restaurantImage.trim().isEmpty()) {
                            restaurantImage =
                                "https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?auto=format&fit=crop&w=300&q=80";
                        }
                    %>

                        <div class="restaurant-header">

                            <img class="restaurant-image"
                                 src="<%= restaurantImage %>"
                                 alt="<%= restaurant.getName() %>">

                            <div class="restaurant-details">
                                <div class="restaurant-name">
                                    <%= restaurant.getName() %>
                                </div>

                                <div class="restaurant-location">
                                    <%= restaurant.getAddress() %>
                                </div>
                            </div>

                            <a class="menu-btn"
                               href="${pageContext.request.contextPath}/menu?restaurantId=<%= restaurantId %>">
                                Explore Menu
                            </a>

                        </div>

                    <% } %>

                    <% for (CartItem item : cart.getItems().values()) {

                        String itemImage = item.getMenu().getImagePath();

                        if (itemImage == null ||
                            itemImage.trim().isEmpty()) {
                            itemImage =
                                "https://images.unsplash.com/photo-1504674900247-0877df9cc836?auto=format&fit=crop&w=300&q=80";
                        }
                    %>

                        <div class="cart-item">

                            <img class="menu-image"
                                 src="<%= itemImage %>"
                                 alt="<%= item.getMenu().getItemName() %>">

                            <div class="item-details">
                                <div class="item-name">
                                    <%= item.getMenu().getItemName() %>
                                </div>

                                <div class="item-price-small">
                                    &#8377;<%= indianFormat.format(
                                        item.getMenu().getPrice()
                                    ) %> per item
                                </div>
                            </div>

                            <form action="${pageContext.request.contextPath}/cart"
                                  method="post"
                                  class="quantity-form">

                                <input type="hidden"
                                       name="action"
                                       value="update">

                                <input type="hidden"
                                       name="source"
                                       value="cart">

                                <input type="hidden"
                                       name="menuId"
                                       value="<%= item.getMenu().getMenuId() %>">

                                <button type="submit"
                                        name="quantity"
                                        value="<%= Math.max(0, item.getQuantity() - 1) %>"
                                        class="quantity-btn"
                                        aria-label="Decrease quantity">
                                    −
                                </button>

                                <span class="quantity-number">
                                    <%= item.getQuantity() %>
                                </span>

                                <button type="submit"
                                        name="quantity"
                                        value="<%= item.getQuantity() + 1 %>"
                                        class="quantity-btn"
                                        aria-label="Increase quantity">
                                    +
                                </button>

                            </form>

                            <div class="item-subtotal">
                                &#8377;<%= indianFormat.format(
                                    item.getSubtotal()
                                ) %>
                            </div>

                        </div>

                    <% } %>

                    <div class="suggestions">
                        Any suggestions? We will pass it on...
                    </div>

                </div>

                <%
                    double deliveryFee = 40;
                    double gstCharges = 20;
                    double totalPayable =
                        cart.getTotal() + deliveryFee + gstCharges;
                %>

                <aside class="bill-box">

                    <div class="bill-title">Bill Details</div>

                    <div class="bill-row">
                        <span class="bill-label">Item Total</span>
                        <span class="bill-value">
                            &#8377;<%= indianFormat.format(cart.getTotal()) %>
                        </span>
                    </div>

                    <div class="bill-row">
                        <span class="bill-label">Delivery Fee</span>
                        <span class="bill-value">&#8377;40</span>
                    </div>

                    <hr class="bill-divider">

                    <div class="bill-row">
                        <span class="bill-label">GST &amp; Other Charges</span>
                        <span class="bill-value">&#8377;20</span>
                    </div>

                    <hr class="bill-divider">

                    <div class="total-row">
                        <span class="total-label">TO PAY</span>
                        <span class="total-value">
                            &#8377;<%= indianFormat.format(totalPayable) %>
                        </span>
                    </div>

                    <a class="place-order"
                       href="${pageContext.request.contextPath}/checkout.jsp">
                        Proceed to Checkout
                    </a>

                </aside>

            </div>

        <% } else { %>

            <div class="empty-cart">
                <div class="empty-cart-icon">🛒</div>
                <h2>Your cart is empty</h2>
                <p>Add some delicious food items to your cart.</p>

                <a class="continue-shopping"
                   href="${pageContext.request.contextPath}/restaurant">
                    Explore Restaurants
                </a>
            </div>

        <% } %>

    </section>

    <%@ include file="footer.jsp" %>

</body>
</html>