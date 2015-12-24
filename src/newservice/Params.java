package newservice;

public class Params {

	
	private String role;

    private String entity_id;

    private String secure_auth;

    public String getRole ()
    {
        return role;
    }

    public void setRole (String role)
    {
        this.role = role;
    }

    public String getEntity_id ()
    {
        return entity_id;
    }

    public void setEntity_id (String entity_id)
    {
        this.entity_id = entity_id;
    }

    public String getSecure_auth ()
    {
        return secure_auth;
    }

    public void setSecure_auth (String secure_auth)
    {
        this.secure_auth = secure_auth;
    }

    @Override
    public String toString()
    {
        return "ClassPojo [role = "+role+", entity_id = "+entity_id+", secure_auth = "+secure_auth+"]";
    }
}
