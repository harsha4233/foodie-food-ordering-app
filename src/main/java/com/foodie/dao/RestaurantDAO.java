package com.foodie.dao;

import java.util.List;

import com.foodie.model.Restaurant;

public interface RestaurantDAO {

    void addRestaurant(Restaurant restaurant);

    List<Restaurant> getAllRestaurants();

    Restaurant getRestaurantById(int restaurantId);

    void updateRestaurant(Restaurant restaurant);

    void deleteRestaurant(int restaurantId);
}