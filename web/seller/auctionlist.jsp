<%@page import="java.util.List"%>
<%@page import="Javabeans.Auction"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Javabeans.User"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Auction list</title>
</head>
<body>

<% ArrayList<Auction> aList = (ArrayList<Auction>) request.getSession().getAttribute("aList");
    int num= (int) request.getSession().getAttribute("num");
    for (int i=0; i<aList.size(); i++)  {
        Auction a = new Auction();
        int pointer = i;
        a = aList.get(i); %>
<br><a href="./BBservlet?action=auctioninfo&pointer=<%=pointer%>&seller=<%=a.seller%>" ><%out.println(a.name);%></a>
<p><%out.println(num);%></p>
<%}%>
</body>
</html>
