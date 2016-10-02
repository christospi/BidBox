<%@ page import="Javabeans.Auction" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="Javabeans.Photo" %>
<%@ page import="Javabeans.Category" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="./../basics/user_header.jsp"/>
    <title>Purchased Auctions</title>
    <style>



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
</head>
<body>
<div class="container">
    <div class="row">
        <center>
            <h3>Auction Info</h3>
            <% ArrayList<Auction> aList = (ArrayList<Auction>) request.getSession().getAttribute("boughtList");
                ArrayList<Photo> pList = (ArrayList<Photo>) request.getSession().getAttribute("boughtpList");
                ArrayList<Category> cList = (ArrayList<Category>) request.getSession().getAttribute("boughtcList");%>

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

            <div>
                <form method="post" action="./../BBservlet?action=edit_item&id=<%=x.id%>&username=<%=x.seller%>">
                    <button type="submit" class="btn btn-warning"  id="edit"> Edit it </button>
                </form>

                <form method="post" action="./../BBservlet?action=delete_item&id=<%=x.id%>&username=<%=x.seller%>">
                    <button type="submit" class="btn btn-danger"  id="Delete"> Delete it </button>
                </form>
            </div>

            <br>

            <h3><b><a href="./BBservlet?action=viewphoto&id=<%=x.id%>&seller=<%=x.seller%>"><span class="glyphicon glyphicon-eye-open"></span> See photos for this item <span class="glyphicon glyphicon-eye-open"></span></a></b></h3>
            <%if (x.sold==1 || x.sold==2){%>

            <form method="post" action="./../BBservlet?action=rate2&seller_name=<%=x.seller%>&auctionID=<%=x.id%>&pointer=<%=point%>&sold=<%=x.sold%>">
                <button type="submit" class="btn btn-info" name="up" id="up">Rate up buyer!</button>
            </form>
            <form method="post" action="./../BBservlet?action=rate2&buyer_id=<%=x.buyerID%>&auctionID=<%=x.id%>&pointer=<%=point%>&sold=<%=x.sold%>">
                <button type="submit" class="btn btn-danger"  name="down" id="down">Rate down buyer!</button>
            </form>

            <%}%>

        </center>

    </div>
</div>
<jsp:include page="/basics/footer.jsp" />
</body>
</html>
