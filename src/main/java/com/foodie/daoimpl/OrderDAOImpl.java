
package com.foodie.daoimpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.foodie.dao.OrderDAO;
import com.foodie.model.Cart;
import com.foodie.model.CartItem;
import com.foodie.model.Orders;
import com.foodie.util.DBConnection;

public class OrderDAOImpl implements OrderDAO {

    @Override
    public void placeOrder(Orders order, Cart cart) {

        String orderSql =
            "INSERT INTO orders " +
            "(restaurant_id, user_id, total_amount, status, payment_mode) " +
            "VALUES (?, ?, ?, ?, ?)";

        String itemSql =
            "INSERT INTO order_items " +
            "(order_id, menu_id, quantity, total_amount) " +
            "VALUES (?, ?, ?, ?)";

        if (cart == null || cart.getItems().isEmpty()) {
            throw new IllegalArgumentException("Cart is empty.");
        }

        try (Connection con = DBConnection.getConnection()) {

            con.setAutoCommit(false);

            try {
                int orderId;

                try (PreparedStatement orderPs =
                         con.prepareStatement(
                             orderSql, Statement.RETURN_GENERATED_KEYS)) {

                    orderPs.setInt(1, order.getRestaurantId());
                    orderPs.setInt(2, order.getUserId());
                    orderPs.setDouble(3, order.getTotalAmount());
                    orderPs.setString(4, order.getStatus());
                    orderPs.setString(5, order.getPaymentMode());

                    orderPs.executeUpdate();

                    try (ResultSet keys = orderPs.getGeneratedKeys()) {
                        if (!keys.next()) {
                            throw new SQLException(
                                "Order ID was not generated.");
                        }
                        orderId = keys.getInt(1);
                    }
                }

                try (PreparedStatement itemPs =
                         con.prepareStatement(itemSql)) {

                    for (CartItem item : cart.getItems().values()) {

                        int menuId = item.getMenu().getMenuId();
                        int quantity = item.getQuantity();
                        double itemTotal =
                            item.getMenu().getPrice() * quantity;

                        itemPs.setInt(1, orderId);
                        itemPs.setInt(2, menuId);
                        itemPs.setInt(3, quantity);
                        itemPs.setDouble(4, itemTotal);

                        itemPs.addBatch();
                    }

                    itemPs.executeBatch();
                }

                con.commit();
                System.out.println(
                    "Order placed successfully. Order ID: " + orderId);

            } catch (Exception e) {
                con.rollback();
                throw e;
            } finally {
                con.setAutoCommit(true);
            }

        } catch (Exception e) {
            throw new RuntimeException("Unable to place order.", e);
        }
    }

    @Override
    public List<Orders> getOrdersByUserId(int userId) {

        List<Orders> orderList = new ArrayList<>();

        String sql =
            "SELECT o.order_id, o.order_date, o.status, " +
            "o.total_amount AS order_total, " +
            "r.name AS restaurant_name, " +
            "r.image_path AS restaurant_image, " +
            "m.item_name AS item_name, " +
            "m.image_path AS menu_image, " +
            "oi.quantity AS quantity, " +
            "oi.total_amount AS item_total " +
            "FROM orders o " +
            "JOIN restaurants r ON o.restaurant_id = r.restaurant_id " +
            "JOIN order_items oi ON o.order_id = oi.order_id " +
            "JOIN menus m ON oi.menu_id = m.menu_id " +
            "WHERE o.user_id = ? " +
            "ORDER BY o.order_date DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {

                    Orders order = new Orders();

                    order.setOrderId(rs.getInt("order_id"));

                    if (rs.getTimestamp("order_date") != null) {
                        order.setOrderDate(
                            rs.getTimestamp("order_date").toString());
                    }

                    order.setStatus(rs.getString("status"));
                    order.setOrderTotal(rs.getDouble("order_total"));
                    order.setRestaurantName(
                        rs.getString("restaurant_name"));
                    order.setRestaurantImage(
                        rs.getString("restaurant_image"));
                    order.setItemName(rs.getString("item_name"));
                    order.setMenuImage(rs.getString("menu_image"));
                    order.setQuantity(rs.getInt("quantity"));
                    order.setItemTotal(rs.getDouble("item_total"));

                    orderList.add(order);
                }
            }

        } catch (SQLException e) {
            throw new RuntimeException(
                "Unable to retrieve order history.", e);
        }

        return orderList;
    }

    @Override
    public Orders getOrderById(int orderId) {

        String sql =
            "SELECT order_id, restaurant_id, user_id, order_date, " +
            "total_amount, status, payment_mode " +
            "FROM orders WHERE order_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, orderId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {

                    Orders order = new Orders();

                    order.setOrderId(rs.getInt("order_id"));
                    order.setRestaurantId(
                        rs.getInt("restaurant_id"));
                    order.setUserId(rs.getInt("user_id"));

                    if (rs.getTimestamp("order_date") != null) {
                        order.setOrderDate(
                            rs.getTimestamp("order_date").toString());
                    }

                    order.setTotalAmount(
                        rs.getDouble("total_amount"));
                    order.setStatus(rs.getString("status"));
                    order.setPaymentMode(
                        rs.getString("payment_mode"));

                    return order;
                }
            }

        } catch (SQLException e) {
            throw new RuntimeException(
                "Unable to retrieve order.", e);
        }

        return null;
    }

    @Override
    public List<Orders> getOrdersByRestaurantId(int restaurantId) {

        List<Orders> orderList = new ArrayList<>();

        String sql =
            "SELECT order_id, restaurant_id, user_id, order_date, " +
            "total_amount, status, payment_mode " +
            "FROM orders WHERE restaurant_id = ? " +
            "ORDER BY order_date DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, restaurantId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {

                    Orders order = new Orders();

                    order.setOrderId(rs.getInt("order_id"));
                    order.setRestaurantId(
                        rs.getInt("restaurant_id"));
                    order.setUserId(rs.getInt("user_id"));

                    if (rs.getTimestamp("order_date") != null) {
                        order.setOrderDate(
                            rs.getTimestamp("order_date").toString());
                    }

                    order.setTotalAmount(
                        rs.getDouble("total_amount"));
                    order.setStatus(rs.getString("status"));
                    order.setPaymentMode(
                        rs.getString("payment_mode"));

                    orderList.add(order);
                }
            }

        } catch (SQLException e) {
            throw new RuntimeException(
                "Unable to retrieve restaurant orders.", e);
        }

        return orderList;
    }

    @Override
    public void updateOrderStatus(int orderId, String status) {

        String sql =
            "UPDATE orders SET status = ? WHERE order_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, status);
            ps.setInt(2, orderId);

            ps.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(
                "Unable to update order status.", e);
        }
    }
}
