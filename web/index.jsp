<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <jsp:include page="/basics/header.jsp" />
</head>
<body>


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
                <hr>
                <h4>Wanna take a sneak peek ?</h4>
                <form method="post" action="">
                    <button type="button" class="btn btn-warning">Continue as Visitor</button>
                </form>
            </div>
        </div>


    </div>

<jsp:include page="/basics/footer.jsp" />

</body>
</html>