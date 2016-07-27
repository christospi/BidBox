
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link rel="stylesheet" type="text/css" href="./../css/signup.css" />
<html>
<head>
    <title>Signup</title>

    <script type="text/javascript">
        function checkForm(form) {

            if (form.FirstName.value === "") {
                alert("Firstname cannot be blank!");
                form.FirstName.focus();
                return false;
            }
            if (form.LastName.value === "") {
                alert("Lastname cannot be blank!");
                form.LastName.focus();
                return false;
            }
            if (form.UserName.value === "") {
                alert("Username cannot be blank!");
                form.UserName.focus();
                return false;
            }
            re = /^\w+$/;
            if (!re.test(form.UserName.value)) {
                alert("Username must contain only letters, numbers and underscores!");
                form.UserName.focus();
                return false;
            }
            if (form.Password.value !== "") {
                if (form.Password.value.length < 4) {
                    alert("Error: Password must contain at least four characters!");
                    form.Password.focus();
                    return false;
                }
                if (form.Password.value === form.UserName.value) {
                    alert("Password must be different from Username!");
                    form.Password.focus();
                    return false;
                }
                re = /[0-9]/;
                if (!re.test(form.Password.value)) {
                    alert("Password must contain at least one number (0-9)!");
                    form.Password.focus();
                    return false;
                }
                re = /[a-z]/;
                if (!re.test(form.Password.value)) {
                    alert("Password must contain at least one lowercase letter (a-z)!");
                    form.Password.focus();
                    return false;
                }
                re = /[A-Z]/;
                if (!re.test(form.Password.value)) {
                    alert("Password must contain at least one uppercase letter (A-Z)!");
                    form.Password.focus();
                    return false;
                }
            } else {
                alert("Please check that you've entered and confirmed your password!");
                form.Password.focus();
                return false;
            }

            if( form.Password.value !== form.RPassword.value) {
                alert("Please enter the same password as above!");
                form.RPassword.focus();
                return false;
            }

            var checked=false;
            var elements = document.getElementsByName("roles");

            for(var i=0; i < elements.length; i++){
                if(elements[i].checked) {
                    checked = true;
                }
            }

            if (!checked) {
                alert("You have to choose at least one role!");
                return false;
            }

            //alert("You entered a valid password: " + form.Password.value);
            return true;
        }
    </script>

</head>
<body>



<div class="form">
    <div class="tab-content">
        <div id="signup">
            <h1>Sign Up for Free</h1>

            <form  action="BBservlet?action=signup" method="post" >

                <div class="top-row">
                    <div class="field-wrap">
                        <label>
                            First Name<span class="req">*</span>
                        </label>
                        <input type="text" name ="name" required autocomplete="off" />
                    </div>
                    <div class="top-row">
                        <div class="field-wrap">
                            <label>
                               user Name<span class="req">*</span>
                            </label>
                            <input type="text" name ="username" required autocomplete="off" />
                        </div>
                    <div class="field-wrap">
                        <label>
                            Last Name<span class="req">*</span>
                        </label>
                        <input type="text" name="surname" required autocomplete="off"/>
                    </div>
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
                    <input type="password" name="pass" required autocomplete="off"/>
                </div>
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
                    <label>
                        verified<span class="req">*</span>
                    </label>
                    <input type="text" name="verified" required autocomplete="off"/>
                </div>
                    <br><input type="submit" value="register">
            </form>
        </div><!-- tab-content -->
    </div> <!-- /form -->
</div>

</body>
</html>