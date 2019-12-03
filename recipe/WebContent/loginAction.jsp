<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page"/>
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userPassword" />
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
		if (userID != null) // 이미 로그인된 사람은 로그인 페이지에 접속할 수 없음
		{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('( ⁰▱⁰ )!!!\n이미 로그인이 되어있습니다!')");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		}
	
		UserDAO userDAO = new UserDAO();
		int result = userDAO.login(user.getUserID(), user.getUserPassword());
		
		if(result == 1)
		{
			String[] personal = userDAO.personal(user.getUserID());
			session.setAttribute("userID", user.getUserID());
			session.setAttribute("userName", personal[1]);
			session.setAttribute("userProfile", personal[2]);
			session.setAttribute("diet", personal[3]);
			
			PrintWriter script = response.getWriter();
			script.println("<script>");
			response.sendRedirect((String)session.getAttribute("prev"));
			script.println("</script>");
		}
		else if(result == 0)
		{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('비밀번호가 틀립니다!')");
			script.println("history.back()");
			script.println("</script>");
		}
		else if(result == -1)
		{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('존재하지 않는 아이디입니다!')");
			script.println("history.back()");
			script.println("</script>");
		}
		else if(result == -2)
		{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('데이터베이스 오류가 발생했습니다!')");
			script.println("history.back()");
			script.println("</script>");
		}
	%>
</body>
</html>