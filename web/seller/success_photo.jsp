<%@ page import="Javabeans.Auction" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="Javabeans.Photo" %>
<%@ page import="Javabeans.User" %>

<% User user2 = (User) request.getSession().getAttribute("user");%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="./../basics/user_header.jsp"/>
    <title>Photo added!</title>
</head>
<body>
<form method="post" action="./../BBservlet?action=viewphoto&owner=<%=user2.username%>" >
    <input type="submit" value="View photo" >
</body>
</html>
