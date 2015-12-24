<%@page import="com.hungrybells.service.*"%>
<%@page import="javassist.bytecode.stackmap.BasicBlock.Catch"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.*"%>
<%@page import="java.text.*"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.Date"%>
<%@include file="getcon.jsp"%>
<%@page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
	
	 
<%
	OrderService orderService=new OrderService();
	final String STATUS_FAILED="failed",STATUS_SUCCESS="success";
	String orderId,deletedStatus;
	long brandId,kitchenId,dishOrderId,dishId,cityId;
	int quantity;
	
	String msg="",status="",responseText="";

	//Get parameter values
	orderId=request.getParameter("orderId");
	
	deletedStatus=request.getParameter("deletedStatus");

	try{
		brandId=Long.parseLong(request.getParameter("brandId"));
	}catch(Exception e){
		brandId=0;
	}
	
	try{
		kitchenId=Long.parseLong(request.getParameter("kitchenId"));
	}catch(Exception e){
		kitchenId=0;
	}
	
	try{
		dishOrderId=Long.parseLong(request.getParameter("dishOrderId"));
	}catch(Exception e){
		dishOrderId=0;
	}
	
	try{
		dishId=Long.parseLong(request.getParameter("dishId"));
	}catch(Exception e){
		dishId=0;
	}

	try{
		cityId=Long.parseLong(request.getParameter("cityId"));
	}catch(Exception exception){
		cityId=0;
	}
	
	try{
		quantity=Integer.parseInt(request.getParameter("quantity"));
	}catch(Exception exception){
		quantity=1;
	}
	
	boolean debug=true;
	//Session check
	String userName = (String) session.getAttribute("uname");
	if (userName == null)
		response.sendRedirect("index.html");

	
	
	String serviceName = request.getParameter("service");
	if(serviceName==null)
		msg="Invalid service name";
		
	ResultSet rs=null; 
	
	if(serviceName.equals("lastOrderId")){
		ps = con.prepareStatement("select max(id) as last_order_id from neworderdetails");
		rs= ps.executeQuery();
		if (rs.next()) {
			status=STATUS_SUCCESS;
			responseText="\"id\":\""+rs.getInt(1)+"\"";
		}
	}else if(serviceName.equals("cities")){
		ps = con.prepareStatement("select id,name from city where deletestatus=0 order by name");
		rs= ps.executeQuery(); 
		int i=0;
		responseText="'cities':[";
		while (rs.next()) {
			responseText+="{'id':'"+rs.getInt("id")+"','name':'"+rs.getString("name")+"'},";
			i++;
		}
		responseText=responseText.substring(0,responseText.lastIndexOf(",")-1);
		responseText+="]";
	}else if(serviceName.equals("kitchens")){
			ps = con.prepareStatement("select id,name from merchant where deletestatus=0 order by name");
			rs= ps.executeQuery();
			int i=0;
			responseText="'kitchens':[";
			while (rs.next()) {
				responseText+="{'id':'"+rs.getInt("id")+"','name':'"+rs.getString("name")+"'},";
				i++;
			}
			responseText=responseText.substring(0,responseText.lastIndexOf(",")-1);
			responseText+="]";
	}else if(serviceName.equals("branches")){
		if(kitchenId<=0)
				msg = "Invalid kitchenId";
		else{
			ps = con.prepareStatement("select id,branch_name from merchantbranch where lower(status)='active' and merchant_id="+kitchenId+" order by branch_name");
			rs= ps.executeQuery();
			responseText="\"branches\":[";
			while (rs.next()) {
				responseText+="{\"id\":\""+rs.getInt("id")+"\",\"name\":\""+rs.getString("branch_name")+"\"},";
			}
			if(responseText.contains(","))
				responseText=responseText.substring(0,responseText.lastIndexOf(","));
			responseText+="]";
		}
	}else if(serviceName.equals("orderRemarks")){
		ps = con.prepareStatement("update neworderdetails set remarks='"+request.getParameter("remarks")+"' where order_id='"+orderId+"'");
		int i=ps.executeUpdate();
		if(i>0)
			responseText="\"result\":{\"status\":\"success\"}";
		else
			responseText="\"result\" :{\"status\":\"failed\"}";
		
	}else if(serviceName.equals("kitchenDetails")){
		if(kitchenId<=0)
			msg = "Invalid kitchenId";
		else{
			ps = con.prepareStatement("select id,branch_name as kitchen_name,merchant_id as brand_id,address,lattitue,longitude,pincode,status,e_mail,mobile_number,alt_mobile_number_one,alt_mobile_number_two,alt_mobile_number_three,alt_email_one,alt_email_two,alt_email_three from merchantbranch where id="+kitchenId);
			rs=ps.executeQuery();
			if(rs.next()){
				responseText="\"id\":\""+rs.getLong("id")+"\",";
				responseText+="\"name\":\""+rs.getString("kitchen_name")+"\",";
				responseText+="\"kitchenId\":\""+rs.getLong("brand_id")+"\",";
				responseText+="\"address\":\""+rs.getString("address").trim()+"\","; 
				responseText+="\"latitude\":\""+rs.getString("lattitue")+"\",";
				responseText+="\"longitude\":\""+rs.getString("longitude")+"\",";
				responseText+="\"pincode\":\""+rs.getString("pincode")+"\",";
				responseText+="\"status\":\""+rs.getString("status").toUpperCase()+"\",";
				
				//Contact numbers array
				String contactNumbers="\""+rs.getString("mobile_number")+"\",";
				if(!(rs.getString("alt_mobile_number_one").equals("") || rs.getString("alt_mobile_number_one").equals("0"))) 
					contactNumbers+="\""+rs.getString("alt_mobile_number_one")+"\",";
				
				if(!(rs.getString("alt_mobile_number_two").equals("") || rs.getString("alt_mobile_number_two").equals("0")))
					contactNumbers+="\""+rs.getString("alt_mobile_number_two")+"\",";
				
				if(!(rs.getString("alt_mobile_number_three").equals("") || rs.getString("alt_mobile_number_three").equals("0")))
					contactNumbers+="\""+rs.getString("alt_mobile_number_three")+"\",";
				
				contactNumbers=contactNumbers.substring(0,contactNumbers.length()-1);
				
				responseText+="\"phone\":["+contactNumbers+"],";
				
				//Email Array
				String emailIds="";
				
				if(rs.getString("e_mail")!=null && !rs.getString("e_mail").equals(""))
					emailIds+="\""+rs.getString("e_mail")+"\",";
				
				if(rs.getString("alt_email_one") !=null && !rs.getString("alt_email_one").equals(""))
					emailIds+="\""+rs.getString("alt_email_one")+"\",";			
				
				if(rs.getString("alt_email_two") !=null && !rs.getString("alt_email_two").equals(""))
					emailIds+="\""+rs.getString("alt_email_two")+"\",";
				
				if(rs.getString("alt_email_three") !=null && !rs.getString("alt_email_three").equals(""))
					emailIds+="\""+rs.getString("alt_email_three")+"\",";
				
				if(emailIds.endsWith(","))
					emailIds=emailIds.substring(0,emailIds.length()-1);
					
				responseText+="\"email\":["+emailIds+"]";
			}
		}
				
	}else if(serviceName.equals("dishes")){
		if(kitchenId<=0)
			responseText = "\"msg\"':\"Invalid kitchenId\"";
		else{
			ps = con.prepareStatement("select id,name,detail_text,recommended,deal_price from deal where status='PUBLISHED' and merchantbranch_id="+kitchenId);
			rs=ps.executeQuery();
			responseText="\"dishes\":[";
			while(rs.next()){
				responseText+="{";
				responseText+="\"id\":\""+rs.getLong("id")+"\",";
				responseText+="\"name\":\""+rs.getString("name")+"\",";
				responseText+="\"description\":\""+rs.getString("detail_text")+"\",";
				responseText+="\"price\":\""+rs.getString("deal_price")+"\",";
				responseText+="\"recommended\":\""+rs.getString("recommended")+"\"";
				responseText+="},";
			}
			responseText=responseText.substring(0, responseText.length()-1);
			responseText+="]";
		}
				
	}else if(serviceName.equals("removeDish")){
		if(dishOrderId>0){
		ps = con.prepareStatement("update orders set deleted=1 where id="+dishOrderId);
		int rows= ps.executeUpdate();
		if(rows>0){
			orderService.updateOrderPrice(orderId);
			status=STATUS_SUCCESS;
		}
		}else{
			msg = "Invalid dishOrderId";
			status=STATUS_FAILED;
		}
	}else if(serviceName.equals("changeKitchen")){
		
		if(orderId==null){
			status=STATUS_FAILED;
			msg="Invalid orderId";
		}
			
		if(kitchenId<=0){
			status=STATUS_FAILED;
			msg="Invalid kitchenId";
		}
		
		if(kitchenId>0 && orderId!=null){
		
			ps = con.prepareStatement("update orders set deleted=1 where order_id='"+orderId+"'");
			int rows= ps.executeUpdate();
			
			if(rows>0)
				status=STATUS_SUCCESS;
		}
				
	}else if(serviceName.equals("addDish")){
		if(dishOrderId>=0){
		ps = con.prepareStatement("insert into orders (order_id,quantity) values('"+orderId+"',"+quantity+")");
		int rows= ps.executeUpdate();
		if(rows>0){
			rs=ps.executeQuery("select max(id) as id from orders where order_id='"+orderId+"'");
			if(rs.next())
				status=STATUS_SUCCESS;
				responseText+="\"dishOrderId\":\""+rs.getLong("id")+"\"";
		
		}
		}else{
			status=STATUS_FAILED;
			msg="Invalid dishorderId";
		}
	}else if(serviceName.equals("updateOrder")){
		if(dishOrderId<=0){
			msg="Invalid dishOrderId";
		}else{
		ps = con.prepareStatement("update orders o set deal_id="+dishId+",amount=(select deal_price from deal where id="+dishId+")*quantity,deal_name=(select name from deal d where d.id="+dishId+"),merchant_name=(select m.name from deal d  join merchantbranch mb on d.merchantbranch_id=mb.id join merchant m on m.id=mb.merchant_id where d.id="+dishId+") where id="+dishOrderId);
		int rows= ps.executeUpdate();
		if(rows>0){
			orderService.updateOrderPrice(orderId); 
			responseText="\"status\":\"success\"";
		}
		}	
	}else if(serviceName.equals("updateQuantity")){
		
		if(dishOrderId<=0){
			status=STATUS_FAILED;
			msg="Invalid dishOrderId";
		}

		ps = con.prepareStatement("update orders o set quantity="+quantity+",amount="+quantity+"*(select deal_price from deal d where d.id=o.deal_id) where id="+dishOrderId);
		int rows= ps.executeUpdate();

		if(rows>0){
			System.out.println(orderService.updateOrderPrice(orderId));
			responseText="\"status\":\"success\"";
		}
	}else if(serviceName.equals("orderSummary")){
		if(orderId!=null){
			String query="select * from orders o join deal d on o.deal_id=d.id where order_id='"+orderId+"' and deleted=0 ";
			if(debug)
				System.out.println(query);
			ps = con.prepareStatement(query);
			rs=ps.executeQuery();
			int orderAmount=0;
			responseText+="\"orderSummary\":{\"orderId\":\""+orderId+"\",\"dishOrders\":[";
			while(rs.next()){
				responseText+="{\"id\":\""+rs.getLong("id")+"\",\"dishId\":\""+rs.getLong("deal_id")+"\",\"dishName\":\""+rs.getString("deal_name")+"\",\"dishPrice\":\""+rs.getInt("deal_price")+"\",\"dishQuantity\":\""+rs.getInt("quantity")+"\"},";
				orderAmount+=rs.getInt("deal_price")*rs.getInt("quantity");
			}
			if(responseText.endsWith(","))
				responseText=responseText.substring(0,responseText.length()-1);
			responseText+="],\"orderAmount\":\""+orderAmount+"\"}";		
	}
	}
	
	String jsonString="\"status\":\""+status+"\"";

	if(!responseText.equals(""))
		jsonString+=","+responseText;	
	
	if(!msg.equals(""))
		jsonString+=","+"\"msg\":\""+msg+"\"";
	
	
	out.println("{"+jsonString+"}");
	if(rs!=null)
		rs.close();
	if(rs!=null)
		ps.close();
	con.close();
	rs = null;
	ps = null;
	con = null;
	
	
%>