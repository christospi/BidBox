<%@ page import="Javabeans.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>

    <% User user2 = (User) request.getSession().getAttribute("user");%>
    <jsp:include page="/basics/maxcdn.jsp" />
    <jsp:include page="/basics/msg_alert.jsp" />
    <%int count= (Integer) request.getSession().getAttribute("count");%>
    <link rel="stylesheet" href="./../css/msg.css">
    <link rel="icon" type="image/png" href="./../img/fav.png">

    <title>BidBox | Bid&Buy</title>
    <nav class="navbar navbar-default navbar-static-top">
        <div class="container-fluid">

            <div id="triangle-topleft">
                <a href="./../BBservlet?action=login&Username=<%=user2.username%>&Password=<%=user2.pass%>"><img  class="penguin" src="./../img/logo5.png" height="130" width="285" > </a>
            </div>

            <script>
                //                $(document).ready(function () {
                //                    var url = window.location;
                //                    // Will only work if string in href matches with location
                //                    $('ul.nav a[href="' + url + '"]').parent().addClass('active');
                //
                //                    // Will also work for relative and absolute hrefs
                //                    $('ul.nav a').filter(function () {
                //                        return this.href == url;
                //                    }).parent().addClass('active').parent().parent().addClass('active');
                //                });
            </script>


            <ul class="nav  nav-pills navbar-right">
                <li  class="active"><a href="./../BBservlet?action=login&Username=<%=user2.username%>&Password=<%=user2.pass%>">Home</a></li>
                <li><a href="./../BBservlet?action=searchpage">Search Auctions</a></li>
                <li><a href="./../BBservlet?action=addpage">Add Auction</a></li>
                <li><a href="./../BBservlet?action=auctionlist&username=<%=user2.username%>&page_num=1">My Auctions</a>
                <li><a href="./../BBservlet?action=msglist&username=<%=user2.username%>">Messages<%if(count!=0){%><span class="badge"><%=count%></span><%}%></a></li>
                <li><a href="./../BBservlet?action=myprofile&username=<%=user2.username%>">My Profile</a>
                <li><a href="./../BBservlet?action=bought_items&page_num=1" >Purchased Items</a></li>
                <li><a href="./../BBservlet?action=pending_bids&page_num=1" >Pending Bids</a></li>
                <li><a href="#">About us</a></li>
                <li><a href="./../BBservlet?action=logout">Log out</a></li>
            </ul>
            <hr>

        </div>

    </nav>
</head>
<body>

</body>
</html>
