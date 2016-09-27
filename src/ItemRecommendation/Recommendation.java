package ItemRecommendation;

import Javabeans.Auction;
import Javabeans.DataBase;
import Javabeans.User;

import java.io.FileNotFoundException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class Recommendation {
    public static ArrayList<Integer> Similarity(int userid) throws FileNotFoundException, SQLException {
        DataBase db = new DataBase();
        db.openConn();
        ArrayList<Auction> auctions = Auction.Auctionlist("*");
        ArrayList<User> users= User.doSelectAll();
        int matrix[][] =  new int[users.size()][auctions.size()];
        ArrayList<Integer> recommendations = new ArrayList<Integer>();
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
                    }
                }
            }

        }
//        for (int i=0;i<users.size();i++){
//            for(int j=0;j<auctions.size();j++){
//                System.out.print("("+auctions.get(j).id+","+users.get(i).userID+","+matrix[i][j]+")");
//
//            }
//            System.out.println();
//        }
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
                System.out.println("dot===="+dotProduct);
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
        for(int i=0;i<users.size();i++){
            System.out.print("("+users.get(i).userID+","+ percentages[i]+")");
        }

    ///Parallel Bubble Sort between matrix and percentages///

            for(int j=0;j<users.size();j++){
                for(int k=0;k<(users.size()-1)-j;k++){
                    if(percentages[k]<percentages[k+1]){
                        double temp = percentages[k];
                        percentages[k]=percentages[k+1];
                        percentages[k+1]=temp;

                        for(int l=0; l<auctions.size();l++){
                            int temp2 = matrix[k][l];
                            matrix[k][l]=matrix[k+1][l];
                            matrix[k+1][l]=temp2;
                        }
                    }
                }
            }

//        for(int i=0;i<users.size();i++){
//            System.out.println(percentages[i]);
//            for(int j=0;j<auctions.size();j++){
//                System.out.print(matrix[i][j]);
//            }
//            System.out.println();
//        }
        db.closeConnection();
        return recommendations;
    }
}

