package com.foodie.dao;

import com.foodie.model.User;

public interface UserDAO {

    void registerUser(User user);

    User loginUser(String email, String password);

    User getUserById(int userId);
    
    boolean emailExists(String email,String Phone_number);
}