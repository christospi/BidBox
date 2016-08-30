<%@ page import="Javabeans.Auction" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="Javabeans.Photo" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Auctions</title>
</head>
<body>
<h3>Auction Info</h3>
<% ArrayList<Auction> aList = (ArrayList<Auction>) request.getSession().getAttribute("aList");
    ArrayList<Photo> pList = (ArrayList<Photo>) request.getSession().getAttribute("pList");%>

<% String pointer = (String) request.getSession().getAttribute("pointer");
    int point = Integer.parseInt(pointer);%>

<table class="forms" cellpadding="2" border="2">
    <tr class="def">
        <td>Owner Name:</td>
        <td>Item name:</td>
        <td>Country:</td>
        <td>City:</td>
        <td>Current bid:</td>
        <td>Category:</td>
        <td>End of auction : </td>
        <td>Description: </td>

    </tr>

    <% Auction x = new Auction();
        x = aList.get(point); %>
    <tr>
        <td><%=x.seller%></td>
        <td><%=x.name%></td>
        <td><%=x.country%></td>
        <td><%=x.city%></td>
        <td><%=x.curr%></td>
        <td><%=x.cat%></td>
        <td><%=x.end%></td>
        <td><%=x.description%></td>

    </tr>
</table>
<br>
<a href="./BBservlet?action=viewphoto&id=<%=x.id%>&seller=<%=x.seller%>%>">See photos for this item</a><br>


<h3>Upload a photo :</h3>
<form method="post" action="./../BBservlet?action=upload&seller=<%=x.seller%>&id=<%=x.id%>" enctype="multipart/form-data">
    <table border="0" class="forms">
        <tr>
            <td>Upload Photo: </td>
            <td><input type="file" name="photo_file" accept="image/gif, image/jpeg, image/png" size="50"/></td>
        </tr>
        <tr>
            <td colspan="2">
                <input type="submit" value="Upload" id="send2">
            </td>
        </tr>
    </table>
</form>
</body>
</html>
