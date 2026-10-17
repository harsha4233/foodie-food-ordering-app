
package com.foodie.controller;

import java.io.IOException;

import com.foodie.daoimpl.MenuDAOImpl;
import com.foodie.model.Cart;
import com.foodie.model.CartItem;
import com.foodie.model.Menu;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/cart")
public class CartController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req,
                          HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        HttpSession session = req.getSession();

        // ADD TO CART
        if ("add".equals(action)) {

            int menuId = Integer.parseInt(req.getParameter("menuId"));

            MenuDAOImpl menuDAO = new MenuDAOImpl();
            Menu menu = menuDAO.getMenuById(menuId);

            if (menu == null) {
                resp.sendError(
                    HttpServletResponse.SC_NOT_FOUND,
                    "Menu item not found."
                );
                return;
            }

            Cart cart = (Cart) session.getAttribute("cart");

            // Create cart if it does not exist
            if (cart == null) {
                cart = new Cart();
            }

            int newRestaurantId = menu.getRestaurantId();

            // If the restaurant changes, clear the previous cart
            if (!cart.getItems().isEmpty()
                    && cart.getRestaurantId() != newRestaurantId) {

                cart.clearCart();
            }

            // Set the current restaurant
            cart.setRestaurantId(newRestaurantId);

            // Add the selected menu item
            CartItem cartItem = new CartItem(menu, 1);
            cart.addItem(cartItem);

            session.setAttribute("cart", cart);

            resp.sendRedirect(
                req.getContextPath()
                + "/menu?restaurantId="
                + newRestaurantId
            );
            return;
        }

        // UPDATE CART
        else if ("update".equals(action)) {

            int menuId = Integer.parseInt(req.getParameter("menuId"));
            int quantity = Integer.parseInt(req.getParameter("quantity"));

            Cart cart = (Cart) session.getAttribute("cart");

            if (cart != null) {
                CartItem item = cart.getItems().get(menuId);

                if (item != null) {
                    if (quantity > 0) {
                        item.setQuantity(quantity);
                    } else {
                        cart.removeItem(menuId);
                    }
                }

                // Reset restaurant ID when cart becomes empty
                if (cart.getItems().isEmpty()) {
                    cart.setRestaurantId(0);
                }

                session.setAttribute("cart", cart);
            }

            String source = req.getParameter("source");

            if ("menu".equals(source)) {
                String restaurantId = req.getParameter("restaurantId");

                resp.sendRedirect(
                    req.getContextPath()
                    + "/menu?restaurantId="
                    + restaurantId
                );
            } else if ("cart".equals(source)) {
                resp.sendRedirect(req.getContextPath() + "/cart");
            } else {
                resp.sendRedirect(req.getContextPath() + "/cart");
            }

            return;
        }

        // DELETE FROM CART
        else if ("delete".equals(action)) {

            int menuId = Integer.parseInt(req.getParameter("menuId"));

            Cart cart = (Cart) session.getAttribute("cart");

            if (cart != null) {
                cart.removeItem(menuId);

                // Reset restaurant ID when cart becomes empty
                if (cart.getItems().isEmpty()) {
                    cart.setRestaurantId(0);
                }

                session.setAttribute("cart", cart);
            }

            resp.sendRedirect(req.getContextPath() + "/cart");
        }
    }

    @Override
    protected void doGet(HttpServletRequest req,
                         HttpServletResponse resp)
            throws ServletException, IOException {

        RequestDispatcher rd =
            req.getRequestDispatcher("/cart.jsp");

        rd.forward(req, resp);
    }
}
