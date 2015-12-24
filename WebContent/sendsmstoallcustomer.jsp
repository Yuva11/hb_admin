<%@page import="newservice.SpearSMSUtility"%>
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
	<%
			PreparedStatement ps = null;
			ResultSet rs = null;
			long c = 0;
			String percentage = request.getParameter("name1");
			String couponname = request.getParameter("country");
			String smstemp = request.getParameter("smstemp");
			String allMobNo = "";
			SpearSMSUtility smsUtility = new SpearSMSUtility();
			try {
				ps = con.prepareStatement("SELECT DISTINCT u.contact_number,u.name FROM user u JOIN neworderdetails nod ON u.id=nod.user_id WHERE nod.order_status='Confirmed' AND contact_number NOT IN('NULL') GROUP BY u.contact_number");
				rs = ps.executeQuery();
				while (rs.next()) {
					allMobNo += rs.getString(1) + ",";
				}
				if (allMobNo.endsWith(","))
					allMobNo = allMobNo.substring(0, allMobNo.length() - 1);
				con.close();
				
				String smob[] = allMobNo.split(",");
				String sendMobile="";
				int count=1;
				int totalNumbers=smob.length;
				int cocent=totalNumbers/250;
				int lastBatch=totalNumbers-cocent*250;
				int countNumber=1;
				int countNumber2=1;
				for (int i = 0; i < smob.length; i++) {
					if(count<=cocent){
						if(countNumber==250){
							System.out.println("---mobno--1-- "+sendMobile.split(",").length);
							System.out.println("---mobno--1-- "+sendMobile);
							smsUtility.process_sms(sendMobile, smstemp,"A16208eead890aefe9b73e725cc4eeebe", null, null);
							countNumber=1;
							count++;
							sendMobile="";
						}else{
							sendMobile=sendMobile+smob[i]+",";
							countNumber++;
						}
					}else{
						sendMobile=sendMobile+smob[i]+",";
						if(countNumber2==lastBatch){
							System.out.println("---mobno--2--"+sendMobile.split(",").length);
							System.out.println("---mobno--2-- "+sendMobile);
							smsUtility.process_sms(sendMobile, smstemp,"A16208eead890aefe9b73e725cc4eeebe", null, null);
							countNumber2=1;
							sendMobile="";
							System.out.print("Done");
						}
						countNumber2++;
					}
				}
			} catch (Exception ek) {
				ek.printStackTrace();
			}
	%>
	<script>
       alert('Sms Sent Successfully');
         window.location='sendsmstocustomer.jsp';
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