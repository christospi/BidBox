
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link rel="stylesheet" type="text/css" href="./../css/signup.css" />

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<html>
<head>
    <jsp:include page="/basics/maxcdn.jsp" />
    <jsp:include page="/basics/register.jsp" />
<% int id=-1;
    String seller=null;
    if ( request.getParameter("auctionid")!=null && !request.getParameter("auctionid").isEmpty() && request.getParameter("seller")!=null && !request.getParameter("seller").isEmpty()){
     id = Integer.parseInt(request.getParameter("auctionid"));
     seller = request.getParameter("seller");

}else{
   id=-1;
}%>
    <script type="text/javascript" src="jquery.js"></script>
    <script type="text/javascript">
        $(document).ready(function()
        {
            $(".username").change(function()
            {
                var username = $(this).val();
                if(username.length > 3)
                {
                    $(".status").html("Checking availability...");
                    $.ajax
                    ({
                        type: "POST",
                        url: "./../BBservlet?action=check_username",
                        data: "username="+ username,
                        success: function(response)
                        {$(".status").html(response);
                            //
                        }
                    });
                }

                else
                {
                    $(".status").html("");
                }

            });
        });

    </script>
    <script type="text/javascript">
        $(document).ready(function()
        {
            $(".email").change(function()
            {
                var email = $(this).val();
                if(email.length > 3) {
                    $(".status2").html("Checking availability...");
                    $.ajax
                    ({
                        type: "POST",
                        url: "./../BBservlet?action=check_email",
                        data: "email=" + email,
                        success: function (response) {
                            $(".status2").html(response);
                            //
                        }
                    });

                }else{
                    $(".status2").html("");
                }


            });
        });

    </script>



</head>
<body>

<center><b><h1>Sign Up for Free</h1> </b> </center>

<div class="container">
    <div class="login-container2">
        <div class="form-box2">

                    <form  action="./../BBservlet?action=signup" method="post" >

                        <div id="new_auctionform">
                                <label>
                                    First Name:<input type="text" name ="name" required autocomplete="off" >
                                </label>
                                    <label >
                                       User Name<input type="text"  class="username" name ="username"  required autocomplete="off" ><span class="status"></span>
                                    </label>


                                <label>
                                    Last Name:
                                    <input type="text" name="surname" required autocomplete="off">
                                </label>

                            <label>
                                Email Address:<input type="email" class="email" name = "email" required autocomplete="off"><span class="status2"></span>
                            </label>

                            <label>
                                Set A Password: <input type="password" id="password" name="pass" pattern="^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?!.*\s).{6,}" title="You have to use six or more characters,uppercase and lowercase letters and numbers." required autocomplete="off">
                            </label>

                            <label>
                                   Confirm Password:   <input type="password"  id="confirm_password" required autocomplete="off">
                            </label>
                            <script type="text/javascript">
                                var password = document.getElementById("password")
                                        , confirm_password = document.getElementById("confirm_password");

                                function validatePassword(){
                                    if(password.value != confirm_password.value) {
                                        confirm_password.setCustomValidity("Passwords don't match");
                                    } else {
                                        confirm_password.setCustomValidity('');
                                    }
                                }

                                password.onchange = validatePassword;
                                confirm_password.onkeyup = validatePassword;
                            </script>


                            <label>
                                Phone:    <input type="text" name="phone" required autocomplete="off">
                            </label>



                            <label>
                                AFM:  <input type="text" name="afm" required autocomplete="off">
                            </label>



                            <label>
                               City:  <input type="text" name="city" required autocomplete="off">
                            </label>



                            <label>
                                Address:  <input type="text" name="address" required autocomplete="off"/>
                            </label>




                            <label>Type of registration:


                                <select name="roles">
                                    <option  value="bidder">Bidder</option>
                                    <option  value ="seller">Seller</option>
                                    <option  value ="combo"> Both </option>

                                </select>

                            </label>

                            <label><button class="btn btn-success btn-block login" type="submit" >Sign up </button></label>
                        </div>
                    </form>
        </div>


    </div>
</div>
<jsp:include page="/basics/footer.jsp" />
</body>
</html>