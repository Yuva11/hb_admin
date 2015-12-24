
<%@page import="javassist.bytecode.stackmap.BasicBlock.Catch"%>
<%@page import="java.sql.ResultSet"%>
<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>
<%@page import="java.text.*"%>
<%@page import="java.sql.ResultSet"%>

<%@page import="java.sql.*"%>
<%@page import="java.util.Date"%>
<%@include file="getcon.jsp"%>

<%@ page language="java" import="java.util.*"%>
 <%@ page language="java" import="java.sql.*"%>

<html>
    <head>
        <title></title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body>

      <table width="980px" height="450px" align="center" >

          <tr bgcolor="#7BA6B4" height="50px" >
              <td>
                  <P ALIGN="CENTER"> <font color="darkblue" size="4"><b>BODYYOKE 75% INVOICE</b></font> </P> 
              </td>

          </tr>
          <tr><td></td></tr>


         <tr align="left">
           <td valign="top" >
              <form name="form8">
                  <table  height="170px">





                  <tr>
                     <td>
                         <b><font color="darkblue" size="4">From Date</font></b>
                     </td>
                     <td >
                         <select name="date" style="width: 46px; background:white; border-width: 1px border-color:darkblue; color:darkblue; font-weight: bold; font-size: 14px">
                              <option>dd</option>
                              <option>01</option>
                              <option>02</option>
                              <option>03</option>
                              <option>04</option>
                              <option>05</option>
                              <option>06</option>
                              <option>07</option>
                              <option>08</option>
                              <option>09</option>
                              <option>10</option>
                              <option>11</option>
                              <option>12</option>
                              <option>13</option>
                              <option>14</option>
                              <option>15</option>
                              <option>16</option>
                              <option>17</option>
                              <option>18</option>
                              <option>19</option>
                              <option>20</option>
                              <option>21</option>
                              <option>22</option>
                              <option>23</option>
                              <option>24</option>
                              <option>25</option>
                              <option>26</option>
                              <option>27</option>
                              <option>28</option>
                              <option>29</option>
                              <option>30</option>
                              <option>31</option>

                         </select>

                         <select name="month" style="width: 52px; background:white; border-width: 1px border-color:darkblue; color:darkblue; font-weight: bold; font-size: 14px">
                              <option>mm</option>  
                              <option>01</option>
                              <option>02</option>
                              <option>03</option>
                              <option>04</option>
                              <option>05</option>
                              <option>06</option>
                              <option>07</option>
                              <option>08</option>
                              <option>09</option>
                              <option>10</option>
                              <option>11</option>
                              <option>12</option>

                         </select>

                         <select name="year" style="width: 63px; background:white; border-width: 1px border-color:darkblue; color:darkblue; font-weight: bold; font-size: 14px">

                             <option>yyyy</option>
                             <option>2012</option>
                             <option>2013</option>
                             <option>2014</option>
                               <option>2015</option>

                         </select>
                     </td>
                   </tr>
              <tr>
                     <td>
                         <b><font color="darkblue" size="4">To Date</font></b>
                     </td>
                     <td >
                         <select name="date1" style="width: 46px; background:white; border-width: 1px border-color:darkblue; color:darkblue; font-weight: bold; font-size: 14px">
                              <option>dd</option>
                              <option>01</option>
                              <option>02</option>
                              <option>03</option>
                              <option>04</option>
                              <option>05</option>
                              <option>06</option>
                              <option>07</option>
                              <option>08</option>
                              <option>09</option>
                              <option>10</option>
                              <option>11</option>
                              <option>12</option>
                              <option>13</option>
                              <option>14</option>
                              <option>15</option>
                              <option>16</option>
                              <option>17</option>
                              <option>18</option>
                              <option>19</option>
                              <option>20</option>
                              <option>21</option>
                              <option>22</option>
                              <option>23</option>
                              <option>24</option>
                              <option>25</option>
                              <option>26</option>
                              <option>27</option>
                              <option>28</option>
                              <option>29</option>
                              <option>30</option>
                              <option>31</option>

                         </select>

                         <select name="month1" style="width: 52px; background:white; border-width: 1px border-color:darkblue; color:darkblue; font-weight: bold; font-size: 14px">
                              <option>mm</option>  
                              <option>01</option>
                              <option>02</option>
                              <option>03</option>
                              <option>04</option>
                              <option>05</option>
                              <option>06</option>
                              <option>07</option>
                              <option>08</option>
                              <option>09</option>
                              <option>10</option>
                              <option>11</option>
                              <option>12</option>

                         </select>

                         <select name="year1" style="width: 63px; background:white; border-width: 1px border-color:darkblue; color:darkblue; font-weight: bold; font-size: 14px">

                             <option>yyyy</option>
                             <option>2012</option>
                             <option>2013</option>
                             <option>2014</option>
                             <option>2015</option>
                             <option>2014</option>
                             <option>2014</option>

                         </select>
                     </td>
                   </tr>

                  <tr>
                      <td colspan="2" >
                          <input type="submit" style="background-color: #000080; color: yellow; font-weight: bold" name="submit" value="SUBMIT">
                          <input type="reset" style="background-color: #000080; color: yellow; font-weight: bold" name="RESET" value="RESET">
                      </td>
                  </tr>


   </table>

    </form>          

<%@ page language="java" import="java.util.*"%> 
  <%@ page language="java" import="java.sql.*"%>
  <%@ page language="java" import="java.sql.Date.*"%>
  <%@ page language="java" import="java.text.DateFormat"%>
<%@ page language="java" import="java.text.SimpleDateFormat"%>
<%
                double tivalue8=0.0;


                String date2=request.getParameter("date");
                String month2=request.getParameter("month");
                String year2=request.getParameter("year");
                StringBuffer obj = new StringBuffer();
                obj.append(date2);
                obj.append("-");
                obj.append(month2);
                obj.append("-");
                obj.append(year2);

                String fdate = obj.toString();


                String date11=request.getParameter("date1");
                String month11=request.getParameter("month1");
                String year11=request.getParameter("year1");
                StringBuffer obj1 = new StringBuffer();
                obj1.append(date11);
                obj1.append("-");
                obj1.append(month11);
                obj1.append("-");
                obj1.append(year11);

                String tdate = obj1.toString();

   %>
   <%

              if ( fdate != null  && tdate != null ) 

             {
             /*    Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
                Connection con = DriverManager.getConnection("jdbc:odbc:pavithra");
             */    Statement st=con.createStatement();


                String query ="select * from deal where start_date>='"+fdate+"' AND end_date<='"+tdate+"'";

                ResultSet rs=st.executeQuery(query);
                while(rs.next())
                   {

                    String dd=rs.getString("start_date");
                      int number=rs.getInt("id");

                           out.println(dd);

                          out.println(number);
                          out.println("<br>");
                   }

             }      
%>   

      </table> 
   </body>
</html>