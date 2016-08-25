
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link rel="stylesheet" type="text/css" href="./../css/signup.css" />
<html>
<head>
    <title>Signup</title>



</head>
<body>



<div class="form">
    <div class="tab-content">
        <div id="signup">
            <h1>Sign Up for Free</h1>

            <form  action="./../BBservlet?action=signup" method="post" >


                    <div class="field-wrap">
                        <label>
                            First Name<span class="req">*</span>
                        </label>
                        <input type="text" name ="name" required autocomplete="off" />
                    </div>
                <%--<script type="text/javascript" src="jquery.js"></script>--%>
                <%--<script type="text/javascript">--%>
                    <%--$(document).ready(function()--%>
                    <%--{--%>
                        <%--$(".uname").change(function()--%>
                        <%--{--%>
                            <%--var uname = $(this).val();--%>
                            <%--if(uname.length > 3)--%>
                            <%--{--%>
                                <%--$(".status").html("Checking availability...");--%>
                                <%--$.ajax--%>
                                <%--({--%>
                                    <%--type: "POST",--%>
                                    <%--url: "BBservlet",--%>
                                    <%--data: "uname="+ uname,--%>
                                    <%--success: function(msg)--%>
                                    <%--{--%>
                                        <%--$(".status").ajaxComplete(function(event, request, settings)--%>
                                        <%--{--%>
                                            <%--$(".status").html(msg);--%>
                                        <%--});--%>
                                    <%--}--%>
                                <%--});--%>
                            <%--}--%>

                            <%--else--%>
                            <%--{--%>
                                <%--$(".status").html("username should be 3 chars");--%>
                            <%--}--%>

                        <%--});--%>
                    <%--});--%>

                <%--</script>--%>
                        <div class="field-wrap">
                            <label>
                               user Name<span class="req">*</span>
                            </label>
                            <input type="text" class="uname" name ="username" required autocomplete="off" /><span class="status"></span>
                        </div>
                    <div class="field-wrap">
                        <label>
                            Last Name<span class="req">*</span>
                        </label>
                        <input type="text" name="surname" required autocomplete="off"/>
                    </div>


                <div class="field-wrap">
                    <label>
                        Email Address<span class="req">*</span>
                    </label>
                    <input type="email" name = "email" required autocomplete="off"/>
                </div>

                <div class="field-wrap">
                    <label>
                        Set A Password<span class="req">*</span>
                    </label>
                    <input type="password" id="password" name="pass" pattern="^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?!.*\s).{6,}" title="You have to use six or more characters,uppercase and lowercase letters and numbers." required autocomplete="off"/>
                </div>

                <div class="field-wrap">
                    <label>
                           Confirm Password<span class="req">*</span>
                    </label>
                    <input type="password"  id="confirm_password" required autocomplete="off"/>
                </div>
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

                    <div class="field-wrap">
                    <label>
                        phone<span class="req">*</span>
                    </label>
                    <input type="text" name="phone" required autocomplete="off"/>
                </div>
                <div class="field-wrap">
                    <label>
                        afm<span class="req">*</span>
                    </label>
                    <input type="text" name="afm" required autocomplete="off"/>
                </div>
                <div class="field-wrap">
                    <label>
                       city<span class="req">*</span>
                    </label>
                    <input type="text" name="city" required autocomplete="off"/>
                </div>
                <div class="field-wrap">
                    <label>
                        address<span class="req">*</span>
                    </label>
                    <input type="text" name="address" required autocomplete="off"/>
                </div>

                <div class="field-wrap">
                    <label>Type of registration: </label>


                        <select name="roles">
                            <option  value="bidder">Bidder</option>
                            <option  value ="seller">Seller</option>
                            <option  value ="combo"> Both </option>

                        </select>


                </div>
                    <br><input type="submit" value="register">
            </form>
        </div><!-- tab-content -->
    </div> <!-- /form -->
</div>

</body>
</html>