<%@ page import="Javabeans.User" %>
<%@ page import="Javabeans.Auction" %>
<%@ page import="Javabeans.Photo" %>
<%@ page import="java.util.ArrayList" %><%--
  Created by IntelliJ IDEA.
  User: kwnst
  Date: 10/1/2016
  Time: 3:28 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="./../basics/user_header.jsp"/>
    <link rel="stylesheet" href="./../css/carousel.css">
</head>
<body>
<%
    User user2 = (User) request.getSession().getAttribute("user");

    Auction x = (Auction) request.getAttribute("auction");
    ArrayList<Photo> pList = (ArrayList<Photo>) request.getSession().getAttribute("pList");%>
<div id="myCarousel" class="carousel slide" data-ride="carousel" style="overflow:hidden">
    <ol class="carousel-indicators horizontal">
        <%  int ind=0;
            for (int i=0;i<pList.size();i++) {
                Photo pb = new Photo();
                pb = pList.get(i);
                ind=ind+1; %>
        <li data-target="#myCarousel" data-slide-to="<%=ind%>"></li>
        <%--<img src="./../BBservlet?action=viewphoto2&pic_name=<%=pb.pic_name%>" width="500" height ="500"  border="1">--%>
        <br>
        <%

            }
        %>
    </ol>
    <div class="carousel-inner" role="listbox">
        <%  int it=0;
            for (int i=0;i<pList.size();i++) {
                Photo pb = new Photo();
                pb = pList.get(i);
                if (it==0) { it=1; %>
        <div class="item peopleCarouselImg active">

            <img class="peopleCarouselImg" src="./../BBservlet?action=viewphoto2&pic_name=<%=pb.pic_name%>"   >

        </div>
        <br>
        <%}else {%>
        <div class="item peopleCarouselImg">
            <img class="peopleCarouselImg" src="./../BBservlet?action=viewphoto2&pic_name=<%=pb.pic_name%>"   >
        </div>
        <%}


        }
        %>
    </div>
    <a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
        <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
        <span class="sr-only">Previous</span>
    </a>
    <a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
        <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
        <span class="sr-only">Next</span>
    </a>
</div>
<br>
<br>
</body>
</html>
