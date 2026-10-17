
package com.foodie.controller;

import java.io.IOException;



import com.foodie.dao.UserDAO;
import com.foodie.daoimpl.UserDAOImpl;
import com.foodie.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginController extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAOImpl();
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email == null || email.trim().isEmpty()
                || password == null || password.isEmpty()) {

            request.setAttribute("error", "Please enter email and password.");
            request.getRequestDispatcher("/login.jsp")
                   .forward(request, response);
            return;
        }

       
        User user = userDAO.loginUser(email.trim(),password);

        if (user != null) {

            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setAttribute("userId", user.getUserId());

            response.sendRedirect(
                request.getContextPath() + "/restaurant"
            );

        } else {

            request.setAttribute(
                "error",
                "Invalid email or password."
            );

            request.getRequestDispatcher("/login.jsp")
                   .forward(request, response);
        }
    }
}