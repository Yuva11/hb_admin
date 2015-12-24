package newservice;

import java.io.Serializable;

public class AdminLoginVO implements Serializable {
	String status;
	String email;

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

}
