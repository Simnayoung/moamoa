<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<%@ page import="java.util.*" %>
<%@ page import="content.ContentDAO" %>
<%@ page import="java.io.PrintWriter" %>
<link href="css/style.css" rel="stylesheet" type="text/css">
<title>✿모아모아 레시피✿</title>
</head>
<body>
	<%
	String questNumber = request.getParameter("number");
	
	String userID = null;
	String userName = null;
	if(session.getAttribute("userID") != null)  {
		userID = (String) session.getAttribute("userID");
		userName = (String) session.getAttribute("userName");
	}
	
	String content = request.getParameter("replyContent");
	
	if (content == null)
	{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('( ⁰▱⁰ )!!!\n입력되지 않은 사항이 있습니다!')");
		script.println("history.back()");
		script.println("</script>");
	}
	
	ContentDAO contentDAO = new ContentDAO();
	int result = contentDAO.replyInput(userID, content.replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">","&gt;").replaceAll("\n","<br>"),questNumber,userName);
	
	if(result == 1)
	{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('(๑•̀ㅂ•́)و'\n등록이 완료되었습니다!')");
		script.println("opener.location.reload()");
		script.println("window.location = document.referrer");
		script.println("</script>");
	}
	else if(result == 0)
	{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('( ⁰▱⁰ )!!!\n데이터베이스 오류가 발생했습니다!')");
		script.println("history.back()");
		script.println("</script>");
	}
	%>
</body>
</html>