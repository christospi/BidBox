package Servlets;

import Javabeans.DataBase;

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
import java.util.logging.Level;
import java.util.logging.Logger;
@WebServlet("/register")
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
        //if (action.equals("signup")) {   //SIGN UP

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

      //  }
    }
}