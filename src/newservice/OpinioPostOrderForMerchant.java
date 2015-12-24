package newservice;

import java.io.Serializable;

public class OpinioPostOrderForMerchant implements Serializable{
	private String name;
	private String phone;
	private String address;
	private String email;
	private String latitude;
	private String longitude;
	

	// Optional Parameters
	private long app_merchant_id;


	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}


	

	public String getPhone() {
		return phone;
	}


	public void setPhone(String phone) {
		this.phone = phone;
	}


	public String getAddress() {
		return address;
	}


	public void setAddress(String address) {
		this.address = address;
	}


	public String getEmail() {
		return email;
	}


	public void setEmail(String email) {
		this.email = email;
	}


	public String getLatitude() {
		return latitude;
	}


	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}


	public String getLongitude() {
		return longitude;
	}


	public void setLongitude(String longitude) {
		this.longitude = longitude;
	}


	public long getApp_merchant_id() {
		return app_merchant_id;
	}


	public void setApp_merchant_id(long app_merchant_id) {
		this.app_merchant_id = app_merchant_id;
	}


	


}
