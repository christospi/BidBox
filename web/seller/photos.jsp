<%@page import="javax.imageio.ImageIO"%>
<%@page import="java.awt.image.BufferedImage"%>
<%@page import="java.io.ByteArrayInputStream"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Blob"%>
<%@ page import="Javabeans.User" %>
<%@ page import="Javabeans.Photo" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Photos</title>
</head>
<body>
<% User user2 = (User) request.getSession().getAttribute("user");%>
<% String pointer = (String) request.getSession().getAttribute("id");
    int pi = Integer.parseInt(pointer);
    ArrayList<Photo> pList = (ArrayList<Photo>) request.getSession().getAttribute("pList");%>

<br><br><br>

<%for (int i=0;i<pList.size();i++) {
    Photo pb = new Photo();
    pb = pList.get(i);

    if (pb.itemID == pi) { %>

<img src="./BBservlet?action=viewphoto2&pic_name=<%=pb.pic_name%>" width="500" height ="500"  border="1">
<br>
<%}
}%>
<p>grgrighoruehgo</p>
<br>
</body>
</html>
