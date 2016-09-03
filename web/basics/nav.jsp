<%@ page import="Javabeans.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <% User user2 = (User) request.getSession().getAttribute("user");%>
    <jsp:include page="/basics/maxcdn.jsp" />
    <link rel="stylesheet" href="./../css/index.css">
    <link rel="icon" type="image/png" href="./../img/fav.png">

    <title>BidBox | Bid&Buy</title>
    <nav class="navbar navbar-default navbar-static-top">
        <div class="container-fluid">

            <div id="triangle-topleft">
                <a href="./../BBservlet?action=login&Username=<%=user2.username%>&Password=<%=user2.pass%>"><img  class="penguin" src="img/peng.png" height="130" width="285" > </a>
            </div>




            <ul class="nav  nav-pills navbar-right">
                <li class="active"><a href="./../BBservlet?action=login&Username=<%=user2.username%>&Password=<%=user2.pass%>">Home</a></li>
                <li><a href="./../welcome/search.jsp">Search Auctions</a></li>
                <li><a href="./../seller/add_auction.jsp">Add Auction</a></li>
                <li><a href="./../BBservlet?action=auctionlist&username=<%=user2.username%>">My Auctions</a>
                <li><a href="./../BBservlet?action=msglist&username=<%=user2.username%>">Messages</a>
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
