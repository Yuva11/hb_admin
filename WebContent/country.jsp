<%@page import="java.sql.*"%>
<%@page import="java.awt.Window"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="javassist.bytecode.stackmap.BasicBlock.Catch"%>
<%@page import="java.sql.ResultSet"%>

<%@page import="java.sql.*"%>
<%@page import="java.text.*"%>
<%@page import="java.sql.ResultSet"%>

<%@page import="java.sql.*"%>
<%@page import="java.util.Date"%>
<%@include file="getcon.jsp"%>
 <html>
      <head>  
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
      <body>  
      			<form action="inserttokenno.jsp" method="get" name="f1" 	onsubmit="return validation()">
      
      <select name='country' onchange="showState(this.value)">  
       <option value="none">Select</option>  
    <%
/*  Class.forName("com.mysql.jdbc.Driver").newInstance();  
 Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/test","root","root");  
 */ Statement stmt = con.createStatement();  
 ResultSet rs = stmt.executeQuery("Select * from merchant");
 while(rs.next()){
     %>
      <option value="<%=rs.getString(1)%>"><%=rs.getString(8)%></option>  
      <%
 }
     %>
      </select>  
      <br>  
      <div id='state'>  
      <select name='state' >  
      <option value='-1'></option>  
      </select>  
      </div>  
      
      <input type="submit" value="Submit" style="margin-left: 11px;" />
</form>
      </body> 
      </html>