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

<body onload="JavaScript:AutoRefresh(20000);">




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
			<br /> 
			<form action="orderdetailparticulardate.jsp" method="post" name="f1"
				onsubmit="return validation()">
			
				<br /> <label class="store"
					style="width: 22%; font-size: 14px; font-family: inherit; background-color: aliceblue; padding: 6px 13px;">
					<!-- Search Purchase order(Indent) -->Select Order Date.
				</label> <input type="text" name="orderdateselect" id="datepicker"
					style="width: 120px;" /><img src="images/ffffff.jpeg" height="25px"
					width="25px" style="margin-top: -9px;" /> <br />
				<br /> <input type="submit" value="Search"
					style="margin-left: 208px;"> <br /> <br />
			</form>

		
			<br /> <label class="store"
				style="width: 31%; font-size: 14px; font-family: inherit; background-color: silver; padding: 6px 13px;"><b>
				Select Date  of delivery Report.</b></label> <br /> <br />

			<table style="float: left; margin-left: 4px;" width="750px"
				align="center" border="1px" >


				<tr style="font-size: 14px; background-color: darkred;color: white;">
					<td>SI.No</td>
					<td>Order Ref/ID</td>
					<td>Order Date</td>
					<td>Qty.</td>
					<td>Amount</td>
					<td>Deal Name</td>
					<td>MerchantBranch Name</td>
					<td>Merchant Mob No</td>
					<td>Merchant Name</td>
					<td>Customer Name</td>
					<td>Cust. Mob. No.</td>
					<td>Status
					<td>
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
					int cont = 0;
					int gtotal = 0;

					//Timestamp ts = new Timestamp(System.currentTimeMillis());

					String orderdateselect=request.getParameter("orderdateselect");
					String sda = orderdateselect;
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
					

					try {
						ps = con.prepareStatement("SELECT  * FROM neworderdetails order by order_date_time  desc");

						rs = ps.executeQuery();

						
						ArrayList ar = new ArrayList();
						while (rs.next()) {
							
							
							Date orderdate1 = (Date) rs.getDate(10);
							String orderdate11 = "" + orderdate1;

							if (sdq.equals(orderdate11)) 
							{
								
								

								merchantbranch_id = rs.getLong(14);
								user_id = rs.getLong(13);
								orderid = rs.getString(15);
								orderdate = rs.getString(10);
								amount = rs.getString(8);
								quantity = rs.getString(7);
								address = rs.getString(4);
								deal_id =rs.getString(9);
								delivery_type=rs.getString(6);
								longitude=rs.getString(2);
								latitude=rs.getString(3);
								
								
								
								
							
								
								
								
								
								
				%>

				<tr style="">
					<td><%=cont++%>
					<td><%=rs.getString(15)%></td>
					<td><%=rs.getString(10)%></td>
					<td><%=rs.getString(7)%></td>
					<td><%=rs.getString(8)%></td>

					<%
					
					
					try {
						ps5 = con.prepareStatement("SELECT  * FROM deal where id=?");
                        ps5.setString(1,deal_id);
						rs5 = ps5.executeQuery();

						while (rs5.next()) 
						{
						
								deal_name =rs5.getString(17);
							%>
							<td><%=rs5.getString(17) %></td>
							<%	
								
					
					
					
					
						ps1 = con.prepareStatement("SELECT  * FROM merchantbranch where id=?");
									ps1.setLong(1, merchantbranch_id);

									rs1 = ps1.executeQuery();

									while (rs1.next()) {
										merchant_id = rs1.getLong(15);
										merchant_mob = rs1.getString("mobile_number");
										merchant_email = rs1.getString(16);
										
										System.out.println("-----------------------------------------fdssdffff -----"+merchant_mob);
					%>

					<td><%=rs1.getString(3)%></td>
					<td><%=rs1.getString("mobile_number")%></td>

					<%
						ps4 = con
												.prepareStatement("SELECT  * FROM merchant where id=?");
										ps4.setLong(1, merchant_id);

										rs4 = ps4.executeQuery();

										while (rs4.next()) {
											merchant_name = rs4.getString(8);
					%>

					<td><%=rs4.getString(8)%></td>

					<%
						}

									}

									ps2 = con
											.prepareStatement("SELECT  * FROM user where id=?");
									ps2.setLong(1, user_id);

									rs2 = ps2.executeQuery();

									while (rs2.next()) {
										user_name = rs2.getString(5);
										cust_mob = rs2.getString(2);
										cust_email = rs2.getString("email");
					%>

					<td><%=rs2.getString(5)%></td>
					<td><%=rs2.getString(2)%></td>
					

					<%
						}
									
									
					if(rs.getString(12).equals("Confirmed"))	
					{
						%>
						<td><%=rs.getString(12)%></td>
						<%
					}
					else
					{
					%>
						<td><%=rs.getString(12)%></td>
					<td><a
						href="sendconfirmation.jsp?orderid=<%=orderid%>&orderdate=<%=orderdate%>&amount=<%=amount%>&quantity=<%=quantity%>&status=<%="Confirmed"%>&merchant_name=<%=merchant_name%>&user_name=<%=user_name%>&cust_mob=<%=cust_mob%>&cust_email=<%=cust_email%>&address=<%=address%>&merchant_mob=<%=merchant_mob%>&merchant_email=<%=merchant_email%>&deal_name=<%=deal_name%>&delivery_type=<%=delivery_type%>&longitude=<%=longitude%>&latitude=<%=latitude%>"
						style="border-radius: 2px;"> <b>Send Confirmation</b></a></td>
				</tr>
				<%
					}
					
					
					
						}
					   }catch(Exception ek)
					        {
						
					        }
					
					
					
					
					}

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