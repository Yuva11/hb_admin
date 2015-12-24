package newservice;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import org.json.simple.JSONArray;

import com.google.gson.Gson;

public class RoadRunnrLogin {

	public String getAddress(String client_id, String client_secret) {
		String outputString = "";
		// Reference -
		// https://developers.google.com/maps/documentation/distancematrix/
		try {
			Gson gson = new Gson();
			String url1 = "http://roadrunnr.in/oauth/token?grant_type=client_credentials&client_id="
					+ client_id + "&client_secret=" + client_secret + "";
			System.out.println("kk- " + url1);
			URL url = new URL(url1);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");
			String line;
			BufferedReader reader = new BufferedReader(new InputStreamReader(
					conn.getInputStream()));
			while ((line = reader.readLine()) != null) {
				outputString += line;
			}
		} catch (Exception e) {
			e.printStackTrace();

		}

		return outputString;
	}

	public static void main(String ar[]) {
		RoadRunnrLogin getAddressGoogleApi = new RoadRunnrLogin();

		try {

			System.out.println(getAddressGoogleApi.getAddress("12.925543",
					"77.675966"));
		} catch (Exception ek) {
			ek.printStackTrace();
		}
	}

}
