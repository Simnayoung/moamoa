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
			String dbURL = "jdbc:mysql://ec2-18-224-2-255.us-east-2.compute.amazonaws.com/Recipe";
			String dbID = "young";
			String dbPassword="asdf";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}
	
	public String[][] listing(String[] searchList)
	{
		String SQL = "SELECT number, name, cookware FROM recipe";
		
		try
		{
			if (searchList == null) {
				stmt = conn.createStatement();
				rs = stmt.executeQuery(SQL);
				
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
				stmt = conn.createStatement();
				rs = stmt.executeQuery(SQL);
				
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
					pstmt.setInt(1,Integer.parseInt(recipeNum));
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
				
				if (ingredients != null) {
					for (int i = 0; i<ingredients.length ; i++) {
						if (i == 0)
							SQL2 += " recipe."+ingredients[i]+" = 1";
						else
							SQL2 += " AND recipe."+ingredients[i]+" = 1";
						}
					}
				if (tools != null) {
					for (int i = 0; i<tools.length;i++) {
						if (ingredients.length==0 && i == 0)
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
					String SQL3 = "INSERT INTO recipe (name, cookware";
					
					if (ingredients != null) {
						for (int i = 0; i<ingredients.length ; i++) {
							SQL3 += ", "+ingredients[i];
						}
					}
					if (tools != null) {
						for (int i = 0; i<tools.length;i++) {
							SQL3 += ", "+tools[i];
						}
					}
					SQL3 += ", "+cate+") VALUES (?, ?";
					if (ingredients != null && tools != null) {
						for (int i = 0; i<(ingredients.length+tools.length) ; i++) {
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
}
