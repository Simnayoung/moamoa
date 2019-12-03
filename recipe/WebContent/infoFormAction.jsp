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
<link href="css/table.css" rel="stylesheet" type="text/css">
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
	function openModiForm(recipeNum) {
		window.open("modifyRAction.jsp?number="+recipeNum, "_blank", "width=600, height=250, resizable=no, scrollbars=yes");
	};
</script>
</head>
<body>
	<%	
	String recipeNumber = request.getParameter("recipeNum");
	Cookie c = new Cookie(recipeNumber, recipeNumber);
	c.setMaxAge(60*60);
	response.addCookie(c);

	RecipeDAO recipeDAO = new RecipeDAO();
	String[] recipeInfo = recipeDAO.recipeInfo(recipeNumber);
	String[][] reviewInfo = recipeDAO.reviewGet(recipeNumber);
	
	String userID = null;
	String likeInfo = null;
	String userReview = null;
	String userMode = null;
	
	if(session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
		userMode = (String) session.getAttribute("diet");
		if (recipeDAO.recipeLike(recipeNumber, userID, 1) != 0 ) {
			likeInfo = "/recipe/cateImg/like.png";
		}
		else
			likeInfo = "/recipe/cateImg/unlike.png";
	}
	
	if(session.getAttribute("userReview") != null)
		userReview = (String) session.getAttribute("userReview");
	%>
	<script type="text/javascript">
	function changeImage(num) {
		const httpRequest = new XMLHttpRequest();

		httpRequest.onreadystatechange = function() {
			if (num == 1) {
				document.getElementById("imgInfo").src = "/recipe/cateImg/unlike.png";
				
			}
			else if (num == 0) {
				document.getElementById("imgInfo").src = "/recipe/cateImg/like.png";
			}
		}
		
		const url = '/recipe/recipeLike.jsp?' + "recipeNumber=" + <%=recipeNumber%> + "&type=" + (num == 1 ? "2" : "3");
		httpRequest.open('GET', url, true);
		httpRequest.send(null);
	}
	</script>
		<table id = "recipet">
		<tr>
			<th>이름</th>
			<td align="center" width=400px><%= recipeInfo[0] %></td>
		</tr>
		<tr>
			<th></th>
			<td id = "recipe_img" align="center">
				<% if (recipeInfo[4] == null) { 
					if (userID != null && userMode.equals("1")) { %>
						<img src="/recipe/cateImg/dietfood.png" style="display: block; max-width: 400px; max-heigt:400px; width: auto; height: auto;">
						<% }
						else { %>
						<img src="/recipe/cateImg/food.png" style="display: block; max-width: 400px; max-heigt:400px; width: auto; height: auto;">
					<% } }
					else {
						if (userID != null && userMode.equals("1")) { %>
							<div class="container-fulid" style="max-width: 400px; max-heigt:400px; width: auto; height: auto; position:relative">
							<div style="position:absolute; background-color:rgba(0, 255, 255, 0.5); z-index:10; height:100%; width:100% "></div>
							<img src="<%=recipeInfo[4]%>" style="position:relative; z-index:1; display: block; max-width: 400px; max-heigt:400px; width: auto; height: auto;">
							</div> <% }
						else { %>
						<img src="<%=recipeInfo[4]%>" style="display: block; max-width: 400px; max-heigt:400px; width: auto; height: auto;">
					<% } } %>
			</td>
		</tr>
		<% if (likeInfo != null) { %><tr>
			<%if (userID != null && userMode.equals("1")) { %>
			<th class = "heart" style = "background-color:rgb(141,169,241);">
			<% }else { %>
			<th class = "heart">
			<%} %>
			<img src="<%=likeInfo%>" onclick="changeImage(<%=recipeDAO.recipeLike(recipeNumber, userID, 1)%>)" style="width: 50%; height: auto; cursor: pointer;" id="imgInfo"></th>
			<%if (userID != null && userMode.equals("1")) { %>
			<th class = "heart" align = "left" style = "background-color:rgb(141,169,241);">
			<% }else { %>
			<th class = "heart" align = "left">
			<%} %>
			<%=recipeDAO.recipeLikeNum(recipeNumber) %>&nbsp;명의 사람이 발자국을 남겼습니다</th>
		</tr><% } %>
		<tr>
			<th valign ="top">재료</th>
			<td width=400px><%= recipeInfo[3] %></td>
		</tr>
		<tr>
			<th>조리도구</th>
			<td width=400px><%= recipeInfo[1] %></td>
		</tr>
		<tr>
			<th valign ="top">방법</th>
			<td width =400px><%= recipeInfo[2] %></td>
		</tr>
		</table>
		<br>
		<%if (userID != null && userMode.equals("1")) { %>
		<table id = "reviewt" style = "background-color:rgb(141,169,241);">
		<% }else { %>
		<table id = "reviewt">
		<%} %>
		<% for (int i = 0; i<reviewInfo.length; i++) { %>
		<tr>
			<th>작성자<br> <b><%= reviewInfo[i][3] %></b>
				<% if (reviewInfo[i][0].equals(userID)) {%>
				<br><a href="#" onclick="openModiForm(<%=recipeNumber%>); return false;">[수정]</a><br>
				<a href="reviewDelAction.jsp?number=<%=recipeNumber%>">[삭제]</a><br>
				<% } else {}%>
			</th>
			<td id = "reviewc" width=400px>
				<% if (reviewInfo[i][2] != null) { 
					if (userID != null && userMode.equals("1")) { %>
						<div class="container-fulid" style="max-width: 100px; max-heigt:100px; width: auto; height: auto; position:relative">
						<div style="position:absolute; background-color:rgba(0, 255, 255, 0.5); z-index:10; height:100%; width:100% "></div>
						<img src="<%=reviewInfo[i][2]%>" style="display: block; max-width: 100px; max-heigt:100px; width: auto; height: auto;">
						</div>
						<% }
						else { %>
						<img src="<%=reviewInfo[i][2]%>" style="display: block; max-width: 100px; max-heigt:100px; width: auto; height: auto;">
					<% } } %>
			<%= reviewInfo[i][1] %></td>
		</tr>
		<% } %>
		<% if (userID != null) { %><tr>
			<th class = "nop" width = 100px>후기 쓰기</th>
			<td class = "nop" align="center" width=400px>
				<% if (userReview != null) { %>
				<img src="<%=userReview%>" style="display: block; max-width: 100px; max-heigt:100px; width: auto; height: auto;">
				<% } %>
				<a href="#" onclick="openFile(); return false;">사진 변경</a><br>
				<form method="post" action="reviewFormAction.jsp?number=<%=recipeNumber%>">
					<textarea rows="10" cols="40" name="reviewContent"></textarea><br>
				<input type="submit" value="등록"></form>
			</td>
		</tr>
		<% } %>
	</table>
</body>
</html>