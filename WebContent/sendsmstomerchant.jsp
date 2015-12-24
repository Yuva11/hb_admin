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
<!-- </script>

	
	
 -->	
 
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
		
		if (document.f1.name10.value == "-select coupon type--") 
		{
			alert("Please select coupon type..");
			document.f1.name10.focus();
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
    <script language="javascript" type="text/javascript">  
      var xmlHttp  
      var xmlHttp
      function showState(str){
      if (typeof XMLHttpRequest != "undefined"){
      xmlHttp= new XMLHttpRequest();
      }
      else if (window.ActiveXObject){
      xmlHttp= new ActiveXObject("Microsoft.XMLHTTP");
      }
      if (xmlHttp==null){
      alert("Browser does not support XMLHTTP Request")
      return;
      } 
      var url="state1.jsp";
      url +="?count=" +str;
      xmlHttp.onreadystatechange = stateChange;
      xmlHttp.open("GET", url, true);
      xmlHttp.send(null);
      }

      function stateChange(){   
      if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){   
      document.getElementById("state").innerHTML=xmlHttp.responseText   
      }   
      }

      function showCity(str){
      if (typeof XMLHttpRequest != "undefined"){
        xmlHttp= new XMLHttpRequest();
        }
      else if (window.ActiveXObject){
        xmlHttp= new ActiveXObject("Microsoft.XMLHTTP");
        }
      if (xmlHttp==null){
      alert("Browser does not support XMLHTTP Request")
      return;
      } 
      var url="city.jsp";
      url +="?count=" +str;
      xmlHttp.onreadystatechange = stateChange1;
      xmlHttp.open("GET", url, true);
      xmlHttp.send(null);
      }
      function stateChange1(){   
      if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){   
      document.getElementById("city").innerHTML=xmlHttp.responseText   
      }   
      }
      </script>  
    
    
 
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
				Sms Send to Merchant </h2>
			<div align="right"
				style="color: white; font-family: serif; padding: 0px;">
  <li class="logout" ><a href='logout.jsp' style="font-size: 13px"><b>Logout</b></a></li>
	</div>
	<form action="sendsmstomerchantconfirm.jsp" method="get" name="f1" 	onsubmit="return validation()">
	  		<table>	
			<tr>		
			<td>Enter Mob No.</td> <td><input type="text" name="name1"  class="input_text"  
					style="margin-bottom: 5px;
    margin-right: 277px;
    padding: 9px;
    width: 158px;" /></td></tr>
						<tr>		
					 <br />
			<tr>		
			<td>Enter SMS Template</td> <td> <textarea rows="6" cols="70" name="smstemp" style="margin-left: 7px;">
</textarea> 
					</td></tr>
						<tr>		
				<br /> 
				<tr><td></td> <td><input type="submit" value="Submit" style="margin-left: 11px;" /></td></tr> <br /> <br />
</form>
		</table>
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