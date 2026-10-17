package com.foodie.util;

import java.sql.Connection;

public class TestConnection {

    public static void main(String[] args) {

        Connection con = null;
		try {
			con = DBConnection.getConnection();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

        if (con != null) {
            System.out.println("SUCCESS: MySQL connection established!");
        } else {
            System.out.println("FAILED: Could not connect to MySQL.");
        }
    }
}