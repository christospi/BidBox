
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="/basics/maxcdn.jsp" />
    <jsp:include page="/basics/nav.jsp" />
    <title>Search Auctions</title>
</head>

<body>

<form method="post" action="/BBservlet?action=searchres">
    <input type="submit" value="Search"/>
</form>

</body>
</html>
