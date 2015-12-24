package newservice;

import java.io.Serializable;

public class OpinioResponseVo implements Serializable{
	
	    
		private String id;

	    private String eta;

	    private String pilot_phone;

	    private String pilot_latitude;

	    private String state;

	    private String longitude;

	    private String latitude;

	    private String delivery_eta;

	    private String pilot_longitude;

	    private String order_code;

	    private String pilot_name;

	    
	    public String getId() {
			return id;
		}

		public void setId(String id) {
			this.id = id;
		}


	    public String getEta ()
	    {
	        return eta;
	    }

	    public void setEta (String eta)
	    {
	        this.eta = eta;
	    }

	    public String getPilot_phone ()
	    {
	        return pilot_phone;
	    }

	    public void setPilot_phone (String pilot_phone)
	    {
	        this.pilot_phone = pilot_phone;
	    }

	    public String getPilot_latitude ()
	    {
	        return pilot_latitude;
	    }

	    public void setPilot_latitude (String pilot_latitude)
	    {
	        this.pilot_latitude = pilot_latitude;
	    }

	    public String getState ()
	    {
	        return state;
	    }

	    public void setState (String state)
	    {
	        this.state = state;
	    }

	    public String getLongitude ()
	    {
	        return longitude;
	    }

	    public void setLongitude (String longitude)
	    {
	        this.longitude = longitude;
	    }

	    public String getLatitude ()
	    {
	        return latitude;
	    }

	    public void setLatitude (String latitude)
	    {
	        this.latitude = latitude;
	    }

	    public String getDelivery_eta ()
	    {
	        return delivery_eta;
	    }

	    public void setDelivery_eta (String delivery_eta)
	    {
	        this.delivery_eta = delivery_eta;
	    }

	    public String getPilot_longitude ()
	    {
	        return pilot_longitude;
	    }

	    public void setPilot_longitude (String pilot_longitude)
	    {
	        this.pilot_longitude = pilot_longitude;
	    }

	    public String getOrder_code ()
	    {
	        return order_code;
	    }

	    public void setOrder_code (String order_code)
	    {
	        this.order_code = order_code;
	    }

	    public String getPilot_name ()
	    {
	        return pilot_name;
	    }

	    public void setPilot_name (String pilot_name)
	    {
	        this.pilot_name = pilot_name;
	    }

	    @Override
	    public String toString()
	    {
	        return "ClassPojo [eta = "+eta+", pilot_phone = "+pilot_phone+", pilot_latitude = "+pilot_latitude+", state = "+state+", longitude = "+longitude+", latitude = "+latitude+", delivery_eta = "+delivery_eta+", pilot_longitude = "+pilot_longitude+", order_code = "+order_code+", pilot_name = "+pilot_name+"]";
	    }

}
