
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link rel="stylesheet" type="text/css" href="./../css/signup.css" />

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<html>
<head>
    <title>Signup</title>



</head>
<body>

<script type="text/javascript">

//    function checkuser(val){
////        $(this).next().stop(true, true).fadeIn(0).html('[input event fired!]: ' + $(this).val()).fadeOut(2000);
//        var xhr = new XMLHttpRequest();
//        xhr.open('GET', 'BBServlet?action=signup', true);
//        $.get('./../welcome/executecheck.jsp');
//        alert("The input value has changed. The new value is: " + val);
//    }


</script>


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
                        <div class="field-wrap">
                            <label >
                               User Name<span class="req">*</span>
                            </label>

                            <input type="text"  class="username" name ="username"  required autocomplete="off" /><span class="status"></span>

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
                    <input type="email" class="email" name = "email" required autocomplete="off"/><span class="status2"></span>
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