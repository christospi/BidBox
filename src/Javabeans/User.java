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
    public String address;
    public String city;
    public String afm;
    public String role;

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
                user.address = rs.getString("address");
                user.city = rs.getString("city");
                user.afm = rs.getString("afm");
                user.role = rs.getString("roles");

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
                user.address = rs.getString("address");
                user.city = rs.getString("city");
                user.afm = rs.getString("afm");
                user.role = rs.getString("roles");


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

        String query = "select * from user";
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
                user2.address = rs.getString("address");
                user2.city = rs.getString("city");
                user2.afm = rs.getString("afm");
                user2.role = rs.getString("roles");

                uList.add((User) user2);
            }

        } catch (SQLException ex) {
            ex.printStackTrace();
            Logger.getLogger(User.class.getName()).log(Level.SEVERE, null, ex);
        }

        return uList;
    }

}
