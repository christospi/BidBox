<%@page import="Javabeans.User"%>
<%@ page import="Javabeans.Message" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="Javabeans.Auction" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="./../basics/user_header.jsp"/>
    <title>Messages</title>

</head>
<body>
    <% User user2 = (User) request.getSession().getAttribute("user");
    ArrayList<Message> mList = (ArrayList<Message>) request.getSession().getAttribute("mList");
    ArrayList<Message> mList2 = (ArrayList<Message>) request.getSession().getAttribute("mList2");%>

    <h3>Inbox</h3>
    <table class="forms" cellpadding="2" border="2">
        <tr class="def">
            <td>From</td>
            <td>To</td>
            <td>Message</td>
            <td>ItemID</td>
        </tr>
        <% for (int i=0; i<mList.size(); i++)  {
            Message m = new Message();
            m = mList.get(i);%>
        <tr>
            <td><%=m.from%></td>
            <td><%=m.to%></td>
            <td><%=m.message%></td>
            <td><%=m.itemID%></td>
            <td>
                <form method="post" action="./BBservlet?action=deletemsg&msgid=<%=m.msgID%>&username=<%=user2.username%>">
                    <input type="submit" value="delete message"/>
                </form>
            </td>
        </tr>
        <%}%>

    </table>
    <h3>Sent</h3>
    <table class="forms" cellpadding="2" border="2">
        <tr class="def">
            <td>From</td>
            <td>To</td>
            <td>Message</td>
            <td>ItemID</td>
        </tr>
        <% for (int i=0; i<mList2.size(); i++)  {
            Message m = new Message();
            m = mList2.get(i);%>
        <tr>
            <td><%=m.from%></td>
            <td><%=m.to%></td>
            <td><%=m.message%></td>
            <td><%=m.itemID%></td>
            <td>
                <form method="post" action="./BBservlet?action=deletemsg&msgid=<%=m.msgID%>&username=<%=user2.username%>">
                    <input type="submit" value="delete message"/>
                </form>
            </td>
        </tr>
        <%}%>

    </table>
<style>
    .modal-admin{
        width:800px;

    }
    .modal {
        text-align: center;
    }

    .modal-admin{
        display: inline-block;
        text-align: left;
        vertical-align: middle;
    }
    .modal-body {
        max-height: 1800px;

        padding:50px;
    }
</style>
    <br>
    <br>

    <jsp:include page="/user/send_msg.jsp" />
    <%--<h3><a href="./BBservlet?action=send_msg"> Send a new message</a> </h3>--%>

<jsp:include page="/basics/footer.jsp" />
</body>
</html>
