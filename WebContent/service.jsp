<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="java.sql.*"%>
<%@page import="java.util.Date"%>
<%@include file="getcon.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<script>

    function get(str)
    {
        var xmlhttp=new XMLHttpRequest();
        xmlhttp.onreadystatechange=function()
          {
          if (xmlhttp.readyState==4 && xmlhttp.status==200)
            {
              document.getElementById("tb2").value=xmlhttp.responseText;
              document.getElementById("tb3").value=xmlhttp.responseText;
            }
          }
        xmlhttp.open("GET","Demo?q="+str,true);
        xmlhttp.send();

    }

    </script>
</head>

<body>
Edit book details:</br>
Enter Book Id: <input type="text" id="tb1" onkeyup="get(this.value)"/></br>
Book name is: <input type="text" id="tb2"/></br>
Course is: <input type="text" id="tb3"/></br>


<%
String str=request.getParameter("q");

String book,course;
try
{
       
       
        PreparedStatement ps=con.prepareStatement("select  * from user where id=?");
        ps.setInt(1,Integer.parseInt(str));
        ResultSet rs=ps.executeQuery();
        if(rs.next())
        {
            book=rs.getString(2);
            course=rs.getString(3);
        }
        else
        {
            book="";
            course="";
        }
        response.getWriter().write(book);
        response.getWriter().write(course);

}
catch(Exception e)
{

	
    e.printStackTrace();
}


%>
</body>
</html>