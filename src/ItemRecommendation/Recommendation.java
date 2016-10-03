package ItemRecommendation;

import Javabeans.Auction;
import Javabeans.DataBase;
import Javabeans.User;
import com.sun.org.apache.xml.internal.utils.res.IntArrayWrapper;

import java.io.FileNotFoundException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

public class Recommendation {

    public static ArrayList<Integer> getfromDB(int userid) throws FileNotFoundException, SQLException {
        ArrayList<Integer> itemlist = new ArrayList<>();
        DataBase db = new DataBase();
        db.openConn();
        String query = "SELECT * FROM recommendations WHERE userID='" + userid +"' ";
        ResultSet rs = db.executeQuery(query);
        while(rs.next()){
            itemlist.add(rs.getInt("itemID"));

        }                                           //returns the recommended items for the given userid
        db.closeConnection();
        return itemlist;
    }

    public static ArrayList<Integer> Similarity(int userid) throws FileNotFoundException, SQLException {
        DataBase db = new DataBase();
        db.openConn();
        ArrayList<Auction> auctions = Auction.Auctionlist("*");
        ArrayList<User> users= User.doSelectAll();
        User user = User.getusername(userid);
        int matrix[][] =  new int[users.size()][auctions.size()];
        ArrayList<Integer>  user_items = new ArrayList<>(); //items user has bid , we need it in case of random choices
        Double recommendations[] = new Double[auctions.size()];
        Double percentages[]= new Double[users.size()];
        String query = "SELECT * FROM bid ";
        ResultSet rs = db.executeQuery(query);
        int itemid;
        int bidderid;
        int pos=0;

        while (rs.next()){
            itemid=rs.getInt("itemID");
            bidderid = rs.getInt("userID");
            for (int i=0;i<users.size();i++){
                if(userid==users.get(i).userID){
                    pos = i;
                }
                for(int j=0;j<auctions.size();j++){
                    if(itemid==auctions.get(j).id && users.get(i).userID == bidderid){
                        matrix[i][j]=1;
                        if(userid==users.get(i).userID ){
                            user_items.add(auctions.get(j).id);
                        }
                    }

                }
            }

        }
        for (int i=0;i< auctions.size();i++){
            if(user.username.equals(auctions.get(i).seller)){

               if(!user_items.contains(auctions.get(i).id)) user_items.add(auctions.get(i).id);
            }
        }

        double dotProduct = 0;
        double magnitude1=0;
        double magnitude2=0;
        for(int i=0;i<users.size();i++){
            if(i==pos) {
                percentages[i]=0.0;
                continue;
            }
            dotProduct=0;
            magnitude1=0;
            magnitude2=0;
            for(int j=0;j<auctions.size();j++){
                dotProduct += (matrix[i][j] * matrix[pos][j]);
//                System.out.println("dot===="+dotProduct);
                magnitude1 += Math.pow(matrix[pos][j], 2);
                magnitude2 += Math.pow(matrix[i][j], 2);
            }

            magnitude1=Math.sqrt(magnitude1);
            magnitude2=Math.sqrt(magnitude2);
            if((magnitude1*magnitude2)==0){
                percentages[i]=0.0;
            }else {
                percentages[i] = (dotProduct / (magnitude1 * magnitude2)) * 100;
            }


        }


    ///Parallel Bubble Sort between matrix and percentages///

            for(int j=0;j<users.size();j++){
                for(int k=0;k<(users.size()-1)-j;k++){
                    if(percentages[k]<percentages[k+1]){
                        double temp = percentages[k];
                        percentages[k]=percentages[k+1];
                        percentages[k+1]=temp;
                        if(k==pos){
                            pos=k+1;
                        }else if(pos==k+1){
                            pos=k;
                        }
                        for(int l=0; l<auctions.size();l++){

                            int temp2 = matrix[k][l];
                            matrix[k][l]=matrix[k+1][l];
                            matrix[k+1][l]=temp2;
                        }
                    }
                }
            }
        //  Make zero the items user has already made a bid for them//
        Integer count[] = new Integer[users.size()];
        for(int i=0;i<users.size();i++){
            count[i]=0;
            if (i==pos) continue;

            for(int j=0;j<auctions.size();j++){
                if (matrix[i][j]==1 && matrix[pos][j]==1){
                    matrix[i][j]=0;

                }else{
                    count[i]+=matrix[i][j];
                }
            }
        }
        double sum=0.0;
        for(int j=0;j<users.size();j++){  //in most cases this should be 30 , the 30 best users
            if(count[j]!=0 && pos!=j){
                sum=sum+percentages[j]; //sum up all the percentages in order to normalize the results by 100%
            }

        }
//        System.out.println("sum"+sum);
        for(int j=0;j<auctions.size();j++){
            recommendations[j]=0.0;
            for(int i=0;i<users.size();i++){
                if(matrix[i][j]!=0 && percentages[i]!=0){
//                    System.out.println("matrix"+matrix[i][j]+" percentages "+percentages[i]+" sum"+sum);
                    recommendations[j]+= (((matrix[i][j]*percentages[i]*100)/sum));
                }
            }
        }
       Integer itemsids[] = new Integer[auctions.size()];
        for(int j=0;j<auctions.size();j++){
//            System.out.print("itemid: "+auctions.get(j).id);
//            System.out.println(" rec"+j+": "+recommendations[j]);
            itemsids[j]=auctions.get(j).id;
        }
        //Sorting ids from the best to the worst recommendation //
        for(int i=0;i<auctions.size();i++){
            for(int j=0;j<(auctions.size()-1)-i;j++){
                if(recommendations[j]<recommendations[j+1]){
                    double temp;
                    temp=recommendations[j];
                    recommendations[j]=recommendations[j+1];
                    recommendations[j+1]=temp;
                    int temp2;
                    temp2=itemsids[j];
                    itemsids[j]=itemsids[j+1];
                    itemsids[j+1]=temp2;

                }
            }
        }


        ArrayList<Integer>  final_list = new ArrayList<>(10);

        int count2=0;
        for(int i=0;i<itemsids.length;i++){
            if(recommendations[i]==0) break;
            if(!user_items.contains(itemsids[i])) {
                final_list.add(itemsids[i]);
                count2++;
            }
        }
        Random rand = new Random();

        int  n = rand.nextInt(itemsids.length) ;
//        System.out.println(itemsids.length-user_items.size());

        if(itemsids.length-user_items.size()>=10) {
            for (int i = count2; i < 10; i++) {
                while (final_list.contains(itemsids[n]) || user_items.contains(itemsids[n])) {
                    n = rand.nextInt(itemsids.length);
                }
                final_list.add(itemsids[n]);
            }
        }else if(itemsids.length-user_items.size()>=count2){
            for (int i = count2; i < itemsids.length-user_items.size(); i++) {
                while (final_list.contains(itemsids[n]) || user_items.contains(itemsids[n])) {
                    n = rand.nextInt(itemsids.length);
                }
                final_list.add(itemsids[n]);
            }
        }


        db.closeConnection();
        return final_list;
    }
}

