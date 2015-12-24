<script src="https://code.jquery.com/jquery-2.1.4.min.js"></script>
<style>
	#msg{
		display:none;
		background: yellow none repeat scroll 0 0;
	    border-radius: 5px;
	    color: #8b0000;
	    padding: 0 10px;
    	position: absolute;
	    font-weight: bold;
	}
</style>

<span id="msg">
<%
	if(session.getAttribute("msg")!=null)
		out.println(session.getAttribute("msg"));
	session.setAttribute("msg", ""); 
%>
</span>


<script>	
	$(document).ready(function(){
		if($("#msg").html().trim()!='')
			$("#msg").show();
		
		setTimeout(clearMsg, 10000);	 
	});
	
	function clearMsg(){
		$("#msg").hide("slow");
	}
</script>