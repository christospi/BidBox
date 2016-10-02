package Javabeans;

import java.io.FileNotFoundException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

public class User {

    public int userID;
    public int ver;
    public String pass;
    public String username;
    public String name;
    public String surname;
    public String email;
    public String phone;
    public String country;
    public String city;
    public String afm;
    public int rating_seller;
    public int rating_bidder;

    public static User getUser(String username) throws FileNotFoundException {
        DataBase db = new DataBase();
        User user = new User();

        db.openConn();

        String query = "select * from user where username='" + username + "'";
        ResultSet rs = db.executeQuery(query);

        try{
            if(rs.next()){

                user.userID = rs.getInt("userID");
                user.username = rs.getString("username");
                user.name = rs.getString("name");
                user.surname = rs.getString("surname");
                user.email = rs.getString("email");
                user.phone = rs.getString("phone");
                user.ver = rs.getInt("verified");
                user.pass = rs.getString("pass");
                user.country = rs.getString("country");
                user.city = rs.getString("city");
                user.afm = rs.getString("afm");
                user.rating_bidder = rs.getInt("rating_bidder");
                user.rating_seller = rs.getInt("rating_seller");


                //TODO Roles mpla mpla
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return user;
    }
    public static User getusername(Integer id) throws FileNotFoundException {
        DataBase db = new DataBase();
        User user = new User();

        db.openConn();

        String query = "select * from user where userID='" + id + "'";
        ResultSet rs = db.executeQuery(query);

        try{
            if(rs.next()){
                user.userID = rs.getInt("userID");
                user.username = rs.getString("username");
                user.name = rs.getString("name");
                user.surname = rs.getString("surname");
                user.email = rs.getString("email");
                user.phone = rs.getString("phone");
                user.ver = rs.getInt("verified");
                user.pass = rs.getString("pass");
                user.country = rs.getString("country");
                user.city = rs.getString("city");
                user.afm = rs.getString("afm");
                user.rating_bidder = rs.getInt("rating_bidder");
                user.rating_seller = rs.getInt("rating_seller");



                //TODO Roles mpla mpla
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return user;
    }
    public static ArrayList<User> doSelectAll() throws FileNotFoundException {

        ArrayList<User> uList = null;

        DataBase db = new DataBase();
        db.openConn();

        String query = "SELECT * FROM user";
        ResultSet rs = db.executeQuery(query);

        try {
            uList = new ArrayList<User>();
            while (rs.next()) {

                User user2 = new User();

                user2.userID = rs.getInt("userID");
                user2.username = rs.getString("username");
                user2.name = rs.getString("name");
                user2.surname = rs.getString("surname");
                user2.email = rs.getString("email");
                user2.phone = rs.getString("phone");
                user2.ver = rs.getInt("verified");
                user2.pass = rs.getString("pass");
                user2.country = rs.getString("country");
                user2.city = rs.getString("city");
                user2.afm = rs.getString("afm");
                user2.rating_bidder = rs.getInt("rating_bidder");
                user2.rating_seller = rs.getInt("rating_seller");


                uList.add((User) user2);
            }

        } catch (SQLException ex) {
            ex.printStackTrace();
            Logger.getLogger(User.class.getName()).log(Level.SEVERE, null, ex);
        }

        return uList;
    }

    public static ArrayList<User> usersPerPage(int page_num) throws FileNotFoundException {

        ArrayList<User> uList = null;

        DataBase db = new DataBase();
        db.openConn();

        String query = "SELECT * FROM user LIMIT " + (page_num - 1) * 10 + ", " + 10 + "";
        ResultSet rs = db.executeQuery(query);

        try {

            uList = new ArrayList<User>();
            while (rs.next()) {

                User user2 = new User();

                user2.userID = rs.getInt("userID");
                user2.username = rs.getString("username");
                user2.name = rs.getString("name");
                user2.surname = rs.getString("surname");
                user2.email = rs.getString("email");
                user2.phone = rs.getString("phone");
                user2.ver = rs.getInt("verified");
                user2.pass = rs.getString("pass");
                user2.country = rs.getString("country");
                user2.city = rs.getString("city");
                user2.afm = rs.getString("afm");
                user2.rating_bidder = rs.getInt("rating_bidder");
                user2.rating_seller = rs.getInt("rating_seller");


                uList.add((User) user2);
            }

        } catch (SQLException ex) {
            ex.printStackTrace();
            Logger.getLogger(User.class.getName()).log(Level.SEVERE, null, ex);
        }

        return uList;
    }

    public static ArrayList<User> unverUsersPerPage(int page_num) throws FileNotFoundException {

        ArrayList<User> uList = null;

        DataBase db = new DataBase();
        db.openConn();

        String query = "SELECT * FROM user WHERE verified=0 LIMIT " + (page_num - 1) * 10 + ", " + 10 + "";
        ResultSet rs = db.executeQuery(query);

        try {

            uList = new ArrayList<User>();
            while (rs.next()) {

                User user2 = new User();

                user2.userID = rs.getInt("userID");
                user2.username = rs.getString("username");
                user2.name = rs.getString("name");
                user2.surname = rs.getString("surname");
                user2.email = rs.getString("email");
                user2.phone = rs.getString("phone");
                user2.ver = rs.getInt("verified");
                user2.pass = rs.getString("pass");
                user2.country = rs.getString("country");
                user2.city = rs.getString("city");
                user2.afm = rs.getString("afm");
                user2.rating_bidder = rs.getInt("rating_bidder");
                user2.rating_seller = rs.getInt("rating_seller");


                uList.add((User) user2);
            }

        } catch (SQLException ex) {
            ex.printStackTrace();
            Logger.getLogger(User.class.getName()).log(Level.SEVERE, null, ex);
        }

        return uList;
    }

    public static int usersCounter() throws FileNotFoundException, SQLException {
        int count = 0;
        DataBase db = new DataBase();
        db.openConn();
        ResultSet rs = db.executeQuery(" SELECT * FROM user");

        while (rs.next()){
            count += 1;
        }
        return count;
    }

    public static int unverUsersCounter() throws FileNotFoundException, SQLException {
        int count = 0;
        DataBase db = new DataBase();
        db.openConn();
        ResultSet rs = db.executeQuery(" SELECT * FROM user WHERE verified=0");

        while (rs.next()){
            count += 1;
        }
        return count;
    }

}
