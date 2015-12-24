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
 
 PreparedStatement ps = null;
	ResultSet rs = null;
	try{      
		 String s[]=null;

/* 	  Class.forName("com.mysql.jdbc.Driver");  
    Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/hb_10018r1_14072015","root","");  
 */  Statement st=con.createStatement(); 
		 rs = st.executeQuery("select * from  merchant");
		
	    	List li = new ArrayList();
	    
			while(rs.next()) 
 			{ 			    
 			    li.add(rs.getString(8));
 			}  
			
			String[] str = new String[li.size()];			
			Iterator it = li.iterator();
			
			int i = 0;
			while(it.hasNext())
			{
				String p = (String)it.next();	
				str[i] = p;
				i++;
			}
		
			//jQuery related start		
				String query = (String)request.getParameter("q");
				
				int cnt=1;
				for(int j=0;j<str.length;j++)
				{
					if(str[j].toUpperCase().startsWith(query.toUpperCase()))
					{
						out.print(str[j]+"\n");
						if(cnt>=5)
							break;
						cnt++;
					}
				}
			//jQuery related end	
		
			
 		rs.close(); 
 		st.close(); 
		con.close();

		    } 
		catch(Exception e){ 
 			e.printStackTrace(); 
 		}


 %>