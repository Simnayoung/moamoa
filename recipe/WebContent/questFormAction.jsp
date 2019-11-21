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
	String questNumber = request.getParameter("questNum");

	ContentDAO contentDAO = new ContentDAO();
	String[][] questInfo = contentDAO.replyList(questNumber);
	
	String userID = null;
	String userName = null;
	if(session.getAttribute("userID") != null)  {
		userID = (String) session.getAttribute("userID");
		userName = (String) session.getAttribute("userName");
	}
	%>
	<table>
		<tr>
			<th>제목</th>
			<td align="center" width=300px><%= questInfo[0][1] %></td>
		</tr>
		<tr>
			<th>작성자</th>
			<td align="center"><%= questInfo[0][3] %></td>
		</tr>
		<tr>
			<th>내용</th>
			<td align="center" width=300px><%= questInfo[0][2] %></td>
		</tr>
		<% for (int i = 1; i<questInfo.length; i++) { %>
		<tr>
			<th>댓글 <%= i %><br>작성자 : <b><%= questInfo[i][1] %></b></th>
			<td align="center" width=300px><%= questInfo[i][0] %></td>
		</tr>
		<% } %>
		<tr>
			<th>댓글 쓰기</th>
			<td align="center" width=300px>
				<form method="post" action="replyFormAction.jsp?number=<%=questNumber%>">
					<textarea rows="10" cols="40" name="replyContent">내용</textarea><br><br>
				<input type="submit" value="등록"></form>
			</td>
		</tr>
	</table>
</body>
</html>