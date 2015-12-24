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
<%@page import="org.apache.commons.httpclient.methods.StringRequestEntity"%>




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
		String status = request.getParameter("status");
		String merchant_name = request.getParameter("merchant_name");
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
		
		
		System.out.println("customer mob no---======-=-----------------==--======="+cust_mob);
				
		try {
			// merchant message
			Map<String, String> uriVar = new HashMap<String, String>();
			uriVar.put("username", "GetWise");
			uriVar.put("password", "1685131350");
			uriVar.put("sendername", "HBells");
			String orderdate1=orderdate.substring(0, 10);
			//String dealname1=deal_name.
			
            String messagemb = "Dear HBPartner Order  "+orderid+" Date "+orderdate1+"  Qty "+quantity+" from "+user_name+" Mobile No. "+cust_mob+" to be DELIVERED at :"+address+"";
			
			uriVar.put("message", messagemb);
			uriVar.put("mobileno", "7026757618");

			RestTemplate rt = new RestTemplate();

			ResponseEntity<String> response1 = rt.exchange("http://bulksms.mysmsmantra.com:8080/WebSMS/SMSAPI.jsp?username={username}&password={password}&sendername={sendername}&message={message}&mobileno={mobileno}",HttpMethod.GET, null, String.class, uriVar);
			System.out.println("successsssss");

			//ResponseEntity<String> response2 = rt.exchange("http://roadrunnr.in/orders",HttpMethod.POST, null, String.class, uriVar);
			
		} catch (Exception e) {

		}

		try {
			// customer message
			Map<String, String> uriVar = new HashMap<String, String>();
			uriVar.put("username", "GetWise");
			uriVar.put("password", "1685131350");
			uriVar.put("sendername", "HBells");
			// mail send
			String messagemb1 = "Dear Customer Order : "+orderid+"  Qty :"+quantity+" from "+merchant_name+" is CONFIRMED for DELIVERY in 45 min to "+address+"";
		
			uriVar.put("message", messagemb1);
			uriVar.put("mobileno", "7026757618");

			RestTemplate rt = new RestTemplate();

			ResponseEntity<String> response1 = rt.exchange("http://bulksms.mysmsmantra.com:8080/WebSMS/SMSAPI.jsp?username={username}&password={password}&sendername={sendername}&message={message}&mobileno={mobileno}",HttpMethod.GET, null, String.class, uriVar);
			System.out.println("successsssss");

		} catch (Exception e) {

		}

		//email..........................................

		try {
			System.out.println("Email Triggering Please Wait.......");

			props.put("mail.smtp.auth", "true");
			props.put("mail.smtp.starttls.enable", "true");
			props.put("mail.smtp.host", "smtp.gmail.com");
			props.put("mail.smtp.port", "587");

			Session session1 = Session.getInstance(props,
					new javax.mail.Authenticator() {
						protected PasswordAuthentication getPasswordAuthentication() {
							return new PasswordAuthentication(user,
									password);
						}
					});
			Message msg = new MimeMessage(session1);
			msg.setSubject("Hungry Bells");
			msg.setContent(
					"<html><h6><font color=\"black\" size='2' style="+"background-color:yellow"+">Dear "+merchant_name+",<br><br>Happy to Confirm your Order. Please note the Order details:</font><br></h6>"
							+ "<font color=\"black\" size='2' style="+"background-color:yellow"+"><b>Order reference no:</b> :- </font><font color=\"black\" size='2' style="+"background-color:yellow"+">"
							+ orderid
							+ "</font><br><br>"
							+ "<font color=\"black\" size='2' style="+"background-color:yellow"+"><b>Deal Name: </b>:- </font> <font color=\"black\" size='2' style="+"background-color:yellow"+">"
							+ deal_name
							+ "</font><br><br>"
							+ "<font color=\"black\" size='2' style="+"background-color:yellow"+"><b>Restaurant Name: </b>:- </font> <font color=\"black\" size='2' style="+"background-color:yellow"+">"
							+ merchant_name
							+ "</font><br><br>"
							+ "<font color=\"black\" size='2' style="+"background-color:yellow"+"><b>Order Quantity : </b>:- </font> <font color=\"black\" size='2' style="+"background-color:yellow"+">"
							+ quantity

							+ "</font><br><br>"
							+ "<font color=\"black\" size='2' style="+"background-color:yellow"+"><b>Total Amount :</b>:- </font> <font color=\"black\" size='2' style="+"background-color:yellow"+">"
							+ amount

							+ "</font><br><br>"
							+ "<font color=\"black\" size='2' style="+"background-color:yellow"+"><b>Delivery Type:</b>:- </font> <font color=\"black\" size='2' style="+"background-color:yellow"+">"
							+ delivery_type
							
							+ "</font><br><br>"
							+ "<font color=\"black\" size='2' style="+"background-color:yellow"+"><b>Address</b> :- </font> <font color=\"black\" size='2' style="+"background-color:yellow"+">"
							+ address

							+ "</font><br><br>"
						   + "<font color=\"black\" size='2' style="+"background-color:yellow"+"><b>-----------------------------------------------------------------------------------------------------<br>For any further assistance please reach out to the Hungry Bells Team</b><br>Thank You,<br>Hungry Bells Operations Team<br>Tel:+91 80 8800 2288<br>Email: hungrybells@getwise.in :- </font> <font color=\"black\" size='2' style="+"background-color:yellow"+">"
									

							+ "</html>", "text/html");

			InternetAddress from = new InternetAddress(user, "Hungry Bells");
			InternetAddress to = new InternetAddress("bheem@getwise.in",
					"Mr."+merchant_name.toUpperCase());
			msg.addRecipient(Message.RecipientType.TO, to);
			msg.setFrom(from);

			Transport transport = session1.getTransport("smtp");
			transport.connect(user, password);
			transport.sendMessage(msg, msg.getAllRecipients());
			transport.close();
			System.out.println("!! Email Triggered !!");

		} catch (Exception e) {
			e.printStackTrace();
		}

		try {
			System.out.println("Email Triggering Please Wait.......");

			props.put("mail.smtp.auth", "true");
			props.put("mail.smtp.starttls.enable", "true");
			props.put("mail.smtp.host", "smtp.gmail.com");
			props.put("mail.smtp.port", "587");

			Session session1 = Session.getInstance(props,
					new javax.mail.Authenticator() {
						protected PasswordAuthentication getPasswordAuthentication() {
							return new PasswordAuthentication(user,
									password);
						}
					});
			Message msg = new MimeMessage(session1);
			msg.setSubject("Hungry Bells");
			msg.setContent(
					"<html><h6><font color=\"black\" size='2' style="+"background-color:yellow"+">Dear "+user_name+",<br><br>Happy to Confirm your Order. Please note the Order details:</font><br></h6>"
							+ "<font color=\"black\" size='2' style="+"background-color:yellow"+"><b>Order reference no:</b> :- </font><font color=\"black\" size='2' style="+"background-color:yellow"+">"
							+ orderid
							+ "</font><br><br>"
							+ "<font color=\"black\" size='2' style="+"background-color:yellow"+"><b>Deal Name: </b>:- </font> <font color=\"black\" size='2' style="+"background-color:yellow"+">"
							+ deal_name
							+ "</font><br><br>"
							+ "<font color=\"black\" size='2' style="+"background-color:yellow"+"><b>Restaurant Name: </b>:- </font> <font color=\"black\" size='2' style="+"background-color:yellow"+">"
							+ merchant_name
							+ "</font><br><br>"
							+ "<font color=\"black\" size='2' style="+"background-color:yellow"+"><b>Order Quantity : </b>:- </font> <font color=\"black\" size='2' style="+"background-color:yellow"+">"
							+ quantity

							+ "</font><br><br>"
							+ "<font color=\"black\" size='2' style="+"background-color:yellow"+"><b>Total Amount :</b>:- </font> <font color=\"black\" size='2' style="+"background-color:yellow"+">"
							+ amount

							+ "</font><br><br>"
							+ "<font color=\"black\" size='2' style="+"background-color:yellow"+"><b>Delivery Type:</b>:- </font> <font color=\"black\" size='2' style="+"background-color:yellow"+">"
							+ delivery_type
							
							+ "</font><br><br>"
							+ "<font color=\"black\" size='2' style="+"background-color:yellow"+"><b>Address</b> :- </font> <font color=\"black\" size='2' style="+"background-color:yellow"+">"
							+ address

							+ "</font><br><br>"
						   + "<font color=\"black\" size='2' style="+"background-color:yellow"+"><b>-----------------------------------------------------------------------------------------------------<br>For any further assistance please reach out to the Hungry Bells Team</b><br>Thank You,<br>Hungry Bells Operations Team<br>Tel:+91 80 8800 2288<br>Email: hungrybells@getwise.in :- </font> <font color=\"black\" size='2' style="+"background-color:yellow"+">"
									

							+ "</html>", "text/html");

			InternetAddress from = new InternetAddress(user, "Hungry Bells");
			InternetAddress to = new InternetAddress("bheem@getwise.in",
					"Mr."+user_name.toUpperCase());
			msg.addRecipient(Message.RecipientType.TO, to);
			msg.setFrom(from);

			Transport transport = session1.getTransport("smtp");
			transport.connect(user, password);
			transport.sendMessage(msg, msg.getAllRecipients());
			transport.close();
			System.out.println("!! Email Triggered !!");

		} catch (Exception e) {
			e.printStackTrace();
		}

		PreparedStatement ps = null;
		ResultSet rs = null;

		try {

			ps = con.prepareStatement("update neworderdetails set order_status=? where order_id=?");

			ps.setString(1, "Confirmed");
			ps.setString(2, orderid);

			ps.executeUpdate();
			con.close();
			
		
		} catch (Exception e) {
			System.out.print(e);
		}
		
	//api for roadrunner....
	
	
		
try {	
			Map<String, Object> uriVar = new HashMap<String, Object>();
		
		 	//user details
		 	Map<String,String> userList = new HashMap<String,String>();
		 	userList.put("name", user_name);
		 	userList.put("phone_no", cust_mob);
			
		 	//user address object
		 	
			Map<String,Object> useraddress = new HashMap<String,Object>();
			useraddress.put("address", address);
			
			//address locality
		 	//locality
		 	
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
			
			//locality
			Map<String,Object> locality = new HashMap<String,Object>();
			locality.put("name",location);
			useraddress.put("locality", locality);
			
			//address city
			Map<String,Object> city = new HashMap<String,Object>();
			city.put("name", "Bangalore");
			useraddress.put("city", city);
			
			
				
			
		  	//order type
		  	
		  	Map<String,Object> order_type = new HashMap<String,Object>();
		  	order_type.put("name", delivery_type);
			
	     //order items in array
		  	
		  	ArrayList<Map<String,Object>> order_item = new ArrayList<Map<String,Object>>();
	     
			Map<String,Object> order_item1 = new HashMap<String,Object>();
			
			order_item.add(order_item1);
			
			  	order_item1.put("quantity", quantity);
				order_item1.put("price", amount);
				
				//item
				
				Map<String,Object> item = new HashMap<String,Object>();
			
				item.put("name", deal_name);
			
				
				order_item1.put("item", item);
			
		  	
				
				//fienal value
		  	
			uriVar.put("order_id",orderid);
			uriVar.put("created_at", orderdate);
			uriVar.put("order_value", amount);
		 	uriVar.put("mount_to_be_collected", amount);
		 	uriVar.put("user",userList);	
		 	uriVar.put("user_address",useraddress);
			uriVar.put("order_type",order_type);
			uriVar.put("order_items",order_item);
			 
		 	
	
		
		 //authentication code		
		 			

			Map<String, String> uriVar1 = new HashMap<String, String>();
			//uriVar1.put("grant_type", "RoadRunnrTestAggregator1");
			uriVar1.put("client_id", "LeLYxifFwElodjkuEf05pMKpIbUTrVwrst1eNMnf");
			uriVar1.put("client_secret", "DnBpHV8yByesNU5v94MpvaryOqDFBjMzNHBHQHwU");
			//uriVar1.put("code", "lmXIemhcdfoxiePt7XTk");
			//uriVar1.put("redirect_uri", "http://128.199.241.199/oauth_clients");

			RestTemplate rt = new RestTemplate();
			ResponseEntity<String> response2 = rt.exchange("http://128.199.241.199/merchant",HttpMethod.POST, null, String.class, uriVar1);
            System.out.println("successsssss"+response2);
		  //  uriVar.add(MediaType.APPLICATION_JSON);
		//        HttpHeaders headers = new HttpHeaders();
		      JSONObject json = new JSONObject();
		         json.putAll(uriVar);
		        //json.putAll(uriVar);
                // response.setContentType("application/json");
               //response.setCharacterEncoding("utf-8");
		        // set headers
		        HttpHeaders headers1 = new HttpHeaders();
		        headers1.setContentType(MediaType.APPLICATION_JSON);
		        headers1.set("Authorization", "Token iClurONRDgEq70Dhog2Dmb5ZzMuOgkogdtlJ86w3");
		        System.out.print("=====json================"+json.toString());
		        HttpEntity<Object> entity = new HttpEntity<Object>(json.toString(), headers1);
		       ResponseEntity<String> response23 = rt.exchange("http://128.199.241.199/orders",HttpMethod.POST, entity, String.class, uriVar1);
			//response2.getHeaders().getLocation();
		  //  response2.getStatusCode();
		     String responseBody = response23.getBody();
		     System.out.print("response entity--------------------555555 =============-"+response23);
		  //  Set set=uriVar.entrySet();
		   // Iterator it=set.iterator();
		  //  while(it.hasNext())
		   // {
		   // 	Map.Entry<String,Object> thisEntry =(Map.Entry<String,Object>)it.next();
		   // 	System.out.println("key : -- "+thisEntry.getKey());
		    //	System.out.println("value : -- "+thisEntry.getValue());
		    	//thisEntry.getValue();
		    //}
		    
		   // System.out.println("response body +---- -ln----"+responseBody);
		   
		   
		   //road runner api integration logic
		    	
		        String responseroadrunnr=null;
		        String roadrunnrstatus=null;
		        String roadrunnrurl = "http://roadrunnr.in/orders";

		        try{
		        HttpClient httpClient = new HttpClient();
		        PostMethod postMethod = new PostMethod(roadrunnrurl);
		        postMethod.addRequestHeader("Content-Type", "application/json");
		        JSONObject jsonObj =new JSONObject(uriVar);
		        String content=jsonObj.toJSONString();
		        StringRequestEntity sre = new StringRequestEntity(content);
		        postMethod.setRequestEntity(sre);
		        httpClient.executeMethod(postMethod);
		        responseroadrunnr=postMethod.getResponseBodyAsString();
		        roadrunnrstatus =responseroadrunnr;///responseroadrunnr

		        System.out.println("------roadrunnrstatus -----id--------"+roadrunnrstatus);

		        }catch(Exception ex){
		        	ex.printStackTrace();
		        }



		    
		  
			
		} catch (Exception e) {

		}	
	
	
	

	
	
	
	
	
	
	
				
				
				
				
				
		
		%>
		
		<script>
       alert('Order confirmed by hungry bells team..');
         window.location='neworderdetails.jsp';
</script>
		
		<%
		
		
		
	%>














	</div>














	</div>

	</div>





	</div>
	</div>

	</div>












</body>
</html>