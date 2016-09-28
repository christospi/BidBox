package xmlClasses;


import Javabeans.DataBase;
import com.sun.org.apache.xalan.internal.xsltc.compiler.util.ResultTreeType;

import java.io.FileNotFoundException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

public class xmlFunctions {

    //Functions for object transformations

    public void xmltodb(xmlAuction auction) throws FileNotFoundException, SQLException, ParseException {

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

        xmlBids xmlbids = new xmlBids();
        List<xmlBid> bids  = new ArrayList<xmlBid>();

        List<String> bid_time;
        List<Float> bid_amount;

        List<Integer> bidder_rating;
        List<String> bidder_username;
        List<String> bidder_location;
        List<String> bidder_country;


        bid_time = new ArrayList<String>();
        bid_amount = new ArrayList<Float>();

        bidder_rating = new ArrayList<Integer>();
        bidder_username = new ArrayList<String>();
        bidder_location = new ArrayList<String>();
        bidder_country = new ArrayList<String>();

        itemID=auction.getId();
        name=auction.getName();
        float loc_latitude;
        float loc_longitude;
        String loc_city;

        String seller_username;
        int seller_rating;

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

        //DateTime fix from xml file format to db format
        started=auction.getSt();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MMM-dd-yy HH:mm:ss");
        LocalDateTime date = LocalDateTime.parse(started,formatter);
        started = date.toString();
        started = (started.replace("T"," "));

        ends=auction.getEnd();
        date = LocalDateTime.parse(ends,formatter);
        ends = date.toString();
        ends = (ends.replace("T"," "));

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

        //if 0 then auction already exists,else 1 auction does not exist
        int check = state.executeUpdate();

        if(check == 0){
            db.closeConnection();
            return;
        }

        //Insert User (seller) from xml file
        query = "INSERT IGNORE INTO user VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?)";
        state = db.getConn().prepareStatement(query);
        state.setInt (1, 0);
        state.setString (2, seller_username);
        state.setString (3, "bidbox");
        state.setString (4, "John");
        state.setString (5, "Doe");
        state.setString (6, seller_username + "@bidbox.com");
        state.setString (7, "1234567890");
        state.setString (8, "USA");
        state.setString (9, "Gotham City");
        state.setString (10, "999999");
        state.setFloat (11, seller_rating/2);
        state.setFloat (12, seller_rating);
        state.setInt (13, 1);

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

            query = "INSERT IGNORE INTO user VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?)";
            state = db.getConn().prepareStatement(query);
            state.setInt (1, 0);
            state.setString (2, bidder_username.get(i));
            state.setString (3, "bidbox");
            state.setString (4, "John");
            state.setString (5, "Doe");
            state.setString (6, bidder_username.get(i) + "@bidbox.com");
            state.setString (7, "1234567890");
            state.setString (8, bidder_country.get(i));
            state.setString (9, bidder_location.get(i));
            state.setString (10, "999999");
            state.setFloat (11, bidder_rating.get(i));
            state.setFloat (12, bidder_rating.get(i)/2);
            state.setInt (13, 1);
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

    /*********************************************************************************/
    /*********************************************************************************/

    public xmlAuction dbtoxml(int givenID) throws FileNotFoundException, SQLException {

        xmlAuction xmlauction = new xmlAuction();
        xmlLocation loc = new xmlLocation();
        xmlSeller seller = new xmlSeller();

        List<String> categories = new ArrayList<String>();

        xmlBids xmlbids = new xmlBids();
        List<xmlBid> bids  = new ArrayList<xmlBid>();


        DataBase db = new DataBase();
        db.openConn();

        ResultSet rs1;
        ResultSet rs2;
        ResultSet rs3;

        //Get Auction from database
        String query = "SELECT * FROM auction WHERE itemID = ?";
        PreparedStatement state = db.getConn().prepareStatement(query);
        state.setInt (1, givenID);

        rs1 = state.executeQuery();
        if(rs1.next()){

            float buy_price_float = 0;

            xmlauction.setId( rs1.getInt("itemID") );
            xmlauction.setName( rs1.getString("name") );
            xmlauction.setCurr( "$" + Float.toString(rs1.getFloat("curr")) );
            xmlauction.setFirst_bid( "$" + Float.toString(rs1.getFloat("first_bid")) );

            buy_price_float = rs1.getFloat("buy_pr");
            if( buy_price_float == 0){
                xmlauction.setBuy_pr("N/A");
            }
            else{
                xmlauction.setBuy_pr( "$" + Float.toString(buy_price_float) );
            }

            xmlauction.setNum_bid( rs1.getInt("num_bid") );
            xmlauction.setCountry( rs1.getString("country") );
            xmlauction.setSt( rs1.getString("st") );
            xmlauction.setEnd( rs1.getString("end") );
            xmlauction.setDescription( rs1.getString("description") );

            loc.setCity( rs1.getString("city") );
            loc.setLat( rs1.getFloat("latitude") );
            loc.setLongt( rs1.getFloat("longtitude") );
            xmlauction.setLocation( loc );

            //We hit a query to obtain more info for auction's seller
            query = "SELECT * FROM user WHERE username = ?";
            state = db.getConn().prepareStatement(query);
            state.setString (1, rs1.getString("seller") );

            rs2 = state.executeQuery();
            if(rs2.next()){
                seller.setRating( (int) rs2.getFloat("rating_seller") );
                seller.setUserid( rs2.getString("username") );

                xmlauction.setSeller( seller );
            }

            //Now we want to obtain all the auction's categories
            query = "SELECT * FROM auction_has_cat WHERE itemID = ?";
            state = db.getConn().prepareStatement(query);
            state.setInt (1, rs1.getInt("itemID") );

            rs2 = state.executeQuery();

            while(rs2.next()){

                int catid = rs2.getInt("catID");

                //Now we want to obtain the names of its categories
                query = "SELECT * FROM category WHERE catID = ?";
                state = db.getConn().prepareStatement(query);
                state.setInt (1, catid);

                rs3 = state.executeQuery();
                if(rs3.next()){
                    categories.add( rs3.getString("cat_name") );
                }
            }

            xmlauction.setCategories( categories );

            //Now we want to obtain all the bids related to this auction
            query = "SELECT * FROM bid WHERE itemID = ?";
            state = db.getConn().prepareStatement(query);
            state.setInt (1, rs1.getInt("itemID") );

            rs2 = state.executeQuery();

            while(rs2.next()){
                xmlBid newbid = new xmlBid();
                xmlBidder newbidder = new xmlBidder();

                newbid.setAmount( "$" + Float.toString(rs2.getFloat("amount")) );
                newbid.setTime(rs2.getString("date"));

                int bidderid = rs2.getInt("userID");

                query = "SELECT * FROM user WHERE userID = ?";
                state = db.getConn().prepareStatement(query);
                state.setInt (1, bidderid);

                rs3 = state.executeQuery();

                //If user exists (obviously exists)
                if(rs3.next()){

                    newbidder.setUserid( rs3.getString("username") );

                    newbidder.setCountry(rs3.getString("country"));

                    newbidder.setLocation( rs3.getString("city") );
                    newbidder.setRating( (int) rs3.getFloat(("rating_bidder")));

                    newbid.setBidder(newbidder);
                    bids.add(newbid);
                }
            }

            xmlbids.setBids( bids );
            xmlauction.setBids( xmlbids );

        }

        return xmlauction;
    }


}
