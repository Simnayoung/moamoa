<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ page import="java.util.*" %>
<%@ page import="content.ContentDAO" %>
<link href="css/style.css" rel="stylesheet" type="text/css">
<title>Insert title here</title>
</head>
<body>
	<%
	String questNumber = request.getParameter("number");

	ContentDAO contentDAO = new ContentDAO();
	String[][] questInfo = contentDAO.replyList(questNumber);
	
	String userID = null;
	String userName = null;
	if(session.getAttribute("userID") != null)  {
		userID = (String) session.getAttribute("userID");
		userName = (String) session.getAttribute("userName");
	}
	%>
	<form method="post" action="modifyQQAction.jsp?number=<%=questNumber%>">
	<table>
		<tr>
			<th>제목</th>
			<td width=300px><input type="text" placeholder="<%= questInfo[0][1] %>" name="questTitle" maxlength="45"></td>
		</tr>
		<tr>
			<th>작성자</th>
			<td><%= questInfo[0][3] %></td>
		</tr>
		<tr>
			<th>내용</th>
			<td width=300px><textarea rows="10" cols="80" name="questContent"><%= questInfo[0][2] %></textarea></td>
		</tr>
		<tr>
			<th colspan="2"><input type="submit" value="수정"></th>
		</tr>
	</table></form>
</body>
</html>