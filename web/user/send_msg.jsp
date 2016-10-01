<%@ page import="Javabeans.User" %>
<%@ page import="Javabeans.Auction" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head></head>
<button type="button" class="btn btn-danger"  role="button" data-toggle="modal" data-target="#myModal"><i class="glyphicon glyphicon-edit"></i> Compose</button>

<!-- Modal -->
<div class="modal fade" id="myModal" role="dialog">
    <div class="modal-admin">

        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">Send Message</h4>
            </div>
            <div class="modal-body">
                <center>
                    <%  User user2 = (User) request.getSession().getAttribute("user");
                        ArrayList<Auction> aList = Auction.Auctionlist(user2.username);
                        ArrayList<Auction> bList = Auction.Auctionlist("*");
                        ArrayList<String> receivers = new ArrayList<String>();
                        ArrayList<String> item = new ArrayList<String>();
                        ArrayList<String> itemid = new ArrayList<String>();
                        ArrayList<String> bidded = new ArrayList<String>();
                        ArrayList<String> itemb = new ArrayList<String>();
                        ArrayList<String> itembid = new ArrayList<String>();
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

                        for (int i = 0; i < bList.size(); i++) {
                            Auction b = new Auction();
                            b = bList.get(i);
                            if (b.buyerID == user2.userID) {
                                if (itemb.contains(b.name)) {
                                } else {
                                    String str = String.valueOf(b.id);
                                    bidded.add(b.seller);
                                    itemb.add(b.name);
                                    itembid.add(str);
                                }
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

                    <form class="form-inline pull-left" action="./../BBservlet?action=send_msgf" method="post" >

                        <div class="form-group ">

                                <label >Sender: </label>
                                <input class="form-control"  type="text" readonly name="user" value="<%=user2.username%>">

                           </div>
                        <div class="form-group">

                            <label>Receiver: </label>
                            <input class="form-control" id="receiver" type="text" name="receiver" >

                        </div>
                        <div class="form-group">

                            <label >Item: </label>
                            <input class="form-control" name="itemID" id="itemID" type="text" name="itemID">

                        </div>

                        <br>
                        <br>
                        <select class="form-control " onchange="takeid(this.value)" required>
                            <option value="">Choose a receiver:</option>
                            <optgroup label="Buyers"></optgroup>
                            <%--<optgroup value="" data-hidden="true" class="ddl-title" label="Receivers">--%>

                            <%   for (int i=0; i<receivers.size(); i++) {
                                String strings = receivers.get(i);
                                String itemname = item.get(i);
                                String id = itemid.get(i);

                            %><option value="<%=id%>:<%=strings%>"   ><%out.println(strings);%> | <%out.println(itemname);%> </option><%
                            }%>
                            <optgroup label="My Bids"></optgroup>
                            <%   for (int i=0; i<bidded.size(); i++) {
                                String strings = bidded.get(i);
                                String itemname = itemb.get(i);
                                String id = itembid.get(i);

                            %><option value="<%=id%>:<%=strings%>"   ><%out.println(strings);%> | <%out.println(itemname);%> </option><%
                            }%>


                        </select>
                        <br>
                        <br>
                        <div class="form-group">
                        <textarea class="form-control" name="message" rows="10" cols="100"></textarea>
                        </div>

                        <br>
                        <br>
                        <label><button class="btn btn-info btn-block login" type="submit" >Send message </button></label>
                    </form>
                    <div class="form-group"> <br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
                       <br><br></div>
                    <%--<jsp:include page="/user/send_msg.jsp" />--%>
                </center>
            </div>
            <div class="modal-footer ">
                <button type="button" class="btn btn-default  " data-dismiss="modal">Close</button>
            </div>
        </div>

    </div>
</div>

</body>
</html>
