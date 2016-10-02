<%@ page import="Javabeans.User" %>
<%@ page import="Javabeans.Message" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>

    <jsp:include page="./../basics/user_header.jsp"/>
    <link rel="stylesheet" href="./../css/msg.css">
    <title>Messages</title>
</head>
<body>





<% User user2 = (User) request.getSession().getAttribute("user");
    ArrayList<Message> mList = (ArrayList<Message>) request.getSession().getAttribute("mList");
    ArrayList<Message> mList2 = (ArrayList<Message>) request.getSession().getAttribute("mList2");

%>

<div class="container">
    <div class="row">

        <div class="col-sm-9 col-md-10">

            <button type="button" class="btn btn-default" data-toggle="tooltip" title="Refresh">
                &nbsp;&nbsp;&nbsp;<span class="glyphicon glyphicon-refresh"></span>&nbsp;&nbsp;&nbsp;</button>

            <jsp:include page="/user/send_msg.jsp" />
        </div>
    </div>
    <hr>
    <div class="row">


            <hr>

        <div class="col-sm-9 col-md-10">
            <!-- Nav tabs -->
            <ul class="nav nav-tabs">
                <li class="active"><a href="#home" data-toggle="tab"><span class="glyphicon glyphicon-inbox">
                </span>Inbox</a></li>
                <li><a href="#profile" data-toggle="tab"><span class="glyphicon glyphicon-share-alt"></span>
                    Sent</a></li>

            </ul>
            <!-- Tab panes -->

            <div class="tab-content">
                <div class="tab-pane fade in active" id="home">
                    <div class="list-group">
                        <% for (int i=0; i<mList.size(); i++)  {
                            Message m = new Message();
                            m = mList.get(i);

                            %>
                        <a id="trigger" class="list-group-item" value="<%=i%>">


                            <span class="glyphicon glyphicon-chevron-right"></span><span class="name" style="min-width: 120px;
                                display: inline-block;"><%=m.from%></span><b>Item:</b>  <span class=""><%=m.itemID%>  |  </span><span class=""><%=m.message%></span>
                            <form method="post" action="./BBservlet?action=deletemsg&msgid=<%=m.msgID%>&username=<%=user2.username%>">
                            <button type="submit" class="btn btn-default pull-right" value=""><span class="glyphicon glyphicon-trash"></span></button></form>
                            <br>
                            </a>
                        <%}%>
                        <%if (mList.size()==0){%>
                        <a href="#" class="list-group-item">
                                <span class="name" style="width:240px; height:240px;
                                       "><center><b>No Messages</b></center></span>

                        </a>
                        <%}%>
                    </div>
                </div>
                <div class="tab-pane fade in" id="profile">
                    <div class="list-group">
                        <% for (int i=0; i<mList2.size(); i++)  {
                            Message m = new Message();
                            m = mList2.get(i);%>
                        <a href="#" class="list-group-item">

                            <span class="glyphicon glyphicon-chevron-right"></span><span class="name" style="min-width: 120px;
                                display: inline-block;"><%=m.from%></span><b>Item:</b>  <span class=""><%=m.itemID%>  <b>| </b> </span><span class=""><%=m.message%></span>
                        <form method="post" action="./BBservlet?action=deletemsg&msgid=<%=m.msgID%>&username=<%=user2.username%>">
                            <button type="submit" class="btn btn-default pull-right " value=""><span class="glyphicon glyphicon-trash"></span></button>
                            <br>
                        </form>
                        </a>
                        <%}%>
                        <%if (mList2.size()==0){%>
                            <a href="#" class="list-group-item">
                                <span class="name" style="width:240px; height:240px;
                                       "><center><b>No Messages</b></center></span>

                             </a>
                        <%}%>

                    </div>
                </div>

            </div>


        </div>
    </div>
</div>
<jsp:include page="/basics/footer.jsp" />
</body>
</html>
