<%@ page import="Javabeans.Auction" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="Javabeans.Photo" %>
<%@ page import="Javabeans.Category" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="./../basics/user_header.jsp"/>

    <style>
        #map {
            height:300px;
            width:700px;
        }
    </style>

    <center><h3>Purchased Auction Info</h3></center>
    <%
        ArrayList<Auction> aList = (ArrayList<Auction>) request.getSession().getAttribute("boughtList");
        ArrayList<Photo> pList = (ArrayList<Photo>) request.getSession().getAttribute("boughtpList");
        ArrayList<Category> cList = (ArrayList<Category>) request.getSession().getAttribute("boughtcList");
        String pointer = (String) request.getSession().getAttribute("pointer");
        int point = Integer.parseInt(pointer);
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

                        <% Auction x = new Auction();
                            x = aList.get(point); %>
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
                            <div id="map"></div>
                        </div>
                    </div>
                    <hr>

                    <%if ( (x.sold==1 || x.sold==2) && x.buyerID!=0 ){%>
                    <div class="row">
                        <div class="col-sm-8 col-sm-offset-2">
                            <div class="form-inline" align="center">
                                <center><h4>How about rating the seller?</h4></center>
                                <form class="form-group" method="post" action="./../BBservlet?action=rate2&seller_name=<%=x.seller%>&auctionID=<%=x.id%>&pointer=<%=point%>&sold=<%=x.sold%>">
                                    <button type="submit" class="btn btn-info" name="up" id="up">Rate up seller!</button>
                                </form>
                                <form class="form-group" method="post" action="./../BBservlet?action=rate2&seller_name=<%=x.seller%>&auctionID=<%=x.id%>&pointer=<%=point%>&sold=<%=x.sold%>">
                                    <button type="submit" class="btn btn-danger"  name="down" id="down">Rate down seller!</button>
                                </form>
                            </div>
                        </div>
                    </div>
                    <%}%>

                </div>
            </div>
        </div>
    </div>
</div>
<jsp:include page="/basics/footer.jsp" />
</body>
</html>
