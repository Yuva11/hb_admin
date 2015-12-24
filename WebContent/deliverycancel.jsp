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
		
		 PreparedStatement ps1 = null;
		 ResultSet rs1 = null;
		 
			OpinioPostOrderCancel opinioPostOrder=new OpinioPostOrderCancel();
			opinioPostOrder.setOrder_code(orderid);
		//	opinioPostOrder.setIs_cancelled("1");
			Map<String, String> map=OpinioUtilsC.getPostAuthentication(opinioPostOrder);
			String canonicalString=map.get("canonicalString");
			String canonicalString1=canonicalString.substring(1,15);
			String Authorization=map.get("authorization");
			System.out.println("canonicalString --  "+canonicalString1+"  orderid - "+orderid);
			System.out.println("authorization --  "+map.get("authorization"));
			String result=null;
			try
			{
			result=OpinioHelper.postOrderToOpinioCancel(canonicalString1, "http://test.deliver.opinioapp.com/api/v1/orders/"+orderid,Authorization);
			System.out.println(result);
		
		/* 	OpinioResponseVo opinio=null;
        	ObjectMapper mapper11 = new ObjectMapper();
        
        	opinio = mapper11.readValue(result,OpinioResponseVo.class);
       	 	ps1 = con.prepareStatement("update neworderdetails set delivery_status=? where  order_id=?");
      	    ps1.setString(1,"cancelled");
      		ps1.setString(2, orderid);
		    ps1.executeUpdate();
			
		    con.close(); 
			 */
			out.print(result);
			
			}
			catch(Exception ek)
			{
				out.print("Status : "+result);
			}
	
	
	


				
				
				
		
		%>

	<script>
		alert('Order delivered by hungry bells team..');
		window.location = 'neworderdetails.jsp';
	</script>














	</div>














	</div>

	</div>





	</div>
	</div>

	</div>












</body>
</html>