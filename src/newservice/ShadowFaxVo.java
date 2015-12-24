package newservice;

import java.io.Serializable;

public class ShadowFaxVo implements Serializable {

    private String message;

    private Data data;

    public String getMessage ()
    {
        return message;
    }

    public void setMessage (String message)
    {
        this.message = message;
    }

    public Data getData ()
    {
        return data;
    }

    public void setData (Data data)
    {
        this.data = data;
    }

    @Override
    public String toString()
    {
        return "ClassPojo [message = "+message+", data = "+data+"]";
    }
}
