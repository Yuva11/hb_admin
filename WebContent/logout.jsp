<%@page import="java.sql.ResultSet"%>
<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*" %>


<!doctype html>
<!--[if lt IE 8]>         <html class="no-js lt-ie8"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js"> <!--<![endif]-->
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
         <title>indglobal inventory</title>
        <meta name="description" content="Responsive Admin Web App">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">

        <link href="http://fonts.googleapis.com/css?family=Lato:300,400,700,300italic,400italic" rel="stylesheet" type="text/css">
        <!-- Needs images, font... therefore can not be part of main.css -->
        <link rel="stylesheet" href="bower_components/font-awesome/css/font-awesome.min.css">
        <link rel="stylesheet" href="bower_components/weather-icons/css/weather-icons.min.css">
        <!-- end Needs images -->
        
            <link rel="stylesheet" href="styles/main.css"/>

    </head>
    
    <% 
  

    session.removeAttribute("uname");
    session.invalidate(); 
   
  
    	 response.sendRedirect("index.html");
   
%>
	  
   
    
    </body>
</html>