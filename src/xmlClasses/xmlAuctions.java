package xmlClasses;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import java.util.ArrayList;
import java.util.List;

@XmlRootElement( name = "Items" )
public class xmlAuctions {

    List<xmlAuction> auctions;

    public List<xmlAuction> getAuctions() {
        return auctions;
    }

    @XmlElement(name="Item")
    public void setAuctions(List<xmlAuction> auctions) {
        this.auctions = auctions;
    }



}
