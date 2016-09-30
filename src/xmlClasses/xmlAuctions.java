package xmlClasses;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import java.io.FileNotFoundException;
import java.sql.SQLException;
import java.text.ParseException;
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
            } catch (ParseException e) {
                e.printStackTrace();
            }
        }
    }

    public void getauctions(Integer[] itemids) throws FileNotFoundException, SQLException {
        xmlAuction auction = new xmlAuction();

        xmlFunctions xmlfuncs = new xmlFunctions();


        for(int i=0;i<itemids.length;i++){
            auction = xmlfuncs.dbtoxml(itemids[i]);
            auctions.add(auction);
        }




    }

}
