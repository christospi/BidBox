<%@page import="Javabeans.User"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="./../basics/admin_header.jsp"/>
    <title>Success!</title>
    <% String user = (String) request.getAttribute("user_name");%>
    <center><h1> <b><% out.println(user);%></b> was succesfully verified ! </h1></center>
</head>
<body><center>
    <img src="./../img/added.png" class="img-responsive" style="max-width:220px; max-height:220px;" alt="Image">

</center>
<jsp:include page="/basics/footer.jsp" />
</body>
</html>
