package com.foodie.util;

import com.foodie.dao.UserDAO;
import com.foodie.daoimpl.UserDAOImpl;
import com.foodie.model.User;

public class TestUserDAO {

    public static void main(String[] args) {

        UserDAO userDAO = new UserDAOImpl();

        User user = new User();

        user.setName("Harsha");
        user.setUsername("harsha123");
        user.setPassword("12345");
        user.setEmail("harsha@gmail.com");
        user.setPhoneNumber("9876543210");
        user.setAddress("Nellore");
        user.setRole("USER");

        userDAO.registerUser(user);

        System.out.println("User registered successfully!");
    
    }
}