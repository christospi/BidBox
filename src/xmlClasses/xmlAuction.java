package xmlClasses;

import Javabeans.Category;

import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlType;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@XmlType( propOrder = {"id", "name", "categories", "curr", "buy_pr", "first_bid",
        "num_bid", "bids", "location", "country", "st", "end", "seller", "description"})
@XmlRootElement( name = "Item" )
public class xmlAuction {

    int id;
    String name;

    List<String> categories;
    String curr;
    String buy_pr;
    String first_bid;
    int num_bid;

    xmlLocation location;
    xmlBids bids;
    xmlSeller seller;

    String country;

    public xmlAuction() {
        categories = new ArrayList<String>();
    }

    String st;
    String end;
    String description;


    public int getId() {
        return id;
    }

    @XmlAttribute(name="ItemID")
    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    @XmlElement(name="Name")
    public void setName(String name) {
        this.name = name;
    }

    public String getCurr() {
        return curr;
    }

    @XmlElement(name="Currently")
    public void setCurr(String curr) {
        this.curr = curr;
    }

    public String getBuy_pr() {
        return buy_pr;
    }

    @XmlElement(name="Buy_Price")
    public void setBuy_pr(String buy_pr) {
        this.buy_pr = buy_pr;
    }

    public String getFirst_bid() {
        return first_bid;
    }

    @XmlElement(name="First_Bid")
    public void setFirst_bid(String first_bid) {
        this.first_bid = first_bid;
    }

    public int getNum_bid() {
        return num_bid;
    }

    @XmlElement(name="Number_of_Bids")
    public void setNum_bid(int num_bid) {
        this.num_bid = num_bid;
    }

    public String getCountry() {
        return country;
    }

    @XmlElement(name="Country")
    public void setCountry(String country) {
        this.country = country;
    }

    public String getSt() {
        return st;
    }

    @XmlElement(name="Started")
    public void setSt(String st) {
        this.st = st;
    }

    public String getEnd() {
        return end;
    }

    @XmlElement(name="Ends")
    public void setEnd(String end) {
        this.end = end;
    }

    public String getDescription() {
        return description;
    }

    @XmlElement(name="Description")
    public void setDescription(String description) {
        this.description = description;
    }

    public List<String> getCategories() {
        return categories;
    }

    @XmlElement(name="Category")
    public void setCategories(List<String> categories) {
        this.categories = categories;
    }

    public xmlLocation getLocation() {
        return location;
    }

    @XmlElement(name="Location")
    public void setLocation(xmlLocation location) {
        this.location = location;
    }

    public xmlBids getBids() {
        return bids;
    }

    @XmlElement(name="Bids")
    public void setBids(xmlBids bids) {
        this.bids = bids;
    }

    public xmlSeller getSeller() {
        return seller;
    }

    @XmlElement(name="Seller")
    public void setSeller(xmlSeller seller) {
        this.seller = seller;
    }
}
