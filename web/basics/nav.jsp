<%@ page import="Javabeans.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <% User user2 = (User) request.getSession().getAttribute("user");%>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <link rel="stylesheet" href="./../css/index.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <link href="https://fonts.googleapis.com/css?family=Dosis" rel="stylesheet">
    <title>BidBox | Bid&Buy</title>
    <nav class="navbar navbar-default navbar-static-top">
        <div class="container-fluid">

            <div id="triangle-topleft">
                <img  class="penguin" src="img/peng.png" height="130" width="285" >
            </div>




            <ul class="nav  nav-pills navbar-right">
                <li class="active"><a href="#">Home</a></li>
                <li><a href="#">My Auctions</a></li>
                <li><a href="./../welcome/search.jsp">Search Auctions</a></li>
                <li><a href="./../seller/add_auction.jsp">Add Auction</a></li>
                <li><a href="./../BBservlet?action=auctionlist&username=<%=user2.username%>">My Auctions</a>
                <li><a href="#">About us</a></li>
                <li><a href="#">Log out</a></li>
            </ul>
            <hr>

        </div>

    </nav>
</head>
<body>

</body>
</html>
