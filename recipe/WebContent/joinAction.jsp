<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page"/>
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userPassword" />
<jsp:setProperty name="user" property="userName" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
		if (userID != null) // 이미 로그인 된 사람은 회원가입 페이지에 접속할 수 없음
		{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 로그인이 되어있습니다.')");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		}
		out.println(user.getUserID());
		out.println(user.getUserName());
		out.println(user.getUserPassword());
	
		if(user.getUserID()==null || user.getUserPassword()==null ||
		user.getUserName()==null) // 회원가입 시 모든사항 입력해야함
		{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력되지 않은 사항이 있습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else
		{
			UserDAO userDAO = new UserDAO(); // 데이터베이스에 접근할 수 있는 객체 생성
			
			int result = userDAO.join(user);
			
			if(result == -1)
			{
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('이미 존재하는 아이디입니다.')");
				script.println("history.back()");
				script.println("</script>");
			}
			else if(result == -2)
			{
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('데이터베이스 오류가 발생했습니다.')");
				script.println("history.back()");
				script.println("</script>");
			}
			else if(result == -1)
			{
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('이미 존재하는 닉네임입니다.')");
				script.println("history.back()");
				script.println("</script>");
			}
			else if(result == 1)
			{
				session.setAttribute("userID", user.getUserID());
				int result1 = userDAO.profile(userID, "/recipe/userImg/member.png");
				session.setAttribute("userProfile", "/recipe/userImg/member.png");
				
				PrintWriter script = response.getWriter();
				script.println("<script>");
				response.sendRedirect((String)session.getAttribute("prev"));
				script.println("</script>");
			}
		}
	%>
</body>
</html>