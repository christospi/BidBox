<%@ page import="Javabeans.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="./../basics/maxcdn.jsp" />
    <jsp:include page="./../basics/nav.jsp" />
    <link rel="stylesheet" href="./../css/search.css">
    <title>User's info</title>
    <%User user2 = (User) request.getSession().getAttribute("user");
        User seller = (User) request.getAttribute("seller");
    %>
</head>

<body>
<div class="table-responsive">
    <table  class="table table-striped table-bordered table-condensed table-hover"  cellpadding="2" border="2">
        <thead class="thead-default">
        </tr>
        <th>Username:</th>
        <th>Name:</th>
        <th>Surname:</th>
        <th>e-mail:</th>
        <th>Phone no.:</th>
        <th>Address:</th>
        <th>City:</th>
        <th>A.F.M.:</th>
        <th>Role (Seller/Bidder):</th>
        <th>Rating-B:</th>
        <th>Rating-S:</th>
        </tr>
        </thead>

        <tbody>
        <tr>

            <td><%=seller.username%></td>
            <td><%=seller.name%></td>
            <td><%=seller.surname%></td>
            <td><%=seller.email%></td>
            <td><%=seller.phone%></td>
            <td><%=seller.address%></td>
            <td><%=seller.city%></td>
            <td><%=seller.afm%></td>
            <td>DEN TO KRATAME</td>
            <td>DEN TO KRATAME</td>
            <td>DEN TO KRATAME</td>

        </tr>

        </tbody>
    </table>
</div>

<jsp:include page="./../basics/footer.jsp" />
</body>
</html>
