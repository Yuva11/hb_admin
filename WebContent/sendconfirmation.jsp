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
	static Properties props = new Properties();

	ArrayList ar = null;

	ArrayList ar2 = null;

	ArrayList ar1 = null;%>

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
		String longitude = request.getParameter("longitude");
		String latitude = request.getParameter("latitude");
		String merchant_mob1 = request.getParameter("merchant_mob1");
		

		PreparedStatement ps3 = null;
		ResultSet rs3 = null;

		PreparedStatement ps4 = null;
		ResultSet rs4 = null;

		try {
			ps3 = con
					.prepareStatement("SELECT  * FROM orders where order_id=?");
			ps3.setString(1, orderid);
			rs3 = ps3.executeQuery();

			ar = new ArrayList();

			ar2 = new ArrayList();
			while (rs3.next()) {
				ar.add(rs3.getString(6));
				ar2.add(rs3.getString(4));
				System.out.println(rs3.getString(2));

			}
		} catch (Exception ek) {

		}
		try {
			
	SpearSMSUtility smsUtility = new SpearSMSUtility();
	String dishNames="";
	   for(int i=0;i<ar.size();i++)
       {
		   dishNames+= ar.get(i)+"-"+ar2.get(i);
		  if(i<ar.size()-1) 	
		  	dishNames+= ",";
        }
 
	  String smsnewtemplateforMerchant = "HB- Order for "+dishNames+" customer name "+user_name+" Mobile no "+cust_mob+" address "+address+" Order id "+orderid+" payment type "+delivery_type+" amount "+amount+".";
      String smsnewtemplateforCutomer = "Dear Customer your order for "+dishNames+" Order id "+orderid+" is confirmed, Will be delivered shortly. Thanks Hungry Bells";
	
    		  
		System.out.println("SMS Triggering Please Wait......."+merchant_mob);

		smsUtility.process_sms(merchant_mob1, smsnewtemplateforMerchant,"A16208eead890aefe9b73e725cc4eeebe", null, null);

		smsUtility.process_sms(cust_mob, smsnewtemplateforCutomer,"A16208eead890aefe9b73e725cc4eeebe", null, null);

	
			
		} catch (Exception ek) {

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
			msg.setSubject("Order Confirmed");
			
			
			String htmlstring="<html><h6><font color=\"black\" size='2' style="+"background-color:yellow"+">Dear "+merchant_name+",<br><br>Happy to Confirm your Order. Please note the Order details:</font><br></h6>"
					+ "<font color=\"black\" size='2' style="+"background-color:yellow"+"><b>Order reference no:</b>  </font><font color=\"black\" size='2' style="+"background-color:yellow"+">"
					+ orderid
					+ "</font><br><br>"
					 
					;
			
		    	   for(int i=0;i<ar.size();i++)
		           {
			              htmlstring+= "<font color=\"black\" size='2' style="+"background-color:yellow"+"><b>Item: </b> </font> "+"<font color=\"black\" size='2' style="+"background-color:yellow"+">"+ar.get(i)+ " : "+ar2.get(i)+"</font><br><br>";
		            }
		            htmlstring+="<font color=\"black\" size='2' style="+"background-color:yellow"+"><b>Restaurant Name: </b> </font> <font color=\"black\" size='2' style="+"background-color:yellow"+">"
					+ merchant_name
					+ "</font><br><br>"
					+ "<font color=\"black\" size='2' style="+"background-color:yellow"+"><b>Total Amount :</b> </font> <font color=\"black\" size='2' style="+"background-color:yellow"+">"
					+ amount

					+ "</font><br><br>"
					+ "<font color=\"black\" size='2' style="+"background-color:yellow"+"><b>Delivery Type:</b> </font> <font color=\"black\" size='2' style="+"background-color:yellow"+">"
					+ delivery_type
					
					
					+ "</font><br><br>"
					+ "<font color=\"black\" size='2' style="+"background-color:yellow"+"><b>Customer Mob :</b> </font> <font color=\"black\" size='2' style="+"background-color:yellow"+">"
					+ cust_mob
					
					+ "</font><br><br>"
					+ "<font color=\"black\" size='2' style="+"background-color:yellow"+"><b>Address</b>  </font> <font color=\"black\" size='2' style="+"background-color:yellow"+">"
					+ address

					+ "</font><br><br>"
				   + "<font color=\"black\" size='2' style="+"background-color:yellow"+"><b>-----------------------------------------------------------------------------------------------------<br>For any further assistance please reach out to the Hungry Bells Team</b><br>Thank You,<br>Hungry Bells Operations Team<br>Tel:+91 80 8800 2288<br>Email: hungrybells@getwise.in :- </font> <font color=\"black\" size='2' style="+"background-color:yellow"+">"
							

					+ "</html>";
		   
		    msg.setContent(htmlstring, "text/html");
			InternetAddress from = new InternetAddress(user, "Hungry Bells");
			InternetAddress to = new InternetAddress(merchant_email,
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
			msg.setSubject("Order Confirmed");
			

			String htmlstring="<html><h6><font color=\"black\" size='2' style="+"background-color:yellow"+">Dear "+user_name+",<br><br>Happy to Confirm your Order. Please note the Order details:</font><br></h6>"
					+ "<font color=\"black\" size='2' style="+"background-color:yellow"+"><b>Order reference no:</b>  </font><font color=\"black\" size='2' style="+"background-color:yellow"+">"
					+ orderid
					+ "</font><br><br>"
					 
					;
			
		    	   for(int i=0;i<ar.size();i++)
		           {
			              htmlstring+= "<font color=\"black\" size='2' style="+"background-color:yellow"+"><b>Item: </b> </font> "+"<font color=\"black\" size='2' style="+"background-color:yellow"+">"+ar.get(i)+ " : "+ar2.get(i)+"</font><br><br>";
		            }
		            htmlstring+="<font color=\"black\" size='2' style="+"background-color:yellow"+"><b>Restaurant Name: </b> </font> <font color=\"black\" size='2' style="+"background-color:yellow"+">"
					+ merchant_name
					+ "</font><br><br>"
					+ "<font color=\"black\" size='2' style="+"background-color:yellow"+"><b>Total Amount :</b> </font> <font color=\"black\" size='2' style="+"background-color:yellow"+">"
					+ amount

					+ "</font><br><br>"
					+ "<font color=\"black\" size='2' style="+"background-color:yellow"+"><b>Delivery Type:</b> </font> <font color=\"black\" size='2' style="+"background-color:yellow"+">"
					+ delivery_type
					
					
					+ "</font><br><br>"
					+ "<font color=\"black\" size='2' style="+"background-color:yellow"+"><b>Customer Mob :</b> </font> <font color=\"black\" size='2' style="+"background-color:yellow"+">"
					+ cust_mob
					
					+ "</font><br><br>"
					+ "<font color=\"black\" size='2' style="+"background-color:yellow"+"><b>Address</b>  </font> <font color=\"black\" size='2' style="+"background-color:yellow"+">"
					+ address

					+ "</font><br><br>"
				   + "<font color=\"black\" size='2' style="+"background-color:yellow"+"><b>-----------------------------------------------------------------------------------------------------<br>For any further assistance please reach out to the Hungry Bells Team</b><br>Thank You,<br>Hungry Bells Operations Team<br>Tel:+91 80 8800 2288<br>Email: hungrybells@getwise.in :- </font> <font color=\"black\" size='2' style="+"background-color:yellow"+">"
							

					+ "</html>";
		   
		    msg.setContent(htmlstring, "text/html");

			InternetAddress from = new InternetAddress(user, "Hungry Bells");
			InternetAddress to = new InternetAddress(cust_email,"Mr."+user_name.toUpperCase());
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

		PreparedStatement ps1 = null;
		ResultSet rs1 = null;

		try {

			ps = con.prepareStatement("update neworderdetails set order_status=? where order_id=?");

			ps.setString(1, "Confirmed");
			ps.setString(2, orderid);

			ps.executeUpdate();

		} catch (Exception e) {
			System.out.print(e);
		}

		//api for roadrunner....

		/* 
		try {	
		 	//locality code
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
			Map<String, String>  user=new LinkedHashMap<String, String>();
			Map<String, Object> user_address=new LinkedHashMap<String, Object>();
			Map<String, Object> user_address_locality=new LinkedHashMap<String, Object>();
			Map<String, Object> user_address_city=new LinkedHashMap<String, Object>();
			Map<String, Object> orderType=new LinkedHashMap<String, Object>();
			Map<String, Object> orderType_Name=new LinkedHashMap<String, Object>();
			
			Map<String, Object> order_items=new LinkedHashMap<String, Object>();
			
			
			map.put("order_id", orderid);
			map.put("created_at", orderdate);
			map.put("order_value",amount);
			map.put("amount_to_be_collected", amount);
			
			user.put("name", user_name);
			user.put("phone_no", cust_mob);

			
			user_address.put("address", address);
			
			user_address_locality.put("name", location);
			user_address.put("locality",user_address_locality);
			
			user_address_city.put("name", "Bangalore");
			user_address.put("city", user_address_city);
			
			
			orderType_Name.put("name", delivery_type);
			
			
			Map items1=new LinkedHashMap();
			List list=new ArrayList();
			
			order_items.put("quantity", quantity);
			order_items.put("price", amount);
			items1.put("name",deal_name);
			
			
			order_items.put("item", items1);
			list.add(order_items);
			
			
			
			
			map.put("user", user);
			map.put("user_address", user_address);
			map.put("order_type", orderType_Name);
			map.put("order_items", list);
			
			
			
			json.put("aa", map);
			System.out.println("Started.......");
			
			
		            Gson gson=new Gson();
		            String tokenno=null;
					String result=test.postData(gson.toJson(map), "http://128.199.241.199/orders/","iClurONRDgEq70Dhog2Dmb5ZzMuOgkogdtlJ86w3");
					
					
					
		            System.out.println("kkkk"+result);
		         
		            RoadrunnrVO roadrunnrVO=null;
		        	ObjectMapper mapper = new ObjectMapper();
		            
		        	roadrunnrVO = mapper.readValue(result,RoadrunnrVO.class);
		        	
		        	
		        	System.out.print("-dss-sdsdsd- "+roadrunnrVO.getId());
		        	
		   
		     	 	ps1 = con.prepareStatement("update neworderdetails set roadrunner_id=?  where  order_id=?");
		     		System.out.print("-------orderid====="+orderid);
		            	    ps1.setString(1,""+roadrunnrVO.getId());
		        			ps1.setString(2, orderid);
		    			
		        			
		        			ps1.executeUpdate();
		        			
		        		 con.close();
		        		 
		           
		 } catch (Exception e) {
			 
			    System.out.print(e);

		}	
		
		
		

		
		
		 */
	%>

	<script>
		alert('Order confirmed by hungry bells team..');
		window.location = 'neworderdetails.jsp';
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