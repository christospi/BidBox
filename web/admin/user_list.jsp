<%@ page import="Javabeans.User" %>
<%@ page import="java.util.ArrayList" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="/basics/maxcdn.jsp" />
    <jsp:include page="/basics/admin_head.jsp" />
    <title>User-List</title>
</head>
<body>
    <h3>Users List</h3>
    <ul>
    <% ArrayList<User> uList = (ArrayList<User>) request.getSession().getAttribute("uList");
        for (int i=0; i<uList.size(); i++)  {
            User s = new User();
            int pointer = i;
            s = uList.get(i);

            if(s.ver == 0){%>
                <li><a href="/BBservlet?action=userinfo&pointer=<%=pointer%>" class="href2" id="link"><%out.println(s.username);%></a> (pending verification)</li>
            <%}
            else{%>
                <li><a href="/BBservlet?action=userinfo&pointer=<%=pointer%>" class="href2" id="link"><%out.println(s.username);%></a></li>
            <%}%>
    <%}%>
    </ul>
</body>
</html>
