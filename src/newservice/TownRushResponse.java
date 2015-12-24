package newservice;

public class TownRushResponse {
	
	private String message;

    private Params params;

    private String code;

    private String kind;

    public String getMessage ()
    {
        return message;
    }

    public void setMessage (String message)
    {
        this.message = message;
    }

    public Params getParams ()
    {
        return params;
    }

    public void setParams (Params params)
    {
        this.params = params;
    }

    public String getCode ()
    {
        return code;
    }

    public void setCode (String code)
    {
        this.code = code;
    }

    public String getKind ()
    {
        return kind;
    }

    public void setKind (String kind)
    {
        this.kind = kind;
    }

    @Override
    public String toString()
    {
        return "ClassPojo [message = "+message+", params = "+params+", code = "+code+", kind = "+kind+"]";
    }
	
	
}
