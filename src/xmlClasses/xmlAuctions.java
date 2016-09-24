package xmlClasses;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import java.io.FileNotFoundException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@XmlRootElement( name = "Items" )
public class xmlAuctions {

    List<xmlAuction> auctions;

    public xmlAuctions() {
        auctions = new ArrayList<xmlAuction>();
    }

    public List<xmlAuction> getAuctions() {
        return auctions;
    }

    @XmlElement(name="Item")
    public void setAuctions(List<xmlAuction> auctions) {
        this.auctions = auctions;
    }

    public void sendauctions() throws FileNotFoundException, SQLException {

        for(int i=0; i<auctions.size(); i++){
            xmlAuction temp = new xmlAuction();
            temp = auctions.get(i);

            xmlFunctions xmlfuncs = new xmlFunctions();

            try {
                xmlfuncs.xmltodb(temp);
            } catch (FileNotFoundException e) {
                e.printStackTrace();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public void getauction(int itemid) throws FileNotFoundException, SQLException {
        xmlAuction auction = new xmlAuction();

        xmlFunctions xmlfuncs = new xmlFunctions();

        //TODO an kanoume gia polla items tha thelei loop,gia kathe itemID
        auction = xmlfuncs.dbtoxml(itemid);

        auctions.add(auction);
    }

}
