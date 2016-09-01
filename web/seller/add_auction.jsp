<%@page import="Javabeans.User"%>

<%@page import="Javabeans.Photo"%>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="/basics/maxcdn.jsp" />
    <jsp:include page="/basics/add_auct.jsp" />
    <title>Add Auction</title>
    <style>
        html, body {
            height: 100%;
            margin: 0;
            padding: 0;
        }
        #map {
            height:344px;
            width:803px;

        }

    </style>
</head>
<center>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDfp9V-7Zc4O_YtJFxAtw8mmy8Dd_XVD-Y&libraries=geometry"></script>

<script>


    var marker1;


    function initMap() {
        var map = new google.maps.Map(document.getElementById('map'), {
            zoom: 10,
            center: {lat: 37.97, lng: 23.73}
        });
        var geocoder = new google.maps.Geocoder;
        map.controls[google.maps.ControlPosition.TOP_CENTER].push(
                document.getElementById('info'));

        marker1 = new google.maps.Marker({
            map: map,
            draggable: true,
            position: {lat: 37.97, lng: 23.73}
        });

        google.maps.event.addListener(marker1, 'dragend', function(event) {
            // alert( 'Lat: ' + event.latLng.lat() + ' and Longitude is: ' + event.latLng.lng() );
            document.getElementById('latitude').value = event.latLng.lat();
            document.getElementById('longtitude').value=event.latLng.lng();
            var latlng = {lat: event.latLng.lat(), lng: event.latLng.lng()};
            geocoder.geocode({'location': latlng}, function(results, status) {
                if (status === 'OK') {
                    if (results[1]) {

                        for(var i = 0; i < results[0].address_components.length; i++) {
                            if (results[0].address_components[i].types[0] == "country") {
                                country=results[0].address_components[i];
                            }
                        }
                        for (var i=0; i<results[0].address_components.length; i++) {
                            for (var b=0;b<results[0].address_components[i].types.length;b++) {


                                if (results[0].address_components[i].types[b] == "administrative_area_level_5") {
                                    //this is the object you are looking for
                                    city= results[0].address_components[i];
                                    break;
                                }
                            }
                        }
                        //city data
                        //alert(city.short_name + " " + city.long_name)


                    }
                    //window.alert( results[1].formatted_address );
                    document.getElementById('city').value =city.long_name ;
                    document.getElementById('country').value =country.long_name ;
                }
            });

        });



    }


</script>
<script async defer
        src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCiStlX5yVBGYb6sDGA7VHax7rb8BcgblM&language=en&callback=initMap">
</script>
<% User user2 = (User) request.getSession().getAttribute("user");
    DateFormat dateFormat = new SimpleDateFormat("dd/MM/YYYY HH:mm:ss");
    Date date = new Date();
    String st = dateFormat.format(date);%>
<center></center><h2>Add a new auction:</h2></center>
<div class="container">
    <div class="login-container2">
    <div id="output"></div>
     <div class="form-box2">
        <form  action="./../BBservlet?action=addauction" method="post" >
            <div id="new_auctionform">
                <label>
                Seller : <input type="text" readonly name="seller" value="<%=user2.username%>   ">
                </label>
                <label>
                Item name:  <input type="text" name="name" placeholder="Item Name">
                </label>
                <label>
                Category :
                <select name="category">
                    <option  value ="art"> Art </option>
                    <option  value ="books"> Books </option>
                    <option  value ="computers"> Computers & Tablets </option>
                    <option  value="electronics">Electronics</option>
                    <option  value ="fashion">Fashion</option>
                    <option  value ="gadgets"> Gadgets </option>
                    <option  value ="home"> Home & Garden </option>
                    <option  value ="jewelry"> Jewelry & Watches </option>
                    <option  value ="sports"> Sports </option>
                    <option  value ="videogame"> Video Games </option>
                    <option  value ="else"> Everything Else </option>

                </select>
                </label>
                <label>
                <div id="map" ></div></label>
                <label> Country: <input type="text" readonly id = "country" name="country" placeholder="ex.Greece"></label>
                <label>City: <input type="text" readonly id="city" name="city" placeholder="ex.Athens"></label>
                <label>Latitude: <input type="text" readonly id="latitude" name="latitude" placeholder="Latitude"></label>
                <label>Longtitude : <input type="text" readonly id="longtitude" name="longtitude" placeholder="Longtitude"></label>
                <label>Starting Price: <input type="number" step="0.01" name="first_bid" placeholder="Starting Price"></label>
                <label> Maximum Price:  <input type="number" step="0.01" name="buy_price" placeholder="Max Price"></label>
                <label>Bids starting date : <input type="text" readonly name="st" value="<%=st%>"></label>
                <label> Bids ending date : <input type="date" name="end" placeholder=" Ending Date "></label>
                <label>Item description : <textarea name="description" rows="4" cols="120 "maxlength="120">Maximum characters 120</textarea></label>
                <label><button class="btn btn-info btn-block login" type="submit" >Add auction </button></label>
            </div>
        </form>
     </div>
     </div>
</div>
<%--<h3>Upload a photo :</h3>--%>
<%--<form method="post" action="./../BBservlet?action=upload&owner=<%=user2.username%>" enctype="multipart/form-data">--%>
    <%--<table border="0" class="forms">--%>
        <%--<tr>--%>
            <%--<td>Upload Photo: </td>--%>
            <%--<td><input type="file" name="photo" accept="image/gif, image/jpeg, image/png" size="50"/></td>--%>
        <%--</tr>--%>
        <%--<tr>--%>
            <%--<td colspan="2">--%>
                <%--<input type="submit" value="Upload" id="send2">--%>
            <%--</td>--%>
        <%--</tr>--%>
    <%--</table>--%>
<%--</form>--%>
<jsp:include page="/basics/footer.jsp" />
</body>
</html>
