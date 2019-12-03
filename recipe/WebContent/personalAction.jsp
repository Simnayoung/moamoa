<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" charset="text/html; charset=UTF-8">
<title>✿모아모아 레시피✿</title>
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
		String userMode = request.getParameter("diet");
	
		UserDAO userDAO = new UserDAO();
		int result = 0;
		if (userMode.equals("off"))
			result = userDAO.rename(userID, userPassword, userName, "0");
		else if (userMode.equals("on"))
			result = userDAO.rename(userID, userPassword, userName, "1");		
		
		if(result == 1)
		{
			String[] personal = userDAO.personal(userID);
			session.setAttribute("userName", personal[1]);
			session.setAttribute("userProfile", personal[2]);
			if (userMode.equals("off"))
				session.setAttribute("diet", "0");
			else if (userMode.equals("on"))
				session.setAttribute("diet", "1");
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('(๑•̀ㅂ•́)و'\n수정이 완료되었습니다!')");
			script.println("</script>");
			response.sendRedirect("rename.jsp");
		}
		else if(result == 0)
		{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('( ⁰▱⁰ )!!!\n오류가 발생했습니다!')");
			script.println("history.back()");
			script.println("</script>");
		}
	%>
</body>
</html>