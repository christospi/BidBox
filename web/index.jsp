<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
 <script src="js/header.js"></script>
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
            </div>
        </div>

    </div>

<script src="js/footer.js"></script>

</body>
</html>