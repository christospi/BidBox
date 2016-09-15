<%@ page import="Javabeans.User" %>
<%@ page import="Javabeans.Auction" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
<% User user2 = (User) request.getSession().getAttribute("user");
    ArrayList<Auction> aList = Auction.Auctionlist(user2.username);
    ArrayList<String> receivers = new ArrayList<String>();
    ArrayList<String> item = new ArrayList<String>();
    ArrayList<String> itemid = new ArrayList<String>();
    for (int i=0; i<aList.size(); i++) {
        Auction a = new Auction();
        int pointer = i;
        a = aList.get(i);

        if(receivers.contains(a.buyerID) && item.contains(a.name) ){



        }else if (a.buyerID!=0){
            User user3 = User.getusername(a.buyerID);
            String str=String.valueOf(a.id);
            receivers.add(user3.username);
            item.add(a.name);
            itemid.add(str);

        }
    }



%>
<script>
    function takeid( str){
        var res0 = str.split(/:(.+)?/)[0].split();
        var res1 = str.split(/:(.+)?/)[1].split();
        document.getElementById("itemID").value = res0;
        document.getElementById("receiver").value = res1;

    }
</script>

    <title>Send a message</title>
</head>
<body>
<div class="form-box2">
    <form  action="./../BBservlet?action=send_msgf" method="post" >
        <label>
            Sender : <input type="text" readonly name="user" value="<%=user2.username%>">
        </label>
        <label>
            Receiver : <input type="text"  id="receiver" name="receiver" >
        </label>
        <label>
            Item : <input type="text"  name="itemID" id="itemID">
        </label>
        <div class="ddl-select input-group-btn">

            <select id="ddlsearch" class="btn btn-default dropdown-toggle" type="button" data-toggle="dropdown" onchange="takeid(this.value)">
                <div class="dropdown-menu">
                    <option value="" data-hidden="true" class="ddl-title">Receivers</option>
                    <%   for (int i=0; i<receivers.size(); i++) {
                        String strings = receivers.get(i);
                        String itemname = item.get(i);
                        String id = itemid.get(i);

                        %><option value="<%=id%>:<%=strings%>"   ><%out.println(strings);%> | <%out.println(itemname);%> </option><%
                    }%>

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
