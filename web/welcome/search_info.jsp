<%@ page import="Javabeans.Auction" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="Javabeans.Photo" %>
<%@ page import="Javabeans.User" %>
<%@ page import="java.util.Objects" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>

    <jsp:include page="/basics/user_header.jsp" />

    <title>Auction Info</title>


</head>
<body>
<div class="container">
    <div class="row">
        <center>
            <h3>Auction Info</h3>
            <%
                User user2 = (User) request.getSession().getAttribute("user");

                Auction x = (Auction) request.getAttribute("auction");
                ArrayList<Photo> pList = (ArrayList<Photo>) request.getSession().getAttribute("pList");%>

            <div class="table-responsive">
                <table  class="table table-striped table-bordered table-condensed table-hover"  cellpadding="2" border="2">
                    <thead class="thead-default">
                    </tr>
                    <th>Owner Name:</th>
                    <th>Item name:</th>
                    <th>Country:</th>
                    <th>City:</th>
                    <th>Current bid:</th>
                    <%--<th>Category:</th>--%>
                    <th>End of auction : </th>
                    <th>Description: </th>
                    </tr>
                    </thead>

                    <tbody>
                    <tr>
                        <%--TODO PROSOXH EDW AN EINAI GUEST DE THA PERNAEI H PARAMETROS USERNAME--%>

                        <td><a href="./BBservlet?action=show_profile&username=<%=user2.username%>&sellerun=<%=x.seller%>"><%=x.seller%></a></td>
                        <td><%=x.name%></td>
                        <td><%=x.country%></td>
                        <td><%=x.city%></td>
                        <td><%=x.curr%></td>
                        <%--<td><%=x.cat%></td>--%>
                        <td><%=x.end%></td>
                        <td><%=x.description%></td>

                    </tr>
                    </tbody>
                </table>
            </div>

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

            <div id="clockdiv">
            </div>

            <br>

            <h3><b><a href="./BBservlet?action=viewphoto&id=<%=x.id%>&seller=<%=x.seller%>"><span class="glyphicon glyphicon-eye-open"></span> See photos for this item</a></b></h3>
            <%if(x.expired!=1 && x.sold!=1 && !(x.seller.equalsIgnoreCase(user2.username))){ %>
            <form method="post" action="/BBservlet?action=place_bid&itemid=<%=x.id%>&bidderid=<%=user2.userID%>&seller=<%=x.seller%>">
                <input type="number" step="any" name="amount" min="<%=x.curr+1%>" required>
                <%--<input type="submit" value="Bid !"/>--%>
                <input type="button" data-toggle="modal" data-target="#myModal" value="Bid !"/>

            <%}%>
        </center>




    </div>

</div>
<center>
    <jsp:include page="/seller/carousel.jsp" />
</center>

<div id="myModal" class="modal fade" role="dialog">
    <div class="modal-dialog">
    <center>
        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">Bid Confirmation</h4>
            </div>
            <div class="modal-body">
                <p>Are you sure you want to make this bid?</p>



                    <button  class="btn btn-success login" type="submit">Yes</button>
                    <button type="button" class="btn btn-danger" data-dismiss="modal">No</button>
                </form>
            </div>

        </div>
    </center>
    </div>
</div>
<jsp:include page="/basics/footer.jsp" />
</body>
</html>
