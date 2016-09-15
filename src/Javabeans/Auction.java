package Javabeans;

import Servlets.BBservlet;

import java.io.FileNotFoundException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class Auction {
    public int id;
    public int expired;
    public String seller;
    public String name;
    public String cat;
    public float curr;
    public float buy_pr;
    public float first_bid;
    public int num_bid;
    public float lat;
    public float longt;
    public String city;
    public String country;
    public Date st;
    public Date end;
    public String description;
    public int noOfRecords;
    public int buyerID;
    public int sold ;



    public static Auction getAuction(String username) throws FileNotFoundException {

        DataBase db = new DataBase();
        Auction auction = new Auction();

        db.openConn();

        String query = "select * from auction where seller='" + username + "'";
        ResultSet rs = db.executeQuery(query);

        try {
            if (rs.next()) {

                auction.id = rs.getInt("itemID");
                auction.lat = rs.getFloat("latitude");
                auction.longt = rs.getFloat("longtitude");
                auction.seller = rs.getString("seller");
                auction.city = rs.getString("city");
                auction.name = rs.getString("name");
                auction.curr = rs.getFloat("curr");
                auction.buy_pr = rs.getFloat("buy_pr");
                auction.first_bid = rs.getFloat("first_bid");
                auction.cat = rs.getString("cat");
                auction.country = rs.getString("country");
                auction.num_bid = rs.getInt("num_bid");
                auction.st = rs.getDate("st");
                auction.end = rs.getDate("end");
                auction.expired = rs.getInt("expired");
                auction.description = rs.getString("description");

            }

        } catch (Exception e) {
            Logger.getLogger(BBservlet.class.getName()).log(Level.SEVERE, null, e);
        }
        return auction;
    }
    public static Auction getAuctionbyid(int itemID) throws FileNotFoundException {

        DataBase db = new DataBase();
        Auction auction = new Auction();

        db.openConn();

        String query = "select * from auction where itemID='" + itemID + "'";
        ResultSet rs = db.executeQuery(query);

        try {
            if (rs.next()) {

                auction.id = rs.getInt("itemID");
                auction.lat = rs.getFloat("latitude");
                auction.longt = rs.getFloat("longtitude");
                auction.seller = rs.getString("seller");
                auction.city = rs.getString("city");
                auction.name = rs.getString("name");
                auction.curr = rs.getFloat("curr");
                auction.buy_pr = rs.getFloat("buy_pr");
                auction.first_bid = rs.getFloat("first_bid");
                auction.cat = rs.getString("cat");
                auction.country = rs.getString("country");
                auction.num_bid = rs.getInt("num_bid");
                auction.st = rs.getDate("st");
                auction.end = rs.getDate("end");
                auction.description = rs.getString("description");
                auction.expired = rs.getInt("expired");
                auction.buyerID = rs.getInt("buyerID");

            }

        } catch (Exception e) {
            Logger.getLogger(BBservlet.class.getName()).log(Level.SEVERE, null, e);
        }
        return auction;
    }
    public  static ArrayList<Auction> Auctionlist(String seller) throws FileNotFoundException, SQLException {

        ArrayList<Auction> aList = null;

        DataBase db = new DataBase();
        db.openConn();
        String query;

        if( seller.equals("*") ){
            query = "select * from auction";
        }
        else{
            query = "select * from auction where seller='" + seller + "'";
        }

        ResultSet rs = db.executeQuery(query);

        try {

            aList = new ArrayList<Auction>();
            while (rs.next()) {

                Auction auction = new Auction();
                auction.id = rs.getInt("itemID");
                auction.lat = rs.getFloat("latitude");
                auction.longt = rs.getFloat("longtitude");
                auction.seller = rs.getString("seller");
                auction.city = rs.getString("city");
                auction.name = rs.getString("name");
                auction.curr = rs.getFloat("curr");
                auction.buy_pr = rs.getFloat("buy_pr");
                auction.first_bid = rs.getFloat("first_bid");
                auction.cat = rs.getString("cat");
                auction.country = rs.getString("country");
                auction.num_bid = rs.getInt("num_bid");
                auction.st = rs.getDate("st");
                auction.end = rs.getDate("end");
                auction.description = rs.getString("description");
                auction.expired = rs.getInt("expired");
                auction.sold = rs.getInt("sold");
                auction.buyerID=rs.getInt("buyerID");
                aList.add((Auction) auction);

            }

        } catch (SQLException ex) {
            ex.printStackTrace();
            Logger.getLogger(User.class.getName()).log(Level.SEVERE, null, ex);
        }


        return aList;

    }

    public int getnum(String seller) throws FileNotFoundException, SQLException {
        DataBase db = new DataBase();
        db.openConn();

        String query = "SELECT COUNT(*) from auction where seller='" + seller + "'";
        ResultSet rs = db.executeQuery(query);
        if (rs.next()) {
            this.noOfRecords = rs.getInt(1);
        }

        System.out.println(noOfRecords);
        return  noOfRecords;
    }


}
