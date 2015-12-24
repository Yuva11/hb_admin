
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
</head>
<body background="images/iskcon-blr-large-map.png">

<%
double lat=Double.parseDouble(request.getParameter("lat"));
double lng=Double.parseDouble(request.getParameter("lng"));
%>
  
    <input type="text" id="txtLatitude" value="<%=lat %>" style=" padding: 5px;" />
  
    <input type="text" id="txtLongitude" value="<%=lng %>" style=" padding: 5px;"/>
    <input type="button" value="Get Address" onclick="GetAddress()" style=" background-color: -moz-oddtreerow;
    color: darkblue;padding: 4px" />
    <script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?sensor=false"></script>
    <script type="text/javascript">
        function GetAddress() {
            var lat = parseFloat(document.getElementById("txtLatitude").value);
            var lng = parseFloat(document.getElementById("txtLongitude").value);
            var latlng = new google.maps.LatLng(lat, lng);
            var geocoder = geocoder = new google.maps.Geocoder();
            geocoder.geocode({ 'latLng': latlng }, function (results, status) {
                if (status == google.maps.GeocoderStatus.OK)
				{
                    if (results[1]) {
                        alert("Location: " + results[1].formatted_address);
                    }
                }
            });
        }
    </script>
</body>
</html>
