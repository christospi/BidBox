package Javabeans;

import Servlets.BBservlet;

import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
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

    public static int getnum(String seller) throws FileNotFoundException, SQLException {
        DataBase db = new DataBase();
        db.openConn();
        int noOfRecords=0;
        String query=null;
        if(!seller.equals("*")){
             query = "SELECT COUNT(*) from auction where seller='" + seller + "'";
        }else{
            query = "SELECT COUNT(*) from auction ";
        }
        ResultSet rs = db.executeQuery(query);
        if (rs.next()) {
            noOfRecords = rs.getInt(1);
        }


        return  noOfRecords;
    }

    public static ArrayList<Auction> search_auction(String query) throws FileNotFoundException, SQLException {

        ArrayList<Auction> aList = null;

        DataBase db = new DataBase();
        db.openConn();

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

    public static ArrayList<Auction> recommended_auctions(ArrayList<Integer> recs) throws FileNotFoundException {
        DataBase db = new DataBase();
        db.openConn();
        ArrayList<Auction> aList = null;
        String query=null;
        String q2=null;

            query="SELECT * FROM auction where itemID in (";
          for(int i=0;i<recs.size();i++){
              if(i!=recs.size()-1){
                  q2=""+recs.get(i)+",";
                  query=query+q2;

              }else{
                  q2=""+recs.get(i)+")";
                  query=query+q2;
              }

          }
          System.out.println(query);


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
                    auction.country = rs.getString("country");
                    auction.num_bid = rs.getInt("num_bid");
                    auction.st = rs.getDate("st");
                    auction.end = rs.getDate("end");
                    auction.description = rs.getString("description");
                    auction.expired = rs.getInt("expired");
                    auction.sold = rs.getInt("sold");
                    auction.buyerID = rs.getInt("buyerID");
                    aList.add((Auction) auction);

                }
                rs.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }

            return aList;
    }

    public static int resultCounter(String query) throws FileNotFoundException, SQLException {
        int count = 0;
        DataBase db = new DataBase();
        db.openConn();

        ResultSet rs = db.executeQuery(query);

        while( rs.next() ){
            count += 1;
        }

        return count;
    }
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getExpired() {
        return expired;
    }

    public void setExpired(int expired) {
        this.expired = expired;
    }

    public String getSeller() {
        return seller;
    }

    public void setSeller(String seller) {
        this.seller = seller;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public float getCurr() {
        return curr;
    }

    public void setCurr(float curr) {
        this.curr = curr;
    }

    public float getBuy_pr() {
        return buy_pr;
    }

    public void setBuy_pr(float buy_pr) {
        this.buy_pr = buy_pr;
    }

    public float getFirst_bid() {
        return first_bid;
    }

    public void setFirst_bid(float first_bid) {
        this.first_bid = first_bid;
    }

    public int getNum_bid() {
        return num_bid;
    }

    public void setNum_bid(int num_bid) {
        this.num_bid = num_bid;
    }

    public float getLat() {
        return lat;
    }

    public void setLat(float lat) {
        this.lat = lat;
    }

    public float getLongt() {
        return longt;
    }

    public void setLongt(float longt) {
        this.longt = longt;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public Date getSt() {
        return st;
    }

    public void setSt(Date st) {
        this.st = st;
    }

    public Date getEnd() {
        return end;
    }

    public void setEnd(Date end) {
        this.end = end;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getBuyerID() {
        return buyerID;
    }

    public void setBuyerID(int buyerID) {
        this.buyerID = buyerID;
    }

    public int getSold() {
        return sold;
    }

    public void setSold(int sold) {
        this.sold = sold;
    }
}
