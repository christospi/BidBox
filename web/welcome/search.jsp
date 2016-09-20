<%@ page import="Javabeans.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="./../basics/maxcdn.jsp" />
    <jsp:include page="./../basics/nav.jsp" />
    <link rel="stylesheet" href="./../css/search.css">
    <title>Search Auctions</title>
    <%User user2 = (User) request.getSession().getAttribute("user");

    %>
</head>

<body>

<div class="container">
    <div class="panel panel-default">
        <div class="panel-heading">
            <h2>Search auctions</h2>
        </div>

        <form method="post" action="/BBservlet?action=searchres&seller=<%=user2.username%>">
        <div class="panel-body">
            <div class="row">
                <div class="col-md-6">

                    <%--<div class="form-horizontal">--%>
                        <%--<div class="input-group">--%>
                            <%--<div class="ddl-select input-group-btn">--%>
                                <label>Choose:</label><br>
                                <select name = "choice" id="ddlsearch" class="btn btn-default dropdown-toggle" type="button" data-toggle="dropdown" required>
                                  <div class="dropdown-menu">
                                    <option selected value="" data-hidden="true" class="ddl-title" disabled>Choose Category: </option>
                                    <option value="any" >Any</option>
                                    <option value="popular">Popular</option>
                                    <option value="recommended">Recommended for you</option>
                                    <div class="dropdown-divider"><hr></div>
                                      <optgroup label="Category">
                                          <option  value ="art"> Art </option>
                                          <option  value ="books"> Books </option>
                                          <option  value ="computers"> Computers & Tablets </option>
                                          <option  value="electronics">Electronics</option>
                                          <option  value ="fashion">Fashion</option>
                                          <option  value ="gadgets"> Gadgets </option>
                                          <option  value ="home"> Home & Garden </option>
                                          <option  value ="jewelry"> Jewelry & Watches </option>
                                          <option  value ="sports"> Sports </option>
                                          <option  value ="videogame"> Video Games </option>
                                          <option  value ="else"> Everything Else </option>
                                      </optgroup>
                                  </div>

                                </select><br>

                            <%--</div>--%>
                            <label>Term:</label><br>
                            <input id="txtkey" name="terms" type="text" class="form-control" placeholder="Enter a term" aria-describedby="ddlsearch"><br>

                            <div class="col-xs-3">
                                <label for="ex2"> From :</label>
                                <input id="ex2" name="from" type="number" step="any" class="form-control" min="0"  placeholder="Price" aria-describedby="ddlsearch" ><br>
                            </div>
                            <div class="col-xs-3">
                                <label for="ex"> To :</label>
                                <input id="ex" name="to" type="number" step="any" class="form-control" min="0"   placeholder="Price" aria-describedby="ddlsearch" ><br>
                            </div>

                                <span class="input-group-btn">
                <button id="btn-search" class="btn btn-info" type="submit"><span class="glyphicon glyphicon-search"></span> Search</button>
              </span>
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
    </div>

   </form>

</div>


<div id="push"></div>


<%--<form method="post" action="/BBservlet?action=searchres">--%>
    <%--<input type="submit" value="Search"/>--%>
<%--</form>--%>
    <jsp:include page="./../basics/footer.jsp" />
</body>
</html>
