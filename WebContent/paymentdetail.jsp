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
<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
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
<link rel="stylesheet" type="text/css" href="css/style3.css" />
<link rel="stylesheet" href="css/style34.css" media="all">
<link rel="stylesheet" href="css/styles.css">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>Hungry Bells</title>
<meta http-equiv="cleartype" content="on">
<link rel="shortcut icon" href="/favicon.ico">
<!-- Responsive and mobile friendly stuff -->
<meta name="HandheldFriendly" content="True">
<meta name="MobileOptimized" content="320">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<style type="text/css">
#maincontent .col {
	background: #ccc;
	background: rgba(204, 204, 204, 0.85);
}
</style>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.11.2/themes/smoothness/jquery-ui.css">
<script src="js/jquery-1.9.1.js"></script>
<script src="js/jquery-ui.js"></script>

<script>
	$(function() {
		$("#datepicker").datepicker({dateFormat : 'yy-mm-dd'}).datepicker("setDate", new Date());
	});
</script>
<script>
	function validation() {
		if (document.f1.mobno.value == 0) {
			alert("Please enter mob no..");
			document.f1.mobno.focus();
			return false;
		}
		if (document.f1.orderdate.value == 0) {
			alert("Please select date..");
			document.f1.orderdate.focus();
			return false;
		}
	}
</script>

</head>
  <% 
   String s1=(String)session.getAttribute("uname");
    if(!(s1==null))
    {
    %>
<body onload="JavaScript:AutoRefresh(20000);">
	<div class="col span_1_of_4" style="width: 100%">
		<div class="right">
			<h2 class="heading"
				style="background-color:darkred;padding: 5px;">
				Payment details:-</h2>
			<div align="right"
				style="color: white; font-family: serif; padding: 0px;">
  <li class="logout" ><a href='logout.jsp' style="font-size: 13px"><b>Logout</b></a></li>
				<!-- <strong><b style="font-family: serif;margin-top: 10px;font-size: 11px;"><img src="images/editproduct.jpg" height="15x" width="20px"></img><a href="editsearchproduct.jsp" style="padding: 8px;background-color: azure">Edit Order</a></b></strong>
   <strong><b style="font-family: serif;margin-top: 10px;font-size: 11px;"><img src="images/Delete_Icon.png" height="15x" width="20px"></img><a href="deletesearchproduct.jsp" style="padding: 8px;background-color: azure">Delete order</a></b></strong> -->

			</div>

			<br />
			<br /> <label class="store"
				style="width: 22%; font-size: 14px; font-family: inherit; background-color: aliceblue; padding: 6px 13px;">Enter
				PayUMoney Id.</label>
			<form action="paymentdetail.jsp" method="post" name="f1"
				onsubmit="return validation()">
				<input type="text" name="payuMoneyId" id="country" class="input_text"
					style="width: 139px; padding: 4px;" /> <br />
				<br /> 
				<br /> <input type="submit" value="Search"
					style="margin-left: 208px;" > <br /> <br />
			</form>

			<table style="float: left; margin-left: 4px;" width="750px"
				align="center" border="1px" >


				<tr style="font-size: 14px; background-color: darkred;color: white;">
					<td>SI.No</td>
					<td>PayUMoneyId</td>
					<td>mihpayid</td>
					<td>mode</td>
				<!-- 	<td>Qty.</td> -->
					<td>status</td>
					<td>key</td>
					
					<td>txnid/Order id</td>
					<td>amount</td>
					<td>discount</td>
					<td>productinfo</td>
					<td>firstname</td>
					<td>email</td>
					<td>phone</td>
					<td>Payment Type</td>
					<td>Bank Ref.No.</td>
					
					
				</tr>
				<%
					PreparedStatement ps = null;
					ResultSet rs = null;
					String payuMoneyId=request.getParameter("payuMoneyId");
					Timestamp ts = new Timestamp(System.currentTimeMillis());
					System.out.println("ts="+ts);
					String date1=""+ts;
					System.out.println("date="+date1);
					
					String mdate=date1.substring(0,10);
					System.out.println("mdate="+mdate);
					
					try {
						ps = con.prepareStatement("SELECT  * FROM newpayment");
					 	//ps.setString(1,payuMoneyId);
						
int count=1;
String sd1=null;

String sd2=null;
						rs = ps.executeQuery();
						  System.out.println("kkkk---- 1 ");
						while (rs.next())
						{
							  System.out.println("kkkk---- 2 ");
							if(payuMoneyId.equals(rs.getString("txnid")))
							{
						    %>
							<tr><td><%=count++ %></td>
							<td><%=rs.getString(40) %></td>
							<td><%=rs.getString(2) %></td><td><%=rs.getString(3) %></td><td><%=rs.getString(4) %></td><td><%=rs.getString(5) %></td>
							<td><%=rs.getString(6) %></td>
							<td><%=rs.getString(7) %></td>
							<td><%=rs.getString(8) %></td>
							<td><%=rs.getString(9) %></td>
							<td><%=rs.getString(10) %></td>
							<td><%=rs.getString(18) %></td>
							<td><%=rs.getString(19) %></td>
								<td><%=rs.getString(27) %></td>
								<td><%=rs.getString(28) %></td>
							</tr>
							<%
						    }
						    else
						    {
							HashMap<String, String> hm = new HashMap<String, String>();
							hm.put("txnid", "BA150112020104RA24");
							  Gson gson=new Gson();
					           String tokenno=null;
					           
					           System.out.println("kkkk----  "+gson.toJson(hm));
								String result=test.postDataRadRunn(gson.toJson(hm), "http://localhost:8090/HBAppService/getResponseFromPayuOnClick.do","");
						      //  RoadrunnrVO roadrunnrVO=null;
			                	//ObjectMapper mapper = new ObjectMapper();
			                    
			                	//roadrunnrVO = mapper.readValue(result,RoadrunnrVO.class);
			                	
			                
						}
					}
					} catch (Exception e) {
						System.out.print(e);
					}
				%>

				</tr>
			
			</table>













		</div>














	</div>

	</div>





	</div>
	</div>

	</div>


 <%
    }
    else
    {
    	 response.sendRedirect("index.html");
    }
%>









</body>
</html>