package newservice;

import java.io.Serializable;

public class OpinioPostOrderCancel implements Serializable{
	
	private String is_cancelled;
	private String order_code;
	
	

	public String getOrder_code() {
		return order_code;
	}

	public void setOrder_code(String order_code) {
		this.order_code = order_code;
	}

	public String getIs_cancelled() {
		return is_cancelled;
	}

	public void setIs_cancelled(String is_cancelled) {
		this.is_cancelled = is_cancelled;
	}
	
	

}
