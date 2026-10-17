package com.foodie.controller;

import java.io.IOException;

import com.foodie.dao.OrderDAO;
import com.foodie.daoimpl.OrderDAOImpl;
import com.foodie.model.Cart;
import com.foodie.model.CartItem;
import com.foodie.model.Orders;
import com.foodie.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/check")
public class CheckoutController extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");

		// Get existing session
		HttpSession session = request.getSession(false);

		// Check whether user is logged in
		if (session == null || session.getAttribute("user") == null) {

			response.sendRedirect(request.getContextPath() + "/login.jsp");

			return;
		}

		// Get logged-in user
		User user = (User) session.getAttribute("user");

		// Get cart from session
		Cart cart = (Cart) session.getAttribute("cart");

		// Check whether cart is empty
		if (cart == null || cart.getItems().isEmpty()) {

			response.sendRedirect(request.getContextPath() + "/cart.jsp");

			return;
		}

		// Get checkout details
		String customerName = request.getParameter("customerName");
		String phone = request.getParameter("phone");
		String address = request.getParameter("address");
		String paymentMethod = request.getParameter("paymentMethod");

		// Validate checkout details
		if (customerName == null || customerName.trim().isEmpty() || phone == null || !phone.matches("[0-9]{10}")
				|| address == null || address.trim().isEmpty() || !"COD".equals(paymentMethod)) {

			response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Please enter valid checkout details.");

			return;
		}

		// Calculate item total
		double itemTotal = 0;

		for (CartItem item : cart.getItems().values()) {

			itemTotal += item.getMenu().getPrice() * item.getQuantity();
		}

		// Charges
		double deliveryFee = 40;
		double gst = 20;

		// Final total
		double total = itemTotal + deliveryFee + gst;

		// =========================================
		// GET RESTAURANT ID FROM CART
		// =========================================

		CartItem firstItem = cart.getItems().values().iterator().next();

		int restaurantId = firstItem.getMenu().getRestaurantId();

		// =========================================
		// CREATE ORDER OBJECT
		// =========================================

		Orders order = new Orders();

		order.setRestaurantId(restaurantId);
		order.setUserId(user.getUserId());
		order.setTotalAmount(total);
		order.setStatus("PLACED");
		order.setPaymentMode(paymentMethod);

		// =========================================
		// SAVE ORDER TO DATABASE
		// =========================================

		OrderDAO orderDAO = new OrderDAOImpl();

		orderDAO.placeOrder(order,cart);

		// =========================================
		// SEND DATA TO CONFIRMATION PAGE
		// =========================================

		request.setAttribute("user", user);

		request.setAttribute("customerName", customerName.trim());

		request.setAttribute("phone", phone);

		request.setAttribute("address", address.trim());

		request.setAttribute("paymentMethod", paymentMethod);

		request.setAttribute("itemTotal", itemTotal);

		request.setAttribute("deliveryFee", deliveryFee);

		request.setAttribute("gst", gst);

		request.setAttribute("total", total);

		// =========================================
		// GO TO ORDER CONFIRMATION PAGE
		// =========================================

		request.getRequestDispatcher("/orderConfirmation.jsp").forward(request, response);
	}
}