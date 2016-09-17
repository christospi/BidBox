<%@page import="Javabeans.User"%>

<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="Javabeans.Auction" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="/basics/maxcdn.jsp" />
    <jsp:include page="/basics/add_auct.jsp" />
    <title>Edit Auction</title>
    <style>
        html, body {
            height: 100%;
            margin: 0;
            padding: 0;
        }
        #map {
            height:344px;
            width:803px;

        }

    </style>
</head>
<center>

    <script>
        function removeT() {
            var s = $("#end").val();
            var end = new Date(s.replace(/-/g, '/').replace('T', ' '));
            document.getElementById("end").value = end;
            window.alert(end);
        }
    </script>

    <%
        User user2 = (User) request.getSession().getAttribute("user");
        Auction auction = (Auction)request.getAttribute("auction");

        DateFormat dateFormat = new SimpleDateFormat("dd/MM/YYYY HH:mm:ss");
        Date date = new Date();
        String st = dateFormat.format(date);%>
    <center></center><h2>Edit your Auction:</h2></center>
<div class="container">
    <div class="login-container2">
        <div id="output"></div>
        <div class="form-box2">
            <form  action="./../BBservlet?action=do_edit_auction&itemid=<%=auction.id%>" method="post" >
                <div id="new_auctionform">
                    <label>
                        Seller : <input type="text" readonly name="seller" value="<%=user2.username%> ">
                    </label>
                    <label>
                        Item name:  <input type="text" name="name" value="<%=auction.name%>" >
                    </label>
                    <label>
                        Category :
                        <select name="category">
                            <option selected><%=auction.cat%></option>
                            <option  value ="art"> Art </option>
                            <option  value ="books"> Books </option>
                            <option  value ="computers"> Computers & Tablets </option>
                            <option  value="electronics">Electronics</option>
                            <option  value ="fashion">Fashion</option>
                            <option  value ="gadgets"> Gadgets </option>
                            <option  value ="home"> Home & Garden </option>
                            <option  value ="jewelry"> Jewelry & Watches </option>
                            <option  value ="sports"> Sports </option>
                            <option  value ="videogame"> Video Games </option>
                            <option  value ="else"> Everything Else </option>
                        </select>
                    </label>

                    <label>Country: <input type="text" id = "country" name="country" value="<%=auction.country%>"></label>
                    <label>City: <input type="text" id="city" name="city" value="<%=auction.city%>"></label>
                    <label>Latitude: <input type="text" id="latitude" name="latitude" value="<%=auction.lat%>"></label>
                    <label>Longtitude: <input type="text" id="longtitude" name="longtitude" value="<%=auction.longt%>"></label>
                    <label>Starting Price: <input type="number" step="any" name="first_bid" value="<%=auction.first_bid%>"></label>
                    <label>Maximum Price: <input type="number" step="any" name="buy_price" value="<%=auction.buy_pr%>"></label>
                    <label>Bids starting date: <input type="text" readonly name="st" value="<%=st%>"></label>
                    <label>Bids ending date: <input type="datetime-local" id="end"  name="end" placeholder=" Ending Date " ></label>

                    <label>Item description : <textarea name="description" rows="4" cols="120 "maxlength="120"><%=auction.description%></textarea></label>
                    <label><button class="btn btn-info btn-block login" type="submit" >Submit Changes</button></label>
                </div>
            </form>
        </div>
    </div>
</div>


<jsp:include page="/basics/footer.jsp" />
</body>
</html>
