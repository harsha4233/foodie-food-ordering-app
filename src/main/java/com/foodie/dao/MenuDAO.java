package com.foodie.dao;

import java.util.List;

import com.foodie.model.Menu;

public interface MenuDAO {

    void addMenu(Menu menu);

    List<Menu> getMenuByRestaurantId(int restaurantId);

    Menu getMenuById(int menuId);

    void updateMenu(Menu menu);

    void deleteMenu(int menuId);
}