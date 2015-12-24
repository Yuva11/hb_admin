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
<script type="text/javascript">
var tableToExcel = (function() {
  var uri = 'data:application/vnd.ms-excel;base64,'
    , template = '<html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http://www.w3.org/TR/REC-html40"><head><!--[if gte mso 9]><xml><x:ExcelWorkbook><x:ExcelWorksheets><x:ExcelWorksheet><x:Name>{worksheet}</x:Name><x:WorksheetOptions><x:DisplayGridlines/></x:WorksheetOptions></x:ExcelWorksheet></x:ExcelWorksheets></x:ExcelWorkbook></xml><![endif]--></head><body><table>{table}</table></body></html>'
    , base64 = function(s) { return window.btoa(unescape(encodeURIComponent(s))) }
    , format = function(s, c) { return s.replace(/{(\w+)}/g, function(m, p) { return c[p]; }) }
  return function(table, name) {
    if (!table.nodeType) table = document.getElementById(table)
    var ctx = {worksheet: name || 'Worksheet', table: table.innerHTML}
    window.location.href = uri + base64(format(template, ctx))
  }
})()
</script>



<link rel="stylesheet" type="text/css" href="css/style3.css" />
<script type="text/javascript" src="js/jquery-1.4.2.min.js"></script>
<script src="js/jquery.autocomplete.js"></script>

<script>
	jQuery(function() {
		$("#country1").autocomplete("list2.jsp");
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
				Reconciled, Settled details View</h2>
			<div align="right"
				style="color: white; font-family: serif; padding: 0px;">
				<li class="logout"><a href='logout.jsp' style="font-size: 13px"><b>Logout</b></a></li>
				<!-- <strong><b style="font-family: serif;margin-top: 10px;font-size: 11px;"><img src="images/editproduct.jpg" height="15x" width="20px"></img><a href="editsearchproduct.jsp" style="padding: 8px;background-color: azure">Edit Order</a></b></strong>
   <strong><b style="font-family: serif;margin-top: 10px;font-size: 11px;"><img src="images/Delete_Icon.png" height="15x" width="20px"></img><a href="deletesearchproduct.jsp" style="padding: 8px;background-color: azure">Delete order</a></b></strong> -->

			</div>
			<br /> <br /> <label class="store"
				style="width: 22%; font-size: 14px; font-family: inherit; background-color: aliceblue; padding: 6px 13px;">
				Search Merchant Name</label>
			<form action="viewseteletment.jsp" method="post" name="f1"
				onsubmit="return validation()">
				<input type="text" name="merchantname" id="country1"
					class="input_text" style="padding: 7px; width: 190px;" /> <br />
				<br /> <input type="submit" value="Search"
					style="margin-left: 208px; padding: 7px"><br />
					<br />
							<a  style="margin-left:940px"  href="javascript:Clickheretoprint()"></a><input type="button" onclick="tableToExcel('testTable', 'W3C Example Table')" value="Export to Excel"
						 style=" font-size: 11px;
    margin-bottom: 4px;
    margin-left: 417px;
    padding: 3px 13px;">	
					
			</form>

			<table style="float: left; margin-left: 4px;" width="750px"
				align="center" id="testTable" border="1px">
				<tr
					style="font-size: 14px; background-color: darkred; color: white;">
					<td>SI.No</td>
					<td>Recon Status</td>
					<td>Order Id</td>
					<td>Order Status</td>
					<td>Merchant Name</td>
					<td>Merchant Branch Name</td>
					<td>Payment ID</td>
					<td>Payment  Method</td>
					<td>Deal Name</td>
					<td>Payment Status</td>
					<td>Order Amount </td>
					<td>HB Discount Value </td>
					<td>Received Amount from PG </td>
					<td>PG Commission </td>
					<td>HB Received Amount </td>
					<td>HB Commission </td>
					<td>Settlement Amount </td>
					<td>P and L </td>
					
				

				</tr>
				<%
					PreparedStatement ps = null;
						ResultSet rs = null;
						PreparedStatement ps1 = null;
						ResultSet rs1 = null;
						PreparedStatement ps2 = null;
						ResultSet rs2 = null;
						PreparedStatement ps3 = null;
						ResultSet rs3 = null;

						String merchantname = request.getParameter("merchantname");
						String merchant_id = null;
						String branch_name = null;
						String branch_id = null;
						String order_id = null;
						String order_type = null;
						String order_amount = null;
						String deal_id = null;
						try {
							ps = con.prepareStatement("SELECT  * FROM merchant where name=?");
							ps.setString(1, merchantname);
							int count = 1;
							rs = ps.executeQuery();
							while (rs.next()) {
								merchant_id = rs.getString(1);

								try {
									ps1 = con
											.prepareStatement("SELECT  * FROM merchantbranch where merchant_id=?");
									ps1.setString(1, merchant_id);
									rs1 = ps1.executeQuery();
									while (rs1.next()) {
										branch_id = rs1.getString(1);
										branch_name = rs1.getString("branch_name");

										try {
											ps2 = con
													.prepareStatement("SELECT  * FROM payment_recon  where merchantbranch_id=?");
											ps2.setString(1, branch_id);
											rs2 = ps2.executeQuery();
											while (rs2.next()) {
												
													deal_id = rs2.getString(9);
												try {
													ps3 = con
															.prepareStatement("SELECT  * FROM deal where id=?");
													ps3.setString(1, deal_id);
													rs3 = ps3.executeQuery();
													while (rs3.next()) {

												
				%>
				<tr>
					<td><%=count++%></td>
					<td><%=rs2.getString("recon_status")%></td>
					<td><%=rs2.getString(3)%></td>
					<td><%=rs2.getString(4)%></td>
					<td><%=merchantname%></td>
					<td><%=branch_name%></td>
					<td><%=rs2.getString(7)%></td>
					<td><%=rs2.getString(8)%></td>
					<td><%=rs3.getString("name")%></td>
					<td><%=rs2.getString(10)%></td>
					<td><%=rs2.getString(11)%></td>
					<td><%=rs2.getString(12)%></td>
					<td><%=rs2.getString(13)%></td>
					<td><%=rs2.getString(14)%></td>
					<td><%=rs2.getString(15)%></td>
					<td><%=rs2.getString(16)%></td>
					<td><%=rs2.getString(17)%></td>
					<td><%=rs2.getString(18)%></td>
						
				  <%--  <td><a href="entrysetlement.jsp?orderid=<%=order_id %>
				   &merchant_id=<%=merchant_id %>
				   &merchantname=<%=merchantname %>
				   &branch_id=<%=branch_id %>
				    &branch_name=<%=branch_name %>
				    
				    &deal_name=<%=rs3.getString("name")%>
				     &deal_id=<%=rs3.getString("id")%>
				       &order_type=<%=order_type%>
				   " style="color: darkblue"> Settled Submit</a></td> --%>
				   
				    <td><a href="updatesetlement.jsp?orderid=<%=rs2.getString(3) %>
				   &merchant_id=<%=rs2.getString(5)%>
				   &merchantname=<%=merchantname %>
				    &branch_name=<%=branch_name %>
				    
				    &deal_name=<%=rs3.getString("name")%>
				       &order_type=<%=order_type%>
				   " style="color: darkblue"> Update</a></td> 
				</tr>

				<%
					
													}

												} catch (Exception e) {
													System.out.print(e);
												}
											}

										} catch (Exception e) {
											System.out.print(e);
										}

									}

								} catch (Exception e) {
									System.out.print(e);
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
		} else {
			response.sendRedirect("index.html");
		}
	%>









</body>
</html>