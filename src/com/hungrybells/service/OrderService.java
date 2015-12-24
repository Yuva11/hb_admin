package com.hungrybells.service;
 
public class OrderService {
	public DBService dbService;

	public OrderService() {
		dbService = new DBService();
	}

	public boolean updateOrderPrice(String orderId) {
		String query="update neworderdetails set order_amount=(select sum(amount) from orders where order_id='" + orderId + "' and deleted=0) where order_id='" + orderId + "'";
		int rows=dbService.executeUpdate(query);
	
		if ( rows> 0)
			return true;
		else
			return false;
	}
}