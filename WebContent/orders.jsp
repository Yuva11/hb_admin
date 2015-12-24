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


<meta charset="utf-8">

<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">

<title>Hungry Bells</title>

<script type="text/JavaScript">

function AutoRefresh( t ) {
 setTimeout("location.reload(true);", t);
}

</script>
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

<body>




	<div class="col span_1_of_4" style="width: 100%">
		<div class="right">
			<h2 class="heading"
				style="background-color:darkred;padding: 5px;">
				New Order details of delivery:-</h2>
			<div align="right"
				style="color: white; font-family: serif; padding: 0px;">
  <li class="logout" ><a href='logout.jsp' style="font-size: 13px"><b>Logout</b></a></li>
				<!-- <strong><b style="font-family: serif;margin-top: 10px;font-size: 11px;"><img src="images/editproduct.jpg" height="15x" width="20px"></img><a href="editsearchproduct.jsp" style="padding: 8px;background-color: azure">Edit Order</a></b></strong>
   <strong><b style="font-family: serif;margin-top: 10px;font-size: 11px;"><img src="images/Delete_Icon.png" height="15x" width="20px"></img><a href="deletesearchproduct.jsp" style="padding: 8px;background-color: azure">Delete order</a></b></strong> -->

			</div>

			<br />
			<br /> <label class="store"
				style="width: 22%; font-size: 14px; font-family: inherit; background-color: aliceblue; padding: 6px 13px;">Enter
				Mob No.</label>
			<form action="orderdetailsshow.jsp" method="post" name="f1"
				onsubmit="return validation()">
				<input type="text" name="mobno" id="country" class="input_text"
					style="width: 139px; padding: 4px;" /> <br />
				<br /> <label class="store"
					style="width: 22%; font-size: 14px; font-family: inherit; background-color: aliceblue; padding: 6px 13px;">
					<!-- Search Purchase order(Indent) -->Select Order Date.
				</label> <input type="text" name="orderdate" id="datepicker"
					style="width: 120px;" /><img src="images/ffffff.jpeg" height="25px"
					width="25px" style="margin-top: -9px;" /> <br />
				<br /> <input type="submit" value="Search"
					style="margin-left: 208px;" onclick="this.form.target='_blank';return true;"> <br /> <br />
			</form>

		
			<br /> <label class="store"
				style="width: 31%; font-size: 14px; font-family: inherit; background-color: silver; "><b><p style="float: left;">Today
				Order details of delivery.</p><a href="selectdateandshow.jsp" style="cue-before: darkred"><p style="color: darkblue"> Report show by date</p></a></b></label> <br /> <br />

			<table style="float: left; margin-left: 4px;" width="750px"
				align="center" border="1px" >


				<tr style="font-size: 14px; background-color: darkred;color: white;">
					<td>SI.No</td>
					<td>Order Ref/ID</td>
					<td>Deal Name</td>
					<td>Coupon Code</td>
					<td>Discount Method</td>
					
					<td>Quantity</td>
					<td>Amount</td>
				</tr>
				<%
					PreparedStatement ps = null;
					ResultSet rs = null;
					PreparedStatement ps1 = null;
					ResultSet rs1 = null;
					PreparedStatement ps2 = null;
					ResultSet rs2 = null;
					PreparedStatement ps4 = null;
					ResultSet rs4 = null;
					PreparedStatement ps5= null;
					ResultSet rs5 = null;
					int cont = 1;
					int gtotal = 0;
					
					String orders_id=request.getParameter("orderid");
					String coupon_code=request.getParameter("coupon_code");
					String discount_method=request.getParameter("discount_method");

					Timestamp ts = new Timestamp(System.currentTimeMillis());

					String sda = "" + ts;
					String sdq = sda.substring(0, 10);
					DateFormat dateFormat = new SimpleDateFormat("yyyy-mm-dd");
					//   String orderdateformat=date.format(ts);

					System.out.print("---------------" + sdq);

					int qty;
					int pprice;
					String ss1, ss3;
					long user_id = 0;
					long merchantbranch_id = 0;
					long merchant_id = 0;

					String orderid = null;
					String orderdate = null;
					String amount = null;
					String quantity = null;
					String status = null;
					String merchant_name = null;
					String user_name = null;
					String cust_mob = null;
					String cust_email = null;
					String address = null;
					String merchant_mob = null;
					String merchant_email = null;
					String deal_name = null;
					String delivery_type = null;
					String deal_id=null;
					String longitude=null;
					String latitude=null;
					String delivery_address=null;
					String landmark=null;
				
					long deal_id1=0;

					try {
						ps = con.prepareStatement("SELECT  * FROM orders where order_id=?");
                        ps.setString(1,orders_id);
						rs = ps.executeQuery();

						
						ArrayList ar = new ArrayList();
						while (rs.next()) 
						{
							deal_id1=rs.getLong(3);
							
						 ar.add(rs.getLong(4));	
						  %>
					<tr style="">
					<td><%=cont++%>
					<td><%=rs.getString(2)%></td>
			    
					  <%
					  
						
						ps1 = con.prepareStatement("SELECT  * FROM deal where id=?");
										ps1.setLong(1, deal_id1);
										rs1 = ps1.executeQuery();


										while (rs1.next())
										{
											deal_name = rs1.getString(17);
						%>

						 <td><%=deal_name%> </td>
				
					                 	<%}
										

					%>
					
					
					  <td><%=coupon_code%></td>
					  <td><%=discount_method%></td>
				    <td><%=rs.getString(4)%></td>
				    
					<td><%=rs.getDouble(5)%></td>
					  <%	
						
						}
						
						ps4 = con.prepareStatement("SELECT  * FROM neworderdetails where order_id=?");
						ps4.setString(1,orders_id);
						rs4 = ps4.executeQuery();

                        double d1=0.0;
                        double d2=0.0;
                        
                        double d3=0.0;
						if (rs4.next())
						{
							d1= rs4.getDouble(8);
							d2= rs4.getDouble(17);
							d3=d1+d2;
						%>

<tr style="border: 1px;border-color: blue"><td></td><td></td><td></td><td></td><td style="font-size: 15px"><b>Total payable amount by user</b></td><td  style="font-size: 15px;"><b></b></td><td  style="font-size: 15px"><b><%=d3%></b></td><tr>
	
	  <%	
		
		
		}

						

					} catch (Exception e) {
						System.out.print(e);
					}
				%>




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