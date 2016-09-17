<%@ page import="Javabeans.Auction" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="/basics/maxcdn.jsp" />
    <jsp:include page="/basics/nav.jsp" />
    <title>Search Results</title>
</head>
<body>

<h2>Your search results:</h2>
<% ArrayList<Auction> aList = (ArrayList<Auction>) request.getSession().getAttribute("aList");
    for (int i=0; i<aList.size(); i++)  {
        Auction a = new Auction();
        int pointer = i;
        a = aList.get(i); %>
<br><a href="./BBservlet?action=auction_search&pointer=<%=pointer%>&seller=<%=a.seller%>" ><%out.println(a.name);%></a>
<%}%>

<jsp:include page="/basics/footer.jsp" />
</body>
</html>
