<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" charset="text/html; charset=UTF-8">
<title>Hello World</title>
</head>
<body>
	<%
		String userID=null;
		if(session.getAttribute("userID") != null)
		{
			userID = (String) session.getAttribute("userID");
		}
		String userPassword = request.getParameter("userPassword");
		String userName = request.getParameter("userName");
	
		UserDAO userDAO = new UserDAO();
		int result = userDAO.rename(userID, userPassword, userName);
		
		if(result == 1)
		{
			String[] personal = userDAO.personal(userID);
			session.setAttribute("userName", personal[1]);
			session.setAttribute("userProfile", personal[2]);
			
			response.sendRedirect("rename.jsp");
		}
		else if(result == 0)
		{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('오류! 다시 시도해주세요.')");
			script.println("history.back()");
			script.println("</script>");
		}
	%>
</body>
</html>