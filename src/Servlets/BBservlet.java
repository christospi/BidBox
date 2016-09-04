package Servlets;

import Javabeans.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
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
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            processRequest(request, response);

        } catch (SQLException ex) {
            Logger.getLogger(BBservlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

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

                String query = "INSERT INTO user VALUES(0, '" + UserName + "',"
                        + "'" + Password + "',"
                        + "'" + FirstName + "',"
                        + "'" + LastName + "',"
                        + "'" + Email + "',"
                        + "'" + Phone+ "',"
                        + "'" + address + "',"
                        + "'" + city + "',"
                        + "'" + afm + "', 0,'" + role + "')";

                Integer i = db.executeUpdate(query);

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
        else if (action.equals("addauction")) {

            String seller = request.getParameter("seller");
            String name = request.getParameter("name");
            String cat = request.getParameter("category");
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
            DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
            Date date = new Date();
            String st = dateFormat.format(date);
            String end = request.getParameter("end");
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
                    + "'" + cat + "',"
                    + "'" + num_bid + "',"
                    + "'" + st + "',"
                    + "'" + end + "',"
                    + "'" + description + "',"
                    + "'" + 0 + "',"
                    + "'" + 0 + "')";

            Integer i = db.executeUpdate(query);
            //out.print(i);

            if (i>0) {
                request.getRequestDispatcher("/seller/success_add.jsp").include(request, response);
            }
            else {
                request.getRequestDispatcher("/seller/fail_add.jsp").include(request, response);
            }

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

            ArrayList<Auction> aList = Auction.Auctionlist(seller);   //arraylist with all info for a user's estates
            int num=new Auction().getnum(seller);

            session.setAttribute("num",num);
            session.setAttribute("aList", aList);

            response.sendRedirect("/BBservlet?page=auctionlist");
        }
        else if (action.equals("auctioninfo")) { //ESTATE INFO

            String pointer = request.getParameter("pointer");   //pointer, points arraylists position to have info only for this estate
            session.setAttribute("pointer", pointer);

            String seller = request.getParameter("seller");
            session.setAttribute("seller", seller);

            ArrayList<Photo> pList = Photo.pdoSelectAll(seller); //get all photos this users uploaded
            session.setAttribute("pList", pList);

//            ArrayList<MessageBean> mList = MessageBean.mdoSelectAll(owner); //get all messages this user has recieved
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

            String username = request.getParameter("username");
            session.setAttribute("username", username);

            ArrayList<Message> mList = Message.mdoSelectAll(username); //get all messages this user has recieved
            session.setAttribute("mList", mList);

            response.sendRedirect("/BBservlet?page=msglist");
        }
        else if (action.equals("deletemsg")){

            int message_id = Integer.parseInt(request.getParameter("msgid"));
            String query = "DELETE FROM message WHERE msgID='"+message_id+"'";

            db.openConn();
            int rs3 = db.executeUpdate(query);
            db.closeConnection();

            response.sendRedirect("/BBservlet?action=msglist");

        }
        else if (action.equals("searchres")){

            ArrayList<Auction> aList = Auction.Auctionlist("*");   //arraylist with all info for a user's estates

            session.setAttribute("aList", aList);

            response.sendRedirect("/BBservlet?page=searchres");

        }
        else if (action.equals("auction_search")){

            String pointer = request.getParameter("pointer");   //pointer, points arraylists position to have info only for this estate
            session.setAttribute("pointer", pointer);

            String seller = request.getParameter("seller");
            session.setAttribute("seller", seller);

            ArrayList<Photo> pList = Photo.pdoSelectAll(seller); //get all photos this users uploaded
            session.setAttribute("pList", pList);

            response.sendRedirect("/BBservlet?page=auction_search");
        }
        else if (action.equals("place_bid")){

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

            query = "UPDATE auction SET curr='" + amount + "' WHERE itemID='"+itemid+"'";
            i = db.executeUpdate(query);

            db.closeConnection();

            response.sendRedirect("/BBservlet?page=auction_search");
        }else if (action.equals("check_username")) {


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
        }else if (action.equals("check_email")) {


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

    }
}