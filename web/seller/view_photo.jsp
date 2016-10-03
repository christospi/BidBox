<%@page import="Javabeans.User"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="./../basics/user_header.jsp"/>
    <title>Success!</title>

    <center><h1> Photo cadded successfully! </h1></center>
</head>
<body><center>
    <img src="./../img/added.png" class="img-responsive" style="max-width:220px; max-height:220px;" alt="Image">

</center>
<jsp:include page="/basics/footer.jsp" />
</body>
</html>
