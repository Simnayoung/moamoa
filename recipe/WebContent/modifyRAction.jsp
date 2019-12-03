<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ page import="java.util.*" %>
<%@ page import="recipeList.RecipeDAO" %>
<link href="css/style.css" rel="stylesheet" type="text/css">
<title>✿모아모아 레시피✿</title>
<script type="text/javascript">
	var g_oInterval = null;
	function openFile() {
		var win = window.open("reviewImgUpload.jsp","_blank", "width=120, height=50, resizable=no, scrollbars=no");
	    g_oInterval = window.setInterval(function() {
	        try {
	            if( win == null || win.closed ) {
	                window.clearInterval(g_oInterval);
	                win = null;
	                location.reload(true);
	            }
	        } catch (e) { }
	    }, 500);
	};
</script>
</head>
<body>
	<%
	String recipeNumber = request.getParameter("number");
	String userID = null;
	String userName = null;
	session.setAttribute("tempNumber", recipeNumber);
	if(session.getAttribute("userID") != null)  {
		userID = (String) session.getAttribute("userID");
		userName = (String) session.getAttribute("userName");
	}

	RecipeDAO recipeDAO = new RecipeDAO();
	String[] reviewInfo = recipeDAO.reviewGGet(userID, recipeNumber);
	%>
	<form method="post" action="modifyRRAction.jsp?number=<%=recipeNumber%>">
	<table>
		<tr>
			<th>작성자</th>
			<td><%= userName %></td>
		</tr>
		<% if (reviewInfo[1]!=null) { %>
		<tr><th colspan="2" align="center">
		<img src="<%=reviewInfo[1]%>" style="display: block; max-width: 100px; max-heigt:100px; width: auto; height: auto;">
		<br><a href="#" onclick="openFile(); return false;">사진 변경</a>
		</th></tr><% } 
		else { %>
		<tr><th colspan="2" align="center"><a href="#" onclick="openFile(); return false;">사진 변경</a>
		</th></tr> <% } %>
		<tr>
			<th>내용</th>
			<td width=300px><textarea rows="10" cols="80" name="reviewContent"><%= reviewInfo[0] %></textarea></td>
		</tr>
		<tr>
			<th colspan="2"><input type="submit" value="수정"></th>
		</tr>
	</table></form>
</body>
</html>