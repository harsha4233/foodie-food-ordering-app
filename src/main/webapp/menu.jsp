
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.foodie.model.Menu" %>
<%@ page import="com.foodie.model.Restaurant" %>
<%@ page import="com.foodie.model.Cart" %>
<%@ page import="com.foodie.model.CartItem" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Foodie - Menu</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/navbar.css">
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/menu.css">
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/footer.css">
</head>
<body>

    <%@ include file="navbar.jsp" %>

    <%
        Restaurant restaurant =
            (Restaurant) request.getAttribute("restaurant");

        Cart cart = (Cart) session.getAttribute("cart");

        List<Menu> allmenu =
            (List<Menu>) request.getAttribute("allmenu");
    %>

    <section class="menu-section">

        <div class="menu-title">
            <h1>
                <%= restaurant != null ? restaurant.getName() : "Restaurant" %>
                <span>Menu</span>
            </h1>

            <p>
                Choose your favourite dishes and enjoy delicious food
                at your doorstep.
            </p>
        </div>

        <div class="search-box">
            <input type="text"
                   id="searchInput"
                   placeholder="Search dishes..."
                   onkeyup="searchMenu()">
            <span class="search-icon">🔍</span>
        </div>

        <div class="menu-grid" id="menuGrid">

            <%
                if (allmenu != null && !allmenu.isEmpty()) {
                    for (Menu menu : allmenu) {

                        CartItem existingItem = null;

                        if (cart != null) {
                            existingItem =
                                cart.getItems().get(menu.getMenuId());
                        }

                        String imagePath = menu.getImagePath();

                        if (imagePath == null ||
                            imagePath.trim().isEmpty()) {
                            imagePath =
                                "https://images.unsplash.com/photo-1504674900247-0877df9cc836?auto=format&fit=crop&w=900&q=80";
                        }
            %>

            <div class="menu-card"
                 data-name="<%= menu.getItemName() %>">

                <img class="menu-image"
                     src="<%= imagePath %>"
                     alt="<%= menu.getItemName() %>">

                <div class="menu-card-body">

                    <div class="menu-name">
                        <%= menu.getItemName() %>
                    </div>

                    <div class="menu-description">
                        <%= menu.getDescription() %>
                    </div>

                    <div class="menu-details">
                        <span class="menu-price">
                            &#8377;<%= menu.getPrice() %>
                        </span>

                        <span class="menu-rating">
                            ⭐ <%= menu.getRating() %>
                        </span>
                    </div>

                    <% if (existingItem == null) { %>

                        <form action="${pageContext.request.contextPath}/cart"
                              method="post">

                            <input type="hidden"
                                   name="action"
                                   value="add">

                            <input type="hidden"
                                   name="menuId"
                                   value="<%= menu.getMenuId() %>">

                            <input type="hidden"
                                   name="quantity"
                                   value="1">

                            <button type="submit" class="add-cart-btn">
                                Add to Cart
                            </button>
                        </form>

                    <% } else { %>

                        <form action="${pageContext.request.contextPath}/cart"
                              method="post"
                              class="quantity-form">

                            <input type="hidden"
                                   name="action"
                                   value="update">

                            <input type="hidden"
                                   name="source"
                                   value="menu">

                            <input type="hidden"
                                   name="restaurantId"
                                   value="<%= menu.getRestaurantId() %>">

                            <input type="hidden"
                                   name="menuId"
                                   value="<%= menu.getMenuId() %>">

                            <button type="submit"
                                    name="quantity"
                                    value="<%= existingItem.getQuantity() - 1 %>"
                                    class="quantity-btn">−</button>

                            <span class="quantity-number">
                                <%= existingItem.getQuantity() %>
                            </span>

                            <button type="submit"
                                    name="quantity"
                                    value="<%= existingItem.getQuantity() + 1 %>"
                                    class="quantity-btn">+</button>
                        </form>

                    <% } %>

                </div>
            </div>

            <%
                    }
                } else {
            %>

                <div class="no-menu">
                    No menu items available.
                </div>

            <%
                }
            %>

        </div>
    </section>

    <%@ include file="footer.jsp" %>

    <script>
        function searchMenu() {
            const input = document.getElementById("searchInput")
                .value.toLowerCase().trim();

            const cards = document.querySelectorAll(".menu-card");

            cards.forEach(function(card) {
                const name =
                    (card.getAttribute("data-name") || "").toLowerCase();

                card.style.display = name.includes(input) ? "" : "none";
            });
        }
    </script>

</body>
</html>
