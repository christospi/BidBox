<%@ page import="Javabeans.Auction" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="Javabeans.Photo" %>
<%@ page import="Javabeans.Category" %>
<%@ page import="Javabeans.User" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="./../basics/guest_header.jsp"/>
    <title>Search Result Info</title>
    <style>
        html, body {
            height: 100%;
            margin: 0;
            padding: 0;
        }
        #map {
            height:300px;
            width:700px;
        }

    </style>

    <center><h3>Auction Info</h3></center>
    <%
        ArrayList<Photo> pList = (ArrayList<Photo>) request.getSession().getAttribute("pList");
        ArrayList<Category> cList = (ArrayList<Category>) request.getSession().getAttribute("cList");
        Auction x = (Auction) request.getAttribute("auction");
    %>


</head>
<body>

<div class="container">
    <div class="row">
        <div class="col-sm-12 ">
            <div class="panel panel-default">
                <div class="panel-heading"><center><h4> Item's Specification </h4></center></div>
                <div class="panel-body">

                    <div class="row">
                        <div class="col-sm-4">
                            <jsp:include page="/seller/carousel.jsp"/>
                        </div>

                        <div class="col-sm-8">

                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="table-responsive">
                                        <table  class="table table-striped table-bordered table-condensed table-hover"  cellpadding="2" border="2">
                                            <thead class="thead-default">
                                            </tr>
                                            <th>Owner Name:</th>
                                            <th>Item name:</th>
                                            <th>Country:</th>
                                            <th>City:</th>
                                            <th>Current bid:</th>
                                            <th>Buy Price:</th>
                                            <th>End of auction:</th>
                                            </tr>
                                            </thead>

                                            <tbody>
                                            <tr>
                                                <td><%=x.seller%></td>
                                                <td><%=x.name%></td>
                                                <td><%=x.country%></td>
                                                <td><%=x.city%></td>
                                                <td><%=x.curr%></td>
                                                <%if (x.buy_pr==0){

                                                %><td>N/A</td><%}else{%>
                                                <td><%=x.buy_pr%></td>
                                                <%}%>
                                                <td><%=x.end%></td>
                                            </tr>

                                            <input type="hidden" id="longi" value="<%=x.longt%>" >
                                            <input type="hidden" id="lati" value="<%=x.lat%>" >

                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="panel panel-default">
                                        <div class="panel-heading"><center><h4> Product Categories </h4></center></div>
                                        <div class="panel-body">
                                            <%  Category a = new Category();
                                                for (int i=0; i<cList.size(); i++)  {
                                                    a = new Category();
                                                    a = cList.get(i);
                                            %>
                                            [   <%=a.name%>   ]
                                            <%}%>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>

                    <div class="row">
                        <div class="col-sm-12">
                            <div class="panel panel-default">
                                <div class="panel-heading"><h4 align:center> Description </h4></div>
                                <div class="panel-body">
                                    <p> <%=x.description%> </p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <center>
                        <div class="row">
                            <div class="col-sm-12">
                                <script>

                                    var end = new Date("<%=x.end%>");

                                    var _second = 1000;
                                    var _minute = _second * 60;
                                    var _hour = _minute * 60;
                                    var _day = _hour * 24;
                                    var timer;
                                    var sold= parseInt("<%=x.sold%>");

                                    function showRemaining() {
                                        var now = new Date();
                                        var distance = end - now;
                                        if (distance < 0) {

                                            clearInterval(timer);
                                            document.getElementById('clockdiv').innerHTML = '<p style="color:red;">EXPIRED!</p>';

                                            return;
                                        }else if(sold==1){
                                            clearInterval(timer);
                                            document.getElementById('clockdiv').innerHTML = '<p style="color:red;">SOLD OUT!</p>';

                                            return;
                                        }

                                        var days = Math.floor(distance / _day);
                                        var hours = Math.floor((distance % _day) / _hour);
                                        var minutes = Math.floor((distance % _hour) / _minute);
                                        var seconds = Math.floor((distance % _minute) / _second);

                                        document.getElementById('clockdiv').innerHTML =  ' <div> <span id="days">' +days+ '</span> <div class="smalltext">Days</div> </div> ';
                                        document.getElementById('clockdiv').innerHTML +=' <div> <span id="hours">' + hours + '</span> <div class="smalltext">hrs</div> </div> ';
                                        document.getElementById('clockdiv').innerHTML +=  ' <div> <span id="minutes">'+ minutes +'</span> <div class="smalltext">mins</div> </div> ';
                                        document.getElementById('clockdiv').innerHTML +=  ' <div> <span id="seconds">'+ seconds +'</span> <div class="smalltext">secs</div> </div> ';
                                    }

                                    timer = setInterval(showRemaining, 1000);
                                </script>
                                <div id="clockdiv"></div>
                            </div>
                        </div>
                    </center>
                    <hr>

                    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDfp9V-7Zc4O_YtJFxAtw8mmy8Dd_XVD-Y&libraries=geometry"></script>
                    <script>

                        var marker1;

                        function initMap() {
                            var map = new google.maps.Map(document.getElementById('map'), {
                                zoom: 10,
                                center: {lat: <%=x.lat%>, lng: <%=x.longt%> }
                            });

                            var geocoder = new google.maps.Geocoder;
                            map.controls[google.maps.ControlPosition.TOP_CENTER].push(
                                    document.getElementById('info'));

                            marker1 = new google.maps.Marker({
                                map: map,
                                draggable: false,
                                position: {lat: <%=x.lat%>, lng: <%=x.longt%>}
                            });

                        }
                    </script>

                    <script async defer
                            src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCiStlX5yVBGYb6sDGA7VHax7rb8BcgblM&language=en&callback=initMap">
                    </script>

                    <div class="row">
                        <div class="col-sm-8 col-sm-offset-2">
                            <center><h4><label> Item's location </label></h4></center>
                            <div id="map" ></div>
                        </div>
                    </div>
                    <hr>


                    <div class="row">
                        <div class="col-sm-2 col-sm-offset-5">
                            <center><h4><label> I am interested ! </label></h4></center>
                            <% if(x.expired!=1 || x.sold==1){ %>
                            <%--<form method="post" action="/BBservlet?action=place_bid&itemid=<%=x.id%>&bidderid=<%=user2.userID%>&seller=<%=x.seller%>">--%>
                            <input type="number" class="form-control" step="any" name="amount" min="<%=x.curr%>" max="<%=x.buy_pr%>">
                            <br><center><input type="button" class="btn btn-success" data-toggle="modal" data-target="#myModal" value="Bid !"/></center>
                            <%--</form>--%>
                            <!-- Modal -->
                            <div id="myModal" class="modal fade" role="dialog">
                                <div class="modal-dialog">

                                    <!-- Modal content-->
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                                            <h4 class="modal-title">Hey you sneaker !</h4>
                                        </div>
                                        <div class="modal-body">
                                            <p>You have to sign in in order to place a bid !</p>

                                            <form method="post" action="BBservlet?action=login_guest&auctionid=<%=x.id%>&seller=<%=x.seller%>">
                                                <input name="Username" type="text" class="form-control" placeholder="username" required><br>
                                                <input type="password" name="Password" class="form-control" placeholder="password" required><br>
                                                <button class="btn btn-info btn-block login" type="submit">Login</button>
                                                <%--<input type="submit" value="Login" />--%>
                                                <p>or <a href="BBservlet?action=signup_page" >Register here</a></p>
                                            </form>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                        </div>
                                    </div>

                                </div>
                            </div>
                            <%}%>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<jsp:include page="/basics/footer.jsp" />
</body>
</html>
