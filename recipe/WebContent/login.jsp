<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="css/style.css" rel="stylesheet" type="text/css">
<link href="css/renacss.css" rel="stylesheet" type="text/css">
<title>✿모아모아 레시피✿</title>
</head>
<body>
	<div id="container">
		<div id="navi">
		<div id = "title">
				<a class="h active" href="main.jsp"><img src="/cateImg/title.png" width = "120px"></a>
		</div>
			<ul class="h">
				<li class="l"><a class="h" href="join.jsp">회원가입</a></li>
            </ul>
		</div>
	</div><section id = "logins"><br>
	<div id = "rena">
		<form method="post" action="loginAction.jsp">
			<h3 style="text-align: center;">로그인</h3>
			<input type="text" placeholder="아이디" name="userID" maxlength="20" style = "width: 150px;">					
			<input type="password" placeholder="비밀번호" name="userPassword" maxlength="20" style = "width: 150px;">	<br>			
			<input type="submit" value="로그인">
		</form></div></section>
	<div id="footer" style = "text-align : center;">
	컴퓨터공학과 심나영/장효정/조민지
	</div>
</body>
</html>