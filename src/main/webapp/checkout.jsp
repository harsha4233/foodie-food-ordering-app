
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="com.foodie.model.Cart" %>
<%@ page import="com.foodie.model.CartItem" %>
<%@ page import="com.foodie.model.User" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>

<%
    User user = (User) session.getAttribute("user");

    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    Cart cart = (Cart) session.getAttribute("cart");

    if (cart == null || cart.getItems().isEmpty()) {
        response.sendRedirect(request.getContextPath() + "/cart.jsp");
        return;
    }

    String ctx = request.getContextPath();

    NumberFormat indianFormat =
        NumberFormat.getNumberInstance(new Locale("en", "IN"));

    indianFormat.setMinimumFractionDigits(2);
    indianFormat.setMaximumFractionDigits(2);

    double itemTotal = 0;

    for (CartItem item : cart.getItems().values()) {
        itemTotal += item.getMenu().getPrice() * item.getQuantity();
    }

    double deliveryFee = 40;
    double gstCharges = 20;
    double totalPayable = itemTotal + deliveryFee + gstCharges;
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Foodie - Checkout</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/navbar.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/checkout.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/footer.css">
</head>

<body>

    <%@ include file="navbar.jsp" %>

    <main class="checkout-section">

        <div class="checkout-title">
            <h1>Check<span>out</span></h1>
            <p>Complete your order and get delicious food delivered.</p>
        </div>

        <form action="<%= ctx %>/check"
              method="post"
              id="checkoutForm">

            <div class="checkout-container">

                <!-- DELIVERY DETAILS -->

                <section class="checkout-box">

                    <h2>Delivery Details</h2>

                    <div class="form-group">
                        <label for="customerName">Full Name</label>

                        <input
                            type="text"
                            id="customerName"
                            name="customerName"
                            value="<%= user.getName() == null ? "" : user.getName() %>"
                            placeholder="Enter your name"
                            autocomplete="name"
                            required>
                    </div>

                    <div class="form-group">
                        <label for="phone">Phone Number</label>

                        <input
                            type="tel"
                            id="phone"
                            name="phone"
                            value="<%= user.getPhoneNumber() == null ? "" : user.getPhoneNumber() %>"
                            placeholder="Enter your phone number"
                            maxlength="10"
                            pattern="[0-9]{10}"
                            inputmode="numeric"
                            autocomplete="tel"
                            required>
                    </div>

                    <div class="form-group">
                        <label for="address">Delivery Address</label>

                        <textarea
                            id="address"
                            name="address"
                            placeholder="Enter your complete delivery address"
                            autocomplete="street-address"
                            required><%= user.getAddress() == null ? "" : user.getAddress() %></textarea>
                    </div>

                    <!-- PAYMENT METHOD -->

                    <div class="payment-section">

                        <h2>Payment Method</h2>

                        <label class="payment-option">
                            <input
                                type="radio"
                                name="paymentMethod"
                                value="COD"
                                checked
                                required
                                onchange="showPayment('cod')">

                            <span>💵 Cash on Delivery</span>
                        </label>

                        <label class="payment-option">
                            <input
                                type="radio"
                                name="paymentMethod"
                                value="UPI"
                                onchange="showPayment('upi')">

                            <span>📱 UPI</span>
                        </label>

                        <div id="upiBox" class="payment-box">

                            <label for="upiId">UPI ID</label>

                            <input
                                type="text"
                                id="upiId"
                                name="upiId"
                                placeholder="example@upi"
                                autocomplete="off"
                                disabled>

                            <p class="payment-note">
                                Demo form only. Online payment is not processed here.
                            </p>
                        </div>

                        <label class="payment-option">
                            <input
                                type="radio"
                                name="paymentMethod"
                                value="CARD"
                                onchange="showPayment('card')">

                            <span>💳 Credit / Debit Card</span>
                        </label>

                        <div id="cardBox" class="payment-box">

                            <p class="payment-note">
                                Card payment is not connected. Do not enter real card details.
                            </p>

                            <label for="cardNumber">Demo Card Number</label>

                            <input
                                type="text"
                                id="cardNumber"
                                placeholder="XXXX XXXX XXXX XXXX"
                                maxlength="19"
                                inputmode="numeric"
                                autocomplete="off"
                                disabled>

                            <div class="card-row">

                                <div class="card-field">
                                    <label for="expiry">Expiry</label>

                                    <input
                                        type="text"
                                        id="expiry"
                                        placeholder="MM/YY"
                                        maxlength="5"
                                        autocomplete="off"
                                        disabled>
                                </div>

                                <div class="card-field">
                                    <label for="cvv">CVV</label>

                                    <input
                                        type="password"
                                        id="cvv"
                                        placeholder="XXX"
                                        maxlength="3"
                                        autocomplete="off"
                                        disabled>
                                </div>

                            </div>
                        </div>

                    </div>

                </section>

                <!-- ORDER SUMMARY -->

                <section class="checkout-box summary-box">

                    <h2>Order Summary</h2>

                    <% for (CartItem item : cart.getItems().values()) {

                        double itemPrice =
                            item.getMenu().getPrice() * item.getQuantity();

                        String imagePath = item.getMenu().getImagePath();

                        if (imagePath != null &&
                            !imagePath.trim().isEmpty() &&
                            !imagePath.startsWith("http://") &&
                            !imagePath.startsWith("https://")) {

                            imagePath = ctx + "/" +
                                imagePath.replaceFirst("^/+", "");
                        }
                    %>

                        <div class="summary-item">

                            <div class="food-image">

                                <% if (imagePath != null &&
                                       !imagePath.trim().isEmpty()) { %>

                                    <img
                                        src="<%= imagePath %>"
                                        alt="<%= item.getMenu().getItemName() == null
                                            ? "Food item"
                                            : item.getMenu().getItemName() %>"
                                        onerror="this.style.display='none';">

                                <% } else { %>

                                    <div class="image-placeholder">🍛</div>

                                <% } %>

                            </div>

                            <div class="food-details">

                                <div class="summary-item-top">

                                    <span class="food-name">
                                        <%= item.getMenu().getItemName() == null
                                            ? "Food item"
                                            : item.getMenu().getItemName() %>
                                    </span>

                                    <span class="food-price">
                                        ₹<%= indianFormat.format(itemPrice) %>
                                    </span>

                                </div>

                                <div class="quantity">
                                    Quantity: <%= item.getQuantity() %>
                                </div>

                            </div>

                        </div>

                    <% } %>

                    <!-- BILL DETAILS -->

                    <div class="bill">

                        <div class="bill-row">
                            <span class="bill-label">Item Total</span>

                            <span class="bill-value">
                                ₹<%= indianFormat.format(itemTotal) %>
                            </span>
                        </div>

                        <div class="bill-row">
                            <span class="bill-label">Delivery Fee</span>

                            <span class="bill-value">
                                ₹<%= indianFormat.format(deliveryFee) %>
                            </span>
                        </div>

                        <div class="bill-row">
                            <span class="bill-label">GST and Other Charges</span>

                            <span class="bill-value">
                                ₹<%= indianFormat.format(gstCharges) %>
                            </span>
                        </div>

                        <hr class="divider">

                        <div class="total-row">
                            <span class="total-label">TO PAY</span>

                            <span class="total-value">
                                ₹<%= indianFormat.format(totalPayable) %>
                            </span>
                        </div>

                        <button type="submit" class="place-order">
                            Place Order <span>→</span>
                        </button>

                        <p class="secure-note">
                            🔒 Please verify your delivery details before placing your order.
                        </p>

                    </div>

                </section>

            </div>

        </form>

    </main>

    <%@ include file="footer.jsp" %>

    <script>
        function showPayment(method) {
            const upiBox = document.getElementById("upiBox");
            const cardBox = document.getElementById("cardBox");

            const upiId = document.getElementById("upiId");
            const cardNumber = document.getElementById("cardNumber");
            const expiry = document.getElementById("expiry");
            const cvv = document.getElementById("cvv");

            upiBox.style.display = "none";
            cardBox.style.display = "none";

            upiId.disabled = true;
            upiId.required = false;

            cardNumber.disabled = true;
            expiry.disabled = true;
            cvv.disabled = true;

            if (method === "upi") {
                upiBox.style.display = "block";
                upiId.disabled = false;
                upiId.required = true;
            }

            if (method === "card") {
                cardBox.style.display = "block";

                cardNumber.disabled = false;
                expiry.disabled = false;
                cvv.disabled = false;
            }
        }

        // Accept only digits in the phone field.
        document.getElementById("phone").addEventListener("input", function () {
            this.value = this.value.replace(/[^0-9]/g, "").substring(0, 10);
        });

        // Format the demo card number.
        document.getElementById("cardNumber").addEventListener("input", function () {
            let value = this.value.replace(/\D/g, "").substring(0, 16);
            this.value = value.replace(/(.{4})/g, "$1 ").trim();
        });

        // Format expiry as MM/YY.
        document.getElementById("expiry").addEventListener("input", function () {
            let value = this.value.replace(/\D/g, "").substring(0, 4);

            if (value.length > 2) {
                value = value.substring(0, 2) + "/" + value.substring(2);
            }

            this.value = value;
        });

        // CVV formatting for demonstration only.
        document.getElementById("cvv").addEventListener("input", function () {
            this.value = this.value.replace(/\D/g, "").substring(0, 3);
        });

        // Set the initial payment view.
        showPayment("cod");
    </script>

</body>
</html>