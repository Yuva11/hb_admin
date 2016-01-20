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
		if (document.f1.discountType.value == 0) {
			alert("Please select Discount type");
			document.f1.discountType.focus();
			return false;
		}
		if (document.f1.name2.value == 0) {
			alert("Please Enter Order type.");
			document.f1.name2.focus();
			return false;
		}
		if (document.f1.name3.value == 0) {
			alert("Please Enter Order value.");
			document.f1.name3.focus();
			return false;
		}
		if (document.f1.name4.value == 0) {
			alert("Please Enter Custom Message.");
			document.f1.name4.focus();
			return false;
		}
		if (document.f1.name5.value == 0) {
			alert("Please Enter Maximum Discount value.");
			document.f1.name5.focus();
			return false;
		}
		if (document.f1.name6.value == 0) {
			alert("Please Enter Minimum Order value.");
			document.f1.name6.focus();
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
      var url="state.jsp";
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
				Update Repeat order discount settings </h2>
			<div align="right"
				style="color: white; font-family: serif; padding: 0px;">
  <li class="logout" ><a href='logout.jsp' style="font-size: 13px"><b>Logout</b></a></li>
	</div>
	<form action="updateRepeatCouponCode.jsp" method="get" name="f1" 	onsubmit="return validation()">
	  		<table>	
	  			<%
					PreparedStatement ps3 = null;
					ResultSet rs3 = null;
					long id = Long.parseLong(request.getParameter("id"));
					long c=0;
			       try
	              {
	      		ps3 = con.prepareStatement("select * from  repeat_discount where id=?");
	      		ps3.setLong(1,id);
					
	      		rs3 = ps3.executeQuery();
	      		if(rs3.next())
	      		{
	    %>
	    		
			<tr>
						<td><input type="number" name="orderNumber" value="<%=rs3.getInt(2)%>" class="input_text"
							placeholder="Order number"
							style="width: 139px; padding: 4px; margin-bottom: 5px" /></td>
					</tr>

					<tr>
						<td><select type="text" name="discountType" class="input_text"
							style="width: 139px; padding: 4px; margin-bottom: 5px"
							placeholder="">
								<option value="0" >Discount type</option>
								<option value="1" <%if(rs3.getInt(3)==1){%> selected <%}%>>%</option>
								<option value="2" <%if(rs3.getInt(3)==2){%> selected <%}%>>Rs</option>
						</select></td>
					</tr>
					<tr>
						<td>
							<input type="number" name="discountValue" value="<%=rs3.getInt(4)%>" class="input_text"
							style="width: 139px; padding: 4px; margin-bottom: 5px"
							placeholder="Dicount value" /></td>
					</tr>

					<tr>
						<td>
							<textarea  placeholder="Discount Message (To be shown to the customer)" name="discountMessage" class="input_text"
								style="width: 139px; padding: 4px; margin-bottom: 5px"><%=rs3.getString(5)%></textarea></td>
					</tr>


					<tr>
						
						<td><input placeholder="Minimum order amount" type="number" name="minimumOrderAmount" class="input_text"
							style="width: 139px; padding: 4px; margin-bottom: 5px" value="<%=rs3.getDouble(6)%>"/></td>
					</tr>

					<tr>
						<td>
							<input placeholder="Maximum discount amount" type="number" name="maximumDiscountAmount" class="input_text"
							style="width: 139px; padding: 4px; margin-bottom: 5px" value="<%=rs3.getDouble(7)%>"/></td>
					</tr>



					<br />



					<br />
					<tr>
					
						<td>
						<input type="submit" value="update"
							style="margin-left: 11px;" />
							
							<input type="button" value="cancel"
							style="margin-left: 11px;" onclick="javascript:window.location='order-dashboard.jsp'" />
							</td>
					</tr>
					<br />
					<br />

					
		
		  <%  			
	      		}
    			
				ps3.executeUpdate();
				con.close();
				
			} catch (Exception e) {
				System.out.print(e);
			}

				%>
</form>
		</table>
		
			<br /> 






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