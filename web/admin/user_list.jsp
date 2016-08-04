<%@ page import="Javabeans.User" %>
<%@ page import="java.util.ArrayList" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>User-List</title>
</head>
<body>
    <h3>Users List</h3>
    <% ArrayList<User> uList = (ArrayList<User>) request.getSession().getAttribute("uList");
        for (int i=0; i<uList.size(); i++)  {
            User s = new User();
            int pointer = i;
            s = uList.get(i); %>
    <br><a href="/BBservlet?action=userinfo&pointer=<%=pointer%>" class="href2" id="link"><%out.println(s.username);%></a>
    <%} %>
</body>
</html>
