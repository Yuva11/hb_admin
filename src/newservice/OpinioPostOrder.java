package newservice;

public class OpinioPostOrder {
	
	// These Are mandatory parameters
	private String merchant_id;
	private double amount;
	private double amount_to_pay;
	private String phone;
	private String address;
	private String locality;
	private String order_code;

	// Optional Parameters
	private String latitude;
	private String longitude;
	private String merchant_phone;

	public String getMerchant_id() {
		return merchant_id;
	}

	public void setMerchant_id(String merchant_id) {
		this.merchant_id = merchant_id;
	}

	public double getAmount() {
		return amount;
	}

	public void setAmount(double amount) {
		this.amount = amount;
	}

	public double getAmount_to_pay() {
		return amount_to_pay;
	}

	public void setAmount_to_pay(double amount_to_pay) {
		this.amount_to_pay = amount_to_pay;
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

	public String getLocality() {
		return locality;
	}

	public void setLocality(String locality) {
		this.locality = locality;
	}

	public String getOrder_code() {
		return order_code;
	}

	public void setOrder_code(String order_code) {
		this.order_code = order_code;
	}

	public String getMerchant_phone() {
		return merchant_phone;
	}

	public void setMerchant_phone(String merchant_phone) {
		this.merchant_phone = merchant_phone;
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
	
	
}
