package Javabeans;

import Servlets.BBservlet;

import java.io.FileNotFoundException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

public class Message {

    public int msgID;
    public String from;
    public String to;
    public String message;
    public int itemID;
    public int seen;

    public static Message getMessage(String to_user) throws FileNotFoundException {

        DataBase db = new DataBase();
        Message message = new Message();

        db.openConn();

        String query = "select * from message where to_user='" + to_user + "'";
        ResultSet rs = db.executeQuery(query);

        try {
            if (rs.next()) {

                message.msgID = rs.getInt("msgID");
                message.from = rs.getString("from_user");
                message.to = rs.getString("to_user");
                message.message = rs.getString("message");
                message.itemID = rs.getInt("itemID");
//                message.seen = 0;
            }

        } catch (Exception e) {
            Logger.getLogger(BBservlet.class.getName()).log(Level.SEVERE, null, e);
        }
        return message;
    }

    public static ArrayList<Message> mdoSelectAll(String to_user) throws FileNotFoundException {

        ArrayList<Message> mList = null;

        DataBase db = new DataBase();
        db.openConn();

        String query = "select * from message where to_user='" + to_user + "'";
        ResultSet rs = db.executeQuery(query);

        try {

            mList = new ArrayList<Message>();
            while (rs.next()) {

                Message message = new Message();

                message.msgID = rs.getInt("msgID");
                message.from = rs.getString("from_user");
                message.to = rs.getString("to_user");
                message.message = rs.getString("message");
                message.itemID = rs.getInt("itemID");
//                message2.seen = 0;
                mList.add((Message) message);
            }

        } catch (SQLException ex) {
            ex.printStackTrace();
            Logger.getLogger(User.class.getName()).log(Level.SEVERE, null, ex);
        }
        return mList;
    }

}
