package com.foodie.controller;

import java.io.IOException;
import java.util.List;

import com.foodie.daoimpl.RestaurantDAOImpl;
import com.foodie.model.Restaurant;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/restaurant")
public class RestaurantController extends HttpServlet {
	
	protected void doGet(HttpServletRequest req , HttpServletResponse resp) throws ServletException, IOException {
		
		   RestaurantDAOImpl restaurantdao = new RestaurantDAOImpl();
		   List<Restaurant>  allrestaurants= restaurantdao.getAllRestaurants();
	   
		   req.setAttribute("restaurants", allrestaurants);//it will send all attributes to the jsp
		   
		   RequestDispatcher rd = req.getRequestDispatcher("restaurant.jsp");
		   rd.forward(req, resp);
	}

}
