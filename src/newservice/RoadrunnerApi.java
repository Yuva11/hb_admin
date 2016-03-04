package newservice;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.codehaus.jettison.json.JSONObject;

import com.google.gson.Gson;
import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.ClientHandlerException;
import com.sun.jersey.api.client.ClientRequest;
import com.sun.jersey.api.client.ClientResponse;
import com.sun.jersey.api.client.WebResource;
import com.sun.jersey.api.client.filter.ClientFilter;
import com.sun.jersey.api.client.filter.GZIPContentEncodingFilter;


public class RoadrunnerApi {
	static String tokenno1;
public static void main(String[] args) throws Exception{

}
public static String getData(String hostURL) {

	String result = "";
	Client client = myGetClient();
	if(client!=null){
		WebResource webResource = client.resource(hostURL);
		ClientResponse response = webResource.accept("application/json").get(ClientResponse.class);
	
		client.addFilter(new GZIPContentEncodingFilter(false));
		JSONObject object = response.getEntity(JSONObject.class);
		result = object.toString();
	}else{
		System.out.println("Please contact To Admin");
	}
	return result;
}

public static String postData(String postValue,String hostURL,String tokenno) {
      tokenno1=tokenno;
	String result = "";
	Client client = myGetClient();
	WebResource webResource = client.resource(hostURL);
	ClientResponse response = webResource.accept("application/json").post(ClientResponse.class, postValue);
	client.addFilter(new GZIPContentEncodingFilter(false));
	JSONObject object = response.getEntity(JSONObject.class);
	result = object.toString();
	return result;
}




public static Client myGetClient() {
	Client client = Client.create();
	client.addFilter(new ClientFilter() {
		
		@Override
		public ClientResponse handle(ClientRequest arg0)throws ClientHandlerException {
			arg0.getHeaders().add("Content-Type", "application/json");
			arg0.getHeaders().add("Authorization","Basic "+tokenno1);
			arg0.getHeaders().add("charset", "utf-8");
			
			return getNext().handle(arg0);
		}
	});
	return client;
}
public static String convert(Map<String, String> map) {
    Gson gson = new Gson();
    String json = gson.toJson(map);
    
    return json;
}
//////////////////////////////////

public static String postDataRadRunn(String postValue,String hostURL,String tokenno) {
    tokenno1=tokenno;
	String result = "";
	Client client = myGetClientRoad();
	WebResource webResource = client.resource(hostURL);
	ClientResponse response = webResource.accept("application/json").post(ClientResponse.class, postValue);
	client.addFilter(new GZIPContentEncodingFilter(false));
	JSONObject object = response.getEntity(JSONObject.class);
	result = object.toString();
	return result;
}

public static Client myGetClientRoad() {
	Client client = Client.create();
	client.addFilter(new ClientFilter() {
		
		@Override
		public ClientResponse handle(ClientRequest arg0)throws ClientHandlerException {
			arg0.getHeaders().add("Content-Type", "application/json");
			arg0.getHeaders().add("Authorization","Token "+tokenno1);
			arg0.getHeaders().add("charset", "utf-8");
			
			return getNext().handle(arg0);
		}
	});
	return client;
}



/////////////////////////////////////////



public static String postDataShadowFax(String postValue,String hostURL,String tokenno) {
    tokenno1=tokenno;
	String result = "";
	Client client = myGetClientShadowFax();
	WebResource webResource = client.resource(hostURL);
	ClientResponse response = webResource.accept("application/json").post(ClientResponse.class, postValue);
	client.addFilter(new GZIPContentEncodingFilter(false));
	JSONObject object = response.getEntity(JSONObject.class);
	result = object.toString();
	return result;
}


public static Client myGetClientShadowFax() {
	Client client = Client.create();
	client.addFilter(new ClientFilter() {
		
		@Override
		public ClientResponse handle(ClientRequest arg0)throws ClientHandlerException {
			arg0.getHeaders().add("Content-Type", "application/json");
			arg0.getHeaders().add("Authorization","Token "+tokenno1);
			arg0.getHeaders().add("charset", "utf-8");
			
			return getNext().handle(arg0);
		}
	});
	return client;
}






}
