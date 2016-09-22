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

}
