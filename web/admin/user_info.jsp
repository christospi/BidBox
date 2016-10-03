<%@ page import="Javabeans.User" %>
<%@ page import="java.util.ArrayList" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="/basics/admin_header.jsp"/>
    <title>User-Info</title>
</head>
<body>
<center><b><h3>User Info</h3></b></center>
<% ArrayList<User> uList = (ArrayList<User>) request.getSession().getAttribute("uList");%>
<% User y = (User) request.getSession().getAttribute("user3");%>
<% String pointer = (String) request.getSession().getAttribute("pointer");
    int point = Integer.parseInt(pointer);%>



<div class="table-responsive">
    <table class="table table-striped table-bordered table-condensed table-hover"  cellpadding="2" border="2"
    <thead class="thead-default">
        <tr class="def">
            <td>User Name</td>
            <td>First Name</td>
            <td>Last Name</td>
            <td>Email</td>
            <td>Phone Number</td>
            <td>Verified</td>
        </tr>
    </thead>
        <% User x = new User();
            x = uList.get(point); %>
        <tr>
            <td><%=x.username %></td>
            <td><%=x.name %></td>
            <td><%=x.surname %></td>
            <td><%=x.email %></td>
            <td><%=x.phone %></td>
            <td><%=x.ver %></td>



        </tr>
    </table>
    <%if (x.ver == 0) {%>
    <center>
    <form method="post" action="/BBservlet?action=verify&user_name2=<%=x.username%>">
        <input class="btn btn-success btn-lg" type="submit" value="Verify"/>
    </form>
    </center>
    <%}%>
</div>


</body>
<jsp:include page="./../basics/footer.jsp"/>
</html>
