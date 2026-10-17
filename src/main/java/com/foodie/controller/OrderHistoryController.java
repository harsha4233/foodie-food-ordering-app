
package com.foodie.controller;

import java.io.IOException;
import java.util.List;

import com.foodie.dao.OrderDAO;
import com.foodie.daoimpl.OrderDAOImpl;
import com.foodie.model.Orders;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/orders")
public class OrderHistoryController extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private OrderDAO orderDAO;

	@Override
	public void init() {
		orderDAO = new OrderDAOImpl();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession(false);

		if (session == null || !(session.getAttribute("userId") instanceof Integer)) {

			response.sendRedirect(request.getContextPath() + "/login.jsp");
			return;
		}

		int userId = (Integer) session.getAttribute("userId");

		try {
			List<Orders> orders = orderDAO.getOrdersByUserId(userId);

			request.setAttribute("orders", orders);

			request.getRequestDispatcher("/orders.jsp").forward(request, response);

		} catch (RuntimeException e) {
			throw new ServletException("Unable to load order history.", e);
		}
	}
}
