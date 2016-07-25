package Javabeans;

import java.io.*;
import java.sql.*;
import java.util.Properties;
import java.util.logging.Logger;
import java.util.logging.Level;

public class DataBase implements Serializable{

    private static String dbUrl;
    private static  String dbDriver;
    private static  String user;
    private static  String password;
    private Connection conn;
    private Statement st;
    private ResultSet rs;

    /**************************************************************************/
    public void importProperties() throws FileNotFoundException {

        Properties props = new Properties();

        try{
            FileReader reader = new FileReader("/home/chris/IdeaProjects/BidBox/src/Javabeans/db.properties");
            props.load(reader);
        } catch (IOException e) {
            e.printStackTrace();
        }

        user = props.getProperty("username");
        password = props.getProperty("password");
        dbUrl = props.getProperty("databaseUrl");
        dbDriver = props.getProperty("driverClassName");

        System.out.println("Diavasa apo to property file ta :  " +user +"  "+ password +"  "+ dbUrl+"  "+dbDriver );

    }

    public void openConn() throws FileNotFoundException {

        importProperties();

        try {
            Class.forName(dbDriver).newInstance();
            conn = DriverManager.getConnection(dbUrl, user, password);
            setStatement(conn.createStatement());

        } catch (SQLException | ClassNotFoundException | InstantiationException | IllegalAccessException ex) {
            Logger.getLogger(DataBase.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public Connection getConn() {
        return this.conn;
    }

    public void setStatement(Statement statement) {
        this.st = statement;
    }

    public Statement getStatement() {
        return this.st;
    }

    public void setResultSet(ResultSet result) {
        this.rs = result;
    }

    public ResultSet setResultSet() {
        return this.rs;
    }

    public void closeConnection() {

        try {
            this.conn.close();
        } catch (SQLException ex) {
            Logger.getLogger(DataBase.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    // EXEQUTE QUERY
    public ResultSet executeQuery(String query) {

        try {
            this.rs = getStatement().executeQuery(query);
        } catch (SQLException ex) {
            Logger.getLogger(DataBase.class.getName()).log(Level.SEVERE, null, ex);
        }

        return this.rs;
    }

    // EXECUTE QUERY IN ORDER TO UPDATE DATABASE
    public int executeUpdate(String query) {

        int num = 0;

        try {
            num = getStatement().executeUpdate(query);
        } catch (SQLException ex) {
            Logger.getLogger(DataBase.class.getName()).log(Level.SEVERE, null, ex);
        }

        return num;
    }
}
