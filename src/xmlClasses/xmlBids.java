package xmlClasses;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import java.util.List;

@XmlRootElement( name = "Bids" )
public class xmlBids {
    List<xmlBid> bids;

    public List<xmlBid> getBids() {
        return bids;
    }
    @XmlElement(name="Bid")
    public void setBids(List<xmlBid> bids) {
        this.bids = bids;
    }
}
