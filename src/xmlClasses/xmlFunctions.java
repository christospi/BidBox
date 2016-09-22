package xmlClasses;


import Javabeans.DataBase;
import com.sun.org.apache.xalan.internal.xsltc.compiler.util.ResultTreeType;

import java.io.FileNotFoundException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class xmlFunctions {
    int itemID;
    String name;
    String currently;
    String first_bid;
    String buy_price;
    int number_of_bids;
    String country;
    String started;
    String ends;
    String description;

    List<String> categories = new ArrayList<String>();

    xmlBids xmlbids;
    List<xmlBid> bids;

    List<String> bid_time = new ArrayList<String>();
    List<Float> bid_amount = new ArrayList<Float>();

    List<Integer> bidder_rating = new ArrayList<Integer>();
    List<String> bidder_username = new ArrayList<String>();
    List<String> bidder_location = new ArrayList<String>();
    List<String> bidder_country = new ArrayList<String>();

    float loc_latitude;
    float loc_longitude;
    String loc_city;

    String seller_username;
    int seller_rating;

    public void xmltodb(xmlAuction auction) throws FileNotFoundException, SQLException {
        itemID=auction.getId();
        name=auction.getName();

        currently=auction.getCurr();
        currently=currently.replace("$","");
        float currently_dbl = Float.parseFloat(currently);

        first_bid=auction.getFirst_bid();
        first_bid=first_bid.replace("$","");
        float first_bid_dbl = Float.parseFloat(first_bid);

        float buy_price_dbl = 0;

        buy_price= auction.getBuy_pr();
        if(buy_price!= null && !buy_price.isEmpty()){
            buy_price=buy_price.replace("$","");
            buy_price_dbl = Float.parseFloat(buy_price);
        }


        number_of_bids=auction.getNum_bid();
        country=auction.getCountry();
        started=auction.getSt();
        ends=auction.getEnd();
        description=auction.getDescription();

        categories=auction.getCategories();
        xmlbids=auction.getBids();
        bids=xmlbids.getBids();

//        System.out.println(itemID);
//        System.out.println(name);
//        System.out.println(currently);
//        System.out.println(first_bid);
//        System.out.println(number_of_bids);
//        System.out.println(buy_price);
//        System.out.println(country);
//        System.out.println(started);
//        System.out.println(ends);
//        System.out.println(description);

//        for(int i =0; i<categories.size();i++){
//            System.out.println(categories.get(i));
//        }

        for(int i=0; i<number_of_bids; i++){

            String temp=null;
            xmlBid bid = new xmlBid();
            xmlBidder bidder = new xmlBidder();

//            System.out.println("*********");

            bid = bids.get(i);
            bidder = bid.getBidder();

            bid_time.add((String) bid.getTime());

            temp = bid.getAmount();
            temp=temp.replace("$","");
            bid_amount.add( Float.parseFloat(temp) );

            bidder_rating.add((Integer) bidder.getRating());
            bidder_username.add((String) bidder.getUserid());
            bidder_location.add((String) bidder.getLocation());
            bidder_country.add((String) bidder.getCountry());

//            System.out.println((String) bid.getTime());
//            System.out.println((String) bid.getAmount());
//            System.out.println((int) bidder.getRating());
//            System.out.println((String) bidder.getUserid());
//            System.out.println((String) bidder.getLocation());
//            System.out.println((String) bidder.getCountry());
//
//            System.out.println("*********");

        }

        xmlLocation location = new xmlLocation();
        xmlSeller seller = new xmlSeller();

        seller = auction.getSeller();
        location = auction.getLocation();

        loc_latitude = location.getLat();
        loc_longitude = location.getLongt();
        loc_city = location.getCity();

        seller_username = seller.getUserid();
        seller_rating = seller.getRating();

//        System.out.println(loc_latitude);
//        System.out.println(loc_longitude);
//        System.out.println(loc_city);
//        System.out.println(seller_username);
//        System.out.println(seller_rating);

        DataBase db = new DataBase();
        db.openConn();
        ResultSet rs;

        //Insert Auction from xml file
        String query = "INSERT IGNORE INTO auction VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";

        PreparedStatement state = db.getConn().prepareStatement(query);
        state.setInt (1, itemID);
        state.setFloat (2, loc_latitude);
        state.setFloat (3, loc_longitude);
        state.setString (4, seller_username);
        state.setString (5, name);
        state.setString (6, country);
        state.setString (7, loc_city);
        state.setFloat (8, buy_price_dbl);
        state.setFloat (9, first_bid_dbl);
        state.setFloat (10, currently_dbl);
        state.setInt (11, number_of_bids);
        state.setString (12, started);
        state.setString (13, ends);
        state.setString (14, description);
        state.setInt (15, 1);
        state.setInt (16, 1);
        state.setInt (17, 0);

        state.executeUpdate();

        //Insert User (seller) from xml file
        query = "INSERT IGNORE INTO user VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        state = db.getConn().prepareStatement(query);
        state.setInt (1, 0);
        state.setString (2, seller_username);
        state.setString (3, "dummy");
        state.setString (4, "John");
        state.setString (5, "Doe");
        state.setString (6, "johndoe@email.com");
        state.setString (7, "1234567890");
        state.setString (8, "Address 21");
        state.setString (9, "Gotham City");
        state.setString (10, "999999");
        state.setString (11, "combo");
        state.setFloat (12, seller_rating/2);
        state.setFloat (13, seller_rating);
        state.setInt (14, 1);

        state.executeUpdate();

        //Insert Category in database but first check its existence
        int cat_id = 0;
        for(int i=0; i<categories.size(); i++){

            query = "INSERT IGNORE INTO category VALUES (?,?)";
            state = db.getConn().prepareStatement(query);
            state.setInt (1, 0);
            state.setString (2, categories.get(i));
            state.executeUpdate();

            query = "SELECT * FROM category WHERE cat_name = ?";
            state = db.getConn().prepareStatement(query);
            state.setString(1,categories.get(i));

            rs = state.executeQuery();
            if(rs.next()){
                cat_id = rs.getInt("catID");
            }


            query = "INSERT INTO auction_has_cat VALUES (?,?,?)";
            state = db.getConn().prepareStatement(query);
            state.setInt (1, 0);
            state.setInt (2, itemID);
            state.setInt (3, cat_id);

            state.executeUpdate();
        }

        //Insert bidders and bids into DB
        int bidder_id = 0;
        for(int i=0; i<number_of_bids; i++){

            query = "INSERT IGNORE INTO user VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
            state = db.getConn().prepareStatement(query);
            state.setInt (1, 0);
            state.setString (2, bidder_username.get(i));
            state.setString (3, "dummy");
            state.setString (4, "John");
            state.setString (5, "Doe");
            state.setString (6, "johndoe@email.com");
            state.setString (7, "1234567890");
            state.setString (8, bidder_country.get(i));
            state.setString (9, bidder_location.get(i));
            state.setString (10, "999999");
            state.setString (11, "combo");
            state.setFloat (12, bidder_rating.get(i));
            state.setFloat (13, bidder_rating.get(i)/2);
            state.setInt (14, 1);
            state.executeUpdate();

            query = "SELECT * FROM user WHERE username = ?";
            state = db.getConn().prepareStatement(query);
            state.setString(1,bidder_username.get(i));

            rs = state.executeQuery();
            if(rs.next()){
                bidder_id = rs.getInt("userID");
            }

            query = "INSERT INTO bid VALUES (?,?,?,?,?)";
            state = db.getConn().prepareStatement(query);
            state.setInt (1, 0);
            state.setInt (2, bidder_id);
            state.setInt (3, itemID);
            state.setFloat (4, bid_amount.get(i));
            state.setString (5, bid_time.get(i));

            state.executeUpdate();
        }


        db.closeConnection();


    }


}
