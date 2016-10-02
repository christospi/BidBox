<%@ page import="Javabeans.User" %>
<%@ page import="java.util.ArrayList" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="/basics/admin_header.jsp"/>
    <title>User-Info</title>
</head>
<body>
<h3>User Info</h3>
<% ArrayList<User> uList = (ArrayList<User>) request.getSession().getAttribute("uList");%>
<% User y = (User) request.getSession().getAttribute("user3");%>
<% String pointer = (String) request.getSession().getAttribute("pointer");
    int point = Integer.parseInt(pointer);%>
<table class="forms" cellpadding="2" border="2">
    <tr class="def">
        <td>User Name</td>
        <td>First Name</td>
        <td>Last Name</td>
        <td>Email</td>
        <td>Phone Number</td>
        <td>Verified</td>
    </tr>

    <% User x = new User();
        x = uList.get(point); %>
    <tr>
        <td><%=x.username %></td>
        <td><%=x.name %></td>
        <td><%=x.surname %></td>
        <td><%=x.email %></td>
        <td><%=x.phone %></td>
        <td><%=x.ver %></td>
        <%if (x.ver == 0) {%>
        <td>
            <form method="post" action="/BBservlet?action=verify&user_name2=<%=x.username%>">
                <input type="submit" value="verify"/>
            </form>
        </td>
        <%}%>
    </tr>
</table>
</body>
</html>
