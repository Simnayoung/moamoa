<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.UserDAO" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="css/style.css" rel="stylesheet" type="text/css">
<link href="css/renacss.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	var g_oInterval = null;
	function openFile() {
		var win = window.open("imgUpload.jsp","_blank", "width=120, height=50, resizable=no, scrollbars=no");
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
<title>Insert title here</title>
</head>
<body>
<%
	String userID = null;
	String userName = null;
	if(session.getAttribute("userID") != null){
	  userID = (String) session.getAttribute("userID");
	  userName = (String) session.getAttribute("userName");
	  }
	else
	{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인이 필요한 서비스입니다.')");
		script.println("location.href = 'main.jsp'");
		script.println("</script>");
	}
	UserDAO userDAO = new UserDAO();
	String[] personal = userDAO.personal(userID);
%>
	<div id="container">
		<div id="navi">
		<div id = "title">
				<a class="h active" href="main.jsp"><img src="/recipe/cateImg/title.png" width = "120px"></a>
			</div>
			<ul class="h">
				<li class="h"><font color = "white">타이틀자리타이틀자</font></li>
         <li class="h"><a class="h" href="viewLike.jsp">발도장</a></li>
         <li class="h"><a class="h" href="question.jsp?choice=0">레시피Q&A</a></li>
         <li class="h"><a class="h" href="request.jsp">레시피요청</a></li>
         <div id="menubar">
               <ul class="h">
                  <li class="l">
                  <a class="h" href="#"><img src="<%=personal[2]%>" style="width: 17px; height: 17px; object-fit: contain; overflow: hidden; border-radius: 70px; -moz-border-radius: 70px; -khtml-border-radius: 70px; -webkit-border-radius: 70px;"/><%=userName%> 님</a>
                     <ul class="h">
                     	<li class="l"><a class="ha" href="logoutAction.jsp">로그아웃</a></li> 
                        <li class="l"><a class="ha" href="rename.jsp">정보수정</a></li>                  
                     </ul>
                  </li>
               </ul></div>
			</ul>
		</div>
	</div>
	<section id = "renas">
	<div id = "rena">
		<img src="<%=personal[2]%>" style="width: 150px; height: 150px; object-fit: contain; overflow: hidden; border-radius: 70px; -moz-border-radius: 70px; -khtml-border-radius: 70px; -webkit-border-radius: 70px;"/>
		<br>
		<a href="#" onclick="openFile(); return false;">프로필 사진 변경</a>	
		<div id = "pass">
		<form method="post" action="personalAction.jsp">
			비밀번호 : <input type="text" placeholder="<%= personal[0] %>" name="userPassword" maxlength="20" style = "width: 150px;"><br>				
			&emsp;닉네임 : <input type="password" placeholder="<%= personal[1] %>" name="userName" maxlength="20" style = "width: 150px;"><br>				
			<input type="submit" value="정보수정">
		</form>
		</div>
	</div>
	</section>
		<div id="footer" style = "text-align : center;">
	컴퓨터공학과 심나영/장효정/조민지
	</div>
</body>
</html>