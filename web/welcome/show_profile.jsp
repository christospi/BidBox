<%@ page import="Javabeans.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="./../basics/maxcdn.jsp" />
    <jsp:include page="./../basics/header.jsp" />
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
        <th>Country:</th>
        <th>City:</th>
        <th>Rating as Buyer:</th>
        <th>Rating as Seller:</th>
        </tr>
        </thead>

        <tbody>
        <tr>

            <td><%=seller.username%></td>
            <td><%=seller.name%></td>
            <td><%=seller.surname%></td>
            <td><%=seller.email%></td>
            <td><%=seller.phone%></td>
            <td><%=seller.country%></td>
            <td><%=seller.city%></td>
            <td><%=seller.rating_bidder%></td>
            <td><%=seller.rating_seller%></td>


        </tr>

        </tbody>
    </table>
</div>

<jsp:include page="./../basics/footer.jsp" />
</body>
</html>
