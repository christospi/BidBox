package xmlClasses;

import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlType;
import javax.xml.bind.annotation.XmlValue;

@XmlRootElement( name = "Location" )
public class xmlLocation {
    float longt;
    float lat;
    String city;

    public float getLongt() {
        return longt;
    }

    @XmlAttribute(name="Longitude")
    public void setLongt(float longt) {
        this.longt = longt;
    }

    public float getLat() {
        return lat;
    }

    @XmlAttribute(name="Latitude")
    public void setLat(float lat) {
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
