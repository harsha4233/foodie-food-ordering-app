package com.foodie.controller;

import com.foodie.daoimpl.MenuDAOImpl;
import com.foodie.daoimpl.RestaurantDAOImpl;
import com.foodie.model.Menu;
import com.foodie.model.Restaurant;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/menu")
public class MenuController extends HttpServlet {
	
	protected void doGet(HttpServletRequest req , HttpServletResponse resp) throws ServletException, IOException {
		
		int restaurantId = Integer.parseInt(req.getParameter("restaurantId"));
		
		MenuDAOImpl menudao = new MenuDAOImpl();
		List<Menu> menubyRestaurant=menudao.getMenuByRestaurantId(restaurantId);
		
		req.setAttribute("allmenu", menubyRestaurant);
		
		RestaurantDAOImpl restaurantdao = new RestaurantDAOImpl(); //these 3 lines for in menu for restaurant name

		Restaurant restaurant = restaurantdao.getRestaurantById(restaurantId);

		req.setAttribute("restaurant", restaurant);
	
		RequestDispatcher rd = req.getRequestDispatcher("menu.jsp");
		rd.forward(req, resp);
		
	}

}
