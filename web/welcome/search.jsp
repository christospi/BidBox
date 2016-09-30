<%@ page import="Javabeans.User" %>
<%@ page import="Javabeans.Category" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="./../basics/maxcdn.jsp" />
    <jsp:include page="./../basics/nav.jsp" />
    <link rel="stylesheet" href="./../css/search.css">
    <title>Search Auctions</title>
    <%User user2 = (User) request.getSession().getAttribute("user");
        ArrayList<Category> cList = (ArrayList<Category>) request.getAttribute("cList");

    %>
</head>

<body>

<%--<div class="container">--%>
    <div class="panel panel-default">
        <div class="panel-heading">
            <h2>Search auctions</h2>
        </div>

        <form method="post" action="/BBservlet?action=searchres&seller=<%=user2.userID%>">
        <div class="panel-body">
            <div class="row">
                <div class="col-md-6">
                    <label>Search filters: </label><br>
                        <input type="checkbox" name="inactive" value=1> Include inactive auctions <br>
                            <label>Choose:</label><br>
                            <select name = "choice" id="ddlsearch" class="btn btn-default dropdown-toggle" type="button" data-toggle="dropdown" required>
                            <div class="dropdown-menu">
                            <option selected value="" data-hidden="true" class="ddl-title" disabled>Choose Category: </option>
                            <option value="any" >Any</option>
                            <option value="popular">Popular</option>
                            <div class="dropdown-divider"><hr></div>
                              <optgroup label="Category">
                                  <%for (int i=0; i<cList.size(); i++)  {
                                    Category a = new Category();
                                    a = cList.get(i); %>
                                      <option value="<%=a.catID%>"><%=a.name%></option>
                                  <%}%>
                              </optgroup>
                          </div>
                        </select><br>

                    <label>Location:</label><br>
                    <input id="txtkey" name="location" type="text" class="form-control" placeholder="Enter location" aria-describedby="ddlsearch"><br>

                <%--</div>--%>
                            <label>Keywords:</label><br>
                            <input id="txtkey" name="keywords" type="text" class="form-control" placeholder="Enter keywords" aria-describedby="ddlsearch"><br>

                            <div class="col-xs-3">
                                <label for="ex2"> From :</label>
                                <input id="ex2" name="from_pr" type="number" step="any" class="form-control" min="0"  placeholder="Price" aria-describedby="ddlsearch" ><br>
                            </div>
                            <div class="col-xs-3">
                                <label for="ex"> To :</label>
                                <input id="ex" name="to_pr" type="number" step="any" class="form-control" min="0"   placeholder="Price" aria-describedby="ddlsearch" ><br>
                            </div>


                        <%--</div>--%>
                    <%--</div>--%>
                </div>
            </div>

            <%--<div class="panel-body">--%>
                <%--<div class="row">--%>
                    <%--<div id="sresult" class="well"></div>--%>
                    <%--<redirect <="" div="">--%>
                    <%--</redirect></div>--%>
            <%--</div>--%>
        <%--</div>--%>
            <span class="input-group-btn">
                <button id="btn-search" class="btn btn-info" type="submit"><span class="glyphicon glyphicon-search"></span> Search </button>
              </span>
            <a href="/BBservlet?action=recommendations&seller=<%=user2.userID%>">    <b>or see our recommendations for you...</b></a>
    </div>

   </form>

<%--</div>--%>


<div id="push"></div>


<%--<form method="post" action="/BBservlet?action=searchres">--%>
    <%--<input type="submit" value="Search"/>--%>
<%--</form>--%>
    <jsp:include page="./../basics/footer.jsp" />
</body>

</html>
