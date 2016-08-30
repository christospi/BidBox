
<%@page import="Javabeans.User"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Success!</title>
    <% User user = (User) request.getSession().getAttribute("user");%>
    <% out.println(user.username);%>
</head>
<body>
<h2>Item added !</h2>
<h3>Do you want to upload a photo? It makes your item more trustworthy...</h3>
<input type="button" value="Yes I Do !" onclick="window.location.href='./../BBservlet?action=auctionlist&username=<%=user.username%>'">
<input type="button" value="Maybe later" onclick="window.location.href='#'">
</body>
</html>
