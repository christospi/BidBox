
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="./../basics/maxcdn.jsp" />
    <jsp:include page="./../basics/nav.jsp" />
    <link rel="stylesheet" href="./../css/search.css">
    <title>Search Auctions</title>
</head>

<body>

<div class="container">
    <div class="panel panel-default">
        <div class="panel-heading">
            <h2>Search auctions</h2>
        </div>
        <form method="post" action="/BBservlet?action=searchres">
        <div class="panel-body">
            <div class="row">
                <div class="col-md-6">
                    <div class="form-horizontal">
                        <div class="input-group">
                            <div class="ddl-select input-group-btn">

                                <select id="ddlsearch" class="btn btn-default dropdown-toggle" type="button" data-toggle="dropdown">
                                  <div class="dropdown-menu">
                                    <option value="" data-hidden="true" class="ddl-title">SEARCH</option>
                                    <option value="Popular">Popular</option>
                                    <option value="Recommended fo you">Recommended for you</option>
                                    <div class="dropdown-divider"><hr></div>
                                      <optgroup label="Category">
                                          <option value="Art">Art</option>
                                          <option value="Books">Books</option>
                                          <option value="ComputernTablets">Computer & Tablets</option>
                                          <option value="Electronics">Electronics</option>
                                          <option value="Fashion">Fashion</option>
                                          <option value="Gadgets">Gadgets</option>
                                          <option value="HomenGarden">Home& Garden</option>
                                          <option value="JewelrynWatches">Jewelry & Watches</option>
                                          <option value="Sports">Sports</option>
                                          <option value="VideoGames">VideoGames</option>
                                          <option value="EverythingElse">Everything Else</option>
                                      </optgroup>
                                  </div>

                                </select>
                            </div>
                            <input id="txtkey" type="text" class="form-control" placeholder="Enter a term" aria-describedby="ddlsearch">
                            <span class="input-group-btn">
                <button id="btn-search" class="btn btn-info" type="submit"><span class="glyphicon glyphicon-search"></span> </button>
              </span>
                        </div>
                    </div>
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
