<%@ page import="Javabeans.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <jsp:include page="/basics/maxcdn.jsp" />

    <link rel="icon" type="image/png" href="./../img/fav.png">

    <link rel="stylesheet" href="./../css/header.css">
    <link rel="stylesheet" href="./../css/index.css">

</head>
<body>

<div class="jumbotron">
    <div class="container-fluid text-center" id="triangle-topleft">
        <a href="./../index.jsp"><img  class="penguin pull-left" src="./../img/logo5.png" height="130" width="285" > </a>
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
            <a class="navbar-brand" href="./../index.jsp">BidBox</a>
        </div>
        <li class="collapse navbar-collapse" id="myNavbar">
            <ul class="nav navbar-nav">

                <li><a href="./../BBservlet?action=guest_searchpage"><i class="glyphicon glyphicon-search"></i> Search Auctions</a></li>
                <li><a href="#"><i class="glyphicon glyphicon-info-sign"></i> About us</a></li>
            </ul>

    </div>
    </div>
</nav>

</body>
</html>
