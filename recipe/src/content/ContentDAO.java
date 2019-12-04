package content;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

public class ContentDAO {
	private PreparedStatement pstmt;
	private PreparedStatement pstmt_;
	private ResultSet rs_Info;
	private Connection conn;
	private Statement stmt;
	private ResultSet rs;
	
	public ContentDAO()
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
	
	public String[][] listing(String userID)
	{
		String SQL = null;
		
		try
		{			
			if (userID == null) {
				SQL = "SELECT id, title, content, number, name FROM question";
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
					recipeContent[count][3] = rs.getString(4);
					recipeContent[count][4] = rs.getString(5);
					
					String SQL2 = "SELECT * FROM reply WHERE number = ?";
					pstmt = conn.prepareStatement(SQL2);
					pstmt.setInt(1,Integer.parseInt(recipeContent[count][3]));
					rs_Info = pstmt.executeQuery();
					
					rs_Info.last();
					int colCount = rs_Info.getRow();
					rs_Info.beforeFirst();
					
					recipeContent[count][5] = Integer.toString(colCount);
					count++;
				}
				return recipeContent;
			}
			else {
				SQL = "SELECT title, content, number FROM question where id = ?";
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1,userID);
				rs = pstmt.executeQuery();
				
				rs.last();
				int rowCount = rs.getRow();
				rs.beforeFirst();
				int count = 0;
				String[][] recipeContent = new String[rowCount][4];
				
				while (rs.next())
				{
					recipeContent[count][0] = rs.getString(1);
					recipeContent[count][1] = rs.getString(2);
					recipeContent[count][2] = rs.getString(3);
					
					String SQL2 = "SELECT * FROM reply WHERE number = ?";
					pstmt = conn.prepareStatement(SQL2);
					pstmt.setInt(1,Integer.parseInt(recipeContent[count][2]));
					rs_Info = pstmt.executeQuery();
					
					rs_Info.last();
					int colCount = rs_Info.getRow();
					rs_Info.beforeFirst();
					
					recipeContent[count][3] = Integer.toString(colCount);
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
	
	public String[][] replyList(String questNum)
	{
		String SQL = null;
		
		try
		{
			SQL = "SELECT id, title, content, name FROM question WHERE number = ?";
			
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,Integer.parseInt(questNum));
			rs = pstmt.executeQuery();
			
			String[][] temp = new String[1][4];
			
			while (rs.next()) {
				temp[0][0] = rs.getString(1);
				temp[0][1] = rs.getString(2);
				temp[0][2] = rs.getString(3);
				temp[0][3] = rs.getString(4);
			}
			
			try {
				String SQL2 = "SELECT content, name FROM reply WHERE number = ?";
			
				pstmt_ = conn.prepareStatement(SQL2);
				pstmt_.setInt(1,Integer.parseInt(questNum));
				rs_Info = pstmt_.executeQuery();
					
				rs_Info.last();
				int rowCount = rs_Info.getRow();
				rs_Info.beforeFirst();
				int count = 1;
				String[][] replyContent = new String[rowCount+1][4];
				replyContent[0][0] = temp[0][0];
				replyContent[0][1] = temp[0][1];
				replyContent[0][2] = temp[0][2];
				replyContent[0][3] = temp[0][3];
					
				while (rs_Info.next()) {
						replyContent[count][0] = rs_Info.getString(1);
						replyContent[count][1] = rs_Info.getString(2);
						replyContent[count][2] = "no";
						replyContent[count][3] = "no";
						
						count++;
				}
					return replyContent;
				}
				catch(Exception e)
				{
					e.printStackTrace();
				}
				
			return temp;
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return null; //데이터베이스 오류
	}
	
	public int questInput(String content, String title, String questNum, String userID, String userName)
	{
		String SQL = null;
		
		try
		{
			SQL = "INSERT INTO question VALUES (?,?,?,?,?)";
			
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,userID);
			pstmt.setString(2,title);
			pstmt.setString(3,content);
			pstmt.setString(4,questNum);
			pstmt.setString(5,userName);
			pstmt.executeUpdate();
			
			return 1;
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return 0; //데이터베이스 오류
	}
	
	public int replyInput(String userID, String content, String questNum, String userName)
	{
		String SQL = null;
		
		try
		{
			SQL = "INSERT INTO reply (id, content, number, name) VALUES (?,?,?,?)";
			
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,userID);
			pstmt.setString(2,content);
			pstmt.setString(3,questNum);
			pstmt.setString(4,userName);
			pstmt.executeUpdate();
			
			return 1;
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return 0; //데이터베이스 오류
	}
	
	   public int modifyQuest (String userID, String number, String title, String content)
	   {
	      if (title != null && title.length() != 0) {
	         String SQL = "UPDATE question SET title = ? WHERE id = ? and number = ?";
	         try
	         {
	            pstmt = conn.prepareStatement(SQL);
	            pstmt.setString(1, title);
	            pstmt.setString(2, userID);
	            pstmt.setString(3, number);
	            pstmt.executeUpdate();
	         }
	         catch(Exception e)
	         {
	            e.printStackTrace();
	            return 0;
	         }
	      }
	      
	      if (content != null && content.length() != 0) {
	         String SQL = "UPDATE question SET content = ? WHERE id = ? and number = ?";
	         try {
	            pstmt = conn.prepareStatement(SQL);
	            pstmt.setString(1, content);
	            pstmt.setString(2, userID);
	            pstmt.setString(3, number);
	            pstmt.executeUpdate();
	         }
	         catch(Exception e)
	         {
	            e.printStackTrace();
	            return 0;
	         }
	      }
	      
	      return 1;
	   }
	
	public int delQuest (String userID, String number)
	{
		try {
			String SQL = "DELETE FROM question WHERE number = ? AND id = ?";
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, number);
				pstmt.setString(2, userID);
				pstmt.executeUpdate();
				
				try {
					String SQL2 = "DELETE FROM reply WHERE number = ?";
					pstmt_ = conn.prepareStatement(SQL2);
					pstmt_.setString(1, number);
					pstmt_.executeUpdate();
				}
				catch(Exception e)
				{
					e.printStackTrace();
					return 0;
				}
				return 1;
			}
			catch(Exception e)
			{
				e.printStackTrace();
				return 0;
			}
		}
}
