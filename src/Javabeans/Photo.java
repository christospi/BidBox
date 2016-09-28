package Javabeans;


        import Servlets.BBservlet;

        import java.io.FileNotFoundException;
        import java.sql.ResultSet;
        import java.sql.SQLException;
        import java.util.ArrayList;
        import java.util.logging.Level;
        import java.util.logging.Logger;


public class Photo{

    public int id;
    public String owner;
//    public int auction_id;
    public String pic_name;
    public int itemID;

    public static Photo getPhoto(String owner) throws FileNotFoundException {

        DataBase db = new DataBase();
        Photo photo = new Photo();

        db.openConn();

        String query = "select * from photo where owner='" + owner + "'";
        ResultSet rs = db.executeQuery(query);

        try {
            if (rs.next()) {

                photo.id = rs.getInt("photoID");
                photo.owner = rs.getString("owner");
//                photo.auction_id = rs.getInt("estate_id");
                photo.pic_name = rs.getString("pic_name");
                photo.itemID = rs.getInt("itemID");

            }

        } catch (Exception e) {
            Logger.getLogger(BBservlet.class.getName()).log(Level.SEVERE, null, e);
        }

        return photo;

    }


    public static ArrayList<Photo> pdoSelectAll(int itemID) throws FileNotFoundException {

        ArrayList<Photo> pList = null;

        DataBase db = new DataBase();
        db.openConn();

        String query = "select * from photo where itemID='" + itemID + "'";
        ResultSet rs = db.executeQuery(query);

        try {

            pList = new ArrayList<Photo>();
            while (rs.next()) {

                Photo photo = new Photo();

                photo.id = rs.getInt("photoID");
                photo.owner = rs.getString("owner");
//                photo.auction_id = rs.getInt("estate_id");
                photo.pic_name = rs.getString("pic_name");
                photo.itemID = rs.getInt("itemID");
                pList.add((Photo) photo);
            }

        } catch (SQLException ex) {
            ex.printStackTrace();
            Logger.getLogger(User.class.getName()).log(Level.SEVERE, null, ex);
        }


        return pList;

    }

}
