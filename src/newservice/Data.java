package newservice;

import java.io.Serializable;

public class Data
{
private String client_code;

private String status;

private Pickup_details pickup_details;

private Order_details order_details;

private String sfx_order_id;

private Drop_details drop_details;

public String getClient_code ()
{
return client_code;
}

public void setClient_code (String client_code)
{
this.client_code = client_code;
}

public String getStatus ()
{
return status;
}

public void setStatus (String status)
{
this.status = status;
}

public Pickup_details getPickup_details ()
{
return pickup_details;
}

public void setPickup_details (Pickup_details pickup_details)
{
this.pickup_details = pickup_details;
}

public Order_details getOrder_details ()
{
return order_details;
}

public void setOrder_details (Order_details order_details)
{
this.order_details = order_details;
}

public String getSfx_order_id ()
{
return sfx_order_id;
}

public void setSfx_order_id (String sfx_order_id)
{
this.sfx_order_id = sfx_order_id;
}

public Drop_details getDrop_details ()
{
return drop_details;
}

public void setDrop_details (Drop_details drop_details)
{
this.drop_details = drop_details;
}

@Override
public String toString()
{
return "ClassPojo [client_code = "+client_code+", status = "+status+", pickup_details = "+pickup_details+", order_details = "+order_details+", sfx_order_id = "+sfx_order_id+", drop_details = "+drop_details+"]";
}
}
