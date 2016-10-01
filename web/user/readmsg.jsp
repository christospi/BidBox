<%@ page import="Javabeans.User" %>
<%@ page import="Javabeans.Message" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>

    <jsp:include page="/basics/maxcdn.jsp" />
    <title>Title</title>
    <% User user2 = (User) request.getSession().getAttribute("user");
        ArrayList<Message> mList = (ArrayList<Message>) request.getSession().getAttribute("mList");
        ArrayList<Message> mList2 = (ArrayList<Message>) request.getSession().getAttribute("mList2");
        int point = (Integer) request.getSession().getAttribute("point");
        int flag = (Integer) request.getSession().getAttribute("flag");
    %>
</head>
<body>
<button type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#myModal">Open Modal</button>


<div id="myModal" class="modal fade" role="dialog">
    <div class="modal-dialog">


        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">Modal Header</h4>
            </div>
            <div class="modal-body">
                <% if (flag ==1) {
                    Message m = new Message();
                    m = mList.get(point);
                %>
                <p><%=m.message%></p>
                <%}%>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
        </div>

    </div>
</div>
</body>
</html>
