package Servlets;

import Javabeans.*;
import xmlClasses.xmlAuction;
import xmlClasses.xmlAuctions;
import xmlClasses.xmlFunctions;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;
import javax.xml.bind.Unmarshaller;
import java.io.*;
import java.sql.*;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/BBservlet?action=upload")
@MultipartConfig(maxFileSize = 16177215)    // upload file's size up to 16MB

public class BBservlet extends HttpServlet {

    private DataBase db = new DataBase();


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(BBservlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (JAXBException e) {
            e.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            processRequest(request, response);

        } catch (SQLException ex) {
            Logger.getLogger(BBservlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (JAXBException e) {
            e.printStackTrace();
        }
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException, JAXBException {

        HttpSession session = request.getSession(true);
        response.setContentType("text/html;charset=UTF-8");
//        Timer timer = new Timer();
//        TimerTask myTask = new TimerTask() {
//            int i=0;
//            public void run() {
//               System.out.println("geia!");
//            }
//        };
//
//        timer.schedule(myTask, 2000, 2000);
        String action = request.getParameter("action");
        String page = request.getParameter("page");
        PrintWriter out = response.getWriter();

        if (action == null || action.equals("")) {

            switch (page){
                case "admin":
                    request.getRequestDispatcher("/user/admin.jsp").include(request, response);
                    break;
                case "userlist":
                    request.getRequestDispatcher("/admin/user_list.jsp").include(request, response);
                    break;
                case "userinfo":
                    request.getRequestDispatcher("/admin/user_info.jsp").include(request, response);
                    break;
                case "verify":
                    request.getRequestDispatcher("/admin/user_list.jsp").include(request, response);
                    break;
                case "userlogin":
                    request.getRequestDispatcher("/welcome/login.jsp").include(request, response);
                    break;
                case "addauction":
                    request.getRequestDispatcher("/seller/add_auction.jsp").include(request, response);
                    break;
                case "auctionlist":
                    request.getRequestDispatcher("/seller/auctionlist.jsp").include(request,response);
                    break;
                case "auctioninfo":
                    request.getRequestDispatcher("/seller/auctioninfo.jsp").include(request,response);
                    break;
                case "viewphoto":
                    request.getRequestDispatcher("/seller/photos.jsp").include(request,response);
                    break;
                case "log_out":
                    request.getRequestDispatcher("index.jsp").include(request,response);
                    break;
                case "msglist":
                    request.getRequestDispatcher("/user/messages.jsp").include(request,response);
                    break;
                case "searchres":
                    request.getRequestDispatcher("/welcome/search_res.jsp").include(request,response);
                    break;
                case "auction_search":
                    request.getRequestDispatcher("/welcome/search_info.jsp").include(request,response);
                    break;
                case "send_msg":
                    request.getRequestDispatcher("/user/send_msg.jsp").include(request,response);
                    break;
                case "profile":
                    request.getRequestDispatcher("/user/profile.jsp").include(request,response);
                    break;

            }

        }
        else if (action.equals("signup")) {   //SIGN UP

            String FirstName = request.getParameter("name");   //take all parameters from form
            String LastName = request.getParameter("surname");
            String UserName = request.getParameter("username");
            String Password = request.getParameter("pass");
            //String RPassword = request.getParameter("RPassword");
            String Email = request.getParameter("email");
            String Phone = request.getParameter("phone");
            String afm = request.getParameter("afm");
            String city = request.getParameter("city");
            String address = request.getParameter("address");
            String role = request.getParameter("roles");
            String query=null;
            db.openConn();

            String query3 = "SELECT COUNT(*) AS total FROM user where username='" + UserName + "'";   //check if username already exists
            ResultSet rs3 = db.executeQuery(query3);
            int exists = 0;
            int exists2 = 0;

            while (rs3.next()) {
                if (rs3.getInt("total") > 0 ) {
                    exists = 1;
                    out.println("<font color=red><b>"+UserName+"</b> is already in use</font>");
                    request.getRequestDispatcher("/welcome/signup.jsp").include(request, response);
                }
            }


            String query4 = "SELECT COUNT(*) AS total FROM user where email='" + Email + "'";  //check if email already exists
            ResultSet rs4 = db.executeQuery(query4);

            while (rs4.next()) {
                if (rs4.getInt("total") > 0 ) {
                    exists2 = 1;
                }
            }

            if(exists == 0 && exists2 ==0 ) {   //user entered valid username and email

                query = "INSERT INTO user VALUES(0, '" + UserName + "',"
                        + "'" + Password + "',"
                        + "'" + FirstName + "',"
                        + "'" + LastName + "',"
                        + "'" + Email + "',"
                        + "'" + Phone+ "',"
                        + "'" + address + "',"
                        + "'" + city + "',"
                        + "'" + afm + "',"
                        + "'" + role + "',"
                        + "0,"
                        + "0,"
                        + "0)";

                System.out.println(query);
                System.out.println(query);

                db.executeUpdate(query);

                //String roles_in="";
                //String role[]=request.getParameterValues("roles");

//                for(int k=0;k<role.length;k++) {
//
//                    roles_in="";
//                    roles_in+=role[k];
//                    String query2 = "INSERT INTO roles VALUES (0, '"+roles_in+"', '"+UserName+"')";
//                    Integer j = db.executeUpdate(query2);
//                    //out.print(j);
//                    //out.print(db.getConn().getWarnings());
//
//                }

                 request.getRequestDispatcher("/welcome/success_signup.jsp").include(request, response);
            }
//            else {
//
//                if(exists == 1) {   //username exists
//                    request.getRequestDispatcher("/welcome/signup_user.jsp").include(request, response);
//                }
//                else if(exists2 == 1) { //email exists
//                    request.getRequestDispatcher("/welcome/signup_email.jsp").include(request, response);
//                }
//
//            }

            db.closeConnection();

        }
        else if (action.equals("login")) {    //LOGIN

            try {

                String username = request.getParameter("Username"); //get user and pass from form
                String password = request.getParameter("Password");
                String query = "select * from user where username='" + username + "' and pass='" + password + "'";

                db.openConn();

                ResultSet rs = db.executeQuery(query);

                if (rs.next()) {    //if user exists

                    User user = User.getUser(username);
                    session.setAttribute("user", user);

                    if (user.ver == 0) {    //if he isnt verified yet display this
                        request.getRequestDispatcher("/welcome/unverified.jsp").include(request, response);
                    }
                    else {  //else see his role and redirect him to the right page

                        if(Objects.equals(user.username, "admin")){
                            response.sendRedirect("/BBservlet?page=admin");
                        }
                        else{
                            response.sendRedirect("/BBservlet?page=userlogin");
                        }

                        /*
                        String []user2 = new String[user.roles.length];
                        for (int k=0;k<user.roles.length;k++) {
                            user2[k]=user.roles[k];
                            //System.out.println(user[k]);
                        }

                        if(user.hasRole(user2) == "Renter"){
                            response.sendRedirect("/DiEstate/DbServlet?page=render");
                        }
                        else if(user.hasRole(user2) == "Tenant"){
                            response.sendRedirect("/DiEstate/DbServlet?page=tenant");
                        }
                        else if(user.hasRole(user2) == "Visitor"){
                            response.sendRedirect("/DiEstate/DbServlet?page=visitor");
                        }
                        else if(user.hasRole(user2) == "Admin"){
                            response.sendRedirect("/DiEstate/DbServlet?page=admin");
                        }
                        else if(user.hasRole(user2) == "Combo"){
                            response.sendRedirect("/DiEstate/DbServlet?page=combo");
                        }
                        */
                    }

                }else { //if user and pass dont exist in db then..

//                    out.print("Invalid User: " + username + " " + password);
                    request.getRequestDispatcher("./welcome/login_fail.jsp").include(request, response);

                }

                db.closeConnection();

            } catch (SQLException ex) {
                Logger.getLogger(DataBase.class.getName()).log(Level.SEVERE, null, ex);
            }

        }
        else if (action.equals("userlist")) {   //USER LIST

            ArrayList<User> uList = User.doSelectAll(); //arraylist with all info fro all users in db
            session.setAttribute("uList", uList);

            response.sendRedirect("/BBservlet?page=userlist");
        }
        else if (action.equals("userinfo")) {   //USER INFO

            String pointer = request.getParameter("pointer");   //pointer, points arraylists position to have info only for this user
            session.setAttribute("pointer", pointer);
            response.sendRedirect("/BBservlet?page=userinfo");

        }
        else if (action.equals("verify")) { //VERIFY A USER

            String user_name = request.getParameter("user_name2");
            String query = "UPDATE user SET verified=1 WHERE username='"+user_name+"'";
            db.openConn();
            int rs = db.executeUpdate(query);
            db.closeConnection();

            ArrayList<User> uList = User.doSelectAll(); //arraylist with all info fro all users in db
            session.setAttribute("uList", uList);

            response.sendRedirect("/BBservlet?page=verify");

        }
        else if(action.equals("addpage")){
            ArrayList<Category> cList = Category.get_all_cat(); //arraylist with all info fro all users in db
            session.setAttribute("cList", cList);

            response.sendRedirect("/BBservlet?page=addauction");
        }
        else if (action.equals("addauction")) {

            String seller = request.getParameter("seller");
            String name = request.getParameter("name");

            String cats[] = request.getParameterValues("category");

            float latitude = Float.parseFloat(request.getParameter("latitude"));
            float longtitude = Float.parseFloat(request.getParameter("longtitude"));
            String country = request.getParameter("country");
            String city = request.getParameter("city");
           // float curr = Float.parseFloat(request.getParameter("curr"));
            float buy_pr = Float.parseFloat(request.getParameter("buy_price"));
            float first_bid = Float.parseFloat(request.getParameter("first_bid"));
            float curr;
            curr= first_bid;

            //int num_bid = Integer.parseInt(request.getParameter("num_bid"));
            int num_bid;
            num_bid=0;
            DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            Date date = new Date();
            String st = dateFormat.format(date);
            String end = request.getParameter("end");

            end = (end.replace("T"," "));
            String description = request.getParameter("description");

            db.openConn();

            String query = "INSERT INTO auction VALUES(0, '" + latitude + "',"
                    + "'" + longtitude + "',"
                    + "'" + seller + "',"
                    + "'" + name + "',"
                    + "'" + country + "',"
                    + "'" + city + "',"
                    + "'" + buy_pr + "',"
                    + "'" + first_bid + "',"
                    + "'" + curr + "',"
                    + "'" + num_bid + "',"
                    + "'" + st + "',"
                    + "'" + end + "',"
                    + "'" + description + "',"
                    + "'" + 0 + "',"
                    + "'" + 0 + "',"
                    + "'" + 0 + "') ";

            PreparedStatement prest;
            prest = db.getConn().prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
            prest.executeUpdate();
            ResultSet rs = prest.getGeneratedKeys();

            if(rs.next())
            {
                int last_inserted_id = rs.getInt(1);
                for(int i=0; i<cats.length; i++){
                    query = "INSERT INTO auction_has_cat VALUES(0, '" + last_inserted_id + "',"
                            + "'" + Integer.parseInt(cats[i]) + "') ";
                    db.executeUpdate(query);
                }
                request.getRequestDispatcher("/seller/success_add.jsp").include(request, response);
            }

//            Integer i = db.executeUpdate(query);
            //out.print(i);

//            if (i>0) {
//                request.getRequestDispatcher("/seller/success_add.jsp").include(request, response);
//            }
//            else {
//                request.getRequestDispatcher("/seller/fail_add.jsp").include(request, response);
//            }

            db.closeConnection();

        }
        else if (action.equals("upload")) { //UPLOAD A PHOTO

            String owner = request.getParameter("seller");
            //String imageName = null;
            int id = Integer.parseInt(request.getParameter("id"));
            InputStream inputStream = null; // input stream of the upload file

            // obtains the upload file part in this multipart request
            Part filePart = request.getPart("photo_file");
            String header = filePart.getHeader("content-disposition");
            String filename = header.substring(header.indexOf("filename=\"")).split("\"")[1];  //getting filename
            //System.out.println(filename +"!!!!!!!!!!!");

            if (filePart != null) {
               //  prints out some information for debugging
//                System.out.println(filePart.getName());
//                System.out.println(filePart.getSize());
//                System.out.println(filePart.getContentType());

                // obtains input stream of the upload file
                inputStream = filePart.getInputStream();
                //imageName = filePart.getName();
            }

            try {
                // connects to the database
                db.openConn();
                Connection conn = db.getConn();

                // constructs SQL statement
                String sql = "INSERT INTO photo (owner,pic,pic_name,itemID) values(?,?,?,?)";

                PreparedStatement statement = conn.prepareStatement(sql);
                statement.setString(1, owner);

                statement.setString(3, filename);
                statement.setInt(4, id);
                if (inputStream != null) {
                    // fetches input stream of the upload file for the blob column
                    statement.setBlob(2, inputStream);
                }

                // sends the statement to the database server
                int row = statement.executeUpdate();

                if (row>0) {
                    request.getRequestDispatcher("/seller/success_photo.jsp").include(request, response);
                }
                else {
                    request.getRequestDispatcher("/seller/failure_photo.jsp").include(request, response);
                }

            } finally {
                db.closeConnection();
            }

        }
        else if (action.equals("auctionlist")) { //ESTATE LIST

            String seller = request.getParameter("username");
            int page_num = Integer.parseInt(request.getParameter("page_num"));
//            ArrayList<Auction> aList = Auction.Auctionlist(seller);   //arraylist with all info for a user's estates
            int total=Auction.getnum(seller);
            session.setAttribute("page_num",page_num);
            session.setAttribute("total",total);
           String query ="SELECT * FROM auction WHERE seller='"+ seller +"' LIMIT " + (page_num-1) * 2 + ", " + 2 + "";
            ArrayList<Auction> aList= Auction.search_auction(query);
            session.setAttribute("aList",aList);


            response.sendRedirect("/BBservlet?page=auctionlist");
        }
        else if (action.equals("auctioninfo")) { //ESTATE INFO

            String pointer = request.getParameter("pointer");   //pointer, points arraylists position to have info only for this estate
            session.setAttribute("pointer", pointer);

            String seller = request.getParameter("seller");
            session.setAttribute("seller", seller);

            int itemID = Integer.parseInt(request.getParameter("itemID"));
            ArrayList<Category> cList = Category.get_its_cat(itemID);
            session.setAttribute("cList", cList);
            ArrayList<Photo> pList = Photo.pdoSelectAll(seller); //get all photos this users uploaded
            session.setAttribute("pList", pList);

//            ArrayList<MessageBean> mList = MessageBean.get_inbox(owner); //get all messages this user has recieved
//            session.setAttribute("mList", mList);

            response.sendRedirect("/BBservlet?page=auctioninfo");

        }
        else if (action.equals("viewphoto")) {   //SEE ESTATE'S PHOTOS

            String id = request.getParameter("id");
            session.setAttribute("id", id);
            String seller = request.getParameter("seller");
            ArrayList<Photo> pList = Photo.pdoSelectAll(seller);
            session.setAttribute("pList", pList);


            response.sendRedirect("/BBservlet?page=viewphoto");

        }
        else if (action.equals("viewphoto2")) {   //SEE ESTATE'S PHOTOS ON JSP

            String name = request.getParameter("pic_name");
            Connection con = null;
            Blob image = null;
            byte[ ] imgData = null ;
            Statement stmt = null;
            ResultSet rs = null;

            try {

                db.openConn();
                con = db.getConn();
                stmt = con.createStatement();

                rs = stmt.executeQuery("SELECT pic from photo where pic_name='"+name+"'");

                if (rs.next()) {

                    image = rs.getBlob(1);
                    imgData = image.getBytes(1,(int)image.length());

                }else {

                    System.out.println("Display Blob Example");
                    System.out.println("image not found for given id");

                }

                // display the image
                response.reset();
                response.setContentType("image/gpg");
                OutputStream o = response.getOutputStream();
                o.write(imgData);
                o.flush();
                o.close();

            }catch (Exception e) {
                System.out.println("Unable To Display image");
                System.out.println("Image Display Error=" + e.getMessage());

            } finally {
                try {
                    rs.close();
                    stmt.close();
                    con.close();
                    db.closeConnection();

                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }else if(action.equals("pagination")){
//            int page2 = 1;
//            int recordsPerPage = 5;
//            if(request.getParameter("page") != null)
//                page2 = Integer.parseInt(request.getParameter("page"));
//           Auction a= new Auction();
//            List<Auction> list = a.viewAllAuctions((page2-1)*recordsPerPage, //prp mallon n pername me get attr seller...
//                    recordsPerPage);
//            int noOfRecords = a.getNoOfRecords();
//            int noOfPages = (int) Math.ceil(noOfRecords * 1.0 / recordsPerPage);
//            request.setAttribute("employeeList", list);
//            request.setAttribute("noOfPages", noOfPages);
//            request.setAttribute("currentPage", page);
//            RequestDispatcher view = request.getRequestDispatcher("auctionlist2.jsp");
//            view.forward(request, response);

        }
        else if (action.equals("logout")) { //LOG OUT

            request.getSession().invalidate();  //terminate session
            response.sendRedirect("/BBservlet?page=log_out");

        }
        else if (action.equals("msglist")){
            db.openConn();
            String username = request.getParameter("username");
            session.setAttribute("username", username);

            ArrayList<Message> mList = Message.get_inbox(username); //get all messages this user has recieved
            session.setAttribute("mList", mList);
            ArrayList<Message> mList2 = Message.get_sent(username); //get all messages this user has recieved
            session.setAttribute("mList2", mList2);
            String query="UPDATE message SET seen=1 WHERE owner='"+ username +"' ";
            db.executeUpdate(query);
            db.closeConnection();

            response.sendRedirect("/BBservlet?page=msglist");
        }
        else if (action.equals("deletemsg")){
            String username = request.getParameter("username");
            int message_id = Integer.parseInt(request.getParameter("msgid"));
            String query = "DELETE FROM message WHERE msgID='"+message_id+"'";

            db.openConn();
            int rs3 = db.executeUpdate(query);
            db.closeConnection();

            response.sendRedirect("/BBservlet?action=msglist&username="+username+"");

        }
        else if (action.equals("searchres")){
            String seller = request.getParameter("seller");
            String choice = request.getParameter("choice");
            String terms = request.getParameter("terms");
            int from;
            int to;
            if(!"".equals(request.getParameter("from"))) {
                 from = Integer.parseInt(request.getParameter("from"));
            }
            if(!"".equals(request.getParameter("to"))) {

                 to = Integer.parseInt(request.getParameter("to"));
            }
            String query="SELECT * FROM auction WHERE seller!='"+ seller +"' AND expired=0 AND sold=0 ";


            if(!choice.equals("any")) {
                query=query+" AND cat = '"+ choice +"'";
            }
            if(!"".equals(request.getParameter("from")) && !"".equals(request.getParameter("to"))) {
                from = Integer.parseInt(request.getParameter("from"));
                to = Integer.parseInt(request.getParameter("to"));
                query=query+"AND curr BETWEEN '"+from+"' AND '"+ to +"'";
            }else{
                if(!"".equals(request.getParameter("from"))){
                    from = Integer.parseInt(request.getParameter("from"));
                    query=query+"AND curr >= '"+from+"' ";
                }else if(!"".equals(request.getParameter("to"))){
                    to = Integer.parseInt(request.getParameter("to"));
                    query=query+"AND curr <= '"+to+"' ";
                }

            }

            ArrayList<Auction> aList =Auction.search_auction(query);
            session.setAttribute("aList",aList);
            response.sendRedirect("/BBservlet?page=searchres");

        }
        else if (action.equals("auction_search")){

            String pointer = request.getParameter("pointer");   //pointer, points arraylists position to have info only for this estate
            session.setAttribute("pointer", pointer);

            String seller = request.getParameter("seller");
            session.setAttribute("seller", seller);

            ArrayList<Photo> pList = Photo.pdoSelectAll(seller); //get all photos this users uploaded
            session.setAttribute("pList", pList);
            ArrayList<Auction> aList = Auction.Auctionlist("*");   //arraylist with all info for a user's estates

            session.setAttribute("aList", aList);
            response.sendRedirect("/BBservlet?page=auction_search");
        }
        else if (action.equals("place_bid")){
            String pointer = request.getParameter("pointer");   //pointer, points arraylists position to have info only for this estate
            session.setAttribute("pointer", pointer);

            String seller = request.getParameter("seller");
            session.setAttribute("seller", seller);


            int itemid = Integer.parseInt(request.getParameter("itemid"));
            session.setAttribute("itemid", itemid);

            int bidderid = Integer.parseInt(request.getParameter("bidderid"));
            float amount = Float.parseFloat(request.getParameter("amount"));


            DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
            Date date = new Date();
            String curdate = dateFormat.format(date);

            String query = "INSERT INTO bid VALUES(0, '" + bidderid + "',"
                    + "'" + itemid + "',"
                    + "'" + amount + "',"
                    + "'" + curdate + "')";

            db.openConn();

            Integer i = db.executeUpdate(query);



            Auction auction = Auction.getAuctionbyid(itemid);

            if(auction.buy_pr==amount){
                query="UPDATE auction SET buyerID='"+bidderid+"', expired= 1 , curr='"+amount+"', sold=1 WHERE  itemID='"+itemid+"'";

            }else{
                query = "UPDATE auction SET buyerID='"+bidderid+"',curr='" + amount + "' WHERE itemID='"+itemid+"'";


            }
            i=db.executeUpdate(query);
            db.closeConnection();

            response.sendRedirect("/BBservlet?action=auction_search&pointer="+pointer+"&seller="+seller+"");
        }
        else if (action.equals("check_username")) {


            db.openConn();
            String UserName = request.getParameter("username");
            String query3 = "SELECT COUNT(*) AS total FROM user where username='" + UserName + "'";
            ResultSet rs3 = db.executeQuery(query3);
            int exists = 0;

            response.setContentType("text/html;charset=UTF-8");


            while (rs3.next()) {
                if (rs3.getInt("total") > 0) {
                    exists = 1;

                    out.println("<font color=red><b>" + UserName + "</b> is already in use</font>");



                } else {

                    out.println("<font color=green><b>" + UserName + "</b> is available!</font>");

                }

            }
        }
        else if (action.equals("check_email")) {


            db.openConn();
            String email = request.getParameter("email");
            String query3 = "SELECT COUNT(*) AS total FROM user where email='" + email + "'";
            ResultSet rs3 = db.executeQuery(query3);
            response.setContentType("text/html;charset=UTF-8");
            while (rs3.next()) {
                if (rs3.getInt("total") > 0) {


                    out.println("<font color=red><b>" + email + "</b> is already in use</font>");



                } else {

                    out.println("<font color=green><b>" + email + "</b> is available!</font>");

                }

            }
        }
        else if (action.equals("send_msg")) {

            response.sendRedirect("/BBservlet?page=send_msg");

        }
        else if (action.equals("send_msgf")) {
            db.openConn();
            String user = request.getParameter("user");
            String receiver = request.getParameter("receiver");
            String message = request.getParameter("message");

            //TODO mipws to itemid thelei int ? !!!
            String itemID = request.getParameter("itemID");

            String query = "INSERT INTO message VALUES(0, '" + message + "',"
                    + "'" + 0 + "',"
                    + "'" + user + "',"
                    + "'" + receiver + "',"
                    + "'" + itemID + "',"
                    + "'" + user + "')";

            db.executeUpdate(query);
            query = "INSERT INTO message VALUES(0, '" + message + "',"
                    + "'" + 0 + "',"
                    + "'" + user + "',"
                    + "'" + receiver + "',"
                    + "'" + itemID + "',"
                    + "'" + receiver + "')";
            db.executeUpdate(query);

            db.closeConnection();

            response.sendRedirect("/BBservlet?action=msglist&username="+user+"");

        }
        else if (action.equals("delete_item")) {

            int itemid = Integer.parseInt(request.getParameter("id"));
            String uname = request.getParameter("username");

            //First we delete the item's photo due to foreign key
            String query = "DELETE FROM photo WHERE itemID='"+itemid+"'";

            db.openConn();
            int rs3 = db.executeUpdate(query);

            query = "DELETE FROM auction_has_cat WHERE itemID='"+itemid+"'";
            rs3 = db.executeUpdate(query);

            //After we have delete its photos, we delete the auction itself
            query = "DELETE FROM auction WHERE itemID='"+itemid+"'";
            rs3 = db.executeUpdate(query);

            db.closeConnection();

            response.sendRedirect("/BBservlet?action=auctionlist&username="+uname+"");

        }
        else if (action.equals("edit_item")) {

            int itemid = Integer.parseInt(request.getParameter("id"));
            String uname = request.getParameter("username");
            ArrayList<Category> cList = Category.get_all_cat();
            session.setAttribute("cList", cList);
            Auction auction = Auction.getAuctionbyid(itemid);

            //TODO mipws einai ligo vlaxiko na pigainei apo action se page xwris logo ??
            //response.sendRedirect("/BBservlet?action=auctionlist&username="+uname+"");

            request.setAttribute("auction",auction);
            //request.setAttribute("username",uname);
            request.getRequestDispatcher("/seller/edit_auction.jsp").include(request, response);
        }
        else if (action.equals("do_edit_auction")) {
            String seller = request.getParameter("seller");
            String name = request.getParameter("name");
            String cats[] = request.getParameterValues("category");
            float latitude = Float.parseFloat(request.getParameter("latitude"));
            float longtitude = Float.parseFloat(request.getParameter("longtitude"));
            String country = request.getParameter("country");
            String city = request.getParameter("city");
            float buy_pr = Float.parseFloat(request.getParameter("buy_price"));
            float first_bid = Float.parseFloat(request.getParameter("first_bid"));
            float curr;
            curr= first_bid;
            int itemid = Integer.parseInt(request.getParameter("itemid"));

            DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            Date date = new Date();
            String st = dateFormat.format(date);
            String end = request.getParameter("end");

            end = (end.replace("T"," "));
            String description = request.getParameter("description");

            db.openConn();

            String query = "UPDATE auction SET latitude='" + latitude + "',"
                    + "longtitude='" + longtitude + "',"
                    + "seller='" + seller + "',"
                    + "name='" + name + "',"
                    + "country='" + country + "',"
                    + "city='" + city + "',"
                    + "buy_pr='" + buy_pr + "',"
                    + "first_bid='" + first_bid + "',"
                    + "curr='" + curr + "',"
                    + "st='" + st + "',"
                    + "end='" + end + "',"
                    + "description='" + description + "' WHERE itemID='"+itemid+"'";


            Integer i = db.executeUpdate(query);
            query = "DELETE FROM auction_has_cat WHERE itemID='"+itemid+"'";
            i = db.executeUpdate(query);
            for(int k=0; k<cats.length; k++){
                query = "INSERT INTO auction_has_cat VALUES(0, '" + itemid + "',"
                        + "'" + Integer.parseInt(cats[k]) + "') ";
                i=db.executeUpdate(query);
            }


            //TODO thelei veltiwsh,den mporw na to steilw sto auctioinfo giati to exoume
            //TODO kanei na pernaei pointer (psaxnei oli ti lista) kai oxi itemid
            if (i>0) {
                request.getRequestDispatcher("/seller/success_add.jsp").include(request, response);
            }
            else {
                request.getRequestDispatcher("/seller/fail_add.jsp").include(request, response);
            }

            db.closeConnection();

        }
        else if (action.equals("profile")) {

            //TODO den kserw an xreiazontai giati to user einai hdh sto session
            String uname = request.getParameter("username");
            User user = User.getUser(uname);
            session.setAttribute("user", user);

            response.sendRedirect("/BBservlet?page=profile");

        }
        else if (action.equals("unmarshall")) {

            File file = new File("/home/chris/Desktop/items-0.xml");
            JAXBContext jaxbContext = JAXBContext.newInstance(xmlAuctions.class);

            Unmarshaller jaxbUnmarshaller = jaxbContext.createUnmarshaller();
            xmlAuctions auctions = (xmlAuctions) jaxbUnmarshaller.unmarshal(file);

            auctions.sendauctions();

            response.sendRedirect("/BBservlet?page=admin");

        }
        else if (action.equals("marshall")) {

            File file = new File("/home/chris/Desktop/unmars.xml");
            JAXBContext jaxbContext = JAXBContext.newInstance(xmlAuctions.class);
            Marshaller jaxbMarshaller = jaxbContext.createMarshaller();

            jaxbMarshaller.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true);

            xmlAuctions auctions = new xmlAuctions();
            auctions.getauction( 1043749860 );

            jaxbMarshaller.marshal(auctions, file);

//            jaxbMarshaller.marshal(auctions, System.out);


            response.sendRedirect("/BBservlet?page=admin");

        }

    }
}