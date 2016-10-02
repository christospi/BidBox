
import ItemRecommendation.Recommendation;
import Javabeans.Auction;
import Javabeans.DataBase;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSessionAttributeListener;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;
import javax.servlet.http.HttpSessionBindingEvent;
import javax.swing.*;
import java.io.FileNotFoundException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Timer;
import java.util.*;
import java.util.TimerTask;

@WebListener
public class Listener implements ServletContextListener,
        HttpSessionListener, HttpSessionAttributeListener {
    private DataBase db = new DataBase();

    // Public constructor is required by servlet spec
    public Listener() {
    }

    // -------------------------------------------------------
    // ServletContextListener implementation
    // -------------------------------------------------------
    public void contextInitialized(ServletContextEvent sce) {
      /* This method is called when the servlet context is
         initialized(when the Web application is deployed). 
         You can initialize servlet context related data here.
      */
        Timer timer = new Timer();

        TimerTask myTask = new TimerTask() {

            @Override
            public void run() {
                // whatever you need to do every 2 seconds
                try {
                    db.openConn();
                } catch (FileNotFoundException e) {
                    e.printStackTrace();
                }
                String query="select * from auction where expired = 0 AND st IS NOT NULL";
                ResultSet rs = db.executeQuery(query);
                try {
                    if (rs.last()) {
                        int rows = rs.getRow();
//                        System.out.println(rows);
                        rs.beforeFirst();


                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }
                try {
                    while (rs.next()) {

                        String string = rs.getString("end");
//                        System.out.println(string);
                        DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
                        Date end ;
                        end=df.parse(string);
                        Date now=new Date();
                        int id=rs.getInt("itemID");
                        int buyerID = rs.getInt("buyerID");
                        long diff = (end.getTime() - now.getTime());

                        long distance = diff /(1000);

                        if (distance <= 0) {
//                            System.out.println("mpikaa");
                            if(buyerID!=0){
                                query="UPDATE auction SET expired=1 WHERE itemID='"+ id +"'";
                            }else{
                                query="UPDATE auction SET sold=1,expired=1 WHERE itemID='"+ id +"'";
                            }
                            db.executeUpdate(query);
                        }


                    }
                } catch (SQLException e) {
                    //e.printStackTrace();
                } catch (ParseException e) {
                    e.printStackTrace();
                }
                db.closeConnection();
            }
        };



        Timer timer2 = new Timer();
        TimerTask myTask2 = new TimerTask() {
            @Override
            public void run() {
                try {
                    db.openConn();

                } catch (FileNotFoundException e) {
                    e.printStackTrace();
                }
                Connection conn = db.getConn();


                Statement statement2 = null;
                try {
                    statement2 = conn.createStatement();
                } catch (SQLException e) {
                    e.printStackTrace();
                }

                Statement statement1 = null;
                try {
                    statement1 = conn.createStatement();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
                String query="DELETE from recommendations"; //svinoume ta pada wste na balume ta nea recommendations
                int l=db.executeUpdate(query);
                query="select * from user where userID>1"; //de theloume ton admin
//                ResultSet rs = db.executeQuery(query);
                ResultSet rs = null;
                try {
                    rs = statement1.executeQuery(query);
                } catch (SQLException e) {
                    e.printStackTrace();
                }
                try {
                    while (rs.next()) {
                        int userID=rs.getInt("userID");
//                        System.out.println(userID);
                       ArrayList<Integer> recommended = Recommendation.Similarity(userID);

                        for(int i=0;i<recommended.size();i++) {
                            query = "INSERT INTO recommendations VALUES(0, '" + userID + "','" + recommended.get(i) + "')";
                           int k= statement2.executeUpdate(query);

                        }
                    }
                    db.closeConnection();
                } catch (SQLException e) {
                    e.printStackTrace();}
                 catch (FileNotFoundException e) {
                    e.printStackTrace();
                }
            }


        };

        timer.schedule(myTask, 2000,2000 );
        timer2.schedule(myTask2,0,7200000 ); //every two hours


    }

    public void contextDestroyed(ServletContextEvent sce) {
      /* This method is invoked when the Servlet Context 
         (the Web application) is undeployed or 
         Application Server shuts down.
      */

    }

    // -------------------------------------------------------
    // HttpSessionListener implementation
    // -------------------------------------------------------
    public void sessionCreated(HttpSessionEvent se) {

      /* Session is created. */
    }

    public void sessionDestroyed(HttpSessionEvent se) {
      /* Session is destroyed. */
    }

    // -------------------------------------------------------
    // HttpSessionAttributeListener implementation
    // -------------------------------------------------------

    public void attributeAdded(HttpSessionBindingEvent sbe) {
      /* This method is called when an attribute 
         is added to a session.
      */
    }

    public void attributeRemoved(HttpSessionBindingEvent sbe) {
      /* This method is called when an attribute
         is removed from a session.
      */
    }

    public void attributeReplaced(HttpSessionBindingEvent sbe) {
      /* This method is invoked when an attibute
         is replaced in a session.
      */
    }
}
