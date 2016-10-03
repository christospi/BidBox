<%@ page import="Javabeans.Auction" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="Javabeans.Photo" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>

    <link rel="stylesheet" href="./../css/itemlist.css">
    <%
        ArrayList<Auction> aList = (ArrayList<Auction>) request.getSession().getAttribute("search_list");
        String guest = (String) request.getSession().getAttribute("guest");

        int page_num = (Integer) request.getAttribute("page_num");

        int total = aList.size()/10;
        if(aList.size()%10 !=0 || aList.size()==0) total+=1;

        if(guest.equals("-1")){
    %>

    <jsp:include page="/basics/guest_header.jsp" />
    <%}else{%>
    <jsp:include page="/basics/user_header.jsp" />
    <%}%>
    <title>Search Results</title>
</head>
<body>

<center><h2>Your search results:</h2></center>
<div class="container">
    <div id="products" class="row list-group">

        <%

            ArrayList<Photo> photos = (ArrayList<Photo>) request.getSession().getAttribute("photos");

            if(page_num!=total){
                System.out.println("alist.size:"+aList.size()+"total"+total);
                for (int i=10*(page_num-1); i< page_num*10 ; i++) {
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
                    <%if (!guest.equals("-1")){%>
                    <a href="./BBservlet?action=auction_search&auctionid=<%=a.id%>&seller=<%=a.seller%>"> <img  class="group list-group-image" src="./../img/item2.jpg "  alt="" /></a>
                    <%}else{%>
                    <a href="./BBservlet?action=auction_search_guest&auctionid=<%=a.id%>&seller=<%=a.seller%>"> <img  class="group list-group-image" src="./../img/item2.jpg "  alt="" /></a>
                    <%}%>
                    <%}else{%>
                    <%if (!guest.equals("-1")){%>
                    <a href="./BBservlet?action=auction_search&auctionid=<%=a.id%>&seller=<%=a.seller%>"> <img class="group list-group-image " src="./../BBservlet?action=viewphoto2&pic_name=<%=p.pic_name%>"  ></a>
                    <%}else{%>
                    <a href="./BBservlet?action=auction_search_guest&auctionid=<%=a.id%>&seller=<%=a.seller%>"> <img class="group list-group-image " src="./../BBservlet?action=viewphoto2&pic_name=<%=p.pic_name%>"  ></a>
                    <%}%>
                    <%}%>
                </div>
                <div class="caption ">
                    <%if (!guest.equals("-1")){%>
                    <br><h4 class="group inner list-group-item-heading"><a href="./BBservlet?action=auction_search&auctionid=<%=a.id%>&seller=<%=a.seller%>" ><%out.println(a.name);%></a></h4>
                    <%}else{%>
                    <br><h4 class="group inner list-group-item-heading"><a href="./BBservlet?action=auction_search_guest&auctionid=<%=a.id%>&seller=<%=a.seller%>" ><%out.println(a.name);%></a></h4>
                    <p class="group inner list-group-item-text">
                        <%}%>
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
                        <%if(!guest.equals("-1")){%>
                        <div class="col-xs-4 col-md-8 pull-right">
                            <a class="btn btn-success pull-right" href="./BBservlet?action=auction_search&auctionid=<%=a.id%>&seller=<%=a.seller%>">More info...</a>
                        </div>
                        <%}else{%>
                        <div class="col-xs-4 col-md-8 pull-right">
                            <a class="btn btn-success pull-right" href="./BBservlet?action=auction_search_guest&auctionid=<%=a.id%>&seller=<%=a.seller%>">More info...</a>
                        </div>
                        <%}%>

                    </div>
                </div>
            </div>
        </div>

        <%}
        }else{
            for (int i=10*(page_num-1); i< aList.size(); i++) {
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
                    <%if (!guest.equals("-1")){%>
                    <a href="./BBservlet?action=auction_search&auctionid=<%=a.id%>&seller=<%=a.seller%>"> <img  class="group list-group-image" src="./../img/item2.jpg "  alt="" /></a>
                    <%}else{%>
                    <a href="./BBservlet?action=auction_search_guest&auctionid=<%=a.id%>&seller=<%=a.seller%>"> <img  class="group list-group-image" src="./../img/item2.jpg "  alt="" /></a>
                    <%}%>
                    <%}else{%>
                    <%if (!guest.equals("-1")){%>
                    <a href="./BBservlet?action=auction_search&auctionid=<%=a.id%>&seller=<%=a.seller%>"> <img class="group list-group-image " src="./../BBservlet?action=viewphoto2&pic_name=<%=p.pic_name%>"  ></a>
                    <%}else{%>
                    <a href="./BBservlet?action=auction_search_guest&auctionid=<%=a.id%>&seller=<%=a.seller%>"> <img class="group list-group-image " src="./../BBservlet?action=viewphoto2&pic_name=<%=p.pic_name%>"  ></a>
                    <%}%>
                    <%}%>
                </div>
                <div class="caption ">
                    <%if(!guest.equals("-1")){%>
                    <br><h4 class="group inner list-group-item-heading"><a href="./BBservlet?action=auction_search&auctionid=<%=a.id%>&seller=<%=a.seller%>" ><%out.println(a.name);%></a></h4>
                    <%}else{%>
                    <br><h4 class="group inner list-group-item-heading"><a href="./BBservlet?action=auction_search_guest&auctionid=<%=a.id%>&seller=<%=a.seller%>" ><%out.println(a.name);%></a></h4>
                    <p class="group inner list-group-item-text">
                        <%}%>
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
                        <%if (!guest.equals("-1")){%>
                        <div class="col-xs-4 col-md-8 pull-right">
                            <a class="btn btn-success pull-right" href="./BBservlet?action=auction_search&auctionid=<%=a.id%>&seller=<%=a.seller%>">More info...</a>
                        </div>
                        <%}else{%>
                        <div class="col-xs-4 col-md-8 pull-right">
                            <a class="btn btn-success pull-right" href="./BBservlet?action=auction_search_guest&auctionid=<%=a.id%>&seller=<%=a.seller%>">More info...</a>
                        </div>
                        <%}%>

                    </div>
                </div>
            </div>
        </div>

        <%}
        }%>
    </div>

    <%-- Pagination for results --%>
    <div class="row">
        <div class="col-md-4 col-md-offset-5">
            <ul class="pagination pagination-lg">
                <%if(page_num!=1){%>
                <li class="page-item">
                    <a class="page-link" href="./../BBservlet?action=search_paging&page_num=<%=page_num-1%>" aria-label="Previous">
                        <span aria-hidden="true">&laquo;</span>
                        <span class="sr-only">Previous</span>
                    </a>
                </li>
                <%}else{%>
                <li class="page-item disabled">
                    <a class="page-link disabled" aria-label="Previous">
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
                <%}else{%>
                <li class="page-item disabled">
                    <a class="page-link disabled" aria-label="Next">
                        <span aria-hidden="true">&raquo;</span>
                        <span class="sr-only">Next</span>
                    </a>
                </li>
                <%}%>
            </ul>
        </div>
    </div>
    <%-- End of pagination --%>


</div>
<jsp:include page="/basics/footer.jsp" />
</body>
</html>



