<%@page import="java.util.Map"%>
<%@page import="newservice.OpinioHelper"%>
<%@page import="newservice.OpinioUtils"%>
<%@page import="newservice.OpinioPostOrder"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<%
    	OpinioPostOrder opinioPostOrder=new OpinioPostOrder();
		opinioPostOrder.setMerchant_id("3");
		opinioPostOrder.setAmount(250);
		opinioPostOrder.setAmount_to_pay(250);
		opinioPostOrder.setPhone("7411446750");
		opinioPostOrder.setAddress("Testing");
		opinioPostOrder.setLocality("test");
		opinioPostOrder.setOrder_code("10");
		
		Map<String, String> map=OpinioUtils.getPostAuthentication(opinioPostOrder);
		String canonicalString=map.get("canonicalString");
		String Authorization=map.get("authorization");
		
		String result=OpinioHelper.postOrderToOpinio(canonicalString, "http://test.deliver.opinioapp.com/api/v1/orders",Authorization);
		System.out.println(result);
		out.print(result);

%>
</body>
</html>