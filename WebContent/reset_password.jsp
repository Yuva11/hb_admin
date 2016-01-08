
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="javassist.bytecode.stackmap.BasicBlock.Catch"%>
<%@page import="java.sql.ResultSet"%>

<%@page import="java.sql.*"%>

<%@page import="java.util.*"%>
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

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
PreparedStatement ps = null;
String username = (String) request.getParameter("user_email");
String status = null, email = null;
try {
	HashMap<String, String> hm = new HashMap<String, String>();
	hm.put("user_email", username);
	Gson gson = new Gson();
	String tokenno = null;
	try {
		String result = test
				.postDataRadRunn(
						gson.toJson(hm),
						"http://service.hungrybells.in:9090/HBAppService/resetPassword.do",
						"");
		AdminLoginVO adminloginVo = null;
		ObjectMapper mapper = new ObjectMapper();

		adminloginVo = mapper.readValue(result, AdminLoginVO.class);

		status = adminloginVo.getStatus();
	
	} catch (Exception el) {

	}

	if (status.equals("success")) {
		//session.setAttribute("uname", email);
		/* response.sendRedirect("index.html"); */
		
		%>
		
		<script>
		alert('Your Password Reseted');
		window.location = 'index.html';
	</script>
		
		
		<% 
		
	} 
} catch (Exception e) {
	System.out.print(e);
}
%>

</body>
</html>