package newservice;

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

public class OpinioHelper {
	static String tokenno1;

	public static void main(String[] args) throws Exception {

	}

	public static String getData(String hostURL) {

		String result = "";
		Client client = myGetClient();
		if (client != null) {
			WebResource webResource = client.resource(hostURL);
			ClientResponse response = webResource.accept("application/x-www-form-urlencoded").get(ClientResponse.class);

			client.addFilter(new GZIPContentEncodingFilter(false));
			JSONObject object = response.getEntity(JSONObject.class);
			result = object.toString();
		} else {
			System.out.println("Please contact To Admin");
		}
		return result;
	}

	public static String postData(String postValue, String hostURL, String tokenno) {
		tokenno1 = tokenno;
		String result = "";
		Client client = myGetClient();
		WebResource webResource = client.resource(hostURL);
		ClientResponse response = webResource.accept("application/x-www-form-urlencoded").post(ClientResponse.class,
				postValue);
		client.addFilter(new GZIPContentEncodingFilter(false));
		JSONObject object = response.getEntity(JSONObject.class);
		result = object.toString();
		return result;
	}

	public static Client myGetClient() {
		Client client = Client.create();
		client.addFilter(new ClientFilter() {

			@Override
			public ClientResponse handle(ClientRequest arg0) throws ClientHandlerException {
				arg0.getHeaders().add("Content-Type", "application/x-www-form-urlencoded");
				arg0.getHeaders().add("Authorization", tokenno1);
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

	public static String postOrderToOpinio(String postValue, String hostURL, String tokenno) {
		tokenno1 = tokenno;
		String result = "";
		Client client = myGetClientRoad();
		WebResource webResource = client.resource(hostURL);
		ClientResponse response = webResource.accept("application/x-www-form-urlencoded").post(ClientResponse.class,
				postValue);
		client.addFilter(new GZIPContentEncodingFilter(false));
		JSONObject object = response.getEntity(JSONObject.class);
		result = object.toString();
		return result;
	}

	public static Client myGetClientRoad() {
		Client client = Client.create();
		client.addFilter(new ClientFilter() {

			@Override
			public ClientResponse handle(ClientRequest arg0) throws ClientHandlerException {
				arg0.getHeaders().add("Content-Type", "application/x-www-form-urlencoded");
				arg0.getHeaders().add("Authorization", tokenno1);
				return getNext().handle(arg0);
			}
		});
		return client;
	}
	
	
	
	public static String postOrderToOpinioCancel(String postValue, String hostURL, String tokenno) {
		tokenno1 = tokenno;
		String result = "";
		Client client = myGetClientRoadCancel();
		WebResource webResource = client.resource(hostURL);
		ClientResponse response = webResource.accept("application/x-www-form-urlencoded").post(ClientResponse.class,
				postValue);
		client.addFilter(new GZIPContentEncodingFilter(false));
		JSONObject object = response.getEntity(JSONObject.class);
		result = object.toString();
		return result;
	}

	public static Client myGetClientRoadCancel() {
		Client client = Client.create();
		client.addFilter(new ClientFilter() {

			@Override
			public ClientResponse handle(ClientRequest arg0) throws ClientHandlerException {
				arg0.getHeaders().add("Content-Type", "application/x-www-form-urlencoded");
				arg0.getHeaders().add("Authorization", tokenno1);
				return getNext().handle(arg0);
			}
		});
		return client;
	}
	
	

}
