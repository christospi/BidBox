<%@page import="Javabeans.User"%>

<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="Javabeans.Auction" %>
<%@ page import="Javabeans.Category" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="./../basics/user_header.jsp"/>
    <title>Edit Auction</title>
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
    <script>
        function removeT() {
            var s = $("#end").val();
            var end = new Date(s.replace(/-/g, '/').replace('T', ' '));
            document.getElementById("end").value = end;
            window.alert(end);
        }
    </script>

    <%
        User user2 = (User) request.getSession().getAttribute("user");
        Auction auction = (Auction)request.getAttribute("auction");
        ArrayList<Category> cList = (ArrayList<Category>) request.getSession().getAttribute("cList");
        %>
    <center></center><h2>Edit your Auction:</h2></center>
<div class="container">
    <div class="login-container2">
        <div id="output"></div>
        <div class="form-box2">
            <form  action="./../BBservlet?action=do_edit_auction&itemid=<%=auction.id%>" method="post" >
                <div id="new_auctionform">
                    <label>
                        Seller : <input type="text" readonly name="seller" value="<%=user2.username%> ">
                    </label>
                    <label>
                        Item name:  <input type="text" name="name" value="<%=auction.name%>" >
                    </label>
                    <label>
                        Category :
                        <select multiple name="category" required>
                            <%for (int i=0; i<cList.size(); i++)  {
                                Category a = new Category();
                                a = cList.get(i); %>
                            <option value="<%=a.catID%>"><%=a.name%></option>
                            <%}%>
                        </select>
                    </label>
                    <div id="map" ></div></label>
                    <label>Country: <input type="text" id = "country" name="country" value="<%=auction.country%>"></label>
                    <label>City: <input type="text" id="city" name="city" value="<%=auction.city%>"></label>
                    <label>Latitude: <input type="text" id="latitude" name="latitude" value="<%=auction.lat%>"></label>
                    <label>Longtitude: <input type="text" id="longtitude" name="longtitude" value="<%=auction.longt%>"></label>
                    <label>Starting Price: <input type="number" step="any" name="first_bid" value="<%=auction.first_bid%>"></label>
                    <label>Maximum Price: <input type="number" step="any" name="buy_price" value="<%=auction.buy_pr%>"></label>
                    <label>Bids ending date: <input type="datetime-local" id="end"  name="end" placeholder=" Ending Date " ></label>

                    <label>Item description : <textarea name="description" rows="4" cols="120 "maxlength="120"><%=auction.description%></textarea></label>
                    <label><button class="btn btn-info btn-block login" type="submit" >Submit Changes</button></label>
                </div>
            </form>
        </div>
    </div>
</div>


<jsp:include page="/basics/footer.jsp" />
</body>
</html>
