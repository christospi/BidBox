<%@ page import="Javabeans.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <% User user2 = (User) request.getSession().getAttribute("user");%>
    <jsp:include page="/basics/maxcdn.jsp" />
    <link rel="icon" type="image/png" href="./../img/fav.png">
    <link rel="stylesheet" href="./../css/add_auct.css">



    <nav class="navbar navbar-default navbar-static-top">
        <div class="container-fluid">

            <div id="triangle-topleft">
                <img class="penguin" src="../img/logo5.png" height="130" width="285" >
            </div>




            <ul class="nav  nav-pills navbar-right">
                <li ><a href="./../BBservlet?action=login&Username=<%=user2.username%>&Password=<%=user2.pass%>">Home</a></li>
                <li><a href="./../welcome/search.jsp">Search Auctions</a></li>
                <li class="active"><a href="./../seller/add_auction.jsp">Add Auction</a></li>
                <li><a href="./../BBservlet?action=auctionlist&username=<%=user2.username%>&page_num=1">My Auctions</a>
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
