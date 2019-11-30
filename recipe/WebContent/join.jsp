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
			<div id="menubar">
               <ul class="h">
                  <li class="l"><a class="h" href="#">접속하기</a>
                     <ul class="h">
                        <form method="post" action="loginAction.jsp">
                        	<font><center>로그인</center></font>
                        	<input type="text" placeholder="아이디" name="userID" maxlength="20"><br>
                        	<input type="password" placeholder="비밀번호" name="userPassword" maxlength="20"><br>
                        	<input type="submit" value="로그인">
                        </form>        
                     </ul>
                  </li>
               </ul></div>
            </ul>
		</div>
	</div><br>
	<section>
		<form method="post" action="joinAction.jsp" enctype="multipart/form-data">
			<h3>회원가입</h3>
			<input type="text" placeholder="아이디" name="userID" maxlength="20"><br>				
			<input type="password" placeholder="비밀번호" name="userPassword" maxlength="20"><br>				
			<input type="text" placeholder="닉네임" name="userName" maxlength="20"><br>							
			<input type="submit" value="회원가입">
		</form>
	</section>
	<div id="footer">
	컴퓨터공학과 심나영/장효정/조민지
	</div>
</body>
</html>