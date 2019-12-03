package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.oreilly.servlet.MultipartRequest;

public class UserDAO
{
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public UserDAO()
	{
		try
		{
			String dbURL = "jdbc:mysql://ec2-18-224-2-255.us-east-2.compute.amazonaws.com/Recipe";
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
	
	public int login(String userID, String userPassword)
	{
		String SQL = "SELECT pw FROM user WHERE id = ?";
		
		try
		{
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next())
			{
				if(rs.getString(1).equals(userPassword))
					return 1; //로그인 성공
				else
					return 0; //비밀번호 틀림
			}
			return -1; //아이디가 없음
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return -2; //데이터베이스 오류
	}
	
	public int join(User user)
	{
		String SQL = "SELECT name FROM user";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next())
			{
				if (rs.getString(1).equals(user.getUserName())) 
					return 0;
				else
				{
					SQL = "INSERT INTO USER VALUES (?,?,?)";
					try
					{
						pstmt = conn.prepareStatement(SQL);
						pstmt.setString(1, user.getUserID());
						pstmt.setString(2, user.getUserPassword());
						pstmt.setString(3, user.getUserName());
						pstmt.executeUpdate();
						return 1;
					}
					catch(Exception e)
					{
						e.printStackTrace();
					}
					return -1;
				}
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return -2;
	}
	
	public String[] personal (String userID)
	{
		String SQL = "SELECT pw, name, profile, diet FROM user WHERE id = ?";
		
		try
			{
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, userID);
				rs = pstmt.executeQuery();
				String[] result = new String[4];
				
				if(rs.next())
				{
					result[0] = rs.getString(1);
					result[1] = rs.getString(2);
					if (rs.getString(3) == null)
						result[2] = "/recipe/userImg/member.png";
					else
						result[2] = rs.getString(3);
					result[3] = Integer.toString(rs.getInt(4));
				}
				return result;
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
			return null;
		}
	
	public int profile (String userID, String profile)
	{
		String SQL = "UPDATE user SET profile = ? WHERE id = ?";
		
		try
			{
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, profile);
				pstmt.setString(2, userID);
				pstmt.executeUpdate();

				return 1;
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
			return 0;
	}
	
	public int rename (String userID, String userPassword, String userName, String userMode)
	{
		String SQL = "UPDATE user SET diet = ? WHERE id = ?";
		
		try
			{
				pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1, Integer.parseInt(userMode));
				pstmt.setString(2, userID);
				pstmt.executeUpdate();
			
				if (userPassword != null && userPassword.length() != 0) {
					SQL = "UPDATE user SET pw = ? WHERE id = ?";
					pstmt = conn.prepareStatement(SQL);
					pstmt.setString(1, userPassword);
					pstmt.setString(2, userID);
					pstmt.executeUpdate();
				}
				if (userName != null && userName.length() != 0 ) {
					for (int i = 0; i<4; i++) {
						if (i==0)
							SQL = "UPDATE user SET name = ? WHERE id = ?";
						else if (i==1)
							SQL = "UPDATE question SET name = ? WHERE id = ?";
						else if (i==2)
							SQL = "UPDATE reply SET name = ? WHERE id = ?";
						else if (i==3)
							SQL = "UPDATE review SET name = ? WHERE id = ?";
						pstmt = conn.prepareStatement(SQL);
						pstmt.setString(1, userName);
						pstmt.setString(2, userID);
						pstmt.executeUpdate();
					}
				}

				return 1;
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
			return 0;
	}
}
