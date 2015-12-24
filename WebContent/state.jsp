<%@page import="java.sql.*"%>
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
<%
String country=request.getParameter("count");  
 String buffer="<select name='state' onchange='showCity(this.value);' style='width:150px;margin-left: 8px;'><option value='-1'>Select</option>";  
 try{
 /* Class.forName("com.mysql.jdbc.Driver").newInstance();  
 Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/test","root","root");  
 */ Statement stmt = con.createStatement();  
 ResultSet rs = stmt.executeQuery("Select * from merchantbranch where merchant_id='"+country+"' ");  
   while(rs.next()){
   buffer=buffer+"<option value='"+rs.getLong(1)+"'>"+rs.getString(3)+"</option>";  
   }  
 buffer=buffer+"</select>";  
 response.getWriter().println(buffer); 
 }
 catch(Exception e){
     System.out.println(e);
 }

 %>