<%@ page import="Javabeans.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
<% User user2 = (User) request.getSession().getAttribute("user");%>
    <title>Send a message</title>
</head>
<body>
<div class="form-box2">
    <form  action="./../BBservlet?action=send_msgf" method="post" >
        <label>
            Sender : <input type="text" readonly name="user" value="<%=user2.username%>">
        </label>
        <label>
            Receiver : <input type="text"  name="receiver" >
        </label>
        <label>
            Item : <input type="text"  name="itemID" >
        </label>
        <div class="ddl-select input-group-btn">

            <select id="ddlsearch" class="btn btn-default dropdown-toggle" type="button" data-toggle="dropdown">
                <div class="dropdown-menu">
                    <option value="" data-hidden="true" class="ddl-title">Receivers</option>
                    <option value="Popular">Popular</option>
                    <option value="Recommended fo you">Recommended for you</option>
                    <div class="dropdown-divider"><hr></div>
                    <optgroup label="Category">
                        <option value="Art">Art</option>
                        <option value="Books">Books</option>
                        <option value="ComputernTablets">Computer & Tablets</option>
                        <option value="Electronics">Electronics</option>
                        <option value="Fashion">Fashion</option>
                        <option value="Gadgets">Gadgets</option>
                        <option value="HomenGarden">Home& Garden</option>
                        <option value="JewelrynWatches">Jewelry & Watches</option>
                        <option value="Sports">Sports</option>
                        <option value="VideoGames">VideoGames</option>
                        <option value="EverythingElse">Everything Else</option>
                    </optgroup>
                </div>

            </select>
        </div>
        <textarea name="message" rows="10" cols="100">

        </textarea>
        <label><button class="btn btn-info btn-block login" type="submit" >Send message </button></label>
    </form>
</div>

</body>
</html>
