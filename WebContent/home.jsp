<%@page import="javassist.bytecode.stackmap.BasicBlock.Catch"%>
<%@page import="java.sql.ResultSet"%>
<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>
<%@page import="java.text.*"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.Date"%>
<%@include file="getcon.jsp"%>
<%@page import="com.sun.jersey.api.client.filter.ClientFilter"%>
<%@page import="org.apache.xmlbeans.impl.xb.xsdschema.Public"%>
<%@page import="com.fasterxml.jackson.databind.ObjectMapper"%>
<%@page import="java.sql.ResultSet"%>

<%@page import="java.sql.*"%>
<%@page import="java.text.*"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.Date"%>
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

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>Hungry Bells</title>
<meta name="description" content="Responsive Admin Web App">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
</head>
<%
	PreparedStatement ps = null;
	String admin = (String) request.getParameter("admin");
	String pass = (String) request.getParameter("pass");
	String status = null, email = null;
	try {
		HashMap<String, String> hm = new HashMap<String, String>();
		hm.put("user_email", admin);
		hm.put("confirm_pass", pass);
		Gson gson = new Gson();
		String tokenno = null;
		try {
			String result = test.postDataRadRunn(
							gson.toJson(hm),
							"http://service.hungrybells.in:9090/HBAppService/adminLoginPanel.do",
							"");
			AdminLoginVO adminloginVo = null;
			ObjectMapper mapper = new ObjectMapper();

			adminloginVo = mapper.readValue(result, AdminLoginVO.class);

			status = adminloginVo.getStatus();
			email = adminloginVo.getEmail();
		} catch (Exception el) {

		}

		if (status.equals("success")) {
			session.setAttribute("uname", email);
			response.sendRedirect("neworderdetails.jsp");
		} else {
			response.sendRedirect("error.jsp");
		}
	} catch (Exception e) {
		System.out.print(e);
	}
%>

</body>
</html>