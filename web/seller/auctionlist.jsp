<%@page import="java.util.List"%>
<%@page import="Javabeans.Auction"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Javabeans.User"%>
<%@ page import="Javabeans.Photo" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="./../basics/user_header.jsp"/>
    <link rel="stylesheet" href="./../css/itemlist.css">
    <title>Auction list</title>
</head>
<body>
<center><h2>My Auctions:</h2></center>
<div class="container">

    <div id="products" class="row list-group">

        <% User user2 = (User) request.getSession().getAttribute("user");
            ArrayList<Auction> aList = (ArrayList<Auction>) request.getSession().getAttribute("aList");
            ArrayList<Photo> photos = (ArrayList<Photo>) request.getSession().getAttribute("photos");

            int total= (int) request.getSession().getAttribute("total");

            if( total%10 == 0 && total != 0) total = total/10;
            else total = total/10 + 1;

            int page_num= (int) request.getSession().getAttribute("page_num");
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

    <%-- Pagination --%>
    <div class="row">
        <div class="col-md-4 col-md-offset-5">
            <ul class="pagination pagination-lg">
                <%if(page_num!=1){%>
                <li class="page-item">
                    <a class="page-link" href="./../BBservlet?action=auctionlist&username=<%=user2.username%>&page_num=<%=page_num-1%>" aria-label="Previous">
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
                <li class="page-item"><a  class="page-link" href="./../BBservlet?action=auctionlist&username=<%=user2.username%>&page_num=<%=page_num%>"><%=page_num%> of <%=total%></a></li>
                <%if(page_num!=total){%>
                <li class="page-item">
                    <a class="page-link" href="./../BBservlet?action=auctionlist&username=<%=user2.username%>&page_num=<%=page_num+1%>" aria-label="Next">
                        <span aria-hidden="true">&raquo;</span>
                        <span class="sr-only">Next</span>
                    </a>
                </li>
                <%}else{%>
                <li class="page-item disabled">
                    <a class="disabled" aria-label="Next">
                        <span aria-hidden="true">&raquo;</span>
                        <span class="sr-only">Next</span>
                    </a>
                </li>
                <%}%>
            </ul>
        </div>
    </div>
    <%-- Pagination over --%>

</div>

<jsp:include page="/basics/footer.jsp" />
</body>
</html>
