package newservice;

public class Drop_details
{
private String contact_number;

private String house_number;

private String name;

private String street;

private String locality;

private String longitude;

private String latitude;

private String city;

public String getContact_number ()
{
return contact_number;
}

public void setContact_number (String contact_number)
{
this.contact_number = contact_number;
}

public String getHouse_number ()
{
return house_number;
}

public void setHouse_number (String house_number)
{
this.house_number = house_number;
}

public String getName ()
{
return name;
}

public void setName (String name)
{
this.name = name;
}

public String getStreet ()
{
return street;
}

public void setStreet (String street)
{
this.street = street;
}

public String getLocality ()
{
return locality;
}

public void setLocality (String locality)
{
this.locality = locality;
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

public String getCity ()
{
return city;
}

public void setCity (String city)
{
this.city = city;
}

@Override
public String toString()
{
return "ClassPojo [contact_number = "+contact_number+", house_number = "+house_number+", name = "+name+", street = "+street+", locality = "+locality+", longitude = "+longitude+", latitude = "+latitude+", city = "+city+"]";
}
}

