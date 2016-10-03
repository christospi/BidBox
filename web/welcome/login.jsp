<%@ page import="Javabeans.User" %>
<%@ page import="java.lang.reflect.Array" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="Javabeans.Category" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%User user = (User) request.getSession().getAttribute("user");
    ArrayList<Category> cList = (ArrayList<Category>) request.getSession().getAttribute("cList");
    %>
    <jsp:include page="./../basics/user_header.jsp"/>
</head>
<body>
<div class="container">
    <h2><b><center>Welcome back <%=user.username%></center></b></h2>
    <h4><b><center><a href="/BBservlet?action=recommendations&seller=<%=user.userID%>">here's your recommendations... </a></center></b></h4>
    <hr>
    <div class="row">
        <div class="col-sm-5">
            <div class="panel-group">
                <div class="panel panel-default">
                      <div class="panel-heading"><center><h5><b>Give us a keyword and we'll do the rest:</b></h5></center></div>
                        <div class="panel-body">
                            <div class="col-xs-10 col-xs-offset-1">
                                <div class="fast-search">
                                    <form method="post" action="/BBservlet?action=searchres&seller=<%=user.username%>&choice=any">
                                    <div class="input-group ">
                                        <input type="text" class="form-control " placeholder="Search" name="keywords" >
                                        <div class="input-group-btn">

                                            <button class="btn btn-default  " type="submit"><i class="glyphicon glyphicon-search"></i> </button>

                                        </div>

                                    </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                </div>
            </div>
        </div>
        <div class="col-sm-2">
            <center><p style="font-size:60px;"><b>or</b></p></center>

        </div>
        <div class="col-sm-5">
            <div class="panel panel-default">
                <div class="panel-heading"><center><h5><b>Browse by Category:</b> </h5></center></div>
                <div class="panel-body">
                    <form method="post" action="/BBservlet?action=searchres&seller=<%=user.username%>">
                        <select name = "choice" id="ddlsearch" class="btn btn-default dropdown-toggle" type="button" data-toggle="dropdown" required>
                            <div class="dropdown-menu">
                                <option selected value="" data-hidden="true" class="ddl-title" disabled>Choose Category: </option>
                                <option value="any" >Any</option>
                                <div class="dropdown-divider"><hr></div>
                                <optgroup label="Category">
                                    <%for (int i=0; i<cList.size(); i++)  {
                                        Category a = new Category();
                                        a = cList.get(i); %>
                                    <option value="<%=a.catID%>"><%=a.name%></option>
                                    <%}%>
                                </optgroup>
                            </div>
                        </select>

                        <button  class="btn btn-info pull-right" type="submit"><span class="glyphicon glyphicon-search"></span> Search </button>

                    </form>
                </div>


            </div>
        </div>
    </div>
</div>
<center><h3>Browse by most popular categories:</h3></center><br>
    <div class="container">
        <div class="row">
            <a href="/BBservlet?action=searchres&seller=<%=user.username%>&choice=6">
            <div class="col-sm-4">
                <div class="panel panel-primary">
                    <div class="panel-heading">Collectibles</div>
                    <center><div class="panel-body"><img src="./../img/collectibles.jpg" class="img-responsive" style="max-width:220px; max-height:220px;" alt="Image"></div></center>

                </div>
            </div>
            </a>
            <a href="/BBservlet?action=searchres&seller=<%=user.username%>&choice=8">
            <div class="col-sm-4">
                <div class="panel panel-danger">
                    <div class="panel-heading">Decorative & Holiday</div>
                   <center><div class="panel-body"><img src="./../img/decorative.png" class="img-responsive" alt="Image" style="max-width:220px; max-height:220px;"></div></center>

                </div>
            </div>
            </a>
            <a href="/BBservlet?action=searchres&seller=<%=user.username%>&choice=63">
            <div class="col-sm-4">
                <div class="panel panel-success">
                    <div class="panel-heading">Comics</div>
                    <center><div class="panel-body"><img src="./../img/comics.jpeg" class="img-responsive" alt="Image" style="max-width:220px; max-height:220px;"></div></center>

                </div>
            </div>
            </a>
        </div>

    </div><br>

    <div class="container">
        <div class="row">
            <a href="/BBservlet?action=searchres&seller=<%=user.username%>&choice=58">
            <div class="col-sm-4">
                <div class="panel panel-primary">
                    <div class="panel-heading">Housewares & Kitchenware</div>
                    <center><div class="panel-body"><img src="./../img/houseware.jpg" class="img-responsive" alt="Image" style="max-width:220px; max-height:220px;"></div></center>

                </div>
            </div>
            </a>
            <a href="/BBservlet?action=searchres&seller=<%=user.username%>&choice=62">
            <div class="col-sm-4">
                <div class="panel panel-danger">
                    <div class="panel-heading">Pop  Culture</div>
                    <center><div class="panel-body"><img src="./../img/pop.jpg" class="img-responsive" alt="Image" style="max-width:220px; max-height:220px;"></div></center>

                </div>
            </div>
            </a>
            <a href="/BBservlet?action=searchres&seller=<%=user.username%>&choice=89">
            <div class="col-sm-4">
                <div class="panel panel-success">
                    <div class="panel-heading">Superhero</div>
                    <center><div class="panel-body"><img src="./../img/superhero.jpg" class="img-responsive" alt="Image" style="max-width:220px; max-height:220px;"></div></center>

                </div>
            </div>
            </a>
        </div>
    </div><br>
    <div class="container">
        <div class="row">
            <div class="col-sm-12">

            </div>
        </div>
    </div>
</body>
<jsp:include page="./../basics/footer.jsp"/>
</html>
