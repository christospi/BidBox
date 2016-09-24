package xmlClasses;

import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement( name = "Seller" )
public class xmlSeller {

    int rating;
    String username;

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
}
