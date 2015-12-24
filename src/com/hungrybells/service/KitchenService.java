package com.hungrybells.service;

import java.sql.DriverManager;
import java.sql.ResultSet;

import com.mysql.jdbc.PreparedStatement;

public class KitchenService {
	String mysqlUser="root",mysqlPassword="wiseroot";
	
	ResultSet resultSet;
	java.sql.Connection connection;
	PreparedStatement preparedStatement;
	public KitchenService() {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			//local 
			connection=DriverManager.getConnection("jdbc:mysql://localhost:3306/",mysqlUser,mysqlPassword);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
}
