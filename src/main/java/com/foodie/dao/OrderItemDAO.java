package com.foodie.dao;

import java.util.List;

import com.foodie.model.OrderItem;

public interface OrderItemDAO {

    void addOrderItem(OrderItem orderItem);

    List<OrderItem> getOrderItemsByOrderId(int orderId);

    void deleteOrderItem(int orderItemId);
}