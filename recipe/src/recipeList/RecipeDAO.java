package recipeList;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

public class RecipeDAO
{
   private PreparedStatement pstmt;
   private ResultSet rs_Info;
   private Connection conn;
   private Statement stmt;
   private ResultSet rs;
   
   public RecipeDAO()
   {
      try
      {
         String dbURL = "jdbc:mysql://ec2-18-224-2-255.us-east-2.compute.amazonaws.com/Recipe?useUnicode=true&characterEncoding=UTF-8";
         String dbID = "hyoj";
         String dbPassword="1234";
         Class.forName("com.mysql.jdbc.Driver");
         conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
      }
      catch(Exception e)
      {
         e.printStackTrace();
      }
   }
   
   public int recipeLikeNum(String recipeNum) {
      String SQL = "SELECT COUNT(*) FROM like_info where number="+recipeNum;
      int total = 0;
      try
      {
         stmt = conn.createStatement();
         rs = stmt.executeQuery(SQL);
      
         if (rs.next())
            total = rs.getInt(1);
         rs.close();
         return total;
      }
      catch(Exception e)
      {
         e.printStackTrace();
      }
      return 0;
   }
   
   public String[][] listing(String[] searchList, String pageNumber)
   {
      String SQL = "SELECT number, name, cookware FROM recipe";
      try
      {
         if (searchList == null) {
            SQL += " ORDER BY number ASC LIMIT ?, 10";
            pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, Integer.parseInt(pageNumber)*10);
            rs = pstmt.executeQuery();
            
            rs.last();
            int rowCount = rs.getRow();
            rs.beforeFirst();
            int count = 0;
            
            String[][] recipeContent = new String[rowCount][6];

            
            while (rs.next())
            {
               recipeContent[count][0] = rs.getString(1);
               recipeContent[count][1] = rs.getString(2);
               recipeContent[count][2] = rs.getString(3);
               
               String SQL2 = "SELECT content, material, image FROM recipe_info WHERE number = ?";
               pstmt = conn.prepareStatement(SQL2);
               pstmt.setString(1,recipeContent[count][0]);
               rs_Info = pstmt.executeQuery();
               
               while (rs_Info.next())
               {
                  recipeContent[count][3] = rs_Info.getString(1);
                  recipeContent[count][4] = rs_Info.getString(2);
                  recipeContent[count][5] = rs_Info.getString(3);
               }
               
               count++;
            }
            return recipeContent;
         }
         else {
            SQL += " WHERE ";
            for(int i = 0; i < searchList.length ; i++) {
               if (i == searchList.length - 1)
                  SQL += searchList[i] + " = 1";
               else 
                  SQL += searchList[i] + " = 1 AND ";
            }
            pstmt = conn.prepareStatement(SQL);
            rs = pstmt.executeQuery();
            
            rs.last();
            int rowCount = rs.getRow();
            rs.beforeFirst();
            int count = 0;
            String[][] recipeContent = new String[rowCount][6];
            
            while (rs.next())
            {
               recipeContent[count][0] = rs.getString(1);
               recipeContent[count][1] = rs.getString(2);
               recipeContent[count][2] = rs.getString(3);
               
               String SQL2 = "SELECT content, material, image FROM recipe_info WHERE number = ?";
               pstmt = conn.prepareStatement(SQL2);
               pstmt.setString(1,recipeContent[count][0]);
               rs_Info = pstmt.executeQuery();
               
               while (rs_Info.next())
               {
                  recipeContent[count][3] = rs_Info.getString(1);
                  recipeContent[count][4] = rs_Info.getString(2);
                  recipeContent[count][5] = rs_Info.getString(3);
               }
               
               count++;
            }
            return recipeContent;
         }
      }
      catch(Exception e)
      {
         e.printStackTrace();
      }
      return null; //데이터베이스 오류
   }
   
   public String[] recipeInfo(String recipeNum)
   {
      String SQL = "SELECT recipe.name, recipe.cookware, recipe_info.content, recipe_info.material, recipe_info.image FROM recipe, recipe_info WHERE recipe.number = "+recipeNum+" and recipe_info.number = "+recipeNum;
      
      try
      {
         stmt = conn.createStatement();
         rs = stmt.executeQuery(SQL);
         String[] recipeContent = new String[5];
         
         while (rs.next())
         {
            recipeContent[0] = rs.getString(1);
            recipeContent[1] = rs.getString(2);
            recipeContent[2] = rs.getString(3);
            recipeContent[3] = rs.getString(4);
            recipeContent[4] = rs.getString(5);
         }
         
         return recipeContent;
      }
      catch(Exception e)
      {
         e.printStackTrace();
      }
      
      return null;
   }
   
   public String[] recipeLikeList(String UserID)
   {
      String SQL = "SELECT number FROM like_info WHERE id = "+UserID;
      
      try
      {
         stmt = conn.createStatement();
         rs = stmt.executeQuery(SQL);
         
         rs.last();
         int rowCount = rs.getRow();
         rs.beforeFirst();
         int count = 0;
         
         String[] recipeList = new String[rowCount];
      
         while (rs.next())
            recipeList[count++] = rs.getString(1);
      
         return recipeList;
      }
      catch(Exception e)
      {
         e.printStackTrace();
      }
      return null;
   }
   public int recipeLike(String recipeNum, String UserID, int plug)
   {
      if (plug == 1) {
         String SQL = "SELECT number FROM like_info WHERE id = "+UserID;
      
         try
         {
            stmt = conn.createStatement();
            rs = stmt.executeQuery(SQL);
         
            while (rs.next())
               if (rs.getString(1).equals(recipeNum))
                  return 1;
         
            return 0;
         }
         catch(Exception e)
         {
            e.printStackTrace();
         }
      }
      else {
         String SQL = null;
         if (plug == 2)
            SQL = "DELETE FROM like_info WHERE number = ? AND id = ?";
         else if (plug == 3)
            SQL = "INSERT INTO like_info (number, id) VALUES ("+recipeNum+", "+UserID+")";
         
         try
         {
            if (plug == 2) {
               pstmt = conn.prepareStatement(SQL);
               pstmt.setString(1,recipeNum);
               pstmt.setString(2, UserID);
               pstmt.executeUpdate();
            }
            else if (plug == 3) {
               stmt = conn.createStatement();
               stmt.executeUpdate(SQL); 
            }
         
            return 1;
         }
         catch(Exception e)
         {
            e.printStackTrace();
            return 0;
         }
      }
      
      return 0;
   }
   
      public int recipeInsert(String name, String content, String cate, String[] ingredients, String[] tools, String material, String cookware)
      {
         String SQL = "SELECT * FROM recipe WHERE name = ?";
         
         try
         {
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1,name);
            rs = pstmt.executeQuery();
            
            rs.last();
            int rowCount = rs.getRow();
            
            if (rowCount != 0)
               return 0;
            else {
               PreparedStatement stmt2;
               ResultSet rs2;
               
               String SQL2 = "SELECT recipe.number, recipe_info.number FROM recipe, recipe_info WHERE";
               
               if (ingredients != null && ingredients.length != 0) {
                  for (int i = 0; i<ingredients.length ; i++) {
                     if (i == 0)
                        SQL2 += " recipe."+ingredients[i]+" = 1";
                     else
                        SQL2 += " AND recipe."+ingredients[i]+" = 1";
                     }
                  }
               if (tools != null && tools.length != 0) {
                  for (int i = 0; i<tools.length;i++) {
                     if (ingredients == null && i == 0)
                        SQL2 += " recipe."+tools[i]+" = 1";
                     else
                        SQL2 += " AND recipe."+tools[i]+" = 1";
                     }
                  }
               if (ingredients == null && tools == null)
                  SQL2 += " recipe."+cate+" = 1";
               else
                  SQL2 += " AND recipe."+cate+" = 1";
               SQL2 += " AND recipe_info.content = ?";

               stmt2 = conn.prepareStatement(SQL2);
               stmt2.setString(1, content);

               rs2 = stmt2.executeQuery();
               
               rs2.last();
               int rowCount2 = rs2.getRow();
               
               if (rowCount2 != 0)
                  return 0;
               else {
                  String SQL6 = "SELECT content FROM recipe_info";
                  stmt = conn.createStatement();
                  rs = stmt.executeQuery(SQL6);
                  int plug = 1;
                  
                  while(rs.next()) {
                     String contentCheck = rs.getString(1);
                     int percent = 0;
                     for (int k = 0; k<contentCheck.length();k++) {
                        if (k>content.length()-1)
                           break;
                        if (content.charAt(k) == contentCheck.charAt(k))
                           percent++;
                     }
                     if ((percent/content.length())*100 > 80) {
                        plug = 0;
                        break;
                     }
                  }
                  
                  if (plug == 1) {
                     String SQL3 = "INSERT INTO recipe (name, cookware";
                     
                     if (ingredients != null && ingredients.length != 0) {
                        for (int i = 0; i<ingredients.length ; i++) {
                           SQL3 += ", "+ingredients[i];
                        }
                     }
                     if (tools != null && tools.length != 0) {
                        for (int i = 0; i<tools.length;i++) {
                           SQL3 += ", "+tools[i];
                        }
                     }
                     SQL3 += ", "+cate+") VALUES (?, ?";
                     if (ingredients != null && ingredients.length != 0) {
                        for (int i = 0; i<ingredients.length ; i++) {
                           SQL3 += ", 1";
                        }
                     }
                     if (tools != null && tools.length != 0) {
                        for (int i = 0; i<tools.length;i++) {
                           SQL3 += ", 1";
                        }
                     }
                     SQL3 += ", 1)";
      
                     
                     PreparedStatement pres = conn.prepareStatement(SQL3);
                     pres.setString(1, name);
                     pres.setString(2, cookware);
                     pres.executeUpdate();
                     
                     String SQL4 = "SELECT number FROM recipe ORDER BY number DESC LIMIT 1";
                     stmt = conn.createStatement();
                     rs = stmt.executeQuery(SQL4);
                     int recipeNumber = 0;
                     while(rs.next())
                        recipeNumber = rs.getInt(1);
                     String SQL5 = "INSERT INTO recipe_info (number, content, material) VALUES (?, ? ,?)";
                     pres = conn.prepareStatement(SQL5);
                     pres.setInt(1, recipeNumber);
                     pres.setString(2, content);
                     pres.setString(3, material);
      
                     pres.executeUpdate();
                     
                     return recipeNumber;
                  }
                  else
                     return 0;
               }
            }
         }
         catch(Exception e)
         {
            e.printStackTrace();
         }
         
         return -1;
      }
   
   public int profile (String newNum, String profile)
   {
      String SQL = "UPDATE recipe_info SET image = ? WHERE number = ?";
      
      try
         {
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, profile);
            pstmt.setString(2, newNum);
            pstmt.executeUpdate();

            return 1;
         }
         catch(Exception e)
         {
            e.printStackTrace();
         }
         return 0;
   }
   
   public String[][] reviewGet(String recipeNum)
   {
      String SQL = "SELECT id, content, image, name FROM review WHERE number = ?";
      
      try
      {
         pstmt = conn.prepareStatement(SQL);
         pstmt.setString(1,recipeNum);
         rs = pstmt.executeQuery();
         
         rs.last();
         int rowCount = rs.getRow();
         rs.beforeFirst();
         int count = 0;
         
         String[][] reviewList = new String[rowCount][4];
         
         while (rs.next()) {
            reviewList[count][0] = rs.getString(1);
            reviewList[count][1] = rs.getString(2);
            reviewList[count][2] = rs.getString(3);
            reviewList[count][3] = rs.getString(4);
            
            count++;
         }
            
         return reviewList;
      }
      catch(Exception e)
      {
         e.printStackTrace();
      }
      return null; //데이터베이스 오류
   }
   
   public String[] reviewGGet(String userID, String recipeNum)
   {
      if (recipeNum != null) {
         String SQL = "SELECT content, image FROM review WHERE id = ? AND number = ?";
      
         try
         {
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1,userID);
            pstmt.setString(2,recipeNum);
            rs = pstmt.executeQuery();
            
            String[] reviewList = new String[2];
            
            while (rs.next()) {
               reviewList[0] = rs.getString(1);
               reviewList[1] = rs.getString(2);
            }
               
            return reviewList;
         }
         catch(Exception e)
         {
            e.printStackTrace();
         }
      }
      else {
         String SQL = "SELECT number FROM review WHERE id = ?";
         
         try
         {
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1,userID);
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
               rs.last();
               int rowCount = rs.getRow();
               rs.beforeFirst();
               int count = 0;
               
               String[] reviewList = new String[rowCount];
               
               while (rs.next()) {
                  reviewList[count] = rs.getString(1);
                  count++;
               }
                  
               return reviewList;
            }
            else
               return null;
         }
         catch(Exception e)
         {
            e.printStackTrace();
         }
      }
      return null; //데이터베이스 오류
   }
   
   public int reviewInput(String userID, String content, String image, String recipeNum, String userName)
   {
      String SQL = null;
      
      try
      {
         String SQL2 = "SELECT * FROM review WHERE id = ? and number = ?";
         pstmt = conn.prepareStatement(SQL2);
         pstmt.setString(1,userID);
         pstmt.setString(2,recipeNum);
         rs = pstmt.executeQuery();
         
         rs.last();
         int rowCount2 = rs.getRow();
         
         if (rowCount2 != 0)
            return -1;
         else {
         SQL = "INSERT INTO review (number, id, content, image, name) VALUES (?,?,?, ?,?)";
         
         pstmt = conn.prepareStatement(SQL);
         pstmt.setString(1,recipeNum);
         pstmt.setString(2,userID);
         pstmt.setString(3,content);
         pstmt.setString(4,image);
         pstmt.setString(5,userName);
         pstmt.executeUpdate();
         
         return 1;
         }
      }
      catch(Exception e)
      {
         e.printStackTrace();
      }
      return 0; //데이터베이스 오류
   }
   
   public int modifyReview (String userID, String number, String content, String image)
   {
      if (image == null) {
         String SQL = "UPDATE review SET content = ? WHERE id = ? and number = ?";
         try
         {
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, content);
            pstmt.setString(2, userID);
            pstmt.setString(3, number);
            pstmt.executeUpdate();
            
            return 1;
         }
         catch(Exception e)
         {
            e.printStackTrace();
            return 0;
         }
      }
      else {
         String SQL = "UPDATE review SET image = ? WHERE id = ? and number = ?";
         try
         {
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, image);
            pstmt.setString(2, userID);
            pstmt.setString(3, number);
            pstmt.executeUpdate();
            
            return 1;
         }
         catch(Exception e)
         {
            e.printStackTrace();
            return 0;
         }
      }
   }
   
   public int delReview (String userID, String number)
   {
      try {
         String SQL = "DELETE FROM review WHERE number = ? AND id = ?";
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, number);
            pstmt.setString(2, userID);
            pstmt.executeUpdate();
            
            return 1;
         }
         catch(Exception e)
         {
            e.printStackTrace();
            return 0;
         }
      }
   
   public boolean nextPage (String pageNumber)
   {
      try {
         String SQL = "SELECT number FROM recipe ORDER BY number ASC LIMIT ?, 1";
            pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, (Integer.parseInt(pageNumber)+1)*10);
            rs = pstmt.executeQuery();
            
            if (rs.next())
               return true;
            else
               return false;
         }
         catch(Exception e)
         {
            e.printStackTrace();
            return false;
         }
   }
}