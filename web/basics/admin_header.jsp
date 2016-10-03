<%@ page import="Javabeans.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <jsp:include page="/basics/maxcdn.jsp" />
    <% User user2 = (User) request.getSession().getAttribute("user");%>
    <link rel="icon" type="image/png" href="./../img/fav.png">

    <link rel="stylesheet" href="./../css/header.css">

</head>
<body>

<div class="jumbotron">
    <div class="container-fluid text-center" id="triangle-topleft">
        <a href="./../BBservlet?action=home&Username=<%=user2.username%>"><img  class="penguin pull-left" src="./../img/logo5.png" height="130" width="285" > </a>
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
                <li class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#"><i class="glyphicon glyphicon-list"></i> Users List
                        <span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="/BBservlet?action=userlist&page_num=1">All Users</a></li>
                        <li class="divider"></li>
                        <li><a href="/BBservlet?action=verify_pend&page_num=1">Unverified Users</a></li>
                    </ul>
                </li>
                <li><a href="./../BBservlet?action=auctions_marsh&page_num=1"><i class="glyphicon glyphicon-floppy-save"></i> Export Auctions</a></li>
                <li><a href="./../BBservlet?action=auctions_unmarshall"><i class="glyphicon glyphicon-floppy-open"></i> Import Auctions</a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right">

                <li><a href="./../BBservlet?action=logout"><span class="glyphicon glyphicon-log-out"></span> Log Out</a></li>
            </ul>
    </div>
    </div>
</nav>

</body>
</html>
