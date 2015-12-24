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

<body >



				<%
					PreparedStatement ps = null;
					ResultSet rs = null;
					PreparedStatement ps1 = null;
					ResultSet rs1 = null;
					
					PreparedStatement ps2 = null;
					ResultSet rs2 = null;
					
		
					PreparedStatement ps3 = null;
					ResultSet rs3 = null;
		
					long c=0;
				
					String name1=request.getParameter("name1");
					String name2=request.getParameter("name2");
					String name3=request.getParameter("name3");
					String name4=request.getParameter("name4");
					String name5=request.getParameter("name5");
					String name6=request.getParameter("name6");
					String name7=request.getParameter("name7");
					String name8=request.getParameter("name8");
					String name9=request.getParameter("name9");
					String name10=request.getParameter("name10");
					String name11=request.getParameter("name11");
					String name12=request.getParameter("name12");
					String name13=request.getParameter("name13");
					String name14=request.getParameter("name14");
					String name15=request.getParameter("name15");
					
					double d1=Double.parseDouble(name10);
					
					double d2=Double.parseDouble(name15);
					double d3=Double.parseDouble(name14);
					double Settlement_Amount=d1-d2;
					double P_and_L=d3-Settlement_Amount;
					
					double hb_discount_value=Double.parseDouble(name11);
					double Received_Amount_from_PG=Double.parseDouble(name12);
					double PG_Commission=Double.parseDouble(name13);
					
					
					String mid=null;
					String mbid=null;long aid=0;
					String mbname=null;
	         
	         	              
	              try
	              {
	      		ps3 = con.prepareStatement("insert into payment_recon values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
				ps3.setLong(1,c);
				ps3.setString(2,name1);
				ps3.setString(3,name2);
				ps3.setString(4,name3);
				ps3.setString(5,name4);
				ps3.setString(6,name5);
				ps3.setString(7,name6);
				ps3.setString(8,name7);
				ps3.setString(9,name8);
				ps3.setString(10,name9);
				ps3.setDouble(11,d1);
				ps3.setDouble(12,hb_discount_value);
				ps3.setDouble(13,Received_Amount_from_PG);
				ps3.setDouble(14,PG_Commission);
				ps3.setDouble(15,d3);
				ps3.setDouble(16,d2);
				ps3.setDouble(17,Settlement_Amount);
				ps3.setDouble(18,P_and_L);
				
				ps3.executeUpdate();
				con.close();
				
			} catch (Exception e) {
				System.out.print(e);
			}

				%>



	<script>
       alert(' Reconciled Successfully inserted');
         window.location='reconciled.jsp';
</script>
		


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