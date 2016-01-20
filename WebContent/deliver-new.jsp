<%@page import="com.sun.jersey.api.client.filter.ClientFilter"%>
<%@page import="org.apache.xmlbeans.impl.xb.xsdschema.Public"%>
<%@page import="com.fasterxml.jackson.databind.ObjectMapper"%>
<%@page import="java.sql.ResultSet"%>
<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>
<%@page import="java.text.*"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.Date"%>
<%@include file="getcon.jsp"%>
<%@page import="org.springframework.web.client.*"%>
<%@page import="org.springframework.http.*"%>

<%@page import="javax.mail.*"%>
<%@page import="javax.mail.internet.*"%>
<%@page import="org.json.*"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.apache.commons.httpclient.HttpClient"%>
<%@page import="org.apache.commons.httpclient.methods.PostMethod"%>
<%@page import="java.util.Map"%>
<%@page import="newservice.OpinioHelper"%>
<%@page import="newservice.OpinioUtils"%>
<%@page import="newservice.OpinioPostOrder"%>


<%@page
	import="org.apache.commons.httpclient.methods.StringRequestEntity"%>

<%@page import="org.codehaus.jettison.json.JSONObject.*"%>
<%@page import="com.google.gson.*"%>
<%@page import="com.sun.jersey.api.client.Client"%>
<%@page import="com.sun.jersey.api.client.ClientHandlerException"%>
<%@page import="com.sun.jersey.api.client.ClientRequest"%>
<%@page import="com.sun.jersey.api.client.ClientResponse"%>
<%@page import="com.sun.jersey.api.client.WebResource"%>
<%@page import="com.sun.jersey.api.client.filter.ClientFilter"%>
<%@page
	import="com.sun.jersey.api.client.filter.GZIPContentEncodingFilter"%>
<%@page import="org.codehaus.jackson.type.*"%>
<jsp:useBean id="test" class="newservice.RoadrunnerApi"></jsp:useBean>
<%@page import="newservice.*"%>






<!doctype html>
<html class="no-js">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>Hungry Bells Order Confirmation</title>
</head>

<body>
	<%!private static String user = "hungrybells@getwise.in";
	private static String password = "GetWise#1";
	static Properties props = new Properties();%>

	<%
		String orderid = request.getParameter("orderid");
		String orderdate = request.getParameter("orderdate");
		String amount = request.getParameter("amount");
		String quantity = request.getParameter("quantity");
		//String status = request.getParameter("status");
		String merchant_name = request.getParameter("merchant_name");
		String merchantbranch_id = request.getParameter("merchantbranch_id");
		String user_name = request.getParameter("user_name");
		String cust_mob = request.getParameter("cust_mob");
		String cust_email = request.getParameter("cust_email");
		String address = request.getParameter("address");
		String merchant_mob = request.getParameter("merchant_mob");
		String merchant_email = request.getParameter("merchant_email");
		String deal_name = request.getParameter("deal_name");
		String delivery_type = request.getParameter("delivery_type");
		String longitude=request.getParameter("longitude");
		String latitude=request.getParameter("latitude");
		String delivery_address=request.getParameter("delivery_address");
		String landmark=request.getParameter("landmark");
		String branch_address=request.getParameter("branch_address");
		String branch_longitude1=request.getParameter("branch_longitude1");
		String branch_lattitue1=request.getParameter("branch_lattitue1");
		String deliveryagentname=request.getParameter("deliveryagentname");
		
		 PreparedStatement ps1 = null;
		 ResultSet rs1 = null;
		 PreparedStatement ps4 = null;
		 ResultSet rs4 = null;
		 PreparedStatement ps44 = null;
		 ResultSet rs44 = null;
	//api for roadrunner....
	if(deliveryagentname.equals("RoadRunnr"))	
	{
try {	
			HashMap<String, String> hm = new HashMap<String, String>();
			hm.put("lat", latitude);
			hm.put("lng", longitude);
			
			String response11=null;
			String location=null;
			String URL = "http://service.hungrybells.in:9090/location/currentlocation";
			
			try{
			HttpClient httpClient = new HttpClient();
			PostMethod postMethod = new PostMethod(URL);
			postMethod.addRequestHeader("Content-Type", "application/json");
			JSONObject jsonObj =new JSONObject(hm);
			String content=jsonObj.toJSONString();
			StringRequestEntity sre = new StringRequestEntity(content);
			postMethod.setRequestEntity(sre);
			httpClient.executeMethod(postMethod);
			response11=postMethod.getResponseBodyAsString();
			location =response11;//location/locality
			
			System.out.println("------location -------------"+location);
			
			}catch(Exception ex){
				ex.printStackTrace();
			}
			
			//map object for roadrunner
			
			Map map=new LinkedHashMap();
			JSONObject json = new JSONObject();
			Map<Object, Object> headMap=new LinkedHashMap<Object, Object>();
			Map<Object, Object> pickup=new LinkedHashMap<Object, Object>();
			Map<Object, Object> pickupuser=new LinkedHashMap<Object, Object>();
			Map<Object, Object> pickupuservalue=new LinkedHashMap<Object, Object>();
			Map<Object, Object> pickup_userfull_address=new LinkedHashMap<Object, Object>();
			Map<Object, Object> pickup_userfull_addressgeo=new LinkedHashMap<Object, Object>();
			Map<Object, Object> pickup_userfull_addresssub_locality=new LinkedHashMap<Object, Object>();
			Map<Object, Object> pickup_userfull_addresslocality=new LinkedHashMap<Object, Object>();
			Map<Object, Object> pickup_userfull_addresscity=new LinkedHashMap<Object, Object>();
			
			
			Map<Object, Object> dropuser=new LinkedHashMap<Object, Object>();
			Map<Object, Object> dropuservalue=new LinkedHashMap<Object, Object>();
			Map<Object, Object> drop_userfull_address=new LinkedHashMap<Object, Object>();
			Map<Object, Object> drop_userfull_addressgeo=new LinkedHashMap<Object, Object>();
			Map<Object, Object> drop_userfull_addresssub_locality=new LinkedHashMap<Object, Object>();
			Map<Object, Object> drop_userfull_addresslocality=new LinkedHashMap<Object, Object>();
			Map<Object, Object> drop_userfull_addresscity=new LinkedHashMap<Object, Object>();
			
			pickupuservalue.put("external_id",orderid);
			pickupuservalue.put("email", merchant_email);
			pickupuservalue.put("phone_no", merchant_mob);
			pickupuservalue.put("name", merchant_name);
			
			pickup_userfull_addressgeo.put("longitude", branch_longitude1);
			pickup_userfull_addressgeo.put("latitude", branch_lattitue1);
			
			
			pickup_userfull_address.put("geo", pickup_userfull_addressgeo);
			pickup_userfull_address.put("address", branch_address);
			
			pickup_userfull_addresssub_locality.put("name","");
			
			pickup_userfull_address.put("sub_locality", pickup_userfull_addresssub_locality);
			
			pickup_userfull_addresslocality.put("name", "");
			
			pickup_userfull_address.put("locality", pickup_userfull_addresslocality);
			
			pickup_userfull_addresscity.put("name", "Bangalore");
			
			pickup_userfull_address.put("city", pickup_userfull_addresscity);
			
			pickupuservalue.put("full_address",pickup_userfull_address);
			pickupuservalue.put("type", "merchant");
			
			pickupuser.put("user", pickupuservalue);
			////////close pickup
			//start drop
			
			dropuservalue.put("external_id",orderid);
			dropuservalue.put("email", cust_email);
			dropuservalue.put("phone_no", cust_mob);
			dropuservalue.put("name", user_name);
			
			drop_userfull_addressgeo.put("longitude", longitude);
			drop_userfull_addressgeo.put("latitude", latitude);
			
			
			drop_userfull_address.put("geo", drop_userfull_addressgeo);
			drop_userfull_address.put("address", delivery_address);
			
			drop_userfull_addresssub_locality.put("name","");
			
			drop_userfull_address.put("sub_locality",drop_userfull_addresssub_locality);
			
			drop_userfull_addresslocality.put("name", "");
			
			drop_userfull_address.put("locality",drop_userfull_addresslocality);
			
			drop_userfull_addresscity.put("name", "Bangalore");
			
			drop_userfull_address.put("city", drop_userfull_addresscity);
			
			dropuservalue.put("full_address",drop_userfull_address);
			dropuservalue.put("type", "merchant");
			
			dropuser.put("user", dropuservalue);
			
			//close pickup or drop
			//start order details
			Map<Object, Object> order_details=new LinkedHashMap<Object, Object>();
			//Map<Object, Object> order_items=new Hashtable<Object, Object>();
			Map<Object, Object> order_type=new LinkedHashMap<Object, Object>();
			if(delivery_type.equals("PAYU") || delivery_type.equals("FO"))
			{
		    	order_details.put("amount_to_be_collected", "0.0");
		    	order_details.put("order_value", amount);
			}
			else if(delivery_type.equals("COD"))
			{
		    	order_details.put("amount_to_be_collected", ""+amount);
		    	order_details.put("order_value", amount);
				
			}
			ArrayList<Object> oitems=new ArrayList<Object>();
			//multiple deal list
			String dealName=null;
			String DealName=null;
					try 
			           {
						ps4 = con.prepareStatement("SELECT  * FROM orders where order_id=?");
						ps4.setString(1, orderid);
                    	rs4 = ps4.executeQuery();
            			while (rs4.next()) 
						{
            				HashMap<Object, Object> order_items=new HashMap<Object, Object>();
            		        order_items.put("price", rs4.getString("amount"));
            		    	Map<Object, Object> order_items_item=new LinkedHashMap<Object, Object>();
            				order_items_item.put("name",rs4.getString("deal_name"));
            				order_items.put("quantity", rs4.getString("quantity"));
                    		order_items.put("item", order_items_item);
            					oitems.add(order_items);
                			 }
					     }catch(Exception e)
			              {
						       e.printStackTrace();
			               }
			order_details.put("order_items", oitems);
			order_details.put("order_id", orderid);
			order_type.put("name", delivery_type);
			order_details.put("order_type", order_type);
			Date date=null;
			SimpleDateFormat dateFormat=null;
			try
	    	{
	    	 dateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ssXXX");
	    	 date=new Date();
	    	 System.out.println("---u-------------"+dateFormat.format(date));
	    	}
	    	catch(Exception e)
	    	{
	    	}
			//map is a Main Map start
			map.put("pickup", pickupuser);
			map.put("drop", dropuser);
			map.put("created_at",""+dateFormat.format(date));
			map.put("order_details", order_details);
			map.put("callback_url", "http://service.hungrybells.in:9090/HBAppService/trackDeliveryStatusRoadrunnr.do");
			//map is a Main Map close
			json.put("aa", map);
		      Gson gson=new Gson();
		           String tokenno=null;
		           String auth_token_for_login=null;
		           System.out.println("kkkk----  "+gson.toJson(map));
		           try
		           {
		           RoadRunnrLogin roadRunnrLogin=new RoadRunnrLogin();
		           String loginforRR= roadRunnrLogin.getAddress("GCeHVua42z215RJStMzU3EZAPIl0Gj4C0ZVH9ONv", "K0fc7nE1bYMjHAtJw7ukAUauThBW5CmH1faaNC0N");
		           
		                RoadRunnerLoginVo roadRunnerLoginVo=null;
	                	ObjectMapper mapper1 = new ObjectMapper();
	                	roadRunnerLoginVo = mapper1.readValue(loginforRR,RoadRunnerLoginVo.class);
	                	auth_token_for_login=roadRunnerLoginVo.getAccess_token();
	                	System.out.println(roadRunnerLoginVo);
	                	
	                	
		           }catch(Exception ek){ek.printStackTrace();}
					String result=test.postDataRadRunn(gson.toJson(map), "http://roadrunnr.in/v1/orders/ship",auth_token_for_login);
				    System.out.println("kkkk--Roadrunner_Ship_ID-"+result);
					out.print(result);
                    RoadrunnrVO roadrunnrVO=null;
                	ObjectMapper mapper = new ObjectMapper();
                	roadrunnrVO = mapper.readValue(result,RoadrunnrVO.class);
                	System.out.print("-dss-sdsdsd- "+roadrunnrVO.getOrder_id());
            	 	ps1 = con.prepareStatement("update neworderdetails set delivery_status=?,delivery_ship_id=?,delivery_agent_name=?,order_status=?  where  order_id=?");
            	 	ps1.setString(1,"assigned");
             	    ps1.setString(2,""+roadrunnrVO.getOrder_id());
     	     	    ps1.setString(3,""+deliveryagentname);
     	     	    ps1.setString(4, "assigned");
        			ps1.setString(5, orderid);
	            	ps1.executeUpdate();
                	con.close();
         } catch (Exception e) {
        	 
        	    System.out.print(e);

		}	
	
	}
	 
	 
	 /////////townrush api integration/////////////////////////////////
	 
	 if(deliveryagentname.equals("TownRush"))
	 {
		 	 try {	
				HashMap<String, String> hm = new HashMap<String, String>();
				hm.put("lat", latitude);
				hm.put("lng", longitude);
				String response11=null;
				String location=null;
				String URL = "http://service.hungrybells.in:9090/location/currentlocation";
				try{
				HttpClient httpClient = new HttpClient();
				PostMethod postMethod = new PostMethod(URL);
				postMethod.addRequestHeader("Content-Type", "application/json");
				JSONObject jsonObj =new JSONObject(hm);
				String content=jsonObj.toJSONString();
				StringRequestEntity sre = new StringRequestEntity(content);
				postMethod.setRequestEntity(sre);
				httpClient.executeMethod(postMethod);
				response11=postMethod.getResponseBodyAsString();
				location =response11;//location/locality
				System.out.println("------location -------------"+location);
				}catch(Exception ex){
					ex.printStackTrace();
				}
				//map object for roadrunner
		    Map map=new LinkedHashMap();
			JSONObject json = new JSONObject();
			Map<Object, Object> headMap=new LinkedHashMap<Object, Object>();
			Map<String, Object>  user=new LinkedHashMap<String, Object>();
			Map<String, Object> user_address=new LinkedHashMap<String, Object>();
			Map<String, Object> user_address_locality=new LinkedHashMap<String, Object>();
			Map<String, Object> user_address_city=new LinkedHashMap<String, Object>();
			Map<String, Object> orderType=new LinkedHashMap<String, Object>();
			Map<String, Object> orderType_Name=new LinkedHashMap<String, Object>();
			Map<String, Float> pickup_location=new LinkedHashMap<String, Float>();
			Map<String, Object> drop_address=new LinkedHashMap<String, Object>();
			
			Map<String, Object> pickup_addess=new LinkedHashMap<String, Object>();
			Map<String, Object> order_items=new LinkedHashMap<String, Object>();
			
			Date date=null;
			SimpleDateFormat dateFormat=null;
			try
	    	{
	    	 dateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ssXXX");
	    	 date=new Date();
	    	System.out.println("---u-------------"+dateFormat.format(date));
	    	}
	    	catch(Exception e)
	    	{
	    		
	    	}
			map.put("shipment_id", orderid);
			map.put("creator_organisation", "044da853");
			map.put("callback_url", "http://service.hungrybells.in:9090/HBAppService/trackDeliveryStatus.do");
			map.put("weight",new Float(2.0));
			map.put("item_count", new Integer(quantity));
			
			if(delivery_type.equals("COD"))
			{
		       map.put("delivery_type", delivery_type.toLowerCase());
			}
		    
			if(delivery_type.equals("PAYU") || delivery_type.equals("FO"))
			{
		        map.put("delivery_type", "prepaid");
		     	map.put("collectible_amount", new Float(0.0));
			}
			else
			{
		     	map.put("collectible_amount", Float.parseFloat(amount));
			}
		    
		    
	        map.put("drop_after",dateFormat.format(date));
			map.put("drop_deadline",dateFormat.format(date));
		
			//merchant details
			user.put("name", merchant_name);
			user.put("phone_number", merchant_mob);
			user.put("flat", "");
			user.put("building", "");
			user.put("street", "");
			user.put("landmark", "");
			user.put("area", branch_address);
			user.put("zip_code", new Integer(560068));
			
            pickup_location.put("lat", new Float(branch_lattitue1));
			pickup_location.put("lon", new Float(branch_longitude1));
			
			user.put("location", pickup_location);
			
			map.put("pickup_address", user);
			
			//user deatils
			
				user_address.put("name", user_name);
				user_address.put("phone_number", cust_mob);
				user_address.put("flat", "");
				user_address.put("building", "");
				user_address.put("street", "");
				user_address.put("landmark", landmark);
				user_address.put("area", delivery_address);
				user_address.put("zip_code",new Integer(560068));

				drop_address.put("lat", new Float(12.6));
				drop_address.put("lon", new Float(72.6));
				
				user_address.put("location", drop_address);
				map.put("drop_address", user_address);
				json.put("aa", map);
				System.out.println("---json format......."+json);
				//login
			    System.out.println("---login for townrush------------");
					Map<String, String>  logintownrush=new LinkedHashMap<String, String>();
				
					logintownrush.put("username", "hungry");
					logintownrush.put("password", "bells");
					String secur_auth=null;
				    String logincode = HttpRequestor.getHttpResponseWithJsonPayLoad("http://www.townrush.in/api/v1/login", logintownrush);
					  System.out.println("---login for townrush------------"+logincode);
							  
				         TownRushResponse townrushVO=null;
		                	ObjectMapper mapper1 = new ObjectMapper();
		                 	townrushVO = mapper1.readValue(logincode,TownRushResponse.class);
		                 	
		                 	if(townrushVO.getCode().equals("login_successful"));
		                 	{
		                 		secur_auth=townrushVO.getParams().getSecure_auth();
		                 		
			                    Gson gson=new Gson();
			                    String tokenno=null;
								String result=test.postData(gson.toJson(map), "http://www.townrush.in/api/v1/shipments",secur_auth);
								TownRushVo townrushVo=null;
			                	ObjectMapper mapper11 = new ObjectMapper();
			                    townrushVo = mapper11.readValue(result,TownRushVo.class);
			               	 	ps1 = con.prepareStatement("update neworderdetails set delivery_status=?,delivery_ship_id=?,delivery_agent_name=?  where  order_id=?");
			              	    ps1.setString(1,"assigned");
			              	    ps1.setString(2,""+townrushVo.getShipment_id());
	             	     	    ps1.setString(3,""+deliveryagentname);
	                			ps1.setString(4, orderid);
	            			    ps1.executeUpdate();
	                			
	                		 con.close(); 
	             
			                }
		               
		                 
				
				
				
				//login completed
				
		/* 		
	                    Gson gson=new Gson();
	                    String tokenno=null;
						String result=test.postData(gson.toJson(map), "http://www.whitekoalastaging.in/api/v1/shipments","pvmg3sr3y9tsd5e3");
						
	 */			/* 		String getShipingid=test.getData("http://www.whitekoalastaging.in/api/v1/shipment/SHHMD85N");
					    System.out.println("kkkk"+result);
	                    System.out.println("---shiping id"+getShipingid);
	                 
	            */          
	                /*     RoadrunnrVO roadrunnrVO=null;
	                	ObjectMapper mapper = new ObjectMapper();
	                    
	                	roadrunnrVO = mapper.readValue(result,RoadrunnrVO.class);
	                 	System.out.print("-shipment id --------for township--- "+roadrunnrVO.getShipment_id());
	                  	 	ps1 = con.prepareStatement("update neworderdetails set roadrunner_id=?  where  order_id=?");
	             	     	    ps1.setString(1,""+roadrunnrVO.getId());
	                			ps1.setString(2, orderid);
	            			ps1.executeUpdate();
	                		 con.close(); */
	         } catch (Exception e) {
	        	    System.out.print(e);
			}	
	 }
	 ///////////////////oooooooooionio//////////////////////
	 if(deliveryagentname.equals("Opinio"))
	 {
		        String merchanr_id=null;
    			HashMap<String, String> hm = new HashMap<String, String>();
				hm.put("lat", latitude );
				hm.put("lng",longitude );
				System.out.println("lat/long : "+latitude+" "+longitude);
				String response11=null;
				String location=null;
				String URL = "http://service.hungrybells.in:9090/location/currentlocation";
				try
				{
				HttpClient httpClient = new HttpClient();
				PostMethod postMethod = new PostMethod(URL);
				postMethod.addRequestHeader("Content-Type", "application/json");
				JSONObject jsonObj =new JSONObject(hm);
				String content=jsonObj.toJSONString();
				StringRequestEntity sre = new StringRequestEntity(content);
				postMethod.setRequestEntity(sre);
				httpClient.executeMethod(postMethod);
				response11=postMethod.getResponseBodyAsString();
				location =response11;//location/locality
				System.out.println("------location ----Opinio---------"+location);
				}catch(Exception ex)
				{
					ex.printStackTrace();
				} 

			OpinioPostOrder opinioPostOrder=new OpinioPostOrder();
			opinioPostOrder.setMerchant_id(merchantbranch_id);
			
			if(delivery_type.equals("PAYU") || delivery_type.equals("FO"))
			{
	         	opinioPostOrder.setAmount(Double.parseDouble(amount));
		    	opinioPostOrder.setAmount_to_pay(Double.parseDouble("0.0"));
			}
			else if(delivery_type.equals("COD"))
			{
		    	opinioPostOrder.setAmount(Double.parseDouble(amount));
		    	opinioPostOrder.setAmount_to_pay(Double.parseDouble(amount));
				
			}
			opinioPostOrder.setPhone(cust_mob);
			opinioPostOrder.setAddress(delivery_address);
			opinioPostOrder.setLocality(location);
			opinioPostOrder.setOrder_code(orderid);
			System.out.println("post detatils "+merchanr_id+" "+" "+amount+" "+cust_mob+" "+delivery_address+" "+orderid+"location - ");
			
			Map<String, String> map=OpinioUtils.getPostAuthentication(opinioPostOrder);
			String canonicalString=map.get("canonicalString");
			String Authorization=map.get("authorization");
			String result=null;
			try
			{
			result=OpinioHelper.postOrderToOpinio(canonicalString, "http://deliver.opinioapp.com/api/v1/orders",Authorization);
			System.out.println(result);
		
			OpinioResponseVo opinio=null;
        	ObjectMapper mapper11 = new ObjectMapper();
        
        	opinio = mapper11.readValue(result,OpinioResponseVo.class);
        	System.out.println("delivery agent-1 "+deliveryagentname);
        	System.out.println("delivery agent- "+deliveryagentname);
       	 	ps1 = con.prepareStatement("update neworderdetails set delivery_status=?,delivery_ship_id=?,delivery_agent_name=?,delivery_boy_name=?,delivery_boy_mob_no=?,order_status=?  where  order_id=?");
      	    ps1.setString(1,"assigned");
      	    ps1.setString(2,""+opinio.getId());
	     	ps1.setString(3,""+deliveryagentname);
	    	ps1.setString(4,""+opinio.getPilot_name());
	    	ps1.setString(5,""+opinio.getPilot_phone());
	    	ps1.setString(6, "assigned");
			ps1.setString(7, orderid);
		    ps1.executeUpdate();
			
		    con.close(); 
			
			out.print(result);
			
			}
			catch(Exception ek)
			{
				out.print("Status : "+result);
			}
	 }

	 /////////////////shodowax///////////////////Shadowfax Api
	 
	 if(deliveryagentname.equals("Shadowfax"))
	 {
		try {	
			HashMap<String, String> hm = new HashMap<String, String>();
			hm.put("lat",latitude );
			hm.put("lng", longitude);
			System.out.print(longitude+" "+latitude);
			String response11=null;
			String location=null;
			String URL = "http://service.hungrybells.in:9090/location/currentlocation";
			try{
			HttpClient httpClient = new HttpClient();
			PostMethod postMethod = new PostMethod(URL);
			postMethod.addRequestHeader("Content-Type", "application/json");
			JSONObject jsonObj =new JSONObject(hm);
			String content=jsonObj.toJSONString();
			StringRequestEntity sre = new StringRequestEntity(content);
			postMethod.setRequestEntity(sre);
			httpClient.executeMethod(postMethod);
			response11=postMethod.getResponseBodyAsString();
			location =response11;//location/locality
			System.out.println("------location -------------"+location);
			}catch(Exception ex){
				ex.printStackTrace();
			}
			
			//map object for shadowfax
			
			Map map=new LinkedHashMap();
			JSONObject json = new JSONObject();
			Map<Object, Object> headMap=new LinkedHashMap<Object, Object>();
			Map<Object, Object> pickup=new LinkedHashMap<Object, Object>();
			Map<Object, Object> pickupuser=new LinkedHashMap<Object, Object>();
			Map<Object, Object> pickupuservalue=new LinkedHashMap<Object, Object>();
			Map<Object, Object> pickup_details=new LinkedHashMap<Object, Object>();
			Map<Object, Object> pickup_userfull_addressgeo=new LinkedHashMap<Object, Object>();
			Map<Object, Object> pickup_userfull_addresssub_locality=new LinkedHashMap<Object, Object>();
			Map<Object, Object> pickup_userfull_addresslocality=new LinkedHashMap<Object, Object>();
			Map<Object, Object> pickup_userfull_addresscity=new LinkedHashMap<Object, Object>();
			
			
			Map<Object, Object> dropuservalue=new LinkedHashMap<Object, Object>();
			Map<Object, Object> drop_details=new LinkedHashMap<Object, Object>();
			Map<Object, Object> drop_userfull_address=new LinkedHashMap<Object, Object>();
			Map<Object, Object> order_details=new LinkedHashMap<Object, Object>();
			Map<Object, Object> drop_userfull_addresssub_locality=new LinkedHashMap<Object, Object>();
			Map<Object, Object> drop_userfull_addresslocality=new LinkedHashMap<Object, Object>();
			Map<Object, Object> drop_userfull_addresscity=new LinkedHashMap<Object, Object>();
			
			headMap.put("client_code","hungry001");
			
			//pichup
			pickup_details.put("name", merchant_name);
			pickup_details.put("contact_number", merchant_mob);
			pickup_details.put("house_number", branch_address);
			pickup_details.put("street", "");
			
			pickup_details.put("locality", location);
			pickup_details.put("city","Bangalore" );
			
			pickup_details.put("latitude",Float.parseFloat(branch_lattitue1));
			pickup_details.put("longitude", Float.parseFloat(branch_longitude1));
			
			
			headMap.put("pickup_details", pickup_details);
			
		  //drop
		
			drop_details.put("name", user_name);
			drop_details.put("contact_number", cust_mob);
			drop_details.put("house_number", delivery_address);
			drop_details.put("street", landmark);
			
			drop_details.put("locality", location);
			drop_details.put("city","Bangalore" );
			
			drop_details.put("latitude",Float.parseFloat(latitude));
			drop_details.put("longitude", Float.parseFloat(longitude));
			
			
			headMap.put("drop_details", drop_details);
			
		    //order details
		    
		    order_details.put("client_order_id", orderid);
		    
		    
		    if(delivery_type.equals("PAYU") || delivery_type.equals("FO"))
			{
		    	order_details.put("order_value",Integer.parseInt(amount));
				order_details.put("paid", "true");
			}
			else if(delivery_type.equals("COD"))
			{
				order_details.put("order_value",Integer.parseInt(amount));
				order_details.put("paid", "false");
				
			}
			order_details.put("preparation_time", "45");
			Date date=null;
			SimpleDateFormat dateFormat=null;
			try
	    	{
	    	 dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	    	 date=new Date();
	    	 System.out.println("---u-------------"+dateFormat.format(date));
	 		order_details.put("scheduled_pickup_time", dateFormat.format(date));
	 		
	    	}
	    	catch(Exception e)
	    	{
	    	}
			headMap.put("order_details", order_details);
			headMap.put("callback_url", "http://sampleUrl.com" );
			//map is a Main Map close
			json.put("aa", headMap);
		      Gson gson=new Gson();
		           String tokenno=null;
		       	ShadowFaxVo shadowFaxVo=null;
		           try
		           {
		            System.out.println("kkkk----  "+gson.toJson(headMap));
					String result=test.postDataShadowFax(gson.toJson(headMap), "http://api.shadowfax.in/api/v1/orders/","003af331aa23577197fb8d16db53a1bc98cbf56c");
				    System.out.println("kkkk--shadowfax result - "+result);
					out.print(result); 
		         	ObjectMapper mapper = new ObjectMapper();
                	shadowFaxVo = mapper.readValue(result,ShadowFaxVo.class);
		           }
		           catch(Exception ek)
		           {
		        	   ek.printStackTrace();
		           }
                	//System.out.print("-dss-sdsdsd- "+roadrunnrVO.getOrder_id());
            	 	ps1 = con.prepareStatement("update neworderdetails set delivery_status=?,delivery_ship_id=?,delivery_agent_name=?,order_status=?  where  order_id=?");
             		System.out.print("-------orderid====="+orderid);
              	    ps1.setString(1,"assigned");
              	    ps1.setString(2,""+shadowFaxVo.getData().getSfx_order_id());
     	     	    ps1.setString(3,""+deliveryagentname);
     	     	    ps1.setString(4,"assigned");
        			ps1.setString(5, orderid);
	            	ps1.executeUpdate();
                	con.close(); 
         } catch (Exception e) {
        	 
        	    System.out.print(e);
		}	
	 }
	 
	 session.setAttribute("msg", "Order assigned");
	// response.sendRedirect("order-dashboard.jsp");
		
			%>

	<script>
		alert('Order delivered by hungry bells team..');
		window.location = 'order-dashboard.jsp';
	</script>














	</div>














	</div>

	</div>





	</div>
	</div>

	</div>




		
