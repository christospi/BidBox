package Javabeans;

import java.io.FileNotFoundException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class Category {
    public int catID;
    public String name;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getCatID() {
        return catID;
    }

    public void setCatID(int catID) {
        this.catID = catID;
    }

    public static String get_name(int catID) throws FileNotFoundException, SQLException {

        DataBase db = new DataBase();

        db.openConn();

        String query;
        String name = null;
        query = "SELECT * FROM category WHERE catID='"+catID+"'";

        ResultSet rs = db.executeQuery(query);

        if(rs.next()){
            name = rs.getString("cat_name");
        }

        db.closeConnection();
        return name;
    }

    public static Category get_cat(int catID) throws SQLException, FileNotFoundException {
        DataBase db = new DataBase();

        db.openConn();

        String query;
        Category cat = new Category();

        query = "SELECT * FROM category WHERE catID='"+catID+"'";

        ResultSet rs = db.executeQuery(query);

        if(rs.next()){
            cat.catID = rs.getInt("catID");
            cat.name = rs.getString("cat_name");
        }

        db.closeConnection();
        return cat;
    }

    public static ArrayList<Category> get_all_cat() throws SQLException, FileNotFoundException {
        DataBase db = new DataBase();

        db.openConn();

        String query;

        query = "SELECT * FROM category";

        ResultSet rs = db.executeQuery(query);

        ArrayList<Category> clist = new ArrayList<Category>();

        while(rs.next()){
            Category cat = new Category();

            cat.catID = rs.getInt("catID");
            cat.name = rs.getString("cat_name");
            clist.add((Category) cat);
        }

        db.closeConnection();
        return clist;
    }

    public static ArrayList<Category> get_its_cat(int itemid) throws SQLException, FileNotFoundException {
        DataBase db = new DataBase();

        db.openConn();

        String query;

        query = "SELECT * FROM category,auction_has_cat WHERE itemID='"+itemid+"' AND auction_has_cat.catID=category.catID";

        ResultSet rs = db.executeQuery(query);

        ArrayList<Category> clist = new ArrayList<Category>();

        while(rs.next()){
            Category cat = new Category();
            cat.catID = rs.getInt("catID");
            cat.name = rs.getString("cat_name");
            clist.add((Category) cat);
        }

        db.closeConnection();
        return clist;
    }


}
