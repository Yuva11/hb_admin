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
					String merchant_id=request.getParameter("country");
					String merchantbranch_id=request.getParameter("state");
					String agent=request.getParameter("name3");
					String token=request.getParameter("name4");
					
					String mid=null;
					String mbid=null;long aid=0;
					String mbname=null;
	              try {
						
						
						ps1 = con.prepareStatement("select * from   merchant where id=?");
						ps1.setString(1,merchant_id);

						rs1=ps1.executeQuery();
						if(rs1.next())
						{
							mid=rs1.getString(8);
							
						}
						
						
					} catch (Exception e) {
						System.out.print(e);
					}

	              
	              try {
						
						
						ps2 = con.prepareStatement("select * from   merchantbranch where id=?");
						ps2.setString(1,merchantbranch_id);

						rs2=ps2.executeQuery();
						if(rs2.next())
						{
							mbid=rs2.getString(3);
							mbname=rs2.getString("branch_name");
							
						}
						
						
					} catch (Exception e) {
						System.out.print(e);
					}
	              
	              
	              try
	              {
	      		ps3 = con.prepareStatement("select * from   deliveryagent where name=?");
				ps3.setString(1,agent);

				rs3=ps3.executeQuery();
				if(rs3.next())
				{
					aid=rs3.getLong(1);
	             }
				
				
			} catch (Exception e) {
				System.out.print(e);
			}

					try {
						
						
						ps = con.prepareStatement("insert into newtokenno values(?,?,?,?,?,?,?,?)");
						ps.setLong(1,c);
						ps.setString(2,mid);
						ps.setString(3,merchant_id);
						ps.setString(4,mbid);
						ps.setString(5,merchantbranch_id);
						ps.setString(6,agent);
						ps.setLong(7,aid);
						ps.setString(8,token);
						ps.executeUpdate();
						con.close();

						
						
					} catch (Exception e) {
						System.out.print(e);
					}
				%>



	<script>
       alert(' Token Successfully inserted');
         window.location='adddeliveryagect.jsp';
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