<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Export to Excel - Demo</title>
</head>
<body>
    <%
        String exportToExcel = request.getParameter("exportToExcel");
        if (exportToExcel != null
                && exportToExcel.toString().equalsIgnoreCase("YES")) {
            response.setContentType("application/vnd.ms-excel");
            response.setHeader("Content-Disposition", "inline; filename="
                    + "excel.xls");
 
        }
    %>
    <table align="left" border="2">
        <thead>
            <tr >
                <th>Sr. No.</th>
                <th>Text Data</th>
                <th>Number Data</th>
            </tr>
        </thead>
        <tbody>
            <%
                for (int i = 0; i < 10; i++) {
            %>
            <tr >
                <td ><%=i + 1%></td>
                <td >This is text data <%=i%></td>
                <td ><%=i * i%></td>
            </tr>
            <%
                }
            %>
        </tbody>
    </table>
    <%
        if (exportToExcel == null) {
    %>
    <a href="ExcelExport.jsp?exportToExcel=YES">Export to Excel</a>
    <%
        }
    %>
</body>
</html>
