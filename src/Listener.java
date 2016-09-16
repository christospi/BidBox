
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
import java.sql.ResultSet;
import java.sql.SQLException;
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
                String query="select * from auction where expired = 0 ";
                ResultSet rs = db.executeQuery(query);
                try {
                    if (rs.last()) {
                        int rows = rs.getRow();
                        System.out.println(rows);
                        rs.beforeFirst();


                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }
                try {
                    while (rs.next()) {

                        String string = rs.getString("end");
                        System.out.println(string);
                        DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
                        Date end ;
                        end=df.parse(string);
                        Date now=new Date();
                        int id=rs.getInt("itemID");
                        int buyerID = rs.getInt("buyerID");
                        long diff = (end.getTime() - now.getTime());
                        long distance = diff /(1000);
                        System.out.println(distance);
                        if (distance <= 0) {
                            System.out.println("mpikaa");
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

        timer.schedule(myTask, 2000,2000 );
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
        System.out.println("geiaa");
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
