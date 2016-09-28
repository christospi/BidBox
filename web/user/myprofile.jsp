<%@ page import="Javabeans.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="/basics/maxcdn.jsp" />
    <jsp:include page="/basics/nav.jsp" />
    <title>My profile</title>


</head>
<body>
<div class="container">
    <div class="row">
        <center>
            <h3>Personal Info</h3>

            <% User user = (User) request.getSession().getAttribute("user");%>

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
                    <th>A.F.M.:</th>
                    <th>Rating as Buyer:</th>
                    <th>Rating as Seller:</th>
                    </tr>
                    </thead>

                    <tbody>
                    <tr>

                        <td><%=user.username%></td>
                        <td><%=user.name%></td>
                        <td><%=user.surname%></td>
                        <td><%=user.email%></td>
                        <td><%=user.phone%></td>
                        <td><%=user.country%></td>
                        <td><%=user.city%></td>
                        <td><%=user.afm%></td>
                        <td><%=user.rating_bidder%></td>
                        <td><%=user.rating_seller%></td>


                    </tr>

                    </tbody>
                </table>
            </div>


            <div>
                <form method="post" action="">
                    <button type="submit" class="btn btn-warning"  id="edit"> Edit personal info </button>
                </form>

            </div>
        </center>
    </div>
</div>
<jsp:include page="/basics/footer.jsp" />
</body>
</html>
