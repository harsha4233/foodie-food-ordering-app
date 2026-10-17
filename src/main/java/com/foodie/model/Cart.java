package com.foodie.model;

import java.util.LinkedHashMap;
import java.util.Map;

public class Cart {

    private int restaurantId;

    private Map<Integer, CartItem> items;


    public Cart() {
        this.restaurantId = 0 ;
        items = new LinkedHashMap<>();
    }

    public int getRestaurantId() {
        return restaurantId;
    }

    public void setRestaurantId(int restaurantId) {
        this.restaurantId = restaurantId;
    }

    public Map<Integer, CartItem> getItems() {
        return items;
    }

    public void setItems(Map<Integer, CartItem> items) {
        this.items = items;
    }

    // Add item
    public void addItem(CartItem cartItem) {

        int menuId = cartItem.getMenu().getMenuId();

        if (items.containsKey(menuId)) {

            CartItem existingItem = items.get(menuId);

            existingItem.setQuantity(existingItem.getQuantity() + cartItem.getQuantity() );

        } else {

            items.put(menuId, cartItem);
        }
    }

    // Remove item
    public void removeItem(int menuId) {

        items.remove(menuId);
    }

  

    // Calculate total
    public double getTotal() {

        double total = 0;

        for (CartItem item : items.values()) {

            total += item.getSubtotal();
        }

        return total;
    }

    // Clear cart
    public void clearCart() {

        items.clear();
    }
}