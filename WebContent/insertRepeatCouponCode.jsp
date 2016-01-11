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

</head>
  <% 
   String s1=(String)session.getAttribute("uname");
 
    if(!(s1==null))
    {
   
    %>

<body >
				<%
					PreparedStatement ps3 = null;
					ResultSet rs = null;
							long c=0;
					int orderNumber=Integer.parseInt(request.getParameter("orderNumber"));
					int discountType=Integer.parseInt(request.getParameter("discountType"));
					int discountValue=Integer.parseInt(request.getParameter("discountValue"));
					
					String discountMessage=request.getParameter("discountMessage");
					
					double maximumDiscountAmount=Double.parseDouble(request.getParameter("maximumDiscountAmount"));
					double minimumOrderAmount=Double.parseDouble(request.getParameter("minimumOrderAmount"));
					
				     try
	              {
	      		ps3 = con.prepareStatement("insert into repeat_discount values(?,?,?,?,?,?,?)");
				ps3.setLong(1,c);
				ps3.setInt(2,orderNumber);
				ps3.setInt(3,discountType);
				ps3.setInt(4,discountValue);
				ps3.setString(5,discountMessage);
				ps3.setDouble(6,maximumDiscountAmount);
				ps3.setDouble(7,minimumOrderAmount);
				ps3.executeUpdate();
				con.close();
				%>
				<script>
       alert(' Coupon Code Successfully inserted');
         window.location='repeat_order_discount.jsp';
</script>
				<% 
				
			} catch (Exception e) {
				%>
				<script>
       alert('OrderNumber already exists');
         window.location='repeat_order_discount.jsp';
</script>
				<%
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