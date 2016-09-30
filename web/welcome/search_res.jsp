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
    System.out.println("alist.size:"+aList.size()+"total"+total);
    for (int i=10*(page_num-1); i< page_num*10 ; i++) {

        Auction a = new Auction();
        int pointer = i;
        a = aList.get(i); %>
        <%if (guest!=-1){%>
            <br><a href="./BBservlet?action=auction_search&auctionid=<%=a.id%>&seller=<%=a.seller%>" ><%out.println(a.name);%>hahahah</a>
        <%}else{%>
            <br><a href="./BBservlet?action=auction_search_guest&auctionid=<%=a.id%>&seller=<%=a.seller%>" ><%out.println(a.name);%>hahaha</a>
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


            <ul class="pagination pagination-lg">



                <%if(page_num!=1){%>
                <li class="page-item">
                    <a class="page-link" href="./../BBservlet?action=search_paging&page_num=<%=page_num-1%>" aria-label="Previous">
                        <span aria-hidden="true">&laquo;</span>
                        <span class="sr-only">Previous</span>
                    </a>
                </li>

                <%}%>
                    <li class="page-item"><a  class="page-link" href="./../BBservlet?action=search_paging&page_num=<%=page_num%>"><%=page_num%> of <%=total%></a></li>
                <%if(page_num!=total){%>


                <li class="page-item">
                    <a class="page-link" href="./../BBservlet?action=search_paging&page_num=<%=page_num+1%>" aria-label="Next">
                        <span aria-hidden="true">&raquo;</span>
                        <span class="sr-only">Next</span>
                    </a>
                </li>

                <%}%>


            </ul>



<jsp:include page="/basics/footer.jsp" />
</body>
</html>
