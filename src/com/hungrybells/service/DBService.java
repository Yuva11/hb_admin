package com.hungrybells.service;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
public class DBService {
	final String mysqlUser="root",mysqlPassword="rootwise";
	public ResultSet resultSet;
	public java.sql.PreparedStatement preparedStatement; 
	public java.sql.Connection connection;
	public DBService() {
		try {
			Class.forName("com.mysql.jdbc.Driver"); 
			//local 
			connection=DriverManager.getConnection("jdbc:mysql://localhost:3306/hb_10018r1",mysqlUser,mysqlPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public ResultSet executeQuery(String query){
		try {
			preparedStatement=connection.prepareStatement(query);
			resultSet=preparedStatement.executeQuery();
			preparedStatement.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			resultSet=null;
		}
		
		return resultSet;
	}
	
	public int executeUpdate(String query){
		try {
			preparedStatement=connection.prepareStatement(query);
			int rows= preparedStatement.executeUpdate();
			preparedStatement.close();
			return rows;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return 0;
		}
	}
}