<%@page import="java.util.List"%>
<%@page import="Javabeans.Auction"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Javabeans.User"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="/basics/maxcdn.jsp" />
    <link rel="stylesheet" href="../css/itemlist.css">
    <jsp:include page="/basics/nav.jsp" />
    <title>Auction list</title>
</head>
<body>
<h2>My Auctions:</h2>
<div class="container">

    <div id="products" class="row list-group">

        <% User user2 = (User) request.getSession().getAttribute("user");
            ArrayList<Auction> bList = (ArrayList<Auction>) request.getSession().getAttribute("boughtList");
            int total= (int) request.getSession().getAttribute("total");
            total = total/10;
            if(total%10 !=0) total+=1;
            int page_num= (int) request.getSession().getAttribute("page_num");
            for (int i=0; i<bList.size(); i++)  {
                Auction a = new Auction();
                int pointer = i;
                a = bList.get(i);
        %>
        <div class="item  list-group-item col-xs-4 col-lg-4">
            <div class="thumbnail">
                <a href="./BBservlet?action=purchasedinfo&pointer=<%=pointer%>&seller=<%=a.seller%>&itemID=<%=a.id%>"> <img class="group list-group-image" src="../img/item2.jpg " height="220" width="220" alt="" /></a>
                <div class="caption">
                    <br><h4 class="group inner list-group-item-heading"><a href="./BBservlet?action=purchasedinfo&pointer=<%=pointer%>&seller=<%=a.seller%>&itemID=<%=a.id%>" ><%out.println(a.name);%></a></h4>
                    <p class="group inner list-group-item-text">

                        <%--<ul style="list-style: none;">--%>
                        <b>Seller:</b> <%=a.seller%> <br>
                        <b>Seller rating:</b> Pending....<br>
                        <b>Ends:</b> <%=a.end%><br>

                        <%--</ul>--%>
                    </p>
                    <div class="row">
                        <div class="col-xs-12 col-md-6">
                            <p class="lead">
                                Current Bid: <%=a.curr%> $ </p>
                        </div>
                        <div class="col-xs-4 col-md-8">
                            <a class="btn btn-success pull-right" href="./BBservlet?action=purchasedinfo&pointer=<%=pointer%>&seller=<%=a.seller%>&itemID=<%=a.id%>">More info...</a>
                        </div>

                    </div>
                </div>
            </div>
        </div>

        <%}%>

    </div>
    <ul class="pagination">
        <%for(int i=1;i<=total;i++){
            if(page_num==i){%>
        <li class="active"><a href="./../BBservlet?action=auctionlist&username=<%=user2.username%>&page_num=<%=i%>"><%=i%></a></li>
        <%}else{%>
        <li ><a href="./../BBservlet?action=auctionlist&username=<%=user2.username%>&page_num=<%=i%>"><%=i%></a></li>
        <%}%>
        <%}%>
    </ul>
</div>

<jsp:include page="/basics/footer.jsp" />
</body>
</html>
