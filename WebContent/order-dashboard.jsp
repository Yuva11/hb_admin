<%@page import="com.sun.faces.facelets.tag.jstl.core.ForEachHandler"%>
<%@page import="javax.security.auth.login.FailedLoginException"%>
<%@page import="java.sql.ResultSet"%>
<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>
<%@page import="java.text.*"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.Date"%>
<%@include file="getcon.jsp"%>
<head>
<%@include file="message.jsp"%>
<meta http-equiv="cleartype" content="on">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">

<!-- Responsive and mobile friendly stuff -->
<meta name="HandheldFriendly" content="True">
<meta name="MobileOptimized" content="320">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link rel="shortcut icon" href="/favicon.ico">
<link rel="stylesheet" href="css/style34.css" media="all">
<link rel="stylesheet" href="css/jquery-ui.min.css">

<script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?sensor=true"></script>
<script src="https://code.jquery.com/jquery-2.1.4.min.js"></script>
<script src="js/jquery-ui.js"></script>
<script src="https://cdn.rawgit.com/nnattawat/flip/v1.0.16/dist/jquery.flip.min.js"></script>
   
<title>Hungry Bells</title>

<style type="text/css">
#maincontent .col {
	background: #ccc;
	background: rgba(204, 204, 204, 0.85);
}

.ui-state-default, .ui-widget-content .ui-state-default,
	.ui-widget-header .ui-state-default {
	background-color: #8b0000;
	color: white;
	font-size: 2em !important;
}

#searchFilters  td {
	text-align: left !important;
}

.btn {
	background-color: #8B0000 !important;
	color: #FFFFFF;
	padding: 5px;
	font-size: 12px;
}

.btn-success {
	background-color: #05590C !important;
}

tr.heading td {
	font-size: 1em;
	padding: 10px;
}

tr.heading {
	margin-bottom: 20px;
	background-color: #8B0000;
	font-weight: bold;
}

input, select, number {
	margin: 5px;
}

select {
	width: 165px;
}

number, text {
	width: 200px;
}

.action-link {
	margin: 10px;
	display: block;
	color:white !important;
}

.action-item {
	list-style: none;
}

#testTable {
	margin-top: 3px;
}

.center {
	text-align: center;
}

.left-align {
	text-align: left;
}

.link-next-page, .link-prev-page {
	margin: 10px;
}

#orderSummary {
	font-size: 15px;
	font-weight: normal;
	float: right;
	text-align: left;
	width: 10%;
	text-transform: capitalize;
}

.order-count {
	float: right;
}

.new-order-count {
	color: black;
	margin-left: -16px;
	margin-right: 2px;
	margin-top: 25px;
	position: absolute;
}

#pendingOrderNotificaton {
	float: left;
	background-color: white;
	padding-right: 20px;
	display: none;
	margin-top: 10px;
}

.coupon {
	border: 3px dotted black;
	margin-left: 25px;
	margin-top: 20px;
	padding: 5px;
	text-transform: uppercase;
	width: -moz-min-content;
	text-align:center;
}

a {
	color:#8B0000 !important;
}

.edit-dish {
	overflow-x: hidden;
    overflow-y: scroll;
    width: 170% !important;
    height: 200px !important;
    background-color: white;
	border:2px solid black;    
}

.change-link {
	text-transform:none !important
}


.icon-call, .icon-sms {
    margin-bottom: -3px;
    margin-left: 7px;
}

 .dish-edit-summary {
 	text-align: center;
 }
 
 .strike {
 	  text-decoration: line-through;
 }
 
 .menuLink{
 	margin-top:10px;
 }
 .menuLink > a >  p {
 	margin-left:10px !important;
 }
</style>
</head>
<%
	 class Kitchen {
		String name;
		long id;
		public Kitchen(long id,String name){
			this.id=id;
			this.name=name;
		}
		
		public long getId(){
			return this.id;
		}
		
		public String getName(){
			return this.name;
		}
	}

	int totalAmount=0;

	ArrayList<Kitchen> kitchens=new ArrayList<Kitchen>();

	int pageNo = 0;
	//Session check
	String userName = (String) session.getAttribute("uname");
	if (userName == null)
		response.sendRedirect("index.html");

	boolean paymentSuccessFilter = true;
	float orderAmount = -1, discountAmount = -1;
	String startDate = "", endDate = "", orderId = "", couponCode = "", kitchenName = "", kitchenBranch = "",
			customerName = "", customerMobile = "", customerEmail = "", paymentType = "", orderStatus = "",
			customerAddress = "", customerLandMark = "", kitchenMobile = "", kitchenEmail = "",
			deliveryAgent = "", deliveryStatus = "";
	long userId = 0, latestOrderId = 0;
	String paymentSuccessCheck = "";
	
	//Pagination
	int serialNumber = 1,ordersPerPage=20;
	PreparedStatement ps = null;
	ResultSet rs = null;
	String query,whereConditions="";

	//Get parameter values if not found in session	
	//Date
	if (request.getParameter("startDate") != null)
		startDate = request.getParameter("startDate");
	else if (session.getAttribute("startDate") != null)
		startDate = session.getAttribute("startDate").toString();
	if (startDate.equals(""))
		startDate = new SimpleDateFormat("yyyy-MM-dd").format(new Date());

	if (request.getParameter("endDate") != null)
		endDate = request.getParameter("endDate");
	else if (session.getAttribute("endDate") != null)
		endDate = session.getAttribute("endDate").toString();
	if (endDate.equals(""))
		endDate = new SimpleDateFormat("yyyy-MM-dd").format(new Date());

	//Order details
	if (request.getParameter("orderStatus") != null)
		orderStatus = request.getParameter("orderStatus");
	else if (session.getAttribute("orderStatus") != null)
		orderStatus = session.getAttribute("orderStatus").toString();

	if (request.getParameter("orderId") != null)
		orderId = request.getParameter("orderId");
	else if (session.getAttribute("orderId") != null)
		orderId = session.getAttribute("orderId").toString();

	orderId = orderId.trim();

	try {
		if (request.getParameter("orderAmount") != null)
			orderAmount = Integer.parseInt(request.getParameter("orderAmount").toString());
		else if (session.getAttribute("orderAmount") != null)
			orderAmount = Integer.parseInt(session.getAttribute("orderAmount").toString());
	} catch (Exception e) {
		orderAmount = -1;
	}

	try {
		if (request.getParameter("discountAmount") != null)
			discountAmount = Integer.parseInt(request.getParameter("discountAmount").toString());
		else if (session.getAttribute("discountAmount") != null)
			discountAmount = Integer.parseInt(session.getAttribute("discountAmount").toString());
	} catch (Exception e) {
		discountAmount = -1;
	}

	if (request.getParameter("couponCode") != null)
		couponCode = request.getParameter("couponCode").toString();
	else if (session.getAttribute("couponCode") != null)
		couponCode = session.getAttribute("couponCode").toString();

	//Customer Details
	try {
		if (request.getParameter("userId") != null)
			userId = Long.parseLong(request.getParameter("userId").toString());
		else if (session.getAttribute("userId") != null)
			userId = Long.parseLong(session.getAttribute("userId").toString());
	} catch (Exception e) {
		userId = 0;
	}

	if (request.getParameter("customerName") != null)
		customerName = request.getParameter("customerName");
	else if (session.getAttribute("customerName") != null)
		customerName = session.getAttribute("customerName").toString();

	if (request.getParameter("customerMobile") != null)
		customerMobile = request.getParameter("customerMobile").toString();
	else if (session.getAttribute("customerMobile") != null)
		customerMobile = session.getAttribute("customerMobile").toString();

	if (request.getParameter("customerLandMark") != null)
		customerLandMark = request.getParameter("customerLandMark").toString();
	else if (session.getAttribute("customerLandMark") != null)
		customerLandMark = session.getAttribute("customerLandMark").toString();

	if (request.getParameter("customerAddress") != null)
		customerAddress = request.getParameter("customerAddress").toString();
	else if (session.getAttribute("customerAddress") != null)
		customerAddress = session.getAttribute("customerAddress").toString();

	//Kitchen Details
	if (request.getParameter("kitchenName") != null)
		kitchenName = request.getParameter("kitchenName").toString();
	else if (session.getAttribute("kitchenName") != null)
		kitchenName = session.getAttribute("kitchenName").toString();

	if (request.getParameter("kitchenBranch") != null)
		kitchenBranch = request.getParameter("kitchenBranch").toString();
	else if (session.getAttribute("kitchenBranch") != null)
		kitchenBranch = session.getAttribute("kitchenBranch").toString();

	if (request.getParameter("kitchenMobile") != null)
		kitchenMobile = request.getParameter("kitchenMobile").toString();
	else if (session.getAttribute("kitchenMobile") != null)
		kitchenMobile = session.getAttribute("kitchenMobile").toString();

	if (request.getParameter("kitchenEmail") != null)
		kitchenEmail = request.getParameter("kitchenEmail").toString();
	else if (session.getAttribute("kitchenEmail") != null)
		kitchenEmail = session.getAttribute("kitchenEmail").toString();

	//Payment Details
	if (request.getParameter("paymentType") != null)
		paymentType = request.getParameter("paymentType").toString();
	else if (session.getAttribute("paymentType") != null)
		paymentType = session.getAttribute("paymentType").toString();

	if (request.getParameter("paymentSuccessFilter") == null
			|| session.getAttribute("paymentSuccessFilter") == null)
		paymentSuccessFilter = true;
	else
		paymentSuccessFilter = false;

	//Delivery details
	if (request.getParameter("deliveryAgentFilter") != null)
		orderStatus = request.getParameter("deliveryAgentFilter");

	if (request.getParameter("deliveryAgentFilter") != null)
		orderStatus = request.getParameter("deliveryAgentFilter");

	
	try {
		pageNo = Integer.parseInt(request.getParameter("pageNo").toString());
	} catch (Exception exception) {
		try {
			if (pageNo == 0)
				pageNo = Integer.parseInt(session.getAttribute("pageNo").toString());
		} catch (Exception e) {
			pageNo = 1;
		}
	}

	//System.out.println("Page No:" + pageNo);
	try {
		String fieldNames = "o.id,o.user_id,o.`order_id`,o.order_type,order_date_time,DATE_FORMAT(o.order_date_time,'%d %b %Y') as order_date,DATE_FORMAT(o.order_date_time,'%h:%i %p') as order_time,o.order_amount,o.discount_amount,o.delivery_address,o.latitude,o.longitude,o.coupan_code as coupon_code,lower(o.order_status) as order_status,lower(o.delivery_status) as delivery_status,o.delivery_agent_name as delivery_agent_name,u.`name` as customer_name,u.`contact_number` as customer_mobile,u.`email` as customer_email,o.landmark,m.id as kitchen_id,m.name as kitchen_name,mb.id as branch_id,mb.`branch_name`,mb.`address` as kitchen_address,mb.`lattitue` as kitchen_latitude,mb.`longitude` as kitchen_longitude,o.`order_quantity`,mb.mobile_number as kitchen_mobile1,mb.`alt_mobile_number_one` as kitchen_mobile2,mb.`alt_mobile_number_two` as kitchen_mobile3, mb.`alt_mobile_number_three` as kitchen_mobile4,mb.`e_mail` as kitchen_email,d.`name` as deal_name,o.discount_method,o.remarks as order_remarks,o.delivery_distance,p.amount as paid_amount,p.status as payment_status";

		String dateCheck = "";
		if (!(startDate.equals("") && endDate.equals("")))
			dateCheck = "DATE(order_date_time) BETWEEN '" + startDate + "' AND '" + endDate + "'";

		String orderStatusCheck = "";
		if (!(orderStatus.equals("") || orderStatus.equals("all"))) {
			if (orderStatus.equals("received"))
				orderStatusCheck = " and (o.order_status ='booked' or o.order_status='received')";
			else
				orderStatusCheck = " and o.order_status='" + orderStatus + "'";
		}

		String userIdCheck = "";
		if (userId > 0)
			userIdCheck = " and u.id=" + userId;

		String orderIdCheck = "";
		if (!orderId.equals(""))
			orderIdCheck = " lower(o.order_id) like '%" + orderId.toLowerCase() + "%'";

		String orderAmountCheck = "";
		if (orderAmount >= 0)
			orderAmountCheck = " and o.order_amount=" + orderAmount;

		String discountAmountCheck = "";
		if (discountAmount >= 0)
			discountAmountCheck = " and o.discount_amount=" + discountAmount;

		String couponCodeCheck = "";
		if (!couponCode.equals(""))
			couponCodeCheck = " and lower(o.coupan_code) like '%" + couponCode.toLowerCase() + "%'";

		String customerNameCheck = "";
		if (!customerName.equals(""))
			customerNameCheck = " and lower(u.name) like '%" + customerName.toLowerCase() + "%'";

		String customerMobileCheck = "";
		if (!customerMobile.equals(""))
			customerMobileCheck = " and u.contact_number like '%" + customerMobile + "%'";

		String customerEmailCheck = "";
		if (!customerEmail.equals(""))
			customerEmailCheck = " and lower(u.email) like '%" + customerEmail.toLowerCase() + "%'";

		String kitchenNameCheck = "";
		if (!kitchenName.equals(""))
			kitchenNameCheck = " and lower(m.name) like '%" + kitchenName.toLowerCase() + "%'";

		String kitchenBranchCheck = "";
		if (!kitchenBranch.equals(""))
			kitchenBranchCheck = " and lower(mb.branch_name) like '%" + kitchenBranch.toLowerCase() + "%'";

		String kitchenMobileCheck = "";
		if (!kitchenMobile.equals(""))
			kitchenMobileCheck = " and (mb.mobile_number like '%" + kitchenMobile
					+ "%' or mb.alt_mobile_number_one like '%+" + kitchenMobile
					+ "%' or mb.alt_mobile_number_two like '%+" + kitchenMobile
					+ "%' or mb.alt_mobile_number_three like '%+" + kitchenMobile + "%')";

		String kitchenEmailCheck = "";
		if (!kitchenEmail.equals(""))
			kitchenEmailCheck = " and (lower(mb.e_mail) like '%" + kitchenEmail.toLowerCase()
					+ "%' or lower(mb.alt_email_one) like '%" + kitchenEmail.toLowerCase()
					+ "%' or lower(mb.alt_email_two) like '%" + kitchenEmail.toLowerCase()
					+ "%' or lower(mb.alt_email_three) like '%" + kitchenEmail.toLowerCase() + "%')";

		String paymentTypeCheck = "";
		if (!(paymentType.equals("") || paymentType.equals("all"))) {
			if (paymentType.equals("cod")) {
				paymentTypeCheck = " and order_type = 'cod'";
			} else {
				paymentTypeCheck = " and order_type <>'cod'";
			}
		}

		
		if (paymentSuccessFilter)
			paymentSuccessCheck = " (p.txnid=o.order_id and p.status = 'success')";
		else
			paymentSuccessCheck = " p.txnid=o.order_id";

		String deliveryAgentCheck = "";
		if (!(deliveryAgent.equals("") || deliveryAgent.equals("all"))) {
			deliveryAgentCheck = " and da.name ='" + deliveryAgent + "'";
		}

		String deliveryStatusCheck = "";
		if (!(deliveryStatus.equals("") || paymentType.equals("all"))) {
			deliveryStatusCheck = " and o.delivery_status='" + deliveryStatus + "'";
		}

		whereConditions = orderIdCheck;

		if (orderIdCheck.equals(""))
			whereConditions += dateCheck + orderAmountCheck + discountAmountCheck + couponCodeCheck
					+ userIdCheck + customerNameCheck + customerMobileCheck + customerEmailCheck
					+ kitchenNameCheck + kitchenBranchCheck + kitchenMobileCheck + kitchenEmailCheck
					+ paymentTypeCheck + orderStatusCheck + deliveryAgentCheck + deliveryStatusCheck;

		/* if (!showFailedPayments) {
			whereConditions += " and (lower(o.order_type)<>'cod' and lower(o.order_type)<>'fo' and lower(p.status)='success'";
			if (paymentType.equals("cod"))
				whereConditions += " or order_type='cod' ";
			else if(paymentType.equals("all")){
				whereConditions += " or order_type='fo' or order_type='fo'";
			}
			whereConditions += ")";
		} */

		query = "SELECT " + fieldNames
				+ " FROM neworderdetails o LEFT JOIN merchantbranch mb ON o.merchantbranch_id=mb.id LEFT JOIN user u ON o.`user_id`=u.`id` LEFT JOIN merchant m ON m.id=mb.`merchant_id` LEFT JOIN deal d ON d.id=o.`deal_id` left join newpayment p on "
				+ paymentSuccessCheck;
		if (!whereConditions.equals("")) {
			query += " where " + whereConditions;
		}

		
		if (new SimpleDateFormat("yyyy-MM-dd").format(new Date()).equals(startDate))
			query += " order by o.id desc limit " + (pageNo * ordersPerPage - ordersPerPage) + ","+ordersPerPage;
		else
			query += " order by o.id desc limit " + (pageNo * ordersPerPage - ordersPerPage) + ","+ordersPerPage;
		ps = con.prepareStatement(query);
		rs = ps.executeQuery();
		serialNumber = pageNo * ordersPerPage - (ordersPerPage-1);

		
	} catch (Exception e) {
		e.printStackTrace();
	}

	//Get last order id for new order notification
	try {
		query = "select max(id) from neworderdetails";
		ps = con.prepareStatement(query);
		ResultSet rs1 = ps.executeQuery();
		if (rs1.next()) {
			latestOrderId = rs1.getInt(1);
		}
		rs1.close();
	} catch (Exception exception) {
		System.out.println(exception);
	}
	
	//Load kitchens

	PreparedStatement preparedStatement=con.prepareStatement("select id,name from merchant where lower(status)='active' order by name");
	ResultSet resultSet=preparedStatement.executeQuery();
	
	
	while(resultSet.next()){
		kitchens.add(new Kitchen(resultSet.getLong("id"),resultSet.getString("name")));
	}
	
	//Get | Set values from session
	session.setAttribute("startDate", startDate);
	session.setAttribute("endDate", endDate);
	session.setAttribute("orderStatus", orderStatus);
	session.setAttribute("paymentType", paymentType);
	session.setAttribute("paymentSuccessFilter", paymentSuccessFilter);
	session.setAttribute("pageNo", pageNo); 	
	
%>
<body>
	<input type="hidden" id="latestOrderId" />
	<div align="right"
		style="color: white; font-family: serif; padding: 0px; margin-right: 10px;">
		<li class="logout"><a href='logout.jsp' style="font-size: 13px"><b>logout</b></a></li>
		<!-- <strong><b style="font-family: serif;margin-top: 10px;font-size: 11px;"><img src="images/editproduct.jpg" height="15x" width="20px"></img><a href="editsearchproduct.jsp" style="padding: 8px;background-color: azure">Edit Order</a></b></strong>
 			<strong><b style="font-family: serif;margin-top: 10px;font-size: 11px;"><img src="images/Delete_Icon.png" height="15x" width="20px"></img><a href="deletesearchproduct.jsp" style="padding: 8px;background-color: azure">Delete order</a></b></strong> -->
	</div>
	<form action="order-dashboard.jsp" method="post" name="f1"
		id="formFilterOrder">
		<input type="hidden" name="pageNo" id="pageNo" value="<%=pageNo%>" />
		<div id="searchFilterContainer" wtyle="width:100%">
			<div style="min-height: 100px;">
				<div id="pendingOrderNotificaton" title="New order(s)">
					<img width="97px" height="100px" src="images/timer.gif"
						style="margin-top: 0px;" > <span
						class="new-order-count"></span>
				</div>
				<div id="orderSummary" style="min-height:100px;float:right">
					<%
					//Order summary
					query = "select count(*) as order_count,lower(order_status) as order_status"
							+ " FROM neworderdetails o LEFT JOIN merchantbranch mb ON o.merchantbranch_id=mb.id LEFT JOIN user u ON o.`user_id`=u.`id` LEFT JOIN merchant m ON m.id=mb.`merchant_id` LEFT JOIN deal d ON d.id=o.`deal_id` left join newpayment p on "+paymentSuccessCheck;
					if (!whereConditions.equals("")) {
						query += " where " + whereConditions;
					}
					query+=" group by order_status order by field(order_status,'received','confirmed','assigned','canceled')";
					
					PreparedStatement preparedStatement1 = con.prepareStatement(query);
					ResultSet orderSummaryReultSet = preparedStatement1.executeQuery();
					int totalOrders=0;
					while(orderSummaryReultSet.next()){
						totalOrders+=orderSummaryReultSet.getInt("order_count");
					%>
						<%=orderSummaryReultSet.getString("order_status").toLowerCase().replace("received", "new") %> : <span class="order-count"><%=orderSummaryReultSet.getInt("order_count")%></span>
						<br>
					<%} %>
					<%if(orderStatus.equals("all")||orderStatus.equals("")){ %>
						<b>Total: <span class="order-count"><%=totalOrders%></b></span>
					<%} %>
				</div>
				
				<br>Orders</br>
			</div>
			<div>
				<table border="1px" id="searchFilters">
					<tr class="heading">
						<td>Date</td>
					</tr>
					<tr>
						<td><input type="text" name="startDate" id="datepicker1"
							value="<%=startDate%>" /> <img src="images/ffffff.jpeg"
							height="25px" width="25px" style="margin-top: -9px;" /> to <input
							type="text" name="endDate" id="datepicker" style="width: 120px;"
							value="<%=endDate%>" /> <img src="images/ffffff.jpeg"
							height="25px" width="25px" style="margin-top: -9px;" /></td>
					</tr>
					<tr class="heading">
						<td>Order</td>
					</tr>
					<tr>
						<td>
							<select id="orderStatusFilter" name="orderStatus" title="Order status">
								<option disabled <%if (orderStatus.equals("")) {%> selected
									<%}%>>Order Status</option>
								<option value="all" <%if (orderStatus.equals("all")) {%>
									selected <%}%>>All</option>
								<option value="received"
									<%if (orderStatus.equals("received")) {%> selected <%}%>>New
								</option>
								<option value="confirmed"
									<%if (orderStatus.equals("confirmed")) {%> selected <%}%>>Confirmed</option>
								<option value="assigned"
									<%if (orderStatus.equals("assigned")) {%> selected <%}%>>Assigned</option>
								<option value="assigned"
									<%if (orderStatus.equals("delivered")) {%> selected <%}%>>Delivered</option>
								<option value="settled" <%if (orderStatus.equals("settled")) {%>
									selected <%}%>>Settled</option>
								<option value="canceled"
									<%if (orderStatus.equals("canceled")) {%> selected <%}%>>Canceled</option>
						</select> <input type="text" name="orderId" placeholder="Order ID"
							tab-index="1" value="<%=orderId%>" title="Order ID" /> <input
							type="text" name="orderAmount" tab-index="2"
							placeholder="Amount paid"
							value="<%=(orderAmount >= 0) ? orderAmount : ""%>" title="Amount" />
							<input type="text" name="discountAmount" tab-index="3"
							placeholder="Discount"
							value="<%=(discountAmount >= 0) ? discountAmount : ""%>"
							title="Discount" /> <input type="text" name="couponCode"
							tab-index="3" placeholder="Coupon code" value="<%=couponCode%>"
							title="Coupon Code" /></td>
					</tr>
					<tr class="heading">
						<td>Customer</td>
					</tr>
					<tr>
						<td><input type="number" name="userId" placeholder="User Id"
							tab-index="4" value="<%=(userId > 0) ? userId : ""%>"
							title="User Id" /> <input type="text" name="customerName"
							placeholder="Name" tab-index="4" value="<%=customerName%>"
							title="Name" /> <input type="text" name="customerMobile"
							tab-index="5" placeholder="Mobile No."
							value="<%=customerMobile%>" title="Mobile" /> <input
							type="email" name="customerEmail" tab-index="6"
							placeholder="Email" value="<%=customerEmail%>" title="Email" />
							<!-- 
								<textarea
									placeholder="Address" rows="3" title="Address"></textarea> 
								--> <input type="text" name="customerLandmark" tab-index="6"
							placeholder="Landmark" value="<%=customerLandMark%>"
							title="Land Mark" /></td>
					<tr class="heading">
						<td>Kitchen</td>
					</tr>
					<tr>
						<td><input type="text" name="kitchenName" tab-index="4"
							placeholder="Name" value="<%=kitchenName%>" title="Name" /> <input
							type="text" name="kitchenBranch" tab-index="4"
							placeholder="Branch" value="<%=kitchenBranch%>" title="Branch" />
							<input type="text" name="kitchenMobile" tab-index="4"
							placeholder="Mobile" value="<%=kitchenMobile%>" title="Mobile" />
							<input type="email" name="kitchenEmail" tab-index="4"
							placeholder="Email" value="<%=kitchenEmail%>" title="Email" /></td>
					</tr>
					<tr class="heading">
						<td>Payment</td>
					</tr>
					<tr>
						<td><select name="paymentType" id="paymentTypeSelect"
							title="Payment type">
								<option disabled>Payment Type</option>
								<option value="all"
									<%if (paymentType.equals("all") || paymentType.equals("")) {%>
									selected <%}%>>All</option>
								<option value="cod" <%if (paymentType.equals("cod")) {%>
									selected <%}%>>Cash On Delivery</option>
								<option value="online" <%if (paymentType.equals("online")) {%>
									selected <%}%>>Online Payment</option>
						</select> <span id="successPaymentCheck"
							<%if (paymentType.equals("cod")) {%> style="display: none" <%}%>>
								<input type="checkbox" name="paymentSuccessFilter"
								id="paymentSuccessFilter" <%if (!paymentSuccessFilter) {%>
								checked <%}%> /><b>Show failed transactions</b>
						</span></td>
					</tr>
					<tr class="heading">
						<td>Delivery</td>
					</tr>
					<tr>
						<td><select id="deliveryAgentFilter"
							name="deliveryAgentFilter" title="Delivery Agent"
							<%if (!((orderStatus.equals("assigned") && orderStatus.equals("delivered") && orderStatus.equals("settled"))))
								out.print("disabled");%>>
								<option disabled selected>Delivery Agent</option>
								<option value="all">All</option>
								<%
									PreparedStatement preparedStatement2 = con.prepareStatement("SELECT  * FROM deliveryagent");
									ResultSet deliveryAgentsResultSet = preparedStatement2.executeQuery();
									while (deliveryAgentsResultSet.next()) {
								%>
								<option><%=deliveryAgentsResultSet.getString(2)%></option>
								<%
									}
									deliveryAgentsResultSet.close();
									deliveryAgentsResultSet = null;
									preparedStatement2.close();
									preparedStatement2 = null;
								%>
						</select> <select id="deliveryStatusFilter" name="deliveryStatusFilter"
							title="Delivery Status"
							<%
								if (!((orderStatus.equals("assigned") && orderStatus.equals("delivered") && orderStatus.equals("settled"))))
									out.print("disabled");
									%>>
								<option disabled selected>Delivery Status</option>
								<option value="all">All</option>
								<%
									preparedStatement1 = con.prepareStatement("SELECT distinct delivery_status FROM neworderdetails");
									ResultSet rs2 = preparedStatement1.executeQuery();
									while (rs2.next()) {
								%>
								<option value="<%=rs2.getString(1).toLowerCase()%>"><%=rs2.getString(1).toLowerCase()%></option>
								<%
									}
									rs2.close();
									rs2 = null;
									preparedStatement1.close();
									preparedStatement1 = null;
								%>
						</select> <span style='float: right'> <input type="button"
								value="Clear" class="btn" style="font-size: 1.5em"
								id="clearFilters" /> <input id="btnApplyFilter" type="button"
								value="Apply" class="btn" style="font-size: 1.5em"
								id="applyFilters" />
						</span></td>
					</tr>
				</table>
			</div>
		</div>
		<!-- 		
				<a style="margin-left:940px"  href="javascript:Clickheretoprint()"></a><input type="button" onclick="tableToExcel('testTable', 'W3C Example Table')" value="Export to Excel" class="btn"
				 style=" font-size: 11px;
  margin-bottom: 4px;
  margin-left: 417px;
  padding: 3px 13px;">	
				 -->
	</form>

	<!-- Order Filter -->

	<%
		if (rs.next()) {
			latestOrderId = rs.getLong("id");
			if (pageNo > 1) {
	%>
	
	<%
		}
	%>

	<!-- 	<a style="margin-left:940px"  href="javascript:Clickheretoprint()"></a>
				<input type="button" onclick="tableToExcel('testTable', 'W3C Example Table')" value="Export to Excel" class="btn" style=" font-size: 11px; margin-bottom: 4px; margin-left: 417px; padding: 3px 13px;">
				<a style="margin-left:940px"  href="javascript:Clickheretoprint()"></a>
				<input type="button" onclick="tableToExcel('testTable', 'W3C Example Table')" value="Export to Excel" class="btn" style=" font-size: 11px; margin-bottom: 4px; margin-left: 417px; padding: 3px 13px;">-->
				
	<div class="menuLink">
		<p style="float: left;">
			<a targethref="selectdateandshow.jsp" style="cue-before: darkred"><p
					style="color: darkblue; float: left; margin-left: 50px">
					Reports</a>
		</p>
		<p style="color: darkblue; float: left; margin-left: 25px">
			<a href="showcoupancode.jsp" style="cue-before: darkred;">Coupons</a>
			
		</p>
		<!-- <a href="adddeliveryagect.jsp" style="cue-before: darkred"><p style="color: darkblue;float: left;margin-left: 25px">Add Token No.</p></a>  
					<a href="reconciled.jsp" style="cue-before: darkred"><p style="color: darkblue;float: left;margin-left: 25px">Reconciled/Settled</p></a>
		
		<p style="color: darkblue; float: left; margin-left: 25px">
			<a href="sendsmstomerchant.jsp" style="cue-before: darkred"><p
					style="color: darkblue; float: left; margin-left: 25px">SMS -
					Merchant</a>
		</p> 
		-->
		<p style="color: darkblue; float: left; margin-left: 25px">

			<a href="sendsmstocustomer.jsp" style="cue-before: darkred"><p
					style="color: darkblue; float: left; margin-left: 25px">SMS -
					Loyal customers</a>
		</p>
 		<p style="color: darkblue; float: left; margin-left: 25px">
			<a href="OpinioMerchant_register.jsp" style="cue-before: darkred"><p
					style="color: darkblue; float: left; margin-left: 25px">Opinio
					Merchant Register</a>
		</p>
		
		<p style="color: darkblue; float: left; margin-left: 25px">
			<a href="repeat_order_discount.jsp" style="cue-before: darkred"><p
					style="color: darkblue; float: left; margin-left: 25px">Reward
				Rules</a> 
		</p>
		
		<p style="color: darkblue; float: left; margin-left: 25px">
			<a href="order_feedback_report.jsp" style="cue-before: darkred"><p
					style="color: darkblue; float: left; margin-left: 25px">Customer Feedback</a> 
		</p>
		
		<p style="color: darkblue; float: left; margin-left: 25px">
			<a href="order_feedback_report.jsp" style="cue-before: darkred"><p
					style="color: darkblue; float: left; margin-left: 25px"></a> 
		</p> 
		
			<p style="color: darkblue; float: right; margin-left: 25px">
			<a href="update_setting.jsp" style="cue-before: darkred"><p
					style="color: darkblue;  margin-left: 25px">Delivery
					Setting</a>
		</p>

	</div>			
				

	<span style="float: left"> <a class="link-prev-page" href="#"
		title="Show previous page"><b><< Previous</b></a>
	</span>
	<span style="float: right"> <a class="link-next-page" href="#"
		title="Show next page"><b>Next >></b></a>
	</span>
	<table style="float: left; margin-left: 4px;" 
		align="center" border="1px" id="testTable">
		<tr style="font-size: 14px; background-color: darkred; color: white;">
			<td>#</td>
			<td>Order ID</td>
			<td style="width:200px">Date | Time</td>
			<td>Payment Type</td>
			<td>Amount</td>
			<td>Customer</td>
			<td>Delivery Address</td>
			<td>Kitchen</td>
			<td style="width:250px">Dish</td>
			<td style="width:200px">Delivery</td>
			<td colspan="4" style="width: 100px">Action</td>
		</tr>
		
		<%
			do {
					String orderIdValue = rs.getString("order_id");
					if (orderIdValue == null)
						orderIdValue = "";

					String userIdValue = rs.getString("user_id");
					if (userIdValue == null)
						userIdValue = "";

					String orderTypeValue = rs.getString("order_type");
					if (orderTypeValue == null)
						orderTypeValue = "";

					String paymentStatusValue = rs.getString("payment_status");
					if (paymentStatusValue == null)
						paymentStatusValue = "";

					String discountAmountValue = rs.getString("discount_amount");
					if (discountAmountValue == null)
						discountAmountValue = "";

					String orderDateValue = rs.getString("order_date");
					if (orderDateValue == null)
						orderDateValue = "";

					String orderTimeValue = rs.getString("order_time");
					if (orderTimeValue == null)
						orderTimeValue = "";

					String orderQuanityValue = rs.getString("order_quantity");
					if (orderQuanityValue == null)
						orderQuanityValue = "";
					
					String orderDateTime=rs.getString("order_date_time");

					String deliveryAddressValue = rs.getString("delivery_address");
					if (deliveryAddressValue == null)
						deliveryAddressValue = "";

					String landmarkValue = rs.getString("landmark");
					if (landmarkValue == null)
						landmarkValue = "";

					long kitchenIdValue = rs.getLong("kitchen_id");

					String kitchenNameValue = rs.getString("kitchen_name");
					if (kitchenNameValue == null)
						kitchenNameValue = "";
					
					long kitchenBranchId = rs.getLong("branch_id");
				
					String branchNameValue = rs.getString("branch_name");
					if (branchNameValue == null)
						branchNameValue = "";

					String kitchenMobile1Value = rs.getString("kitchen_mobile1");
					if (kitchenMobile1Value == null)
						kitchenMobile1Value = "";
					kitchenMobile1Value = kitchenMobile1Value.trim();

					String kitchenMobile2Value = rs.getString("kitchen_mobile2");
					if (kitchenMobile2Value == null)
						kitchenMobile2Value = "";
					kitchenMobile2Value = kitchenMobile2Value.trim();

					String kitchenMobile3Value = rs.getString("kitchen_mobile3");
					if (kitchenMobile3Value == null)
						kitchenMobile3Value = "";
					kitchenMobile3Value = kitchenMobile3Value.trim();

					String kitchenMobile4Value = rs.getString("kitchen_mobile4");
					if (kitchenMobile4Value == null)
						kitchenMobile4Value = "";
					kitchenMobile4Value = kitchenMobile4Value.trim();

					String kitchenAddressValue = rs.getString("kitchen_address");
					if (kitchenAddressValue == null)
						kitchenAddressValue = "";

					String customerNameValue = rs.getString("customer_name");
					if (customerNameValue == null)
						customerNameValue = "";

					String customerMobileValue = rs.getString("customer_mobile");
					if (customerMobileValue == null)
						customerMobileValue = "";

					String customerEmailValue = rs.getString("customer_email");
					if (customerEmailValue == null)
						customerEmailValue = "";

					String addressLatitudeValue = rs.getString("latitude");
					if (addressLatitudeValue == null)
						addressLatitudeValue = "";

					String addressLongitudeValue = rs.getString("longitude");
					if (addressLongitudeValue == null)
						addressLongitudeValue = "";

					String orderAmountValue = rs.getString("order_amount");
					if (orderAmountValue == null)
						orderAmountValue = "";
					
					Double finalAmountValue=Double.parseDouble(orderAmountValue)+Double.parseDouble(discountAmountValue);
					
					String paidAmountValue = rs.getString("paid_amount");
					if (paidAmountValue == null)
						paidAmountValue = "";


					String couponCodeValue = rs.getString("coupon_code");
					if (couponCodeValue == null)
						couponCodeValue = "";

					String discountMethodValue = rs.getString("discount_method");
					if (discountMethodValue == null)
						discountMethodValue = "";

					String deliverAddressValue = rs.getString("delivery_address");
					if (deliverAddressValue == null)
						deliverAddressValue = "";

					String kitchenLatitudeValue = rs.getString("kitchen_latitude");
					if (kitchenLatitudeValue == null)
						kitchenLatitudeValue = "";

					String kitchenLongitudeValue = rs.getString("kitchen_longitude");
					if (kitchenLongitudeValue == null)
						kitchenLongitudeValue = "";

					String kitchenEmailValue = rs.getString("kitchen_email");
					if (kitchenEmailValue == null)
						kitchenEmailValue = "";

					String orderStatusValue = rs.getString("order_status");
					if (orderStatusValue == null)
						orderStatusValue = "";

					String deliveryStatusValue = rs.getString("delivery_status");
					if (deliveryStatusValue == null)
						deliveryStatusValue = "";

					String deliveryAgentNameValue = rs.getString("delivery_agent_name");
					if (deliveryAgentNameValue == null)
						deliveryAgentNameValue = "";

					String orderRemarks = rs.getString("order_remarks");
					if (orderRemarks == null)
						orderRemarks = "";

					String deliveryDistanceValue = rs.getString("delivery_distance");
					if (deliveryDistanceValue == null)
						deliveryDistanceValue = "";
					String dealNames = "";
		%>
		<tr>
				<td><b><%=serialNumber++%></b></td>
				<td><b> <%=orderIdValue%>
				</b> <br> <%
			 	String iconName = "";
			 			if (orderStatusValue.toLowerCase().equals("received")
			 					|| orderStatusValue.toLowerCase().equals("booked")) {
			 				iconName = "timer.gif";
			 %> <img src="images/<%=iconName%>" height="100px" width="100px"
							alt="<%=orderStatusValue%>"
							title="<%=orderStatusValue.toUpperCase()%>" /> <%
			 	} else {
	 				if (orderStatusValue.toLowerCase().equals("confirmed"))
	 					iconName = "thumbs-up.png";
	 				else if (orderStatusValue.toLowerCase().equals("assigned"))
	 					iconName = "delivery-boy.png";
	 				else if (orderStatusValue.toLowerCase().equals("delivered"))
	 					iconName = "success.png";
	 				else if (orderStatusValue.toLowerCase().equals("canceled"))
	 					iconName = "thumbs-down.png";
	 				else if (orderStatusValue.toLowerCase().equals("settled"))
	 					iconName = "shake-hand.png";
			 %> <img src="images/<%=iconName%>" height="50px" width="50px"
							alt="<%=orderStatusValue%>" title="<%=orderStatusValue%>"
							style="margin-top: 20px" /> <%
			 	if (orderStatus.equals("assigned")) {
			 					out.print("<br>" + deliveryAgentNameValue);
			 				}
			 			}	
			 %>
 			</td>
			<td>
				<b>
					<%=orderDateValue%></br> <br>
					<br>
					<%=orderTimeValue%></td>
				</b>
			<td>
				<b> <%
				 	if (orderTypeValue.toLowerCase().equals("payu")) {
				 		out.println(paymentStatusValue.toLowerCase());
				 %> <a target="_new" title="View Details"
									href="paymentdetails.jsp?orderid=<%=orderIdValue%>"> <%=orderTypeValue.toUpperCase()%>
								</a> <%
								
				 	if (paymentStatusValue.toLowerCase().equals("success")) {
				 %> <br> <img src="images/success-checkbox.gif" alt="Success"
									alt="Success" title="Payment success" style="margin-top: 5px;"
									alt="<%=paymentStatusValue.toLowerCase()%>" /> <%
				 	} else if (paymentStatusValue.toLowerCase().equals("failure")) {
				 %> <br> <img src="images/close.jpg" alt="Failed"
									title="Payment failed" alt="<%=paymentStatusValue.toLowerCase()%>"
									style="margin-top: 5px; width: 20px" /> <%
				 	} else {
				 %> 
				 
				 	<br>
					 <a href="update-payment-status.jsp?orderid=<%=orderIdValue%>"
										title="Processing..."> <img src="images/refresh.png"
											alt="Status unavailable"
											title="Payment status not available. Click to refresh"
											style="margin-top: 5px;" />
									</a> <%
					 	}
				 			} else {
				 				out.print(orderTypeValue.toUpperCase());
				 			}
				 %>
							</b></td>
				
							<td class="left-align">Paid &nbsp;&nbsp;
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : <b>Rs. <span id="paidAmount<%=orderIdValue%>"><%=orderAmountValue%></span></b></br> <%
				 	if (discountAmountValue.equals("0")) {
				 %> Discount : <b title="Not Applied">NA</b>
								<%
									} else {
								%> Discount : <b>Rs. <span id="discountAmount<%=orderIdValue%>"><%=discountAmountValue%></span></b> <%
				 	}
				 %> </br> </br> <b style="font-size: 12px">Total &nbsp;&nbsp; : Rs.
				 <%
				 	int paid,discount;
				 	try{
				 		paid=Integer.parseInt(orderAmountValue);
				 	}catch(Exception e){
				 		paid=0;
				 	}
					try{
				 		discount=Integer.parseInt(discountAmountValue);
				 	}catch(Exception e){
				 		discount=0;
				 	}
				 
				 	totalAmount=paid+discount;
				 %> 
				 <span id="totalAmount<%=orderIdValue%>">
					<%=totalAmount %>
				 </span>
				 	<% if (!(discountMethodValue.toLowerCase().equals("none")
				 					|| discountMethodValue.toLowerCase().equals(""))) {
				 %>
									<div class="coupon">
										<%
											if (discountMethodValue.toLowerCase().equals("discount_code")) {
															out.print(couponCodeValue+"<br>");
											}else if (discountMethodValue.toLowerCase().equals("hb_money")) {
												out.print("HB&nbsp;MONEY");
											}else if(discountMethodValue.toLowerCase().equals("repeat_order")){
												out.print("REPEAT ORDER<br>");
											}else if (discountMethodValue.toLowerCase().equals("firstorder")) {
												out.print("FO<br>");
											} 
											
										%>
									</div> <%
				 	}
				 %>
			</td>
			<td class="left-align"><span style="float: right"
				title="User Id"><%=userIdValue%></span> <a
				href="order-dashboard.jsp?userId=<%=userIdValue%>"
				title="View orders by <%=customerNameValue.toUpperCase()%>"> <b><%=customerNameValue.toUpperCase()%></b>
					<br>
			</a> <b> <%= customerMobileValue%> 
				<a href='tel://+91<%=customerMobileValue%>' title="Call"><img  class="icon-call"	src="images/call.png" alt="Call" /></a> <a target="_new" href='send-sms.jsp?mobile=91<%=customerMobileValue%>' title="SMS">
					<img src="images/sms.png" alt="SMS" />
				</a>
			</b> <br> <a target="_new" href='https://mail.google.com/mail/?view=cm&fs=1&tf=1&to=<%=customerEmailValue%>'
				title="Send a mail" ><%=customerEmailValue%></a> <br>
			<br> <!-- 	<textarea id="customerRemarks<%=orderId%>" onclick="editCustomerRemarks(this)" class="customer-remarks"  style="height:100px;cursor:pointer" placeholder="Remarks" name="customerRemarks" ></textarea> -->

			</td>
			<td style="text-transform:capitalize"><a title="Find on map"
				href='getAddress.jsp?lat=<%=addressLatitudeValue%>&lng=<%=addressLongitudeValue%>'
				target="_new"> <%=deliverAddressValue%> <br> <%
				 	if (!landmarkValue.trim().equals("")) {
				 %> <b>Landmark: <%=landmarkValue%></b> <%
				 	}
				 %> <br>Geo co-ords : <%=addressLatitudeValue%> , <%=addressLongitudeValue%>
							</a> <br> <b> <%
				 	if (!deliveryDistanceValue.equals("0")) {
				 %> Delivery distance : <%=deliveryDistanceValue%> KM <%
				 	}
				 %>
			</b></td>
			<td>
				<div class="card" id="kitchenCard<%=orderIdValue%>" style="width:200px;height:90px;text-transform:capitalize">
					<div>
						<%
							if(!(orderStatusValue.equals("canceled") || orderStatusValue.equals("assigned"))){
						%>
						<a href="javascript:void(0);" style="float: right"  onclick="changeKitchen('<%=orderIdValue%>')" class="change-link">change</a>
						<%}%>
						<br>
						<a id="kitchenLink<%=orderIdValue%>" href="order-dashboard.jsp?kitchenName=<%=kitchenNameValue.replaceAll("'", "\\'")%>" title="View orders for <%=kitchenNameValue%>">
							<label style="color:#8B0000;font-size:15px" id="kitchenName<%=orderIdValue%>"><%=kitchenNameValue%></label>
						</a> 
						 <a id="branchLink<%=orderIdValue%>" title="View orders at <%=branchNameValue%>" href="order-dashboard.jsp?kitchenBranch=<%=branchNameValue%>">
								<label title="Branch" id="branchName<%=orderIdValue%>" >
									<%=branchNameValue%>
								</label>
						 </a>
						<%
							if (!kitchenMobile1Value.equals("0")) {
						%>
						<span >
						</span>
						<br> 
						<span id="branchContactDetails<%=orderIdValue%>" style="text-transform: none !important">
							<b><%=kitchenMobile1Value%></b>&nbsp; 
							<a
								href='tel://+91<%=kitchenMobile1Value%>' title="Call">
								<img class="icon-call"	 src="images/call.png" alt="Call" /></a>
								<a target="_new" href='send-sms.jsp?mobile=91<%=kitchenMobile1Value%>' title="SMS">
								<img class="icon-sms"	 src="images/sms.png" alt="SMS" /></a>
							<%
								}
							if (!kitchenMobile2Value.equals("0") && !kitchenMobile2Value.equals(kitchenMobile1Value)) {
							%>
							<br>
							<b><%=kitchenMobile2Value%></b>&nbsp; <a
								href='tel://+91<%=kitchenMobile2Value%>' title="Call"><img class="icon-call"	
								src="images/call.png" alt="Call" /></a>  <a target="_new"
								href='send-sms.jsp?mobile=91<%=kitchenMobile2Value%>' title="SMS"><img class="icon-sms"	
								src="images/sms.png" alt="SMS" /></a> <br> <a title="Call" href="tel://+91<%=kitchenMobile2Value%>"></a>
							<%
								}
							if (!kitchenMobile3Value.equals("0") && !kitchenMobile3Value.equals(kitchenMobile1Value)
									&& !kitchenMobile3Value.equals(kitchenMobile2Value)) {
							%>
							<br>
							<b><%=kitchenMobile3Value%></b>&nbsp; <a href='tel://+91<%=kitchenMobile3Value%>' title="Call"><img class="icon-call"	
								src="images/call.png" alt="Call" /></a>  <a target="_new"
								href='send-sms.jsp?mobile=91<%=kitchenMobile3Value%>' title="SMS"><img class="icon-sms"	
								src="images/sms.png" alt="SMS" /></a> <br> <a title="Call" href="tel://+91<%=kitchenMobile3Value%>"></a>
							<%
								}
								if (!kitchenMobile4Value.equals("") && !kitchenMobile4Value.equals(kitchenMobile1Value)
										&& !kitchenMobile4Value.equals(kitchenMobile2Value)
										&& !kitchenMobile4Value.equals(kitchenMobile3Value)) {
							%>
								
								<b><%=kitchenMobile4Value%></b>&nbsp; <a
									href='tel://+91<%=kitchenMobile4Value%>' title="Call"><img class="icon-call"	
									src="images/call.png" alt="Call" /></a> <a target="_new"
									href='send-sms.jsp?mobile=91<%=kitchenMobile4Value%>' title="SMS"><img class="icon-sms"	
									src="images/sms.png" alt="SMS" /></a> <br> 
									<a title="Call" href="tel://+91<%=kitchenMobile4Value%>"></a>
							<%
								}
								%>
								<br>
								<%
								if (!kitchenEmailValue.equals("")) {
							%>
							<br>
							<a title="Send a mail"
								href="https://mail.google.com/mail/?view=cm&fs=1&tf=1&to=<%=kitchenEmailValue%>">
								<%=kitchenEmailValue%></a>
							<%
								}
							%>
							</span>
							<br> <br> 
							<span id="branchAddress<%=orderIdValue%>" >
								<a target="_new" title="Find on map" href='getAddress.jsp?lat=<%=kitchenLatitudeValue%>&lng=<%=kitchenLongitudeValue%>'>
								<%=kitchenAddressValue%>
								<%out.print(kitchens.size()); %>
							</a>
						</span>
					</div>
					<div>
						<select class="kitchen" id="kitchen<%=orderIdValue%>" onChange="kitchenChanged('<%=orderIdValue%>')" title="Brand">
							<option selected disabled>Brand</option>
							<%
								for(int i=0;i< kitchens.size();i++){
									Kitchen kitchen=kitchens.get(i);
							%>
								<option value="<%=kitchen.getId()%>"><%=kitchen.getName()%></option>
							<%	}
							%>
						</select>
						<select id="branch<%=orderIdValue%>" onchange="branchChanged('<%=orderIdValue%>',this.value)" hidden>
						</select>
						<a href="javascript:void(0);" style="float: right"  onclick="flipKitchenCard('<%=orderIdValue%>',false)">back</a>
					</div>
				</div>
			</td>
			<td class="left-align">
				<%
					ArrayList<Long> orderIds = new ArrayList();
					ArrayList<Long> dishIds = new ArrayList();
					ArrayList<String> dishes = new ArrayList();
					ArrayList<Integer> dishPrices = new ArrayList();
					ArrayList<Integer> dishQuantities = new ArrayList();
					ArrayList<Integer> deleteStatus =new ArrayList();

					preparedStatement1 = con.prepareStatement( "SELECT o.id as order_id,d.name,quantity,d.id as deal_id,d.deal_price,deleted FROM orders o LEFT JOIN deal d ON o.deal_id = d.id WHERE o.`order_id`='" + orderIdValue + "'");
					rs2 = preparedStatement1.executeQuery();
					while (rs2.next()) { 
						dealNames += rs2.getString("name") + ",";
						orderIds.add(rs2.getLong("order_id"));
						dishIds.add(rs2.getLong("deal_id"));   
						dishes.add(rs2.getString("name"));
						dishQuantities.add(rs2.getInt("quantity"));
						dishPrices.add(rs2.getInt("deal_price"));
						deleteStatus.add(rs2.getInt("deleted"));
					}
				%> 
				<div class="card" id="dishCard<%=orderIdValue%>" style="width:200px;float: right">
					<div>
						<%
							if(!(orderStatusValue.equals("canceled") || orderStatusValue.equals("assigned"))){
						%>
						<a href="javascript:void(0);"  id="changeDish" onclick="changeDishes('<%=orderIdValue%>')" style="float:right">change</a>
						<%} %>
						<ol id="dishList<%=orderIdValue%>">
							<%
								for (int i = 0; i < dishes.size(); i++) {
							%>
							<li id="dishItem<%=orderIds.get(i)%>" <% if(deleteStatus.get(i)==1){ %> class="strike" <%}%>>
								<b style="font-size: 10px">
									<span <% if(!(deleteStatus.get(i)==1)){ %>id="dishName<%=orderIds.get(i)%>-<%=dishIds.get(i)%>" <%}%>>
										<%=dishes.get(i)%>
									</span>
									 : 
									<span <% if(!(deleteStatus.get(i)==1)){ %>id="dishQuantity<%=orderIds.get(i)%>-<%=dishIds.get(i)%>"<%}%>>
										<%=dishQuantities.get(i)%>
									</span>
								</b>
							</li>
							<%
								}
							%>
						</ol>
					</div>
					<div class="edit-dish">
						<img id="loading<%=orderIdValue %>" alt="loading..." src="images/icon-loading.gif"  style="margin-left: 150px;margin-top: 10px;display:none">
						<ol id="dishEditList<%=orderIdValue%>">
							<%
								for (int i = 0; i < dishes.size(); i++) {
									if(deleteStatus.get(i)==1)
										continue;
							%>
							<li id="order<%=orderIds.get(i)%>" >
								<select id="dish<%=orderIds.get(i)%>" name="dish<%=i%>" style="width: 200px" onchange="dishChanged('<%=orderIdValue%>',<%=orderIds.get(i)%>,this.value);" >
									<%
										preparedStatement1 = con.prepareStatement("select id,name,deal_price from deal where merchantbranch_id="+kitchenBranchId+" and status='PUBLISHED' order by name");
										System.out.println("select id,name,deal_price from deal where merchantbranch_id="+kitchenBranchId+" and status='PUBLISHED' order by name");
										rs2 = preparedStatement1.executeQuery();
										while (rs2.next()) {%>
											<option <%if(rs2.getLong("id")==dishIds.get(i)){%>selected="selected"<%}%> value="<%=rs2.getLong("id")%>"><%=rs2.getString("name")%> &nbsp;&nbsp;|&nbsp;&nbsp; Rs.<%=rs2.getString("deal_price")%></option>
									<%
									}
									%>
								</select> 
								:
								<input type="number" value="<%=dishQuantities.get(i)%>" id="dishEditQuantity<%=orderIds.get(i)%>-<%=dishIds.get(i)%>" min="1" max="999" placeholder="Quantity" style="width: 44px" onchange="dishQuantityChanged('<%=orderIdValue%>',<%=orderIds.get(i)%>,this.value)"/>
								<a href="javascript:void(0);" onclick="removeDish('<%=orderIdValue%>',<%=orderIds.get(i)%>)">
									<img src="images/close.jpg" alt="remove" title="Remove dish" style="margin-top: 5px; width: 10px" />
								</a>
							</li>
							<%
								}
							%>
						</ol>
						<a href="javascript:void(0);" style="float: left;margin:5px" onclick="addDish('<%=orderIdValue%>',<%=kitchenBranchId%>)">add dish</a>
						<a href="javascript:void(0);" style="float: right;margin:5px" onclick="saveDishes('<%=orderIdValue %>')">back</a>
						<div class="dish-edit-summary">
							<b style="font-size: 12px">
								Total &nbsp;&nbsp; : Rs.
								<span id="dishEditTotalAmount<%=orderIdValue%>">
									<%=totalAmount%>
								</span>
							</b>
						</div>
					</div>
				</div>
			</td>
			<td>
				<form action="deliver-new.jsp" method="post" style="border: none"
					id="assignDelivery<%=orderIdValue%>">
					<input type="hidden" name="orderid" value="<%=orderIdValue%>" /> 
					<input 	type="hidden" name="orderdate" value="<%=orderDateTime%>" /> 
					<input type="hidden" name="amount" value="<%=orderAmountValue%>" /> 
					<input type="hidden" name="quantity" value="<%=orderQuanityValue%>" />
					<input type="hidden" name="status" value="<%=orderIdValue%>" /> 
					<input type="hidden" name="merchantbranch_id" value="<%=kitchenBranchId%>" />
					<input type="hidden" name="merchant_name" value="<%=kitchenNameValue%>" />
					<input type="hidden" name="user_name" value="<%=customerNameValue%>" /> 
					<input type="hidden" name="cust_mob" value="<%=customerMobileValue%>" /> 
					<input type="hidden" name="cust_email" value="<%=customerEmailValue%>" />
					<input type="hidden" name="delivery_address" value="<%=deliveryAddressValue%>" />
					<input type="hidden" name="landmark" value="<%=addressLongitudeValue%>" />
					<input type="hidden" name="merchant_mob" value="<%= kitchenMobile %>" />
					<input type="hidden" name="merchant_email" value="<%=kitchenEmailValue%>" /> 
					<input type="hidden" name="deal_name" value="<%=dealNames%>" />
					<input type="hidden" name="delivery_type" value="<%=orderTypeValue%>" />
					<input type="hidden" name="latitude" value="<%=addressLatitudeValue%>" />
					<input type="hidden" name="longitude" value="<%=addressLongitudeValue%>" /> 
					<input type="hidden" name="branch_address" value="<%=kitchenAddressValue%>" /> 
					<input type="hidden" name="branch_longitude1" value="<%=kitchenLongitudeValue%>" /> 
					<input type="hidden" name="branch_lattitue1" value="<%=kitchenLatitudeValue%>" /> 
					<b>

					<%
						if (orderStatusValue.equals("received")) {
									out.print("YET TO CONFIRM!");
								} else if (orderStatusValue.equals("confirmed") || orderStatusValue.equals("assigned")
										|| !(deliveryStatus.toLowerCase().equals("delivered"))) {
									if (orderStatusValue.equals("assigned"))
										out.print(deliveryStatusValue.toUpperCase());

									if (orderStatusValue.equals("canceled"))
										out.println("CANCELED");
									else {
					%> 
					<br>
					<br>
					<select id="deliveryAgentSelect" name="deliveryagentname" style="width: 95%" onchange="assignDelivery('<%=orderIdValue%>')">
						<option disabled selected>
							<%
								if (!orderStatusValue.equals("delivered"))
									out.print("Re -");
							%>
							Assign to
						</option>
						<%
							preparedStatement1 = con.prepareStatement("SELECT * FROM deliveryagent ");
							rs2 = preparedStatement1.executeQuery();
							while (rs2.next()) {
						%>
						<option value="<%=rs2.getString(2)%>"
							<%if (deliveryAgent.equals(rs2.getString(2))) {%> selected <%}%>><%=rs2.getString(2)%></option>
						<%
							}
							rs2.close();
							rs2 = null;
							preparedStatement1.close();
							preparedStatement1 = null;
						%>
					</select> 
				<%
				 	}
	 			} else if (orderStatusValue.equals("canceled"))
		 			out.print("CANCELED");
				  else
		 			out.print(deliveryStatusValue.toUpperCase());
				 %>

				</b><br>
				<!-- <textarea disabled onclick="editDeliveryA	gentRemarks(this);" style="height:100px" placeholder="Remarks" name="deliveryAgentRemarks" ></textarea> -->
				</form>
			</td>
			<td>
				<%
					if (!orderStatusValue.equals("canceled")) {
				%> 
					<a class="action-link btn btn-success" title="Confirm the order [ Sends SMS & Email ]" href="send-confirmation-new.jsp?orderid=<%=rs.getString("order_id")%>&orderdate=<%=rs.getString("order_date")%>&amount=<%=finalAmountValue%>&quantity=<%=orderQuanityValue%>&status=<%=rs.getString("order_status")%>&merchant_name=<%=rs.getString("kitchen_name")%>&user_name=<%=rs.getString("customer_name")%>&cust_mob=<%=rs.getString("customer_mobile")%>&cust_email=<%=rs.getString("customer_email")%>&address=<%=rs.getString("delivery_address")%>&merchant_mob=<%=rs.getString("kitchen_mobile1")%>&merchant_mob1=<%=rs.getString("kitchen_mobile1")%>&merchant_email=<%=rs.getString("kitchen_email")%>&deal_name=<%=rs.getString("deal_name")%>&delivery_type=<%=rs.getString("order_type")%>&latitude=<%=rs.getString("latitude")%>&longitude=<%=rs.getString("longitude")%>&delivery_address=<%=rs.getString("delivery_address")%>&landmark=<%=rs.getString("landmark")%>" onclick="confirmClicked(this)">Confirm</a>
				<%
					} else if (orderStatusValue.equals("delivered") || orderStatusValue.equals("settled")) {
				%>
					<h4>
						Well done <%=userName%>!
					</h4> 
			<%
 				}
 				if (orderStatusValue.equals("received") || orderStatusValue.equals("confirmed")) {
			 %> <a class="action-link btn" href="#" onclick="cancelOrder('<%=orderIdValue%>')" title="Cancel the order">
					<b>Cancel</b>
				</a> 
			<%
			 	} else if (orderStatusValue.equals("canceled")) {
			 %> 
			 <a class="action-link btn btn-success" href="#" title="Process the order" onclick="reOpen('<%=orderIdValue%>')">
					<b>Re - open</b>
			 </a> 
			 <%
			 	}
			 %>
				<div>
					<textarea id="orderRemarks<%=orderIdValue%>" class="order-remarks"
						style="height: 100px; cursor: pointer;" placeholder="Remarks"
						name="orderRemarks" onblur="saveRemarks(this,'<%=orderIdValue%>')"><%=orderRemarks%></textarea>
				</div>
			</td>
		</tr>
		<%
			}while (rs.next());
				rs.close();
				ps.close();
				con.close();

				rs = null;
				ps = null;
				con = null;
		%>
	</table>
	<%
		if (pageNo > 1) {
	%>
	<span style="float: left"> <a class="link-prev-page" href="#"
		title="Show previous page"><b> < Previous</b> </a>
	</span>
	<%
		}
	%>

	<a style="float: right" class="link-next-page" href="#"
		title="Show next page"><b>Next >></b></a>
	<%
		} else {
	%>
	<div style="margin-top: 100px">
		<%
			if (orderStatus.equals("received")) {
		%>
			<b> No new orders received! We will notify you when orders comes in!</b>
		<%
			} else {
		%>
			<b> No orders found! Please try with different order details.</b>
		<%
			}
		%>
	</div>
	<%
		}
	%>
</body>

<script type="text/javascript">
	function kitchenChanged(orderId){
			$("#branch"+orderId+" option").remove();
			$("#branch"+orderId).append("<option selected disabled>Kitchen</option>");
		
			var xhttp;
			xhttp = new XMLHttpRequest();
			xhttp.onreadystatechange = function() {
				if (xhttp.readyState == 4 && xhttp.status == 200) {
				   var jSonObject=JSON.parse(xhttp.responseText);
				   $.each(jSonObject.branches,function(index,branch){
					   $("#branch"+orderId).append("<option value='"+branch.id+"'>"+branch.name+"</option>");
				   });
				   $("#branch"+orderId).show();
				}
			}
			xhttp.open("GET", "ajax-service.jsp?service=branches&kitchenId="+$("#kitchen"+orderId).val(), true);
			xhttp.send();
	}
	
	function branchChanged(orderId,branchId){
		//Show loading icon while AJAX call happens
		// $('#kitchenCard'+orderId).html('<img src="images/icon-loading.gif" alt="loading..."/>'); 
			
		var xhttp;
		xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function() {
			if (xhttp.readyState == 4 && xhttp.status == 200) {
				var xhttp1;
				xhttp1 = new XMLHttpRequest();
				xhttp1.onreadystatechange = function() {
					if (xhttp1.readyState == 4 && xhttp1.status == 200) {
					  var branchDetails=JSON.parse(xhttp1.responseText);
					  
					  //Update the new kitchen details
					  $("#kitchenName"+orderId).html($("#kitchen"+orderId+ " option:selected").text());
					  $("#branchName"+orderId).html(branchDetails.name);
					  $("#branchContactDetails"+orderId).html('');
					  $.each(branchDetails.phone,function(index,phone){
						  $("#branchContactDetails"+orderId).append('<br><b>'+phone+'</b>'+ 
				  													'<a title="Call" href="tel://+'+phone+'" class="icon-call" ><img class="icon-call" alt="Call" src="images/call.png"></a>'+
				  													'<a title="SMS" href="send-sms.jsp?mobile='+phone+'" target="_new"><img alt="SMS" class="icon-sms" src="images/sms.png"></a><br>');
					  });
					  
					  $.each(branchDetails.email,function(index,email){
						  $("#branchContactDetails"+orderId).append('<br><a href="https://mail.google.com/mail/?view=cm&amp;fs=1&amp;tf=1&amp;to='+email+'" title="Send a mail"">'+email+'</a></b>');
					  });
					  $('#branchAddress'+orderId).html('<a href="getAddress.jsp?lat='+branchDetails.latitude+'&lng='+branchDetails.longitude+'" title="Find on map" target="_new">'+branchDetails.address+'</a>');
					  $('#kitchenCard'+orderId).flip(false);
					  $('#dishList'+orderId).html('');
					  
					  //Clear Dish List & Total amount
					  $('#dishEditList'+orderId).html('');
					  $('#dishEditTotalAmount'+orderId).html('0');
					  
					  $('#dishCard'+orderId).flip(true);
					}
				}
				xhttp1.open("GET", "ajax-service.jsp?service=kitchenDetails&kitchenId="+branchId, true);
				xhttp1.send();
			}
		}
		xhttp.open("GET", "ajax-service.jsp?service=changeKitchen&orderId="+orderId+"&kitchenId="+branchId, true);
		xhttp.send();
		
		
	}
	
	


	function GetAddress() {
		var lat = parseFloat(document.getElementById("txtLatitude").value);
		var lng = parseFloat(document.getElementById("txtLongitude").value);
		var latlng = new google.maps.LatLng(lat, lng);
		var geocoder = geocoder = new google.maps.Geocoder();
		geocoder.geocode({
			'latLng' : latlng
		}, function(results, status) {
			if (status == google.maps.GeocoderStatus.OK) {
				if (results[1]) {
					alert("Location: " + results[1].formatted_address);
				}
			}
		});
	}

	function assignDelivery(orderId) {
		$("#assignDelivery" + orderId).submit();
	}

	function checkForNewOrder() {
		var xhttp;
		xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function() {
			if (xhttp.readyState == 4 && xhttp.status == 200) {
			   var jsonObject=JSON.parse(xhttp.responseText);
			   showPendingOrderNotification(jsonObject.id);
			}
		}
		xhttp.open("GET", "ajax-service.jsp?service=lastOrderId&lastOrderId="+ $("#latestOrderId").val(), true);
		xhttp.send();
		
		setTimeout(checkForNewOrder, "30000");
	}

	function showPendingOrderNotification(latestOrderId) {
		var orderCount = latestOrderId - $("#latestOrderId").val();
		if(orderCount<=0)
			return;

		// Let's check if the browser supports notifications
		if (!("Notification" in window)) {
			alert("This browser does not support desktop notification. Please update your browser or other browser");
		}

		// Let's check whether notification permissions have already been granted
		else if (Notification.permission === "granted") {
			// If it's okay let's create a notification
			var notification = new Notification(orderCount
					+ " new order(s) received!", {
				"icon" : "/images/login_logo.png"
			});
		}
		// Otherwise, we need to ask the user for permission
		else if (Notification.permission !== 'denied') {
			Notification.requestPermission(function(permission) {
				// If the user accepts, let's create a notification
				if (permission === "granted") {
					var notification = new Notification(orderCount
							+ " new order(s) received!");
				}
			});
		}
		
		$(".new-order-count").html(orderCount);
		$("#pendingOrderNotificaton").show();
		$("#latestOrderId").val(latestOrderId);
	}

	function reOpen(orderId) {
		if (confirm("Are you sure you want to re-open this order?"))
			window.location = "order-reopen.jsp?id=" + orderId;
	}

	function cancelOrder(orderId, pageNo) {
		if (confirm("Are you sure you want to cancel this order?"))
			window.location = "cancel-order-new.jsp?orderid=" + orderId
					+ "&pageNo=" + pageNo;
	}

	function saveRemarks(remarkBox, orderId) {
		$.ajax({
			url : "ajax-service.jsp?service=orderRemarks&remarks="
					+ $(remarkBox).val() + "&orderId=" + orderId,
			success : function(response) {
				$("#msg").val("Remarks saved").show();
			}
		});
	}

	function editDeliveryRemarks(remarkBox) {
		$(remarkBox).removeAttr("disabled");
		$(remarkBox).removeAttr("readonly");
	}

	function editOrderRemarks(userId, remarkBox) {
		$(remarkBox).removeAttr("disabled");
		$(remarkBox).removeAttr("readonly");
	}


	function removeDish(orderId,dishOrderId){
		$('#loading'+orderId).show();
		var xhttp;
		xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function() {
			if (xhttp.readyState == 4 && xhttp.status == 200) {
				$('#loading'+orderId).hide();		
			   var jsonObject=JSON.parse(xhttp.responseText);
			   if(jsonObject.status=='success'){
			  $("#order"+dishOrderId).hide("slow");
			   //$("#order"+dishOrderId).remove();
			  $("#dishItem"+dishOrderId).addClass("strike");
			  refreshOrderSummary(orderId);
		   }
		   }
		}
		xhttp.open("GET", "ajax-service.jsp?service=removeDish&orderId="+orderId+"&dishOrderId="+dishOrderId, true);
		xhttp.send();
	}
	
	function addDish(orderId,kitchenId){
		$('#loading'+orderId).show();
		var xhttp;
		xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function() {
			if (xhttp.readyState == 4 && xhttp.status == 200) {
				$('#loading'+orderId).hide();
			   var dishOrder=JSON.parse(xhttp.responseText);
			   if(dishOrder.status=='success'){
				   $('#dishEditList'+orderId).append('<li id="order'+dishOrder.dishOrderId+'">'+
							'<select style="width: 200px"  id="dish'+dishOrder.dishOrderId+'" onchange="dishChanged(\''+orderId+'\','+dishOrder.dishOrderId+',this.value)">'+							
							'<option selected disabled>Select a dish</option>'+			
							'</select>'+ 
							 ' : <input type="number" style="width: 44px" placeholder="Quantity" max="999" min="1" id="dishQuantity'+dishOrder.dishOrderId+'" value="1" onChange="dishQuantityChanged(\''+orderId+'\','+dishOrder.dishOrderId+',this.value)">'+
							 '<a href="javascript:void(0);" onclick="removeDish(\''+orderId+'\','+dishOrder.dishOrderId+')">'+ 
							 '<img style="margin-top: 5px; width: 10px;" title="Remove dish" alt="remove" src="images/close.jpg" >'+
							 '</a>'+
						'</li>');
				   loadDishes(kitchenId,dishOrder.dishOrderId);
			   }
			  		
			}
		}
		xhttp.open("GET", "ajax-service.jsp?service=addDish&orderId="+orderId, true);
		xhttp.send();
	}
	
	function loadDishes(kitchenId,dishOrderId){
		var xhttp;
		xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function() {
			if (xhttp.readyState == 4 && xhttp.status == 200) {
			   var dishes=JSON.parse(xhttp.responseText).dishes;
			   $.each(dishes,function(index,dish){
				   $("#dish"+dishOrderId).append("<option value='"+dish.id+"'>"+dish.name+"&nbsp;&nbsp;|&nbsp;&nbsp;Rs."+dish.price+"</option>");
			   });			  		
			}
		}
		xhttp.open("GET", "ajax-service.jsp?service=dishes&kitchenId="+kitchenId, true);
		xhttp.send();
	}
	
	function changeDishes(orderId) {
		$("#kitchenCard" + orderId).flip(false);
		$("#dishCard" + orderId).flip(true);
	}

	function saveDishes(orderId) {
		$("#dishCard" + orderId).flip(false);
		total=parseInt($('#totalAmount'+orderId).html());
		paid=parseInt($('#paidAmount'+orderId).html());
		discount=parseInt($('#discountAmount'+orderId).html());
		balance=total-paid;
		if(!isNaN(discount))
			balance-=discount;
		var msg=" to be collected from customer\n";
		if(balance<0){
			msg=" to be refunded to customer\n";
			balance=balance*-1;
			if(!isNaN(discount))
				balance-=discount;
		}
			
// 		if(balance!=0)
// 			$('#orderRemarks'+orderId).val($('#orderRemarks'+orderId).val()+'\n\nRs.'+balance+msg);
		
		//saveRemarks($('#orderRemarks'+orderId), orderId);
		$("#totalAmount"+orderId).html($("#dishEditTotalAmount"+orderId).html());
	}

	function changeKitchen(orderId) {
		$("#dishCard" + orderId).flip(false);
		$("#kitchenCard" + orderId).flip(true);
		$.ajax({
			url : "ajax-service.jsp?service=kitchens",
			success : function(response) {
				var kitchens=JSON.parse(response);
			}
		});
		
	}
	
	function dishChanged(orderId,dishOrderId,dishId){
		$('#loading'+orderId).show();
		var xhttp;
		xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function() {
			$('#loading'+orderId).hide();
			if (xhttp.readyState == 4 && xhttp.status == 200) {
				 var result=JSON.parse(xhttp.responseText);
				 if(result.status=='success')
					 refreshOrderSummary(orderId);
			}
		}
		xhttp.open("GET", "ajax-service.jsp?service=updateOrder&orderId="+orderId+"&dishOrderId="+dishOrderId+"&dishId="+dishId, true);
		xhttp.send();
		
	}
	
	function dishQuantityChanged(orderId,dishOrderId,quantity){
		$('#loading'+orderId).show();
		var xhttp;
		xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function() {
			if (xhttp.readyState == 4 && xhttp.status == 200) {
				$('#loading'+orderId).hide();
				 var result=JSON.parse(xhttp.responseText);
				 if(result.status=='success')
					 refreshOrderSummary(orderId);
			}
		}
		xhttp.open("GET", "ajax-service.jsp?service=updateQuantity&orderId="+orderId+"&dishOrderId="+dishOrderId+"&quantity="+quantity, true);
		xhttp.send();
	}

	function refreshOrderSummary(orderId){
		var xhttp;
		xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function() {
			if (xhttp.readyState == 4 && xhttp.status == 200) {
				 var orderSummary=JSON.parse(xhttp.responseText).orderSummary;
				 $('#dishList'+orderId).html('');
				 $.each(orderSummary.dishOrders,function(index,dishOrder){
					   $('#dishList'+orderId).append('<li id="dishItem'+dishOrder.id+'">'+
								'<b><span>'+dishOrder.dishName+'</span>'+
								': <span>'+dishOrder.dishQuantity+'</span></br>'+
						'</li>');
				   });
				 $('#dishEditTotalAmount'+orderId).html(orderSummary.orderAmount);
				 $('#changeDish'+orderId).html('change');
				 
			}
		}
		xhttp.open("GET", "ajax-service.jsp?service=orderSummary&orderId="+orderId, true);
		xhttp.send();
	}
	
	function saveKitchen(kitchenId) {
		flipKitchenCard(kitchenId,false);
	}
	
	function flipKitchenCard(kitchenId,showFront){
		$("#kitchenCard" + kitchenId).flip(showFront);
	}
	
	function confirmClicked(confirmButton){
		confirmButton.prop("disabled","disabled");
		confirmButton.html('Please wait');
	}

	
	$(document).ready(function() {
						//Change dish
						$(".card").flip({
							trigger : 'manual'
						});
						
						//Start date
						if ($("#datepicker").val() == "")
							$("#datepicker").datepicker({
								dateFormat : 'yy-mm-dd'	
							}).datepicker("setDate", new Date());
						else
							$("#datepicker").datepicker({
								dateFormat : 'yy-mm-dd'
							});

						//End date
						if ($("#datepicker1").val() == "")
							$("#datepicker1").datepicker({
								dateFormat : 'yy-mm-dd'
							}).datepicker("setDate", new Date());
						else
							$("#datepicker1").datepicker({
								dateFormat : 'yy-mm-dd'
							});

						$("#paymentTypeSelect").change(function() {
							if ($("#paymentTypeSelect").val() == "cod")
								$("#successPaymentCheck").hide();
							else {
								$("#successPaymentCheck").show("slow");
								$("#showFailedPayments").removeProp('checked');
							}
						});

						//Accordions 
						$("#searchFilterContainer").accordion({
							collapsible : true,
							active : 10
						});

						$("#searchFilterContainer").accordion({
							collapsible : true,
							active : 10
						});

						$(".link-prev-page").click(function() {
							$("#pageNo").val(parseInt($("#pageNo").val()) - 1);
							$("#formFilterOrder").submit();
						});

						$(".link-next-page").click(function() {
							$("#pageNo").val(parseInt($("#pageNo").val()) + 1);
							$("#formFilterOrder").submit();
						});

						$("#btnApplyFilter").click(function() {
							$("#pageNo").val("1");
							$("#formFilterOrder").submit();
						});

						$("#pendingOrderNotificaton")
								.click(
										function() {
											$("#searchFilterContainer")
													.accordion("disable");
											window.location = "order-dashboard.jsp?orderStatus=received";
										});
						
						
						//Load the latest order id on page load
						 	var xhttp;
							xhttp = new XMLHttpRequest();
							xhttp.onreadystatechange = function() {
								if (xhttp.readyState == 4 && xhttp.status == 200) {
								   var jsonObject=JSON.parse(xhttp.responseText);
								   $("#latestOrderId").val(jsonObject.id+"");
								}
							}
							xhttp.open("GET", "ajax-service.jsp?service=lastOrderId", true);
							xhttp.send();
							
							//Check for new orders and notify
						    setTimeout(checkForNewOrder,"30000");
							

						$("#clearFilters").click(
								function() {
									$("#formFilterOrder").find(
											"input[type!=button], textarea")
											.val("");
									$("#formFilterOrder").find("select").val(
											"all");
								});

						$("#orderStatusFilter")
								.change(
										function() {
											if ($("#orderStatusFilter").val() == 'assigned'
													|| $("#orderStatusFilter")
															.val() == 'delivered'
													|| $("#orderStatusFilter")
															.val() == 'settled') {
												$("#deliveryAgentFilter")
														.removeAttr("disabled");
												$("#deliveryStatusFilter")
														.removeAttr("disabled");
											} else {
												$("#deliveryAgentFilter").val("all");
												$("#deliveryAgentFilter").prop(
														'disabled', 'disabled');

												$("#deliveryStatusFilter").val(
														"all");
												$("#deliveryStatusFilter")
														.prop('disabled',
																'disabled');
											}
										});		
						
					});
</script>
</html>