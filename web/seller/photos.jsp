<%@page import="javax.imageio.ImageIO"%>
<%@page import="java.awt.image.BufferedImage"%>
<%@page import="java.io.ByteArrayInputStream"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Blob"%>
<%@ page import="Javabeans.User" %>
<%@ page import="Javabeans.Photo" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Photos</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <style>

        .carousel-indicators {
            position: absolute;
            bottom: 10px;
            left: 0;
            z-index: 15;
            width: 60%;
            margin-left: 20px;
            list-style: none;
            text-align: center;
        }
        .carousel-inner > .item > img,
        .carousel-inner > .item > a > img {
            width: 50%;

            margin: auto;
        }

    </style>
</head>
<body>
<% User user2 = (User) request.getSession().getAttribute("user");%>
<% String pointer = (String) request.getSession().getAttribute("id");
    int pi = Integer.parseInt(pointer);
    ArrayList<Photo> pList = (ArrayList<Photo>) request.getSession().getAttribute("pList");
%>

<br><br><br>
<div id="myCarousel" class="carousel slide" data-ride="carousel">
    <ol class="carousel-indicators">
            <%  int ind=0;
                for (int i=0;i<pList.size();i++) {
                Photo pb = new Photo();
                pb = pList.get(i);
                if (pb.itemID == pi) {ind=ind+1; %>
            <li data-target="#myCarousel" data-slide-to="<%=ind%>"></li>
            <%--<img src="./../BBservlet?action=viewphoto2&pic_name=<%=pb.pic_name%>" width="500" height ="500"  border="1">--%>
            <br>
            <%}

            }
              %>
    </ol>
    <div class="carousel-inner" role="listbox">
            <%  int it=0;
                for (int i=0;i<pList.size();i++) {
                Photo pb = new Photo();
                pb = pList.get(i);
                if (pb.itemID == pi && it==0) { it=1; %>
        <div class="item active">

            <img src="./../BBservlet?action=viewphoto2&pic_name=<%=pb.pic_name%>" width="460" height="345"  >

        </div>
            <br>
            <%}else{%>
                <div class="item">
                    <img src="./../BBservlet?action=viewphoto2&pic_name=<%=pb.pic_name%>" width="460" height="345"  >
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
</body>
</html>
