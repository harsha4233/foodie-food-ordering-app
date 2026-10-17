
package com.foodie.dao;

import java.util.List;

import com.foodie.model.Cart;
import com.foodie.model.Orders;

public interface OrderDAO {

    void placeOrder(Orders order, Cart cart);

    Orders getOrderById(int orderId);

    List<Orders> getOrdersByUserId(int userId);

    List<Orders> getOrdersByRestaurantId(int restaurantId);

    void updateOrderStatus(int orderId, String status);
}
