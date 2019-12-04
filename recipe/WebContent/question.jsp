<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ page import="java.util.*" %>
<%@ page import="content.ContentDAO" %>
<%@ page import="recipeList.RecipeDAO" %>
<%@ page import="java.io.PrintWriter" %>
<link href="css/style.css" rel="stylesheet" type="text/css">
<link href="css/renacss.css" rel="stylesheet" type="text/css">
<title>✿모아모아 레시피✿</title>
<script type="text/javascript">
	function openInfoForm(recipeNum) {
		window.open("questFormAction.jsp?questNum="+recipeNum, "_blank", "width=420, height=400, resizable=no, scrollbars=yes");
	}
	function openModiForm(recipeNum) {
		window.open("modifyQAction.jsp?number="+recipeNum, "_blank", "width=600, height=250, resizable=no, scrollbars=yes");
	}
</script>
</head>
<body>
<%
	String choice = request.getParameter("choice");
	String userID = null;
	String userName = null;
	String userProfile = null;
	String userMode = null;
	if(session.getAttribute("userID") != null){
	  userID = (String) session.getAttribute("userID");
	  userName = (String) session.getAttribute("userName");
	  userProfile = (String) session.getAttribute("userProfile");
	  userProfile = (String) session.getAttribute("userProfile");
	  }
	else if (userID == null)
	{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인이 필요한 서비스 입니다!')");
		script.println("location.href = 'main.jsp'");
		script.println("</script>");
	}
	
	ContentDAO contentDAO = new ContentDAO();
	String[][] questList = null;
	if (choice.equals("0"))
		questList = contentDAO.listing(null);
	else if (choice.equals("1"))
		questList = contentDAO.listing(userID);
 %>
	<div id="container">
		<div id="navi">
		<div id = "title">
				<a class="h active" href="main.jsp"><img src="/recipe/cateImg/title.png" width = "120px"></a>
		</div>
			<ul class="h">
		<li class="h"><font color = "white">타이틀자리타이틀자</font></li>
         <li class="h"><a class="h" href="viewLike.jsp?choice=0">발도장</a></li>
         <li class="h"><a class="h" href="question.jsp?choice=0"><font color ="rgb(255,197,19)">레시피Q&A</font></a></li>
         <li class="h"><a class="h" href="request.jsp">레시피요청</a></li>
         <div id="menubar">
               <ul class="h">
                  <li class="l">
                  <a class="h" href="#"><img src="<%=userProfile%>" style="width: 17px; height: 17px; object-fit: contain; overflow: hidden; border-radius: 70px; -moz-border-radius: 70px; -khtml-border-radius: 70px; -webkit-border-radius: 70px;"/><%=userName%> 님</a>
                     <ul class="h">
                     	<li class="l"><a class="ha" href="logoutAction.jsp">로그아웃</a></li> 
                        <li class="l"><a class="ha" href="rename.jsp">회원정보수정</a></li>                  
                     </ul>
                  </li>
               </ul></div>
			</ul>
		</div>
	</div>
	<section>
	<br>
		<div id = "ques">
			<h3>질문 남기기</h3>
				<form method="post" action="questAction.jsp?number=<%=questList.length+1%>">
				<input type="text" placeholder="제목" name="questTitle" maxlength="45" style = "height: 20px; width : 660px; margin-bottom: 10px;"><br>
				<textarea rows="10" cols="80" name="questContent" style = "margin-bottom: 10px;">내용</textarea><br>
				<input type="submit" value="등록">
				</form>
		</div>
		<div id = "queslis">
		<a href="question.jsp?choice=0">[전체 보기]</a>&nbsp;|&nbsp;<a href="question.jsp?choice=1">[내가 쓴 질문]</a>
			<% if (choice.equals("0")) { %> 
				<% for(int i = questList.length-1; i>=0 ; i--) {%>
				<hr size="1" width="700"> 
				<div style="width: 680px; text-align: right;">
				<% if (questList[i][0].equals(userID)) {%>
				<a href="#" onclick="openModiForm(<%=questList[i][3]%>); return false;">[수정]</a>&nbsp;|&nbsp;
				<a href="questDelAction.jsp?number=<%=questList[i][3]%>">[삭제]</a><br>
				<% } else {}%>
				</div>
				<div id="recipeContent" onclick="openInfoForm(<%=questList[i][3]%>);" style =" padding-left : 20px;">
					&nbsp;<b><%=questList[i][1]%></b>&emsp;[<%=questList[i][5]%>]<br><br>
					&nbsp;작성자 : <%=questList[i][4]%><br>
					&nbsp;내용 : 
					<% if (questList[i][2].length() < 50) { %><%=questList[i][2]%><br>
					<% } else { %><%= questList[i][2].substring(0, 50) %> ...<br> <% } %>
				</div>
			<% } }
			else if (choice.equals("1")) { for(int i = questList.length-1; i>=0 ; i--) {%>
				<hr size="1" width="700"> 
				<div style="width: 680px; text-align: right;">
				<a href="#" onclick="openModiForm(<%=questList[i][2]%>); return false;">[수정]</a><br>
				</div>
				<div id="recipeContent" onclick="openInfoForm(<%=questList[i][2]%>);" style =" padding-left : 20px;">
					&nbsp;<b><%=questList[i][0]%></b>&emsp;[<%=questList[i][3]%>]<br><br>
					&nbsp;내용 : <% if (questList[i][1].length() < 50) { %><%=questList[i][1] %><br>
					<% } else { %><%= questList[i][1].substring(0, 50)%> ...<br> <% } %>
				</div>
			<% } } %>
			<hr size="1" width="700"> </div>
		</section>
		<%
		Cookie[] ck = request.getCookies();
		
		if (ck != null) {
			RecipeDAO recipeDAO = new RecipeDAO();
			int len = 0;
			for (Cookie c : ck) {
				if (c.getValue().length() > 5)
					continue;
				len++;
			}
			String[] relist = null;
			int check = 0;
			if (len > 4) {
				relist = new String[3];
				for (Cookie c : ck) {
					if (check >= len-4 && check < len-1)
						relist[check-len+4] = c.getValue();					
					check++;
				}
			}
			else {
				relist = new String[len-1];
				for (Cookie c : ck) {
					if (check >= len-1)
						break;
					relist[check] = c.getValue();
					check++;
				}
			}	%>
			<div id="sidebar">
			최근 본 레시피
		<%	for (int i = relist.length-1; i >=0 ; i--) {
			String[] recipeInfo = recipeDAO.recipeInfo(relist[i]);
				%>
				<hr size="1" width="80"> 
			<div onclick="openInfoForm(<%=relist[i]%>);">
			
					<% if (recipeInfo[4] == null) { 
					if (userID != null && userMode.equals("1")) { %>
						<img src="/recipe/cateImg/dietfood.png" style="position:relative; z-index:1; display: block; max-width: 80px; max-heigt:80px; width: auto; height: auto;">
						<% }
						else { %>
						<img src="/recipe/cateImg/food.png" style="display: block; max-width: 80px; max-heigt:80px; width: auto; height: auto;">
					<% } }
					else {
						if (userID != null && userMode.equals("1")) { %>
							<div class="container-fulid" style="max-width: 80px; max-heigt:80px; width: auto; height: auto; position:relative">
							<div style="position:absolute; background-color:rgba(0, 255, 255, 0.5); z-index:10; height:100%; width:100% "></div>
							<img src="<%=recipeInfo[4]%>" style="position:relative; z-index:1; display: block; max-width: 80px; max-heigt:80px; width: auto; height: auto;">
							</div> <% }
						else { %>
						<img src="<%=recipeInfo[4]%>" style="display: block; max-width: 80px; max-heigt:80px; width: auto; height: auto;">
						<% } } %>
				
			</div>
			<br><%= recipeInfo[0] %>
		<%
			} %>
		<hr size="1" width="100"> 
		</div>
		<%
		}
		%>
	<div id="footer">
	컴퓨터공학과 심나영/장효정/조민지
	</div>
</body>
</html>