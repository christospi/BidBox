<%@ page import="Javabeans.User" %>
<%@ page import="java.util.ArrayList" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="/basics/admin_header.jsp"/>

    <title>User-List</title>
</head>
<body>

<center><h3>Unverified Users List</h3></center>


<ul>
    <%
        ArrayList<User> uList = (ArrayList<User>) request.getSession().getAttribute("uList");
        int page_num = (int) request.getAttribute("page_num");
        int total = (int) request.getAttribute("total");

        if( total%10 == 0 && total != 0) total = total/10;
        else total = total/10 + 1;

        for (int i=0; i<uList.size(); i++)  {
            User s = new User();
            int pointer = i;
            s = uList.get(i);

            if(s.ver == 0){%>
    <a href="/BBservlet?action=userinfo&pointer=<%=pointer%>">
        <div class="col-sm-3">
            <div class="panel panel-primary">
                <div class="panel-heading"><%out.println(s.username);%></div>
                <center><div class="panel-body"><img src="./../img/user.png" class="img-responsive" style="max-width:220px; max-height:220px;" alt="Image"></div></center>
                <div class="panel-footer">Pending Verification</div>
            </div>
        </div>
    </a>
    <%}
    else{%>
    <a href="/BBservlet?action=userinfo&pointer=<%=pointer%>">
        <div class="col-sm-3">
            <div class="panel panel-primary">
                <div class="panel-heading"><%out.println(s.username);%></div>
                <center><div class="panel-body"><img src="./../img/user.png" class="img-responsive" style="max-width:220px; max-height:220px;" alt="Image"></div></center>

            </div>
        </div>
    </a>
    <%}%>
    <%}%>
</ul>

<%-- Pagination --%>
<div class="row">
    <div class="col-md-4 col-md-offset-5">
        <ul class="pagination pagination-lg">
            <%if(page_num!=1){%>
            <li class="page-item">
                <a class="page-link" href="/BBservlet?action=verify_pend&page_num=<%=page_num-1%>" aria-label="Previous">
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
            <li class="page-item"><a  class="page-link" href="/BBservlet?action=verify_pend&page_num=<%=page_num%>"><%=page_num%> of <%=total%></a></li>
            <%if(page_num!=total){%>
            <li class="page-item">
                <a class="page-link" href="/BBservlet?action=verify_pend&page_num=<%=page_num+1%>" aria-label="Next">
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
<jsp:include page="./../basics/footer.jsp"/>
</body>
</html>
