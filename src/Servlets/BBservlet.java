package Servlets;

import Javabeans.DataBase;
import Javabeans.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Objects;
import java.util.logging.Level;
import java.util.logging.Logger;


//@WebServlet("/BBservlet")
public class BBservlet extends HttpServlet {

    private DataBase db = new DataBase();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        out.println("Hello user!");
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(BBservlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        out.println("Hello user!");

        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(BBservlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession(true);
        response.setContentType("text/html;charset=UTF-8");
        String action = request.getParameter("action");
        String page = request.getParameter("page");
        //PrintWriter out = response.getWriter();

        out.println("Hello user1!");

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
            String verified = request.getParameter("verified");
            out.println("Hello user1.5!");
            db.openConn();
            out.println("Hello user2!");
            String query3 = "SELECT COUNT(*) AS total FROM user where username='" + UserName + "'";   //check if username already exists
            ResultSet rs3 = db.executeQuery(query3);
            int exists = 0;
            int exists2 = 0;

            while (rs3.next()) {
                if (rs3.getInt("total") > 0 ) {
                    exists = 1;
                }
            }

            String query4 = "SELECT COUNT(*) AS total FROM user where email='" + Email + "'";  //check if email already exists
            ResultSet rs4 = db.executeQuery(query4);

            while (rs4.next()) {
                if (rs4.getInt("total") > 0 ) {
                    exists2 = 1;
                }
            }
            out.println("Hello user3!");
            if(exists == 0 && exists2 ==0 ) {   //user entered valid username and email

                String query = "INSERT INTO user VALUES(0, '" + UserName + "',"
                        + "'" + Password + "',"
                        + "'" + FirstName + "',"
                        + "'" + LastName + "',"
                        + "'" + Email + "',"
                        + "'" + Phone+ "',"
                        + "'" + address + "',"
                        + "'" + city + "',"
                        + "'" + afm + "', 0)";

                Integer i = db.executeUpdate(query);
                //out.print(i);
                //out.print(db.getConn().getWarnings());
                out.println("Hello user4!");
                String roles_in="";
                String role[]=request.getParameterValues("roles");

                for(int k=0;k<role.length;k++) {

                    roles_in="";
                    roles_in+=role[k];
                    String query2 = "INSERT INTO roles VALUES (0, '"+roles_in+"', '"+UserName+"')";
                    Integer j = db.executeUpdate(query2);
                    //out.print(j);
                    //out.print(db.getConn().getWarnings());

                }

                // request.getRequestDispatcher("/welcome/success_signup.jsp").include(request, response);
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

            out.println("Hello from login brace!");

            try {

                String username = request.getParameter("Username"); //get user and pass from form
                String password = request.getParameter("Password");
                String query = "select * from user where username='" + username + "' and pass='" + password + "'";

                out.println("--" + username + "-->" + password);

                db.openConn();

                out.println("bug 1 !");
                out.println(query);

                ResultSet rs = db.executeQuery(query);

                out.println("bug 2 !");

                if (rs.next()) {    //if user exists

                    out.println("EXISTS !");
                    User user = User.getUser(username);
                    session.setAttribute("user", user);

                    if (user.ver == 0) {    //if he isnt verified yet display this
                        request.getRequestDispatcher("/welcome/unverified.jsp").include(request, response);
                    }
                    else {  //else see his role and redirect him to the wright page

                        if(Objects.equals(user.username, "admin")){
                            response.sendRedirect("/BBservlet?page=admin");
                        }

//                        response.sendRedirect("/welcome/login.jsp");
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

                    out.print("Invalid User: " + username + " " + password);
                    request.getRequestDispatcher("./welcome/unverified.jsp").include(request, response);

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
    }
}