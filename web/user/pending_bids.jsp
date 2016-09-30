<%@page import="java.util.List"%>
<%@page import="Javabeans.Auction"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Javabeans.User"%>
<%@ page import="Javabeans.Photo" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="/basics/maxcdn.jsp" />
    <link rel="stylesheet" href="./../css/itemlist.css">
    <jsp:include page="/basics/nav.jsp" />
    <title>Pending Bids</title>
</head>
<body>
<h2>My pending bids:</h2>
<div class="container">

    <div id="products" class="row list-group">

        <% User user2 = (User) request.getSession().getAttribute("user");
            ArrayList<Auction> aList = (ArrayList<Auction>) request.getAttribute("pendlist");
            ArrayList<Photo> photos = (ArrayList<Photo>) request.getAttribute("photos");
            int total= aList.size();
            total = total/10;
            if(total%10 !=0) total+=1;

            int page_num= (int) request.getAttribute("page_num");
            for (int i=0; i<aList.size(); i++)  {
                Auction a = new Auction();
                int pointer = i;
                a = aList.get(i);
        %>

        <div class="item  list-group-item col-xs-4 col-lg-4 ">
            <div class="thumbnail ">
                <div class="photo">

                    <% Photo p = new Photo();
                        p=photos.get(i);
                        if (p.id==-1){
                    %>
                    <a href="./BBservlet?action=auctioninfo&pointer=<%=pointer%>&seller=<%=a.seller%>&itemID=<%=a.id%>"> <img  class="group list-group-image" src="./../img/item2.jpg "  alt="" /></a>
                    <%}else{%>
                    <a href="./BBservlet?action=auctioninfo&pointer=<%=pointer%>&seller=<%=a.seller%>&itemID=<%=a.id%>"> <img class="group list-group-image " src="./../BBservlet?action=viewphoto2&pic_name=<%=p.pic_name%>"  ></a>

                    <%}%>
                </div>
                <div class="caption ">
                    <br><h4 class="group inner list-group-item-heading"><a href="./BBservlet?action=auctioninfo&pointer=<%=pointer%>&seller=<%=a.seller%>&itemID=<%=a.id%>" ><%out.println(a.name);%></a></h4>
                    <p class="group inner list-group-item-text">

                        <%--<ul style="list-style: none;">--%>
                        <b>Seller:</b> <%=a.seller%> <br>
                        <b>Description:</b> <%=a.description.substring(0, Math.min(100,a.description.length() /2) )%>...<br>
                        <b>Ends:</b> <%=a.end%><br>

                        <%--</ul>--%>
                    </p>
                    <div class="row ">
                        <div class="col-xs-4 col-md-8 pull-right">
                            <p class="lead ">
                                Current Bid: <%=a.curr%> $ </p>
                        </div>
                        <div class="col-xs-4 col-md-8 pull-right">
                            <a class="btn btn-success pull-right" href="./BBservlet?action=auctioninfo&pointer=<%=pointer%>&seller=<%=a.seller%>&itemID=<%=a.id%>">More info...</a>
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
