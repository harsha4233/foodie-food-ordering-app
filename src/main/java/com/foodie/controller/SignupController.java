package com.foodie.controller;

import java.io.IOException;

import org.mindrot.jbcrypt.BCrypt;

import com.foodie.dao.UserDAO;
import com.foodie.daoimpl.UserDAOImpl;
import com.foodie.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/signup")
public class SignupController extends HttpServlet {

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

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        name = name.trim();
        email = email.trim();
        phone = phone.trim();
        address = address.trim();

        // Check password
        if (!password.equals(confirmPassword)) {

            request.setAttribute(
                "error",
                "Passwords do not match"
            );

            request.getRequestDispatcher("/signup.jsp")
                   .forward(request, response);

            return;
        }
        
        
        
        if (userDAO.emailExists(email,phone)) {

            request.setAttribute(
                "error",
                "Email or PhoneNo already exists. Try another email or phoneNo."
            );

            request.getRequestDispatcher("/signup.jsp")
                   .forward(request, response);

            return;
        }

        // Create User object
        User user = new User();

        user.setName(name);

        // Username is not asked separately.
        // Use email as username.
        user.setUsername(email);

        String en_password=BCrypt.hashpw(password, BCrypt.gensalt());//encrypting the password
        user.setPassword(en_password);
        
        user.setEmail(email);
        user.setPhoneNumber(phone);
        user.setAddress(address);

        // Normal user
        user.setRole("user");

        // Save to database
        userDAO.registerUser(user);

        //direct profile
        HttpSession session = request.getSession();
        session.setAttribute("user", user);
        session.setAttribute("userId", user.getUserId());

        response.sendRedirect(
            request.getContextPath() + "/restaurant"
        );

        
        
        // Go to login
//        response.sendRedirect(
//            request.getContextPath() + "/login.jsp"
//        );
    }
}