<%@ page import="java.sql.*" %>
<%!
Connection con=null;
  PreparedStatement ps=null;
  String kk=null;
    String secondsoft=null;
    String title=null;
%>
<%
Class.forName("com.mysql.jdbc.Driver");
con=DriverManager.getConnection("jdbc:mysql://localhost:3306/proddump","root","");

%>