<%@ page import="Javabeans.Auction" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="Javabeans.Photo" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
                        <jsp:include page="/basics/maxcdn.jsp" />
                        <jsp:include page="/basics/admin_head.jsp" />
                        <link rel="stylesheet" href="./../css/itemlist.css">
    <title>Export Auctions</title>
</head>
<body>
<div class="container">

    <div id="products" class="row list-group">

        <% 
            ArrayList<Auction> auctionslist = (ArrayList<Auction>) request.getSession().getAttribute("allauctions");
            ArrayList<Photo> photos = (ArrayList<Photo>) request.getSession().getAttribute("photos");
            int total= (int) request.getSession().getAttribute("total");
            total = total/10;
            if(total%10 !=0) total+=1;
            int page_num= (int) request.getSession().getAttribute("page_num");
            for (int i=0; i<auctionslist.size(); i++)  {
                Auction a = new Auction();
                int pointer = i;
                a = auctionslist.get(i);
        %>
        <form method="post" action="/BBservlet?action=marshall&page_num=<%=page_num%>">
        <div class="item list-group-item  ">
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
                            <div class="checkbox checkbox-success pull-right">
                                <input  name="item_option" id="item_option<%=i%>" value="<%=a.id%>"  type="checkbox">
                                <label for="item_option<%=i%>">
                                    Export
                                </label>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>

        <%}%>

    </div>

        <ul class="pagination ">
            <%for(int i=1;i<=total;i++){
                if(page_num==i){%>
            <li class="active"><a href="./../BBservlet?action=auctions_marsh&page_num=<%=i%>"><%=i%></a></li>
            <%}else{%>
            <li ><a href="./../BBservlet?action=auctions_marsh&page_num=<%=i%>"><%=i%></a></li>
            <%}%>
            <%}%>
        </ul>
    <div class="col-xs-4 col-md-4 pull-right">

            <button type="submit " class="btn btn-success ">Export Selected Items</button>
        </form>
    </div>
</div>

<jsp:include page="/basics/footer.jsp" />
</body>
</html>
