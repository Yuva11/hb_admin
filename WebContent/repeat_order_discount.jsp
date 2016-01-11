<%@page import="javassist.bytecode.stackmap.BasicBlock.Catch"%>
<%@page import="java.sql.ResultSet"%>
<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>
<%@page import="java.text.*"%>
<%@page import="java.sql.ResultSet"%>

<%@page import="java.sql.*"%>
<%@page import="java.util.Date"%>
<%@include file="getcon.jsp"%>

<!doctype html>
<html class="no-js">
<head>
<link rel="stylesheet" type="text/css" href="css/style3.css" />
<link rel="stylesheet" href="css/style34.css" media="all">
<link rel="stylesheet" href="css/styles.css">



<link rel="stylesheet" type="text/css" href="css/style3.css" />
<script type="text/javascript" src="js/jquery-1.4.2.min.js"></script>
<script src="js/jquery.autocomplete.js"></script>

<script>
	jQuery(function() {
		$("#country1").autocomplete("list3.jsp");
	});
</script>
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
<!-- 
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.11.2/themes/smoothness/jquery-ui.css">
<script src="js/jquery-1.9.1.js"></script>
<script src="js/jquery-ui.js"></script>

<script>
	$(function() {
		$("#datepicker").datepicker({dateFormat : 'yy-mm-dd'}).datepicker("setDate", new Date());
	});
</script>
 -->
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
	String s1 = (String) session.getAttribute("uname");

	if (!(s1 == null)) {
%>

<body onload="JavaScript:AutoRefresh(20000);">




	<div class="col span_1_of_4" style="width: 100%">
		<div class="right">
			<h2 class="heading" style="background-color: darkred; padding: 5px;">
				Coupon Code Details for repeat order customer:-</h2>
			<div align="right"
				style="color: white; font-family: serif; padding: 0px;">
				<li class="logout"><a href='logout.jsp'
					style="font-size: 13px"><b>Logout</b></a></li>
				<!-- <strong><b style="font-family: serif;margin-top: 10px;font-size: 11px;"><img src="images/editproduct.jpg" height="15x" width="20px"></img><a href="editsearchproduct.jsp" style="padding: 8px;background-color: azure">Edit Order</a></b></strong>
   <strong><b style="font-family: serif;margin-top: 10px;font-size: 11px;"><img src="images/Delete_Icon.png" height="15x" width="20px"></img><a href="deletesearchproduct.jsp" style="padding: 8px;background-color: azure">Delete order</a></b></strong> -->

			</div>



			<table style="float: left; margin-left: 4px;" width="750px"
				align="center" border="1px">


				<tr
					style="font-size: 14px; background-color: darkred; color: white;">
					<td>SI.No</td>
					<td>Order Number</td>
					<td>Order type</td>
					<td>Order value</td>
					<td>Custom Message</td>
					<td>Maximum Discount value</td>
					<td>Minimum Order value</td>
					<td style="background-color: silver;"><p style="color: blue;">
							<a href="add_repeat_coupan_discount.jsp">Add discount for repeat customer orders</a>
						</p></td>
					<td></td>


				</tr>
				<%
					PreparedStatement ps = null;
						ResultSet rs = null;
						PreparedStatement ps1 = null;
						ResultSet rs1 = null;
						PreparedStatement ps2 = null;
						ResultSet rs2 = null;

						String payuMoneyId = request.getParameter("payuMoneyId");
						try {
							ps = con.prepareStatement("SELECT  * FROM repeat_discount");

							int count = 1;
							rs = ps.executeQuery();
							while (rs.next()) {
								
					
								String branchname=null;;
				%>
				<tr>
					<td><%=count++%></td>
					<td><%=rs.getString(2)%></td>
					<td><%=rs.getString(3)%></td>
					<td><%=rs.getString(4)%></td>
					<td><%=rs.getString(5)%></td>
					<td><%=rs.getString(6)%></td>
					<td><%=rs.getString(7)%></td>
						
					<td><a href="updaterepeatOrder.jsp?id=<%=rs.getString(1)%>"style="color: blue;">Update</a></td>
					<td><a href="deleterepeatOrder.jsp?id=<%=rs.getString(1)%>"style="color: blue;">Delete</a></td>

				</tr>
				<%
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
		} else {
			response.sendRedirect("index.html");
		}
	%>









</body>
</html>