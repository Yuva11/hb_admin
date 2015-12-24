package newservice;

public class RoadrunnrVO {
	
	    private String delivery_id;

	    private String driver_phone;

	    private String driver_name;

	    private Status status;

	    private String new_trip;

	    private String order_id;

	    public String getDelivery_id ()
	    {
	        return delivery_id;
	    }

	    public void setDelivery_id (String delivery_id)
	    {
	        this.delivery_id = delivery_id;
	    }

	    public String getDriver_phone ()
	    {
	        return driver_phone;
	    }

	    public void setDriver_phone (String driver_phone)
	    {
	        this.driver_phone = driver_phone;
	    }

	    public String getDriver_name ()
	    {
	        return driver_name;
	    }

	    public void setDriver_name (String driver_name)
	    {
	        this.driver_name = driver_name;
	    }

	    public Status getStatus ()
	    {
	        return status;
	    }

	    public void setStatus (Status status)
	    {
	        this.status = status;
	    }

	    public String getNew_trip ()
	    {
	        return new_trip;
	    }

	    public void setNew_trip (String new_trip)
	    {
	        this.new_trip = new_trip;
	    }

	    public String getOrder_id ()
	    {
	        return order_id;
	    }

	    public void setOrder_id (String order_id)
	    {
	        this.order_id = order_id;
	    }

	    @Override
	    public String toString()
	    {
	        return "ClassPojo [delivery_id = "+delivery_id+", driver_phone = "+driver_phone+", driver_name = "+driver_name+", status = "+status+", new_trip = "+new_trip+", order_id = "+order_id+"]";
	    }
	
}
