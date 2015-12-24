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
<body>


	<%
		String start_date = "" + session.getAttribute("s_date");
		String end_date = "" + session.getAttribute("e_date");
		String exportToExcel = request.getParameter("exportToExcel");
		if (exportToExcel != null
				&& exportToExcel.toString().equalsIgnoreCase("YES")) {
			response.setContentType("application/vnd.ms-excel");
			response.setHeader("Content-Disposition", "inline; filename="
					+ "" + start_date + "_To_" + end_date + ".xls");

		}
	%>
	<table>
		<thead>
			<tr style="font-size: 14px; background-color: darkred; color: white;">
				<td>SI.No</td>
				<td>Order Ref/ID</td>
				<td>Payment Type</td>
				<td>payuMoneyId</td>
				<td>status</td>
				<td>amount</td>
				<td>Order Date</td>
				<td>Total Amount</td>
				<td>Discount Applied</td>
				<td>given Address</td>
				<td>google Address</td>
				<td>Landmark</td>
				<td>MerchantBranch Name</td>
				<td>Merchant Mob No</td>
				<td>Merchant Name</td>
				<td>Customer Name</td>
				<td>Customer email</td>
				<td>Cust. Mob. No.</td>
				<td>delivery_ship_id</td>
				<td>delivery_agent_name</td>
				<td>delivery_status</td>
				<td>Order_Status</td>
			</tr>
		</thead>
		<%
			PreparedStatement ps = null;
			ResultSet rs = null;
			PreparedStatement ps1 = null;
			ResultSet rs1 = null;
			PreparedStatement ps2 = null;
			ResultSet rs2 = null;
			PreparedStatement ps4 = null;
			ResultSet rs4 = null;
			PreparedStatement ps5 = null;
			ResultSet rs5 = null;
			PreparedStatement ps6 = null;
			ResultSet rs6 = null;
			PreparedStatement ps7 = null;
			ResultSet rs7 = null;
			int cont = 1;
			int gtotal = 0;
			Timestamp ts = new Timestamp(System.currentTimeMillis());
			String sda = "" + ts;
			String sdq = sda.substring(0, 10);
			DateFormat dateFormat = new SimpleDateFormat("yyyy-mm-dd");
			int qty;
			int pprice;
			String ss1, ss3;
			long user_id = 0;
			long merchantbranch_id = 0;
			long merchant_id = 0;
			String orderid = null;
			String orderdate = null;
			String amount = null;
			String quantity = null;
			String status = null;
			String merchant_name = null;
			String user_name = null;
			String cust_mob = null;
			String cust_email = null;
			String address = null;
			String merchant_mob = null;
			String merchant_email = null;
			String deal_name = null;
			String delivery_type = null;
			String deal_id = null;
			String longitude = null;
			String latitude = null;
			String delivery_address = null;
			String landmark = null;
			String coupon_code = null;
			String discount_method = null;
			double lat = 0;
			double lng = 0;
			String branch_name = null;
			String branch_address = null;
			String branch_lattitue1 = null;
			String branch_longitude1 = null;
			try {
				ps = con.prepareStatement("SELECT  * FROM neworderdetails where order_date_time BETWEEN '"
						+ start_date + "' AND '" + end_date + "'" );
				//ps.setString(1,"Confirmed");
				rs = ps.executeQuery();
				ArrayList ar = new ArrayList();
				while (rs.next()) {
					if(rs.getString("order_status").equals("Confirmed"))
					{
					Date orderdate1 = (Date) rs.getDate(10);
					String orderdate11 = "" + orderdate1;
					merchantbranch_id = rs.getLong(14);
					user_id = rs.getLong(13);
					orderid = rs.getString(15);
					orderdate = rs.getString(10);
					amount = rs.getString(8);
					quantity = rs.getString(7);
					address = rs.getString(4);
					deal_id = rs.getString(9);
					delivery_type = rs.getString(6);
					longitude = rs.getString(2);
					latitude = rs.getString(3);
					delivery_address = rs.getString("delivery_address");
					landmark = rs.getString("landmark");
					discount_method = rs.getString(16);
					coupon_code = rs.getString(18);
					lat = rs.getDouble(3);
					lng = rs.getDouble(2);
		%>
		<tr style="">
			<td><%=cont++%>
			<td><a
				href="orders.jsp?orderid=<%=orderid%>&coupon_code=<%=coupon_code%>&discount_method=<%=discount_method%>"
				style="color: darkblue"><%=rs.getString(15)%></a></td>
			<%
				if (rs.getString(6).equals("COD")
								|| rs.getString(6).equals("cod")) {
			%>
			<td><%=rs.getString(6)%></td>
			<%
				} else {
			%>
			<td><a href="paymentdetails.jsp?orderid=<%=orderid%>"
				style="color: darkblue"><%=rs.getString(6)%></a></td>
			<%
				}
						try {
							ps7 = con
									.prepareStatement("SELECT  * FROM newpayment where txnid=?");
							ps7.setString(1, orderid);
							rs7 = ps7.executeQuery();
							if (rs7.next()) {
			%>
			<td><%=rs7.getString("payuMoneyId")%></td>
			<td><%=rs7.getString("status")%></td>
			<td><%=rs7.getString("amount")%></td>
			<%
				} else {
			%>
			<td></td>
			<td></td>
			<td></td>
			<%
				}

						} catch (Exception ek) {

						}
			%><td><%=rs.getString(10)%></td>
			<td><%=rs.getString(8)%></td>
			<td><%=rs.getString(17)%></td>
			<td><%=rs.getString("delivery_address")%></td>
			<td></td>
			<td><%=rs.getString("landmark")%></td>
			<%
				try {
							ps5 = con
									.prepareStatement("SELECT  * FROM deal where id=?");
							ps5.setString(1, deal_id);
							rs5 = ps5.executeQuery();
							while (rs5.next()) {
								deal_name = rs5.getString(17);
			%>
			<%
				ps1 = con
										.prepareStatement("SELECT  * FROM merchantbranch where id=?");
								ps1.setLong(1, merchantbranch_id);

								rs1 = ps1.executeQuery();

								while (rs1.next()) {
									merchant_id = rs1.getLong(15);
									merchant_mob = rs1.getString("mobile_number");
									merchant_email = rs1.getString(16);
									branch_name = rs1.getString("branch_name");
									branch_address = rs1.getString("address");
									branch_lattitue1 = rs1.getString("lattitue");
									branch_longitude1 = rs1.getString("longitude");
			%>

			<td><%=rs1.getString(3)%></td>
			<td><%=rs1.getString("mobile_number")%></td>
			<%
				ps4 = con
											.prepareStatement("SELECT  * FROM merchant where id=?");
									ps4.setLong(1, merchant_id);

									rs4 = ps4.executeQuery();

									while (rs4.next()) {
										merchant_name = rs4.getString(8);
			%>

			<td><%=rs4.getString(8)%></td>

			<%
				}

								}

								ps2 = con
										.prepareStatement("SELECT  * FROM user where id=?");
								ps2.setLong(1, user_id);

								rs2 = ps2.executeQuery();

								while (rs2.next()) {
									user_name = rs2.getString(5);
									cust_mob = rs2.getString(2);
									cust_email = rs2.getString("email");
			%>

			<td><%=rs2.getString(5)%></td>
			<td><%=rs2.getString(14)%></td>
			<td><%=rs2.getString(2)%></td>
			<td><%=rs.getString("delivery_ship_id")%></td>
			<td><%=rs.getString("delivery_agent_name")%></td>
			<td><%=rs.getString("delivery_status")%></td>
			<%
				}
								if (rs.getString(12).equals("Confirmed")) {
			%>
			<td><%=rs.getString(12)%></td>
			<td></td>
			<%
				} else {
			%>
			<td><%=rs.getString(12)%></td>
			<%
				}
			%>
			<%
				}
						} catch (Exception ek) {

						}
					}
				}
				} catch (Exception e) {
					System.out.print(e);
				}
			%>
		</tr>
	</table>

</body>
</html>