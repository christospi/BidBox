<%@page import="Javabeans.User"%>

<%@page import="Javabeans.Photo"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Add photo</title>
        <% User user2 = (User) request.getSession().getAttribute("user");%>
</head>
<body>
<h3>Upload a photo <%out.println(user2.username);%> :</h3>
<form method="post" action="./../BBservlet?action=upload&owner=<%=user2.username%>" enctype="multipart/form-data">
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
