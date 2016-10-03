<%@page import="Javabeans.User"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="./../basics/user_header.jsp"/>
    <title>Success!</title>
    <% User user = (User) request.getSession().getAttribute("user");%>
 <center><h1> <b><% out.println(user.username);%></b> your item added successfully! </h1></center>
</head>
<body><center>
<img src="./../img/added.png" class="img-responsive" style="max-width:220px; max-height:220px;" alt="Image">
<h3>Do you want to upload a photo? It makes your item more trustworthy...</h3>
<input type="submit" class="btn btn-success" value="Yes I Do !" onclick="window.location.href='./../BBservlet?action=auctionlist&username=<%=user.username%>&page_num=1'"/>
<input type="submit" class="btn btn-warning" value="Maybe later" onclick="window.location.href='#'"/>
</center>
<jsp:include page="/basics/footer.jsp" />
</body>
</html>
