<%@page import="Javabeans.User"%>
<%@page import="Javabeans.Message"%>

<%User user2 = (User) request.getSession().getAttribute("user");
    int count= Message.get_new(user2.username);
    session.setAttribute("count",count);
%>
