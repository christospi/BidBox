<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/index.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <link href="https://fonts.googleapis.com/css?family=Dosis" rel="stylesheet">
    <title>BidBox | Bid&Buy</title>

</head>
<body>

<nav class="navbar navbar-default">
    <div class="container-fluid">

        <div id="triangle-topleft">
        <img  class="penguin" src="img/peng.png" height="130" width="285" ></div>

    </div>
</nav>
<center><h1><b>Welcome to BidBox - The best auction site !</b></h1></center>


    <div class="container">
        <div class="login-container">
            <div id="output"></div>
            <div class="avatar"></div>
            <div class="form-box">
                <form method="post" action="BBservlet?action=login">
                    <input name="Username" type="text" placeholder="username" required>
                    <input type="password" name="Password" placeholder="password" required>
                    <button class="btn btn-info btn-block login" type="submit">Login</button>
                    <%--<input type="submit" value="Login" />--%>
                    <p>or <a href="welcome/signup.jsp" >Register here</a></p>
                </form>
            </div>
        </div>

    </div>

<%--<div class="navbar navbar-fixed-bottom" ></div>--%>
<footer class="footer">
    <div class="container">
        <p class="developers"> © Developed by <b>C&K</b></p>
    </div>
</footer>
</body>
</html>