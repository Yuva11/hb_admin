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
<%@page import="org.apache.commons.httpclient.methods.StringRequestEntity"%>

<%@page import="org.codehaus.jettison.json.JSONObject.*"%>
<%@page import="com.google.gson.*"%>
<%@page import="com.sun.jersey.api.client.Client"%>
<%@page import="com.sun.jersey.api.client.ClientHandlerException"%>
<%@page import="com.sun.jersey.api.client.ClientRequest"%>
<%@page import="com.sun.jersey.api.client.ClientResponse"%>
<%@page import="com.sun.jersey.api.client.WebResource"%>
<%@page import="com.sun.jersey.api.client.filter.ClientFilter"%>
<%@page import="com.sun.jersey.api.client.filter.GZIPContentEncodingFilter"%>
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

	<%
		String orderid = request.getParameter("orderid");
	
	PreparedStatement ps = null;
	ResultSet rs = null;
	
	try {

		ps = con.prepareStatement("update neworderdetails set delivery_status=? where order_id=?");

		ps.setString(1, "Delivered");
		ps.setString(2, orderid);

		ps.executeUpdate();
		
	
	} catch (Exception e) {
		System.out.print(e);
	}
%>
		
		<script>
       alert('Order delivered  by hungry bells team..');
         window.location='neworderdetails.jsp';
</script>
		
	







	</div>














	</div>

	</div>





	</div>
	</div>

	</div>












</body>
</html>