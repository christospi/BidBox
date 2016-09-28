<%@ page import="Javabeans.Auction" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="/basics/maxcdn.jsp" />
    <% ArrayList<Auction> aList = (ArrayList<Auction>) request.getSession().getAttribute("search_list");
    int guest = (Integer)request.getSession().getAttribute("guest");
    int page_num = (Integer) request.getAttribute("page_num");
    int total = aList.size()/10;
    if(aList.size()%10 !=0) total+=1;
    if(guest!=-1){
    %>

    <jsp:include page="/basics/nav.jsp" />
    <%}else{%>
    <jsp:include page="/basics/header.jsp" />
    <%}%>
    <title>Search Results</title>
</head>
<body>

<h2>Your search results:</h2>
<ul style="list-style: none;">
<%
    if(page_num!=total){

    for (int i=10*(page_num-1); i< (aList.size()/((total-page_num)*10))*10; i++) {

        Auction a = new Auction();
        int pointer = i;
        a = aList.get(i); %>
        <%if (guest!=-1){%>
            <br><a href="./BBservlet?action=auction_search&auctionid=<%=a.id%>&seller=<%=a.seller%>" ><%out.println(a.name);%></a>
        <%}else{%>
            <br><a href="./BBservlet?action=auction_search_guest&auctionid=<%=a.id%>&seller=<%=a.seller%>" ><%out.println(a.name);%></a>
        <%}%>
<%}
}else{


    for (int i=10*(page_num-1); i< aList.size(); i++) {

        Auction a = new Auction();
        int pointer = i;
        a = aList.get(i); %>
        <%if (guest!=-1){%>
        <br><a href="./BBservlet?action=auction_search&auctionid=<%=a.id%>&seller=<%=a.seller%>" ><%out.println(a.name);%></a>
        <%}else{%>
        <br><a href="./BBservlet?action=auction_search_guest&auctionid=<%=a.id%>&seller=<%=a.seller%>" ><%out.println(a.name);%></a>
        <%}%>
        <%}

}
%>
</ul>
<%
if(aList.size()==0){
%><h3>Nothing to show...</h3>

<%}%>


            <ul class="pagination">
                <%for(int i=1;i<=total;i++){
                    if(page_num==i){%>
                <li class="active"><a href="./../BBservlet?action=search_paging&page_num=<%=i%>"><%=i%></a></li>

                <%}else{%>
                <li ><a href="./../BBservlet?action=search_paging&page_num=<%=i%>"><%=i%></a></li>
                <%}%>
                <%}%>
            </ul>



<jsp:include page="/basics/footer.jsp" />
</body>
</html>
