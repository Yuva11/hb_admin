package newservice;

public class Order_details
{
private String preparation_time;

private String paid;

private String client_order_id;

private String order_value;

private String scheduled_pickup_time;

public String getPreparation_time ()
{
return preparation_time;
}

public void setPreparation_time (String preparation_time)
{
this.preparation_time = preparation_time;
}

public String getPaid ()
{
return paid;
}

public void setPaid (String paid)
{
this.paid = paid;
}

public String getClient_order_id ()
{
return client_order_id;
}

public void setClient_order_id (String client_order_id)
{
this.client_order_id = client_order_id;
}

public String getOrder_value ()
{
return order_value;
}

public void setOrder_value (String order_value)
{
this.order_value = order_value;
}

public String getScheduled_pickup_time ()
{
return scheduled_pickup_time;
}

public void setScheduled_pickup_time (String scheduled_pickup_time)
{
this.scheduled_pickup_time = scheduled_pickup_time;
}

@Override
public String toString()
{
return "ClassPojo [preparation_time = "+preparation_time+", paid = "+paid+", client_order_id = "+client_order_id+", order_value = "+order_value+", scheduled_pickup_time = "+scheduled_pickup_time+"]";
}
}

