<%@ page import="Javabeans.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>


    <% User user2 = (User) request.getSession().getAttribute("user");%>
    <jsp:include page="/basics/maxcdn.jsp" />
    <jsp:include page="/basics/msg_alert.jsp" />
    <%int count= (Integer) request.getSession().getAttribute("count");%>
    <link rel="stylesheet" href="./../css/index.css">
    <link rel="icon" type="image/png" href="./../img/fav.png">

    <title>BidBox | Bid&Buy</title>
    <nav class="navbar navbar-default navbar-static-top">
        <div class="container-fluid">

            <div id="triangle-topleft">
                <a href="./../BBservlet?action=login&Username=<%=user2.username%>&Password=<%=user2.pass%>"><img  class="penguin" src="./../img/logo5.png" height="130" width="285" > </a>
            </div>




            <ul class="nav  nav-pills navbar-right">
                <li  class="active"><a href="./../BBservlet?action=userlist">Users</a></li>
                <li><a href="./../BBservlet?action=auctions_marsh&page_num=1">Export Auctions</a></li>
                <li><a href="./../BBservlet?action=auctions_unmarshall">Import Auctions</a></li>
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
