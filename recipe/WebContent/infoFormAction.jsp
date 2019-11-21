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
<title>Insert title here</title>
</head>
<body>
	<%
	String recipeNumber = request.getParameter("recipeNum");

	RecipeDAO recipeDAO = new RecipeDAO();
	String[] recipeInfo = recipeDAO.recipeInfo(recipeNumber);

	String userID = null;
	String likeInfo = null;
	
	if(session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
		if (recipeDAO.recipeLike(recipeNumber, userID, 1) != 0 ) {
			likeInfo = "/recipe/cateImg/like.png";
		}
		else
			likeInfo = "/recipe/cateImg/unlike.png";
	}
	
	if (recipeInfo[4] == null)
		recipeInfo[4] = "/recipe/cateImg/food.png";
	%>
	<script type="text/javascript">
	function changeImage(num) {
		if (num == 1) {
			var test = '<%=recipeDAO.recipeLike(recipeNumber,userID, 2)%>';
			if (test != 0) {
				document.getElementById("imgInfo").src = "/recipe/cateImg/unlike.png";
			}
		}
		else if (num == 0) {
			var test = '<%=recipeDAO.recipeLike(recipeNumber,userID, 3)%>';
			if (test != 0) {
				document.getElementById("imgInfo").src = "/recipe/cateImg/like.png";
		}
	}
}
	</script>
	<table>
		<tr>
			<th>이름</th>
			<td align="center" width=300px><%= recipeInfo[0] %></td>
		</tr>
		<tr>
			<th></th>
			<td align="center"><img src="<%=recipeInfo[4]%>" style="display: block; max-width: 300px; max-heigt:300px; width: auto; height: auto;"></td>
		</tr>
		<tr>
			<th>재료</th>
			<td align="center" width=300px><%= recipeInfo[3] %></td>
		</tr>
		<tr>
			<th>조리도구</th>
			<td align="center" width=300px><%= recipeInfo[1] %></td>
		</tr>
		<tr>
			<th>방법</th>
			<td align="center" width=300px><%= recipeInfo[2] %></td>
		</tr>
		<% if (likeInfo != null) { %><tr>
			<th colspan="2"><br><img src="<%=likeInfo%>" onclick="changeImage(<%=recipeDAO.recipeLike(recipeNumber, userID, 1)%>)" style="width: 10%; height: auto; cursor: pointer;" id="imgInfo"></th>
		</tr><% } %>
	</table>
</body>
</html>