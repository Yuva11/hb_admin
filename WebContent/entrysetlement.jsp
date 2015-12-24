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
	$(function() {
		$("#datepicker1").datepicker({dateFormat : 'yy-mm-dd'}).datepicker("setDate", new Date());
	});
</script>


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
<!-- <link rel="stylesheet"
	href="//code.jquery.com/ui/1.11.2/themes/smoothness/jquery-ui.css">
<script src="js/jquery-1.9.1.js"></script>
<script src="js/jquery-ui.js"></script>

<script>
	$(function() {
		$("#datepicker").datepicker({dateFormat : 'yy-mm-dd'}).datepicker("setDate", new Date());
	});
</script> -->
<script>
	function validation() {
		if (document.f1.name1.value == "--select status--") {
			alert("Please select status ");
			document.f1.name1.focus();
			return false;
		}
		if (document.f1.orderdate.value == 0) {
			alert("Please select date..");
			document.f1.orderdate.focus();
			return false;
		}

	}
</script>

<!-- 
  <script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?sensor=true"></script>
    <script type="text/javascript">
        function GetAddress() {
            var lat = parseFloat(document.getElementById("txtLatitude").value);
            var lng = parseFloat(document.getElementById("txtLongitude").value);
            var latlng = new google.maps.LatLng(lat, lng);
            var geocoder = geocoder = new google.maps.Geocoder();
            geocoder.geocode({ 'latLng': latlng }, function (results, status) {
                if (status == google.maps.GeocoderStatus.OK)
				{
                    if (results[1]) {
                        alert("Location: " + results[1].formatted_address);
                    }
                }
            });
        }
    </script> -->
</head>
  <% 
   String s1=(String)session.getAttribute("uname");

    if(!(s1==null))
    {
   
    %>

<body >




	<div class="col span_1_of_4" style="width: 100%">
		<div class="right">
			<h2 class="heading"
				style="background-color:darkred;padding: 5px;">
				Reconciled, Settled details Entry </h2>
			<div align="right"
				style="color: white; font-family: serif; padding: 0px;">
  <li class="logout" ><a href='logout.jsp' style="font-size: 13px"><b>Logout</b></a></li>
			
			</div>
			<%
			String orderid=request.getParameter("orderid"); 
			String merchant_id=request.getParameter("merchant_id"); 
			
			String merchantname=request.getParameter("merchantname"); 
			
			String branch_id=request.getParameter("branch_id"); 
			
			String branch_name=request.getParameter("branch_name"); 
			
			String deal_name=request.getParameter("deal_name"); 
			
			String deal_id=request.getParameter("deal_id");
			String order_type=request.getParameter("order_type");
			
			
			String order_status=null;
	
			String payment_status=null;
			double amount=0.0;
			String discount=null;
			String payuMoneyId=null;

			PreparedStatement ps = null;
			ResultSet rs = null;
	

			PreparedStatement ps1 = null;
			ResultSet rs1 = null;
			double d1=0.0,d2=0.0,d3=0.0,d4=0.0;
	
		
			try {
				ps = con.prepareStatement("SELECT  * FROM neworderdetails where order_id=?");
				ps.setString(1, orderid);
				rs = ps.executeQuery();
				if(rs.next()) 
				{
					order_status=rs.getString("order_status");
					
					amount=rs.getDouble("order_amount");
					discount=rs.getString("discount_amount");
					d1=Double.parseDouble(rs.getString("order_amount"));
					d2=Double.parseDouble(rs.getString("discount_amount"));
					d3=d1-d2;
					
				}
			}
			catch(Exception e)
			{
				
			}
			
			
			try {
				ps1 = con.prepareStatement("SELECT  * FROM newpayment where txnid=?");
				ps1.setString(1, orderid);
				rs1 = ps1.executeQuery();
				if(rs1.next()) 
				{
					payment_status=rs1.getString("status");
					payuMoneyId=rs1.getString("payuMoneyId");
					
				}
			}
			catch(Exception e)
			{
				
			}
			
			

		
			
			%>
	<form action="setalment_insert.jsp" method="get" name="f1" 	onsubmit="return validation()">
	    
		
			<table style="float: left;width: 700px">	
			<tr>		
			<td>Reconciled Status</td> <td>
			<select type="text" name="name1"  class="input_text"  
					style="width: 139px; padding: 4px;margin-bottom: 5px" >
					<option>--select status--</option>
					<option>Reconciled</option>
					<option>Settled</option>
					<option> Not Yet</option>
					</select>
					</td></tr>
					
						<tr>		
			<td>Order Id</td> <td><input type="text" name="name2" value="<%=orderid %>" class="input_text"  
					style="width: 139px; padding: 4px;margin-bottom: 5px" /></td></tr>
					
					
					
						<tr>		
			<td>Order Status</td> <td><input type="text" name="name3" value="<%=order_status %>" class="input_text"  
					style="width: 139px; padding: 4px;margin-bottom: 5px" /></td></tr>
					
						<tr>		
			<td>Merchant Name</td> <td> <input type="text"  value="<%=merchantname %>" class="input_text"  
					style="width: 139px; padding: 4px;margin-bottom: 5px" /></td></tr>

<input type="hidden" name="name4" value="<%=merchant_id %>" class="input_text"  
					style="width: 139px; padding: 4px;margin-bottom: 5px" />
					
						<tr>		
			<td>Merchant branch Name</td> <td> <input type="text"  value="<%=branch_name%>" class="input_text"  
					style="width: 139px; padding: 4px;margin-bottom: 5px" /></td></tr>
					
					<input type="hidden" name="name5" value="<%=branch_id %>" class="input_text"  
					style="width: 139px; padding: 4px;margin-bottom: 5px" />
					
						<tr>		
			<td>Payment ID</td> <td><input type="text" name="name6" value="<%=payuMoneyId%>" class="input_text"  
					style="width: 139px; padding: 4px;margin-bottom: 5px" /></td></tr>
					
					
					<tr>		
			<td>Payment  Method</td> <td><input type="text" name="name7" value="<%=order_type%>" class="input_text"  
					style="width: 139px; padding: 4px;margin-bottom: 5px" /></td></tr>
					
						<tr>		
			<td>Deal  Name</td> <td><input type="text"   value="<%=deal_name%>" class="input_text"  
					style="width: 139px; padding: 4px;margin-bottom: 5px" /></td></tr>
					
					<input type="hidden" name="name8" value="<%=deal_id %>" class="input_text"  
					style="width: 139px; padding: 4px;margin-bottom: 5px" />
					
		
		</table>
		
		
		
		
			<table style="width: 600px">	
			
						<tr>		
			<td>Payment Status</td> <td><input type="text" name="name9"  value="<%=payment_status%>" class="input_text"  
					style="width: 139px; padding: 4px;margin-bottom: 5px" /></td></tr>
					
						<tr>		
			<td>Order Amount </td> <td><input type="text" name="name10"  value="<%=amount%>" class="input_text"  
					style="width: 139px; padding: 4px;margin-bottom: 5px" /></td></tr>
					
						<tr>		
			<td>HB Discount Value </td> <td> <input type="text" name="name11" value="<%=d2%>" class="input_text"  
					style="width: 139px; padding: 4px;margin-bottom: 5px" /></td></tr>

<% double d=0.0; %>
						<tr>		
			<td>Received Amount from PG</td> <td> <input type="text" value="<%=d %>" name="name12"  class="input_text"  
					style="width: 139px; padding: 4px;margin-bottom: 5px" /></td></tr>
					
						<tr>		
			<td>PG Commission </td> <td><input type="text" name="name13" value="<%=d %>" class="input_text"  
					style="width: 139px; padding: 4px;margin-bottom: 5px" /></td></tr>
					
						<tr>		
			<td>HB Received Amount  </td> <td><input type="text" name="name14" value="<%=d %>" class="input_text"  
					style="width: 139px; padding: 4px;margin-bottom: 5px" /></td></tr>
					
					
						<tr>		
			<td>HB Commission  </td> <td><input type="text" name="name15" value="<%=d %>" class="input_text"  
					style="width: 139px; padding: 4px;margin-bottom: 5px" /></td></tr>
					
					
				<tr><td></td> <td><input type="submit" value="Submit" style="margin-left: 11px;" /></td></tr>
		

		</table>
		
		
		
		
		</form>
		
		
		
		
		
		
		
		
		
		
		
		
		
		
			<br /> <!-- <label class="store"
				style="width: 75%; font-size: 14px; font-family: inherit; background-color: silver; "><b><p style="float: left;">Today
				Order details of delivery.</p><a href="selectdateandshow.jsp" style="cue-before: darkred"><p style="color: darkblue;float: left;margin-left: 50px"> Report show by date</p></a>
				<a href="paymentdetails.jsp" style="cue-before: darkred;"><p style="color: darkblue;float: left;margin-left: 20px">Payment details</p></a>
				<a href="adddeliveryagect.jsp" style="cue-before: darkred"><p style="color: darkblue">Add Delivery Agent</p></a>
				
				</b></label> <br /> <br />
 -->
<%-- 			<table style="float: left; margin-left: 4px;" width="750px"
				align="center" border="1px" >


				<tr style="font-size: 14px; background-color: darkred;color: white;">
					<td>SI.No</td>
					<td>Order Ref/ID</td>
					<td>Order Date</td>
				<!-- 	<td>Qty.</td> -->
					<td>Total Amount</td>
					<td>Discount Applied</td>
					
					<td>given Address</td>
					<td>google Address</td>
					<td>Landmark</td>
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
					int cont = 1;
					int gtotal = 0;

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
					String coupon_code=null;
					String discount_method=null;
					double lat=0;
					double lng=0;
					
				
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
								delivery_address=rs.getString("delivery_address");
								landmark=rs.getString("landmark");
								
								discount_method=rs.getString(16);
								coupon_code=rs.getString(18);
								
								lat=rs.getDouble(3);
								lng=rs.getDouble(2);
								
							%>
							
							
				<tr style="">
					<td><%=cont++%>
					<td><a href="orders.jsp?orderid=<%=orderid%>&coupon_code=<%=coupon_code%>&discount_method=<%=discount_method %>" style="color: darkblue"><%=rs.getString(15)%></a> </td>
					<td><%=rs.getString(10)%></td>
					<td><%=rs.getString(7)%></td>
					<td><%=rs.getString(8)%></td>
				 <td><%=rs.getString(17)%></td>
				  <td><%=rs.getString(19)%></td>
					<td><%=rs.getString("delivery_address")%></td>
			 <td>
                      
     <a href="getAddress.jsp?lat=<%=lat%>&lng=<%=lng%>" style=" color: blue"> Get Address</a>
  </td>
			 
					<td><%=rs.getString("landmark")%></td>
					

					<%
					
					
					try {
						ps5 = con.prepareStatement("SELECT  * FROM deal where id=?");
                        ps5.setString(1,deal_id);
						rs5 = ps5.executeQuery();

						while (rs5.next()) 
						{
						
								deal_name =rs5.getString(17);
							%>
							<%	
								
					ps1 = con.prepareStatement("SELECT  * FROM merchantbranch where id=?");
									ps1.setLong(1, merchantbranch_id);

									rs1 = ps1.executeQuery();

									while (rs1.next()) {
										merchant_id = rs1.getLong(15);
										merchant_mob = rs1.getString("mobile_number");
										merchant_email = rs1.getString(16);
										System.out.println("--kkkk--"+merchant_mob);
										System.out.println("--kkkk--"+merchant_email);
										
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
				
						<td></td>
			
						<%
					}
					else
					{
					%>
						<td><%=rs.getString(12)%></td>
					<td><a
						href="sendconfirmation.jsp?orderid=<%=orderid%>&orderdate=<%=orderdate%>&amount=<%=amount%>&quantity=<%=quantity%>&status=<%="Confirmed"%>&merchant_name=<%=merchant_name%>&user_name=<%=user_name%>&cust_mob=<%=cust_mob%>&cust_email=<%=cust_email%>&address=<%=address%>&merchant_mob=<%=merchant_mob%>&merchant_email=<%=merchant_email%>&deal_name=<%=deal_name%>&delivery_type=<%=delivery_type%>&longitude=<%=longitude%>&latitude=<%=latitude%>&delivery_address=<%=delivery_address%>&landmark=<%=landmark%>"
						style="border-radius: 2px;"> <b>Send Confirmation</b></a></td>
						
				<%
					}
					%>
											<td><a href="cancelorder.jsp?orderid=<%=orderid%>"> <b>Cancel</b></a></td>
		
										<td><a
						href="deliver.jsp?orderid=<%=orderid%>&orderdate=<%=orderdate%>&amount=<%=amount%>&quantity=<%=quantity%>&status=<%="Confirmed"%>&merchant_name=<%=merchant_name%>&user_name=<%=user_name%>&cust_mob=<%=cust_mob%>&cust_email=<%=cust_email%>&address=<%=address%>&merchant_mob=<%=merchant_mob%>&merchant_email=<%=merchant_email%>&deal_name=<%=deal_name%>&delivery_type=<%=delivery_type%>&longitude=<%=longitude%>&latitude=<%=latitude%>&delivery_address=<%=delivery_address%>&landmark=<%=landmark%>"
						style="border-radius: 2px;"> <b>Deliver</b></a></td>
		
					<%
					
					
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

				</tr>
			
			</table>





 --%>







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