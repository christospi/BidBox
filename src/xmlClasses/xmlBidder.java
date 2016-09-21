package xmlClasses;

import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlType;

@XmlType( propOrder = {"location", "country"})
@XmlRootElement( name = "Bidder" )
public class xmlBidder {
    int rating;
    String username;
    String location;
    String country;

    public int getRating() {
        return rating;
    }

    @XmlAttribute(name="Rating")
    public void setRating(int rating) {
        this.rating = rating;
    }

    public String getUserid() {
        return username;
    }

    @XmlAttribute(name="UserID")
    public void setUserid(String username) {
        this.username = username;
    }

    public String getLocation() {
        return location;
    }

    @XmlElement(name="Location")
    public void setLocation(String location) {
        this.location = location;
    }

    public String getCountry() {
        return country;
    }

    @XmlElement(name="Country")
    public void setCountry(String country) {
        this.country = country;
    }
}
