package newservice;

import java.util.HashMap;
import java.util.Map;


import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.methods.StringRequestEntity;
import org.json.simple.JSONObject;

import com.google.gson.JsonObject;

public class HttpRequestor {
	
	public static String getHttpResponseWithJsonPayLoad(String url, Map<String,String> requestParams){
		String response=null;
		try{
		HttpClient httpClient = new HttpClient();
		PostMethod postMethod = new PostMethod(url);
		postMethod.addRequestHeader("Content-Type", "application/json");
		JSONObject jsonObj =new JSONObject(requestParams);
		String content=jsonObj.toJSONString();
		StringRequestEntity sre = new StringRequestEntity(content);
		postMethod.setRequestEntity(sre);
		httpClient.executeMethod(postMethod);
		response=postMethod.getResponseBodyAsString();
		}catch(Exception ex){
			ex.printStackTrace();
		}
		return response;
	}

	public static void main(String []args){
		HashMap<String,String> hm = new HashMap<String,String>();
		hm.put("lat", "12.9551158");
		hm.put("lng", "77.6874921");
		String location=getHttpResponseWithJsonPayLoad("http://service.hungrybells.in:9090/location/currentlocation", hm);
		System.out.println(location);
		
	}
}
