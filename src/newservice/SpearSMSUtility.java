
package newservice;

import java.net.HttpURLConnection;
import java.net.URL;
import java.io.*;
import java.net.URLEncoder;
import java.security.KeyManagementException;
import java.security.NoSuchAlgorithmException;
import java.security.cert.CertificateException;
import java.security.cert.X509Certificate;

import javax.net.ssl.HostnameVerifier;
import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLSession;
import javax.net.ssl.TrustManager;
import javax.net.ssl.X509TrustManager;


public class SpearSMSUtility {
	
	
	public void addSslCertificate() throws NoSuchAlgorithmException, KeyManagementException{
		
		TrustManager[] trustAllCerts = new TrustManager[] {
				   new X509TrustManager() {
				      public java.security.cert.X509Certificate[] getAcceptedIssuers() {
				        return null;
				      }

				      public void checkClientTrusted(X509Certificate[] chain,
							String authType) throws CertificateException {
						
						
					}

					public void checkServerTrusted(X509Certificate[] chain,
							String authType) throws CertificateException {
						
					}

				   }
				};

				SSLContext sc = SSLContext.getInstance("SSL");
				sc.init(null, trustAllCerts, new java.security.SecureRandom());
				HttpsURLConnection.setDefaultSSLSocketFactory(sc.getSocketFactory());

				// Create all-trusting host name verifier
				HostnameVerifier allHostsValid = new HostnameVerifier() {
				    public boolean verify(String hostname, SSLSession session) {
						
						return false;
					}
				};
				// Install the all-trusting host verifier
				HttpsURLConnection.setDefaultHostnameVerifier(allHostsValid);
				/*
				 * end of the fix
				 */
	}
	
	
             static String working_key="A16208eead890aefe9b73e725cc4eeebe";
		     static String sender_id="HBELLS";
		     static String api_url="alerts.spearcommunication.in";
		     static String start="http://";
		     String time;
			 String unicode="A519dd7ef681140eb9c23642f4d21810c";
			 String dlr_url="alerts.spearcommunication.in";
			 String type;
		


	//  declaring class variable
   	 // function to set sender id
	     public static  void setsender_id(String sid)
			{      
	    	 					sender_id=sid;
								return;

		    }
	       // function to set working key  
	     public static  void setworking_key(String wk)
			{ 	
				// checking for valid working key
							 working_key=wk;
								return;
							}
							
		    
		    // function to set Api url
	      public static  void setapi_url(String ap)
			{   
				//checking for valid url format
				String check= ap;
				String str=check.substring(0,7);
//			    System.out.println(""+str );
				String t="http://";
				String s="https:/";
				String st="https://";
				if(str.equals(t))
					 { 
					 	start=t;
						api_url=check.substring(7);
					}
				else if(check.substring(0,8).equals(st))
				{ 
				start=st;
                api_url=check.substring(8);
				}
				else if(str.equals(s))
					{ 
					start=st;
	                api_url=check.substring(7);
					}
			 	else
				   { 
					 start=t;
	                 api_url=ap;
					}
	        }
	        //function to set parameter import java.net.URLEncoder;
	     public  void setparams(String ap,String wk,String sd)
			{ 
			    setworking_key(wk);
			    //System.out.println(wk);
			    setsender_id(sd);
			    setapi_url(ap);
			}
			/*function to send sms 
			  @ Simple message : last two field are set to null
			  @ Unicode message :set unicode parameter to one
			  @ Scheduled message : give time in 'ddmmyyyyhhmm' format
			*/
		  public String process_sms(String mob_no,String message,String dlr_url,String unicode,String time) throws IOException, KeyManagementException, NoSuchAlgorithmException
			{   	
			  addSslCertificate();
				message=URLEncoder.encode(message, "UTF-8");			
				
			 	if (unicode==null)
					 unicode="0";
					unicode="&unicode="+unicode;
				if (time==null)
					 time="";
					else time="&time="+time;
		        URL url = new URL(""+start+api_url+"/api/v3/index.php?method=sms&api_key="+dlr_url+"&sender="+sender_id+"&to="+mob_no+"&message="+message+unicode+time+"" );
			    
//		        System.out.println("url look like " + url );
			    HttpURLConnection con = (HttpURLConnection) url.openConnection();
			    con.setRequestMethod("POST");
			    con.setDoOutput(true);
			    con.getOutputStream();
			    con.getInputStream();
			    BufferedReader rd;
			    String line;
	            String result = "";
	            rd = new BufferedReader(new InputStreamReader(con.getInputStream()));
	           while ((line = rd.readLine()) != null)
	            {
	               result += line;
	            }
		        rd.close(); 
		        System.out.println("Result is" + result);
				return result;
				
				
			}
			//function for checking message delivery status
	     public String messagedelivery_status(String mid) throws Exception
			{
				URL url = new URL("http://"+api_url+"/status.php?workingkey="+working_key+"&messageid="+mid+"&type=json");
				System.out.println("url look like " + url );		 
		        HttpURLConnection con = (HttpURLConnection) url.openConnection();
				con.setRequestMethod("POST");
				con.setDoOutput(true);
			    con.getOutputStream();
				con.getInputStream();
				BufferedReader rd;
				String line;
		        String result = "";
		        rd = new BufferedReader(new InputStreamReader(con.getInputStream()));
		        while ((line = rd.readLine()) != null)
		          {
		            result += line;
		          }
		        rd.close(); 
		        System.out.println("Result is" + result);
		        return result;
	        }
	        
	  		//function for checking group delivery status
	     public String groupdelivery_status(String gid) throws Exception
			{
				URL url = new URL("http://"+api_url+"/groupstatus.php?workingkey="+working_key+"&messagegid="+gid+"&type=xml");
				//System.out.println("url look like " + url );		
		        HttpURLConnection con = (HttpURLConnection) url.openConnection();
				con.setRequestMethod("POST");
				con.setDoOutput(true);
				con.getOutputStream();
				con.getInputStream();
				BufferedReader rd;
				String line;
		        String result = "";
		        rd = new BufferedReader(new InputStreamReader(con.getInputStream()));
	            while ((line = rd.readLine()) != null)
	             {
		            result += line;
//					System.out.println("Result is" + result);
	             }
		        rd.close(); 
		        System.out.println("Result is" + result);
		        return result;  
	        }
	     
	     public  void unicode_sms(String mob_no,String message,String dlr_url,String unicode) throws IOException, KeyManagementException, NoSuchAlgorithmException
			{
	    	 process_sms(mob_no, message, dlr_url, unicode, time=null);  				
									
			}

	     
	     public  void send_sms(String mob_no,String message,String dlr_url) throws IOException, KeyManagementException, NoSuchAlgorithmException
			{
	    	 process_sms(mob_no, message, dlr_url, unicode=null, time=null);  				
									
			}
	     
	     public  void schedule_sms(String mob_no,String message,String dlr_url,String unicode,String time) throws IOException, KeyManagementException, NoSuchAlgorithmException
			{
	    	 process_sms(mob_no, message, dlr_url, unicode, time);  				
									
			}
	     
	     public  void schedule_sms(String mob_no,String message,String dlr_url,String time) throws IOException, KeyManagementException, NoSuchAlgorithmException
			{
	    	 process_sms(mob_no, message, dlr_url, unicode=null, time);  				
									
			}
	     
	     
	     
	     
	   
	   public static void main(String ar[]) throws KeyManagementException, NoSuchAlgorithmException, IOException
	     {
	    	 
	    	 SpearSMSUtility sms=new SpearSMSUtility();
	    	// sms.send_sms("7026757618", "hi", "alerts.spearcommunication.in");
	    	  
	    	 sms.process_sms("7026757618", "Dear, we received order for bheem SIngh customer name-XXXXXXXXXXX mobile no XXXXXXXXXXX address-XXXXXXXXXXXXXXXXXXXXXXXX order id-XXXXXXXXXX.Thanks Hungry bells-Discover your taste", "", "", "");  				
	 		
		  
	     }
	  
	     
	     
	     
	     
	     
	     
	     
}
