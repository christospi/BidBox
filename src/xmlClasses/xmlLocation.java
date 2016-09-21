package xmlClasses;

import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlType;
import javax.xml.bind.annotation.XmlValue;

@XmlRootElement( name = "Location" )
public class xmlLocation {
    Double longt;
    Double lat;
    String city;

    public Double getLongt() {
        return longt;
    }

    @XmlAttribute(name="Longitude")
    public void setLongt(Double longt) {
        this.longt = longt;
    }

    public Double getLat() {
        return lat;
    }

    @XmlAttribute(name="Latitude")
    public void setLat(Double lat) {
        this.lat = lat;
    }

    public String getCity() {
        return city;
    }

    @XmlValue
    public void setCity(String city) {
        this.city = city;
    }
}
