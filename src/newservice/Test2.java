package newservice;

import java.util.Map;

public class Test2 {
public static void main(String[] args) throws Exception{
	
	OpinioPostOrder opinioPostOrder=new OpinioPostOrder();
	opinioPostOrder.setMerchant_id("3");
	opinioPostOrder.setAmount(250);
	opinioPostOrder.setAmount_to_pay(250);
	opinioPostOrder.setPhone("7411446750");
	opinioPostOrder.setAddress("Testing");
	opinioPostOrder.setLocality("test");
	opinioPostOrder.setOrder_code("10");
	
	Map<String, String> map=OpinioUtils.getPostAuthentication(opinioPostOrder);
	String canonicalString=map.get("canonicalString");
	String Authorization=map.get("authorization");
	
	String result=OpinioHelper.postOrderToOpinio(canonicalString, "http://test.deliver.opinioapp.com/api/v1/orders",Authorization);
	System.out.println(result);
}
}
