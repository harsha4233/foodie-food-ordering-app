package com.foodie.daoimpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.foodie.dao.RestaurantDAO;
import com.foodie.model.Restaurant;
import com.foodie.util.DBConnection;

public class RestaurantDAOImpl implements RestaurantDAO {

    @Override
    public void addRestaurant(Restaurant restaurant) {

        String sql = "INSERT INTO restaurants "
                + "(name, address, phone_number, cuisine_type, "
                + "delivery_time, admin_user_id, rating, is_active, image_path) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setString(1, restaurant.getName());
            ps.setString(2, restaurant.getAddress());
            ps.setString(3, restaurant.getPhoneNumber());
            ps.setString(4, restaurant.getCuisineType());
            ps.setString(5, restaurant.getDeliveryTime());
            ps.setInt(6, restaurant.getAdminUserId());
            ps.setDouble(7, restaurant.getRating());
            ps.setBoolean(8, restaurant.isActive());
            ps.setString(9, restaurant.getImagePath());

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<Restaurant> getAllRestaurants() {

        List<Restaurant> restaurants = new ArrayList<>();

        String sql = "SELECT * FROM restaurants";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery()
        ) {

            while (rs.next()) {

                Restaurant restaurant = new Restaurant();

                restaurant.setRestaurantId(rs.getInt("restaurant_id"));
                restaurant.setName(rs.getString("name"));
                restaurant.setAddress(rs.getString("address"));
                restaurant.setPhoneNumber(rs.getString("phone_number"));
                restaurant.setCuisineType(rs.getString("cuisine_type"));
                restaurant.setDeliveryTime(rs.getString("delivery_time"));
                restaurant.setAdminUserId(rs.getInt("admin_user_id"));
                restaurant.setRating(rs.getDouble("rating"));
                restaurant.setActive(rs.getBoolean("is_active"));
                restaurant.setImagePath(rs.getString("image_path"));

                restaurants.add(restaurant);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        System.out.println(restaurants.size());
        return restaurants;
    }

    @Override
    public Restaurant getRestaurantById(int restaurantId) {

        String sql = "SELECT * FROM restaurants WHERE restaurant_id = ?";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, restaurantId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                Restaurant restaurant = new Restaurant();

                restaurant.setRestaurantId(rs.getInt("restaurant_id"));
                restaurant.setName(rs.getString("name"));
                restaurant.setAddress(rs.getString("address"));
                restaurant.setPhoneNumber(rs.getString("phone_number"));
                restaurant.setCuisineType(rs.getString("cuisine_type"));
                restaurant.setDeliveryTime(rs.getString("delivery_time"));
                restaurant.setAdminUserId(rs.getInt("admin_user_id"));
                restaurant.setRating(rs.getDouble("rating"));
                restaurant.setActive(rs.getBoolean("is_active"));
                restaurant.setImagePath(rs.getString("image_path"));

                return restaurant;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    @Override
    public void updateRestaurant(Restaurant restaurant) {

        String sql = "UPDATE restaurants SET "
                + "name = ?, "
                + "address = ?, "
                + "phone_number = ?, "
                + "cuisine_type = ?, "
                + "delivery_time = ?, "
                + "admin_user_id = ?, "
                + "rating = ?, "
                + "is_active = ?, "
                + "image_path = ? "
                + "WHERE restaurant_id = ?";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setString(1, restaurant.getName());
            ps.setString(2, restaurant.getAddress());
            ps.setString(3, restaurant.getPhoneNumber());
            ps.setString(4, restaurant.getCuisineType());
            ps.setString(5, restaurant.getDeliveryTime());
            ps.setInt(6, restaurant.getAdminUserId());
            ps.setDouble(7, restaurant.getRating());
            ps.setBoolean(8, restaurant.isActive());
            ps.setString(9, restaurant.getImagePath());
            ps.setInt(10, restaurant.getRestaurantId());

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void deleteRestaurant(int restaurantId) {

        String sql = "DELETE FROM restaurants WHERE restaurant_id = ?";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, restaurantId);

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}