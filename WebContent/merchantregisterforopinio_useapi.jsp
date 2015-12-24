<%@page import="javassist.bytecode.stackmap.BasicBlock.Catch"%>
<%@page import="java.sql.ResultSet"%>
<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>
<%@page import="java.text.*"%>
<%@page import="java.sql.ResultSet"%>

<%@page import="java.sql.*"%>
<%@page import="java.util.Date"%>
<%@page import="newservice.*"%>
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
				
				    String country=request.getParameter("country");
					String state=request.getParameter("state");
				
					String mid=null;
					String mbid=null;long aid=0;
					String mbname=null;
			  
	              try
	              {
	      		ps3 = con.prepareStatement("select * from merchantbranch where id=?");
				ps3.setLong(1,Long.parseLong(state));
			    rs3=ps3.executeQuery();
			    if(rs3.next())
			    {
				   
				    OpinioPostOrderForMerchant opinioPostOrder=new OpinioPostOrderForMerchant();
					opinioPostOrder.setName(rs3.getString("branch_name"));
					opinioPostOrder.setPhone(rs3.getString("mobile_number"));
					System.out.println("merchant name -- "+rs3.getString("branch_name"));
					opinioPostOrder.setAddress(rs3.getString("address"));
					opinioPostOrder.setEmail(rs3.getString("alt_email_three"));
					opinioPostOrder.setLatitude(rs3.getString("lattitue"));
					opinioPostOrder.setLongitude(rs3.getString("longitude"));
					opinioPostOrder.setApp_merchant_id(rs3.getLong("id"));
					System.out.println("id----"+rs3.getLong("id"));
					
					Map<String, String> map=OpinioUtilsM.getPostAuthentication(opinioPostOrder);
					String canonicalString=map.get("canonicalString");
					String Authorization=map.get("authorization");
					
					String result=OpinioHelper.postOrderToOpinio(canonicalString, "http://deliver.opinioapp.com/api/v1/merchants",Authorization);
					System.out.println("result - "+result);
					out.print(result);
			       
			    }
			
				con.close();
				
			} catch (Exception e) {
				System.out.print(e);
			}

				%>



	<script>
       alert(' Merchant Successfully Registered');
         window.location='OpinioMerchant_register.jsp';
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