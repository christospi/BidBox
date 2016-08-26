<%--
  Created by IntelliJ IDEA.
  User: kwnst
  Date: 26-Aug-16
  Time: 1:43 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Search Auctions</title>
    <h1> Select location from the map</h1>
    <style>
        html, body {
            height: 100%;
            margin: 0;
            padding: 0;
        }
        #map {
            height:547px;
            width:1333px;

        }

    </style>
</head>
<body>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDfp9V-7Zc4O_YtJFxAtw8mmy8Dd_XVD-Y&libraries=geometry"></script>
<div id="map" ></div>
<script>


    var marker1;


    function initMap() {
        var map = new google.maps.Map(document.getElementById('map'), {
            zoom: 4,
            center: {lat: 34, lng: -40.605}
        });

        map.controls[google.maps.ControlPosition.TOP_CENTER].push(
                document.getElementById('info'));

        marker1 = new google.maps.Marker({
            map: map,
            draggable: true,
            position: {lat: 40.714, lng: -74.006}
        });

        google.maps.event.addListener(marker1, 'dragstart', function(event) {
            // alert( 'Lat: ' + event.latLng.lat() + ' and Longitude is: ' + event.latLng.lng() );
            document.getElementById('location1').value = event.latLng.lat();
            document.getElementById('location2').value=event.latLng.lng();
        });



    }


</script>
<script async defer
        src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDfp9V-7Zc4O_YtJFxAtw8mmy8Dd_XVD-Y&callback=initMap">
</script>
Latitude :<input type="text" readonly id="location1" placeholder="Latitude">
Longtitude : <input type="text" readonly id="location2" placeholder="Longtitude">

</body>
</html>
