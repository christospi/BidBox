<%@ page import="Javabeans.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <jsp:include page="/basics/maxcdn.jsp" />
    <% User user2 = (User) request.getSession().getAttribute("user");%>
    <jsp:include page="/basics/msg_alert.jsp" />
    <%int count= (Integer) request.getSession().getAttribute("count");%>
    <link rel="icon" type="image/png" href="./../img/fav.png">

    <link rel="stylesheet" href="./../css/header.css">


</head>
<body>

<div class="jumbotron">
    <div class="container-fluid text-center" id="triangle-topleft">
            <a href="./../BBservlet?action=login&Username=<%=user2.username%>&Password=<%=user2.pass%>"><img  class="penguin pull-left" src="./../img/logo5.png" height="130" width="285" > </a>
    </div>
</div>

<nav class="navbar navbar-inverse">
    <div class="container-fluid">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#">BidBox</a>
        </div>
        <li class="collapse navbar-collapse" id="myNavbar">
            <ul class="nav navbar-nav">
                <li><a href="./../BBservlet?action=login&Username=<%=user2.username%>&Password=<%=user2.pass%>">Home</a></li>
                <li><a href="./../BBservlet?action=searchpage"> Search Auctions</a></li>
                <li><a href="./../BBservlet?action=addpage"> Add Auction</a></li>
                <li class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown" > My Box
                        <span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="./../BBservlet?action=auctionlist&username=<%=user2.username%>&page_num=1"> My Auctions</a>
                        <li class="divider"></li>
                        <li><a href="./../BBservlet?action=bought_items&page_num=1"> Purchased Items</a></li>
                        <li><a href="./../BBservlet?action=pending_bids&page_num=1"> Pending Bids</a></li>
                    </ul>
                </li>
                <li><a href="#">About us</a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <li><a href="./../BBservlet?action=myprofile&username=<%=user2.username%>"><span class="glyphicon glyphicon-user"></span> My Account</a></li>
                <li><a href="./../BBservlet?action=msglist&username=<%=user2.username%>"><span class="glyphicon glyphicon-envelope"></span> Messages<%if(count!=0){%>&nbsp;<span class="badge"><%=count%></span><%}%></a></li>
                <li><a href="./../BBservlet?action=logout"><span class="glyphicon glyphicon-log-out"></span> Log Out</a></li>
            </ul>
        </div>
    </div>
</nav>

</body>
</html>
