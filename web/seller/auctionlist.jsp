<%@page import="java.util.List"%>
<%@page import="Javabeans.Auction"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Javabeans.User"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="/basics/maxcdn.jsp" />
    <jsp:include page="/basics/nav.jsp" />
    <title>Auction list</title>
</head>
<body>
<h2>My Auctions:</h2>
<ul style="list-style: none;">
<% User user2 = (User) request.getSession().getAttribute("user");
    ArrayList<Auction> aList = (ArrayList<Auction>) request.getSession().getAttribute("aList");
    int total= (int) request.getSession().getAttribute("total");
    int page_num= (int) request.getSession().getAttribute("page_num");
    for (int i=0; i<aList.size(); i++)  {
        Auction a = new Auction();
        int pointer = i;
        a = aList.get(i); %>
<br><li><a href="./BBservlet?action=auctioninfo&pointer=<%=pointer%>&seller=<%=a.seller%>&itemID=<%=a.id%>" ><%out.println(a.name);%></a></li>
<%}%>
</ul>

<ul class="pagination">
    <%for(int i=1;i<=total/2;i++){
        if(page_num==i){%>
            <li class="active"><a href="./../BBservlet?action=auctionlist&username=<%=user2.username%>&page_num=<%=i%>"><%=i%></a></li>
        <%}else{%>
            <li ><a href="./../BBservlet?action=auctionlist&username=<%=user2.username%>&page_num=<%=i%>"><%=i%></a></li>
        <%}%>
    <%}%>
</ul>

<jsp:include page="/basics/footer.jsp" />
</body>
</html>
