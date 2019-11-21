<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="css/style.css" rel="stylesheet" type="text/css">
<title>Insert title here</title>
</head>
<body>
	<div id="container">
		<div id="navi">
			<ul class="h">
				<li class="h"><a class="h active" href="main.jsp">모아모아 레시피</a></li>
				<li class="l"><a class="h" href="join.jsp">회원가입</a></li>
            </ul>
		</div>
	</div><section><br>
		<form method="post" action="loginAction.jsp">
			<h3 style="text-align: center;">로그인</h3>
			<input type="text" placeholder="아이디" name="userID" maxlength="20">					
			<input type="password" placeholder="비밀번호" name="userPassword" maxlength="20">					
			<input type="submit" value="로그인">
		</form></section>
	<div id="footer">
	컴퓨터공학과 심나영/장효정/조민지
	</div>
</body>
</html>