package newservice;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.security.SignatureException;
import java.util.Base64;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.SortedMap;
import java.util.TreeMap;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;

public class OpinioUtils {

	public static String calculateRFC2104HMAC(String data, String key) throws java.security.SignatureException {
		String result;
		try {
			// get an hmac_sha1 key from the raw key bytes
			SecretKeySpec signingKey = new SecretKeySpec(key.getBytes(), "HmacSHA1");

			// get an hmac_sha1 Mac instance and initialize with the signing key
			Mac mac = Mac.getInstance("HmacSHA1");
			mac.init(signingKey);

			// compute the hmac on input data bytes
			byte[] rawHmac = mac.doFinal(data.getBytes());

			// base64-encode the hmac
			byte[] encodedBytes = Base64.getEncoder().encode(rawHmac);
			System.out.println("ecncoded value is " + new String(encodedBytes));
			result = new String(encodedBytes);

		} catch (Exception e) {
			throw new SignatureException("Failed to generate HMAC For Opinio Service: " + e.getMessage());
		}
		return result;
	}

	public static String percentEncodeRfc3986(String s) {
		String out;
		try {
			out = URLEncoder.encode(s, "UTF-8").replace("+", "%20").replace("*", "%2A").replace("%7E", "~");
		} catch (UnsupportedEncodingException e) {
			out = s;
		}
		return out;
	}

	public static String canonicalize(SortedMap<String, String> sortedParamMap) {
		if (sortedParamMap.isEmpty()) {
			return "";
		}

		StringBuffer buffer = new StringBuffer();
		Iterator<Map.Entry<String, String>> iter = sortedParamMap.entrySet().iterator();

		while (iter.hasNext()) {

			Map.Entry<String, String> kvpair = iter.next();
			buffer.append("&");
			buffer.append(percentEncodeRfc3986(kvpair.getKey()));
			buffer.append("=");
			buffer.append(percentEncodeRfc3986(kvpair.getValue()));

		}
		String canonical = buffer.toString();
		return canonical;
	}

	// Deprecated Method
	public static String sha1(String messsage, String keyString) throws Exception {
		Mac sha256_HMAC = Mac.getInstance("HmacSHA256");
		SecretKeySpec secret_key = new SecretKeySpec(keyString.getBytes(), "HmacSHA1");
		sha256_HMAC.init(secret_key);
		String hash = Base64.getEncoder().encodeToString(sha256_HMAC.doFinal(messsage.getBytes()));
		System.out.println(hash);
		return hash;
	}

	public static Map<String, String> getPostAuthentication(OpinioPostOrder opinioPostOrder) throws Exception {

		SortedMap<String, String> sortedParamMap = new TreeMap<String, String>();
		Map<String, String> map = new HashMap<String, String>();

		String canonicalString = null;
		String signature = null;
		String authorization = null;

		sortedParamMap.put("merchant_id", opinioPostOrder.getMerchant_id());
		sortedParamMap.put("amount", "" + opinioPostOrder.getAmount());
		sortedParamMap.put("amount_to_pay", "" + opinioPostOrder.getAmount_to_pay());
		sortedParamMap.put("phone", opinioPostOrder.getPhone());
		sortedParamMap.put("address", opinioPostOrder.getAddress());
		sortedParamMap.put("locality", opinioPostOrder.getLocality());
		sortedParamMap.put("order_code", opinioPostOrder.getOrder_code());

		// setting optional parameters

		canonicalString = canonicalize(sortedParamMap);
		String StringToSign = "POST" + "\n" + "deliver.opinioapp.com" + "\n" + "/api/v1/orders" + "\n"
				+ "PJksl89uh7hsaMskd" + "\n" + canonicalString + "\n" + "&SignatureVersion=1" + "\n"
				+ "&SignatureMethod=HmacSHA1";

		signature = calculateRFC2104HMAC(StringToSign, "ILasdi9809ck09icHN");

		authorization = "Opinio" + " " + "PJksl89uh7hsaMskd" + ":" + signature;
		map.put("authorization", authorization);
		map.put("canonicalString", canonicalString);
		return map;
	}
}
