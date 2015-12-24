<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<ui:composition xmlns="http://www.w3.org/1999/xhtml" xmlns:ui="http://java.sun.com/jsf/facelets"
	xmlns:h="http://java.sun.com/jsf/html" xmlns:f="http://java.sun.com/jsf/core" xmlns:p="http://primefaces.org/ui"
	template="/p/layout.xhtml">
	<ui:define name="action_header">
		<script>
			function showSettingDlg(xhr, status, args) {
				if (args.validate)
					PRODUCTSETTDLG.show();
				else
					$("#PDTMSG").show();
			}
		</script>

	</ui:define>
	<ui:define name="content">

		<h:form  onkeypress="if (event.keyCode == 13) { document.getElementById('enterKey').click(); return false; }"  id="form1" prependId="false">
			<p:growl id="PDTMSG" />
			
    		 <div id="main_container">
     			<div class="head_bottom_listbg">
					<div id="container">
						<div class="head_list_box">
						<h3>Order</h3></div>
						<div class="head_list_box1">
							<div class="left_arrow_smal"></div>
							<h3><span>List of Orders</span></h3>
						</div>
					
						<div class="head_list_box1">
							<div class="left_arrow_smal"></div>
							<h3><span><a href="../DealOrders/neworderdetails.jsp" style=" color: white;">List of New Orders</a></span></h3>
						</div>
						
						<div class="menu_list_button_box">
							<p:outputPanel rendered="false">
								<div class="button_list"> 
									 <h:commandLink id="btnview" rendered="true" action="#{dealBean.publish}"><i class="fa fa-th-large"></i>
									   <f:setPropertyActionListener target="#{dealBean.action}" value="PUBLISH_VIEW"/>
									</h:commandLink>
									<p:tooltip for="btnview" value="Approve" showEffect="fade" hideEffect="fade"/>   
								</div>
							</p:outputPanel>
						</div>
					</div>
				</div>
     			<div class="contant_main">
    				 <div class="contant_box">
			     		 <div class="dropdons_box">
							<div class="serch_box">
                            <h:inputText class="text_box" id="txtsrch" value="#{dealOrderBean.searchKey}" tabindex="1"/>
                            <p:watermark for="txtsrch" value="Search by Merchant / Customer / Ref No"/>
                            <div class="search1">
                            <h:commandLink  id="enterKey" action="#{dealOrderBean.search}" tabindex="2">
                            <i class="fa fa-search"></i>
                            </h:commandLink>
                            </div>
                          </div>
 						</div>
 						<div  class="contant_table_box">


								<p:dataTable value="#{dealOrderBean.ordersList}" var="it"  rowKey="#{it.id}" 
									paginator="true" rows="20" paginatorPosition="bottom" 
									paginatorAlwaysVisible="true" rowIndexVar="idx"
									paginatorTemplate="{CurrentPageReport}  {FirstPageLink} {PreviousPageLink} {PageLinks} {NextPageLink} {LastPageLink} {RowsPerPageDropdown}"
									rowsPerPageTemplate="20,50,100,500,1000">
					
									<p:column headerText="SI.No" style="width:55px;text-align:center">
										<h:outputText value="#{idx+1}" />
									</p:column>
									<p:column headerText="Order Ref"  sortBy="#{it.orderId}" >
									<p:commandLink style="color:gray;"
										update=":form1:orderDetailsViewId"
										oncomplete="PF('OrderDetails').show()" value="#{it.orderId}"
										id="orderDetailsId" action="#{dealOrderBean.showOrderDetails}">
										<f:setPropertyActionListener
											target="#{dealOrderBean.orderDetailsId}" value="#{it.orderId}" />
									</p:commandLink>
								</p:column>
									<p:column headerText="Merchant Name"  sortBy="#{it.merchant.name}" > 
											<h:outputText value="#{it.merchant.name}" /> 
									</p:column>
								     <p:column headerText="Customer Name"  sortBy="#{it.customer.firstName}" >
								     <h:outputText value="#{it.customer.firstName}" />
								     </p:column>
								     <p:column headerText="Mobile No."  sortBy="#{it.customer.mobileNumber}" >
								     <h:outputText value="#{it.customer.mobileNumber}" />
								     </p:column>
								     <p:column headerText="Email ID"  sortBy="#{it.customer.email}" >
								     <h:outputText value="#{it.customer.email}" />
								     </p:column>
					 
									 <p:column headerText="Order Date" rendered="true"  sortBy="#{it.dealordersdate}" > 
										<p style="text-align:center !important;">
										<h:outputText value="#{it.dealordersdate}" converter="HC"/> 
										</p>
									</p:column> 
									
									<p:column headerText="Payment Date" rendered="true"  sortBy="#{it.paymentAtempt.paymentdate}" >
										<p style="text-align:center !important;">
										<h:outputText value="#{it.paymentAtempt.paymentdate}" converter="HC"/> 
										</p>
									</p:column>
									 
									<p:column headerText="Amount" style="width:75px;text-align:right"  sortBy="#{it.amount}" >
										<h:outputText value="#{it.amount}"><f:convertNumber pattern="#0.00"  /></h:outputText> 
									</p:column>
									<p:column headerText="Status"  sortBy="#{it.status}" > 
										<h:outputText value="#{it.status}"  /> 
									</p:column> 
									<p:column rendered="false">
									<p:commandLink id="sele" process="@this" rendered="false"
						action="#{dealOrderBean.getDetail}"
						oncomplete="PF('OrderDetail').show()" update=":dialog12">
						
						<img src="#{request.contextPath}/images/publish.png" />
						<f:setPropertyActionListener
							target="#{dealOrderBean.selectedorder}" value="#{it}" />
						
						
					</p:commandLink>
								</p:column>	
									
									
								</p:dataTable> 

							</div>
 
 					</div> 
    			</div> 
     		</div> 
     		<h:panelGroup id="orderDetailsViewId">
				<p:dialog header="Order Details" draggable="true" modal="true"
					closable="false" width="700" widgetVar="OrderDetails"
					showEffect="slide" hideEffect="slide" closeOnEscape="true"
					resizable="false">
					<h:form>
						<p:outputPanel process="@this">
							<div>
								<p:scrollPanel style="width:650px;height:500px">
									<h:panelGrid columns="2" cellpadding="5">
										<h:outputText value="Order ID:" />
										<h:outputText
											value="#{dealOrderBean.orderDetailsCustomHBADto.order_id}"
											style="font-weight: bold" />
										<h:outputText value="Deal Order Date:" />
										<h:outputText
											value="#{dealOrderBean.orderDetailsCustomHBADto.dealordersdate}"
											style="font-weight: bold" />
										<h:outputText value="Bank Transaction ID:" />
										<h:outputText
											value="#{dealOrderBean.orderDetailsCustomHBADto.bank_transcation_id}"
											style="font-weight: bold" />
										<h:outputText value="Bank Transaction Status:" />
										<h:outputText
											value="#{dealOrderBean.orderDetailsCustomHBADto.order_status}"
											style="font-weight: bold" />
										<h:outputText value="Customer Name:" />
										<h:outputText
											value="#{dealOrderBean.orderDetailsCustomHBADto.first_name}"
											style="font-weight: bold" />
										<h:outputText value="Customer Mobile No:" />
										<h:outputText
											value="#{dealOrderBean.orderDetailsCustomHBADto.customer_mobileno}"
											style="font-weight: bold" />
										<h:outputText value="Customer Email ID:" />
										<h:outputText
											value="#{dealOrderBean.orderDetailsCustomHBADto.customer_email}"
											style="font-weight: bold" />
										<h:outputText value="Delivery Address:" />
										<h:outputText
											value="#{dealOrderBean.orderDetailsCustomHBADto.delivery_address}"
											style="font-weight: bold" />
										<h:outputText value="Deal Name:" />
										<h:outputText
											value="#{dealOrderBean.orderDetailsCustomHBADto.dealname}"
											style="font-weight: bold" />
										<h:outputText value="Deal Details:" />
										<h:outputText
											value="#{dealOrderBean.orderDetailsCustomHBADto.dealdetails}"
											style="font-weight: bold" />
										<h:outputText value="Quantity:" />
										<h:outputText
											value="#{dealOrderBean.orderDetailsCustomHBADto.quantity}"
											style="font-weight: bold" />
										<h:outputText value="Amount:" />
										<h:outputText
											value="#{dealOrderBean.orderDetailsCustomHBADto.cost}"
											style="font-weight: bold" />
										<h:outputText value="Brand Name:" />
										<h:outputText
											value="#{dealOrderBean.orderDetailsCustomHBADto.brand_name}"
											style="font-weight: bold" />
										<h:outputText value="Outlet Name:" />
										<h:outputText
											value="#{dealOrderBean.orderDetailsCustomHBADto.branch_name}"
											style="font-weight: bold" />
										<h:outputText value="Outlet Address:" />
										<h:outputText
											value="#{dealOrderBean.orderDetailsCustomHBADto.outlet_address}"
											style="font-weight: bold" />
										<h:outputText value="Outlet Contact No:" />
										<h:outputText
											value="#{dealOrderBean.orderDetailsCustomHBADto.outlet_mobileno}"
											style="font-weight: bold" />
										<h:outputText value="Outlet Alt Contact No1:" />
										<h:outputText
											value="#{dealOrderBean.orderDetailsCustomHBADto.alt_mobile_number_one}"
											style="font-weight: bold" />
										<h:outputText value="Outlet Alt Contact No2:" />
										<h:outputText
											value="#{dealOrderBean.orderDetailsCustomHBADto.alt_mobile_number_two}"
											style="font-weight: bold" />
										<h:outputText value="Outlet Alt Contact No3:" />
										<h:outputText
											value="#{dealOrderBean.orderDetailsCustomHBADto.alt_mobile_number_three}"
											style="font-weight: bold" />
										<h:outputText value="City Name:" />
										<h:outputText
											value="#{dealOrderBean.orderDetailsCustomHBADto.city_name}"
											style="font-weight: bold" />
										<h:outputText value="Location Name:" />
										<h:outputText
											value="#{dealOrderBean.orderDetailsCustomHBADto.location_name}"
											style="font-weight: bold" />
										<h:outputText value="Outlet Email:" />
										<h:outputText
											value="#{dealOrderBean.orderDetailsCustomHBADto.outlet_email}"
											style="font-weight: bold" />
										<h:outputText value="Outlet Alt Email1:" />
										<h:outputText
											value="#{dealOrderBean.orderDetailsCustomHBADto.alt_email_one}"
											style="font-weight: bold" />
										<h:outputText value="Outlet Alt Email2:" />
										<h:outputText
											value="#{dealOrderBean.orderDetailsCustomHBADto.alt_email_two}"
											style="font-weight: bold" />
										<h:outputText value="Outlet Alt Email3:" />
										<h:outputText
											value="#{dealOrderBean.orderDetailsCustomHBADto.alt_email_three}"
											style="font-weight: bold" />
										<h:outputText value="Tax Details:" />
										<h:outputText value="**" style="font-weight: bold" />
									</h:panelGrid>
								</p:scrollPanel>
							</div>
							<br></br>
							<div align='right'>
								<p:commandButton value="Close"
									style="color:#fff !important;background:#616161 !important;box-shadow:none !important;border: medium none !important;"
									oncomplete="PF('OrderDetails').hide()" />
							</div>
						</p:outputPanel>
					</h:form>
				</p:dialog>
			</h:panelGroup>
		</h:form>
		
		
			<p:dialog id="dialog12"  rendered="true" header="Deal Order Details List"
			draggable="false" modal="true" closable="true" width="auto" height="auto"
			widgetVar="OrderDetail"  showEffect="slide"
			hideEffect="slide" closeOnEscape="true" resizable="false">
			<h:form id="dlgfrm">
               <p:outputPanel id="dlgpnl">
				<p:dataTable value="#{dealOrderBean.orderdetaillist}" var="it"  rowKey="#{it.id}" 
									paginator="true" rows="10" paginatorPosition="bottom" 
									paginatorAlwaysVisible="true" rowIndexVar="idx"
									paginatorTemplate="{CurrentPageReport}  {FirstPageLink} {PreviousPageLink} {PageLinks} {NextPageLink} {LastPageLink} {RowsPerPageDropdown}"
									rowsPerPageTemplate="20,50,100,500,1000">
					
									<p:column headerText="SI.No" style="width:55px;text-align:center">
										<h:outputText value="#{idx+1}" />
									</p:column>
									
									<p:column headerText="Deal" rendered="true">
									
										
										<h:outputText value="#{it.deal.name}"/> 
			
									</p:column>
									<p:column headerText="Delivery Address" rendered="true">
										<h:outputText value="#{it.deliveryAddress}"/> 
									</p:column>
									 <p:column headerText="Order Cost">
								     <h:outputText value="#{it.cost}" />
								     </p:column>
					 
									 <p:column headerText="Quantity" rendered="true">
									
										
										
										<h:outputText value="#{it.quantity}"/> 
										
									</p:column> 
									
									
									
									
								
									<!-- <p:column headerText="Select" selectionMode="single" style="width:60px;text-align:center"/> -->
								</p:dataTable> 

                        </p:outputPanel>

			</h:form>
		</p:dialog>
		
		
		
		
		
  </ui:define>
  
  
  	  
  
  
  
</ui:composition>
	