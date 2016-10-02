
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="/basics/admin_header.jsp"/>

    <link rel="stylesheet" href="./../css/itemlist.css">
    <title>Import Auctions</title>
</head>
<body>
<%String [] filenames = (String[])  request.getSession().getAttribute("filenames");%>
<div class="panel panel-info">
    <div class="panel-heading"><h3>Import XML File </h3></div>
    <div class="panel-body">
        <form method="post" action="./../BBservlet?action=unmarshall" enctype="multipart/form-data">
            <table border="0" class="forms">
                <%for(int i=0;i<filenames.length;i++){

               %>
                <tr>
                <td><input  name="item_option" class="item_option" value="<%=filenames[i]%>"  type="radio"></td>
                <td><img src="./../img/xml.png"  height="42" width="42"> <%=filenames[i]%></td>

                </tr>

                <%}%>

                <tr>
                    <td colspan="2">
                        <center>
                            <br>
                            <button type="submit" class="btn btn-info"  id="send_xml"> Import </button></center>
                    </td>
                </tr>

            </table>
        </form>
    </div>
</div>
</body>
</html>
