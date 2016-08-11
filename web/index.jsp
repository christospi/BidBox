<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>BidBox</title>
</head>
<body>
<center><h1>Welcome to BidBox - The best auction site !</h1></center>
<form method="post" action="BBservlet?action=login">
    <center>
        <table border="1" width="30%" cellpadding="3">
            <thead>
            <tr>
                <th colspan="2">Login Here</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>User Name</td>
                <td><input type="text" name="Username"/></td>
            </tr>
            <tr>
                <td>Password</td>
                <td><input type="password" name="Password"/></td>
            </tr>
            <tr>
                <td><input type="submit" value="Login" /></td>
                <td><input type="reset" value="Reset" /></td>
            </tr>
            <tr>
                <td colspan="2">Yet Not Registered!! <a href="welcome/signup.jsp">Register Here</a></td>
            </tr>
            </tbody>
        </table>
    </center>
</form>
</body>
</html>