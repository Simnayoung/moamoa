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
			<div id="menubar">
               <ul class="h">
                  <li class="l"><a class="h" href="#">접속하기</a>
                     <ul class="h">
                        <form method="post" action="loginAction.jsp">
                        	<div class = "p">
		                       	<input type="text" placeholder="아이디" name="userID" maxlength="20" style = "width: 100px;"><br>
		                       	<input type="password" placeholder="비밀번호" name="userPassword" maxlength="20" style = "width: 100px;"><br>
		                       	<input type="submit" value="로그인">
	                       	</div>
                        </form>        
                     </ul>
                  </li>
               </ul></div>
            </ul>
		</div>
	</div>
	<section id = "logins">
	<br>
	<div id = "rena">
		<form method="post" action="joinAction.jsp" enctype="multipart/form-data">
		
			<h3>회원가입</h3>
			<input type="text" placeholder="아이디" name="userID" maxlength="20" style = "width: 150px;"><br>				
			<input type="password" placeholder="비밀번호" name="userPassword" maxlength="20" style = "width: 150px;"><br>	
			<div id = "joi">			
			<input type="text" placeholder="닉네임" name="userName" maxlength="20" style = "width: 150px;"><br>							
			<input type="submit" value="회원가입">
			</div>
		</form>
	</div>
	</section>
	<div id="footer">
	컴퓨터공학과 심나영/장효정/조민지
	</div>
</body>
</html>