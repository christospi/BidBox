<%@ page import="Javabeans.Auction" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="Javabeans.Photo" %>
<%@ page import="Javabeans.Category" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="/basics/maxcdn.jsp" />
    <jsp:include page="/basics/auct_inf.jsp" />
    <title>Auctions</title>
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


        #clockdiv{
            font-family: sans-serif;
            color: #fff;
            display: inline-block;
            font-weight: 100;
            text-align: center;
            font-size: 16px;
        }

        #clockdiv > div{
            padding: 4px;
            border-radius: 3px;
            background: #17aaa6;
            display: inline-block;
        }

        #clockdiv div > span{
            padding: 10px;
            border-radius: 3px;
            background: rgba(57, 211, 207, 0.4);
            display: inline-block;
        }

        .smalltext{
            padding-top: 3px;
            font-size: 12px;
        }
    </style>
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

//            google.maps.event.addListener(marker1, 'dragend', function(event) {
//                // alert( 'Lat: ' + event.latLng.lat() + ' and Longitude is: ' + event.latLng.lng() );
//                document.getElementById('latitude').value = event.latLng.lat();
//                document.getElementById('longtitude').value=event.latLng.lng();
//                var latlng = {lat: event.latLng.lat(), lng: event.latLng.lng()};
//                geocoder.geocode({'location': latlng}, function(results, status) {
//                    if (status === 'OK') {
//                        if (results[1]) {
//
//                            for(var i = 0; i < results[0].address_components.length; i++) {
//                                if (results[0].address_components[i].types[0] == "country") {
//                                    country=results[0].address_components[i];
//                                }
//                            }
//                            for (var i=0; i<results[0].address_components.length; i++) {
//                                for (var b=0;b<results[0].address_components[i].types.length;b++) {
//
//
//                                    if (results[0].address_components[i].types[b] == "administrative_area_level_5") {
//                                        //this is the object you are looking for
//                                        city= results[0].address_components[i];
//                                        break;
//                                    }
//                                }
//                            }
//                            //city data
//                            //alert(city.short_name + " " + city.long_name)
//
//
//                        }
//                        //window.alert( results[1].formatted_address );
//                        document.getElementById('city').value =city.long_name ;
//                        document.getElementById('country').value =country.long_name ;
//                    }
//                });
//
//            });



        }


    </script>
    <script async defer
            src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCiStlX5yVBGYb6sDGA7VHax7rb8BcgblM&language=en&callback=initMap">
    </script>
</head>
<body>

<div class="container">

    <div class="row">

            <center>
            <h3>Auction Info</h3>
            <% ArrayList<Auction> aList = (ArrayList<Auction>) request.getSession().getAttribute("aList");
                ArrayList<Photo> pList = (ArrayList<Photo>) request.getSession().getAttribute("pList");
                ArrayList<Category> cList = (ArrayList<Category>) request.getSession().getAttribute("cList");%>

            <% String pointer = (String) request.getSession().getAttribute("pointer");
                int point = Integer.parseInt(pointer);
               %>

            <div class="table-responsive">
                <table  class="table table-striped table-bordered table-condensed table-hover"  cellpadding="2" border="2">
                <thead class="thead-default">
                    </tr>
                        <th>Owner Name:</th>
                        <th>Item name:</th>
                        <th>Country:</th>
                        <th>City:</th>
                        <th>Current bid:</th>
                        <th>Category:</th>
                        <th>End of auction : </th>
                        <th>Description: </th>
                     </tr>
                </thead>



                    <% Auction x = new Auction();
                        x = aList.get(point); %>
                    <tbody>
                    <tr>

                        <td><%=x.seller%></td>
                        <td><%=x.name%></td>
                        <td><%=x.country%></td>
                        <td><%=x.city%></td>
                        <td><%=x.curr%></td>
                        <%
                            Category a = new Category();
                            a = cList.get(0); %>
                        <td><%=a.name%></td>
                        <td><%=x.end%></td>
                        <td><%=x.description%></td>

                    </tr>

                <%for (int i=1; i<cList.size(); i++)  {
                    a = new Category();
                        a = cList.get(i); %>
                    <tr>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>

                        <td><%=a.name%></td>

                        <td></td>
                        <td></td>
                    </tr>
                <%}%>


                    </tbody>
                </table>
            </div>
                <label>
                    <div id="map" ></div></label>
            <script >

                var end = new Date("<%=x.end%>");

                var _second = 1000;
                var _minute = _second * 60;
                var _hour = _minute * 60;
                var _day = _hour * 24;
                var timer;

                function showRemaining() {
                    var now = new Date();
                    var distance = end - now;
                    if (distance < 0) {

                        clearInterval(timer);
                        document.getElementById('clockdiv').innerHTML = '<p style="color:red;">EXPIRED!</p>';

                        return;

                    }
                    else {
                        var days = Math.floor(distance / _day);
                        var hours = Math.floor((distance % _day) / _hour);
                        var minutes = Math.floor((distance % _hour) / _minute);
                        var seconds = Math.floor((distance % _minute) / _second);

                        document.getElementById('clockdiv').innerHTML = ' <div> <span id="days">' + days + '</span> <div class="smalltext">Days</div> </div> ';
                        document.getElementById('clockdiv').innerHTML += ' <div> <span id="hours">' + hours + '</span> <div class="smalltext">hrs</div> </div> ';
                        document.getElementById('clockdiv').innerHTML += ' <div> <span id="minutes">' + minutes + '</span> <div class="smalltext">mins</div> </div> ';
                        document.getElementById('clockdiv').innerHTML += ' <div> <span id="seconds">' + seconds + '</span> <div class="smalltext">secs</div> </div> ';
                    }

                    timer = setInterval(showRemaining, 1000);
                }
            </script>

            <div id="clockdiv">
            </div>

            <% if(x.st == null){ %>
            <div>
                <h4> Your auction is not started yet ! </h4>
                <form method="post" action="./../BBservlet?action=start_auction&id=<%=x.id%>&username=<%=x.seller%>">
                    <button type="submit" class="btn btn-success"  id="startit"> Start it ! </button>
                </form>
            </div>
            <%}%>

            <% if(x.num_bid == 0){ %>
                <div>
                    <h4>No one has bidden yes ! That's awful...</h4>
                    <form method="post" action="./../BBservlet?action=edit_item&id=<%=x.id%>&username=<%=x.seller%>">
                        <button type="submit" class="btn btn-warning"  id="edit"> Edit it </button>
                    </form>

                    <form method="post" action="./../BBservlet?action=delete_item&id=<%=x.id%>&username=<%=x.seller%>">
                        <button type="submit" class="btn btn-danger"  id="Delete"> Delete it </button>
                    </form>
                </div>
            <%}%>



            <br>

            <h3><b><a href="./BBservlet?action=viewphoto&id=<%=x.id%>&seller=<%=x.seller%>"><span class="glyphicon glyphicon-eye-open"></span> See photos for this item <span class="glyphicon glyphicon-eye-open"></span></a></b></h3>
            <%if ( (x.sold==1 || x.sold==3) && x.buyerID!=0 ){%>

                <form method="post" action="./../BBservlet?action=rate&buyer_id=<%=x.buyerID%>&auctionID=<%=x.id%>&pointer=<%=point%>&sold=<%=x.sold%>">
                    <button type="submit" class="btn btn-info" name="up" id="up">Rate up buyer!</button>
                </form>
                <form method="post" action="./../BBservlet?action=rate&buyer_id=<%=x.buyerID%>&auctionID=<%=x.id%>&pointer=<%=point%>&sold=<%=x.sold%>">
                    <button type="submit" class="btn btn-danger"  name="down" id="down">Rate down buyer!</button>
                </form>

                <%}%>

                <jsp:include page="/seller/carousel.jsp" />
            <div class="panel panel-warning">
                <div class="panel-heading"><h3>Upload a photo </h3></div>
                <div class="panel-body">
                    <form method="post" action="./../BBservlet?action=upload&seller=<%=x.seller%>&id=<%=x.id%>" enctype="multipart/form-data">
                        <table border="0" class="forms">
                            <tr>

                                <td><input type="file" class="btn btn-default btn-file" name="photo_file" accept="image/gif, image/jpeg, image/png" size="50"/></td>

                            </tr>

                            <tr>
                                <td colspan="2">
                                    <center>
                                    <button type="submit" class="btn btn-info"  id="send2"> Upload </button></center>
                                </td>
                            </tr>
                        </table>
                    </form>
                </div>
            </div>
            </center>

    </div>
</div>
<jsp:include page="/basics/footer.jsp" />
</body>
</html>
