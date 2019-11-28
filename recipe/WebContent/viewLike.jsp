<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ page import="java.util.*" %>
<%@ page import="recipeList.RecipeDAO" %>
<%@ page import="java.io.PrintWriter" %>
<link href="css/style.css" rel="stylesheet" type="text/css">
<title>Insert title here</title>
<script type="text/javascript">
	function openInfoForm(recipeNum) {
		window.open("infoFormAction.jsp?recipeNum="+recipeNum, "_blank", "width=410, height=400, resizable=no, scrollbars=yes");
	}
</script>
</head>
<body>
<%
	String choice = request.getParameter("choice");
	String userID = null;
	String userName = null;
	String userProfile = null;
	if(session.getAttribute("userID") != null){
	  userID = (String) session.getAttribute("userID");
	  userName = (String) session.getAttribute("userName");
	  userProfile = (String) session.getAttribute("userProfile");
	  }
	else if (userID == null)
	{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인이 필요한 서비스입니다.')");
		script.println("location.href = 'main.jsp'");
		script.println("</script>");
	}
	
	RecipeDAO recipeDAO = new RecipeDAO();
	String[] searchList = recipeDAO.recipeLikeList(userID);
	String[] reviewList = recipeDAO.reviewGGet(userID, null);
 %>
	<div id="container">
		<div id="navi">
		<div id = "title">
				<a class="h active" href="main.jsp"><img src="/cateImg/title.png" width = "120px"></a>
		</div>
			<ul class="h">
		<li class="h"><font color = "white">타이틀자리타이틀자</font></li>
         <li class="h"><a class="h" href="viewLike.jsp?choice=0">발도장</a></li>
         <li class="h"><a class="h" href="question.jsp?choice=0">레시피Q&A</a></li>
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
		<section><br>
		<a href="viewLike.jsp?choice=0">[전체 보기]</a>&nbsp;|&nbsp;<a href="viewLike.jsp?choice=1">[발도장찍은 레시피]</a>&nbsp;|&nbsp;<a href="viewLike.jsp?choice=2">[후기 남긴 레시피]</a>
			<% if (choice.equals("0")) { 
			for(int i = 0; i<searchList.length ; i++) {
				String[] recipeInfo = recipeDAO.recipeInfo(searchList[i]);
			%>
				<hr size="1" width="700"> 
				<div id="recipeContent" onclick="openInfoForm(<%=searchList[i]%>);">
					<table><tr>
					<th>
					<% if (recipeInfo[4] == null) { %><img src="/recipe/cateImg/food.png" style="display: block; max-width: 100px; max-heigt:100px; width: auto; height: auto;">
					<% } else { %><img src="<%=recipeInfo[4]%>" style="display: block; max-width: 100px; max-heigt:100px; width: auto; height: auto;">
					<% } %>
					</th>
					<td>
					&nbsp;<b><%=recipeInfo[0]%></b><br>
					&nbsp;재료 : <%=recipeInfo[3]%><br>
					&nbsp;요리도구 : <%=recipeInfo[1]%><br>
					</td>
					</tr></table>
				</div>
			<% } for(int i = 0; i<reviewList.length ; i++) {
				String[] recipeInfo = recipeDAO.recipeInfo(reviewList[i]);
			%>
				<hr size="1" width="700"> 
				<div id="recipeContent" onclick="openInfoForm(<%=reviewList[i]%>);">
					<table><tr>
					<th>
					<% if (recipeInfo[4] == null) { %><img src="/recipe/cateImg/food.png" style="display: block; max-width: 100px; max-heigt:100px; width: auto; height: auto;">
					<% } else { %><img src="<%=recipeInfo[4]%>" style="display: block; max-width: 100px; max-heigt:100px; width: auto; height: auto;">
					<% } %>
					</th>
					<td>
					&nbsp;<b><%=recipeInfo[0]%></b><br>
					&nbsp;재료 : <%=recipeInfo[3]%><br>
					&nbsp;요리도구 : <%=recipeInfo[1]%><br>
					</td>
					</tr></table>
				</div>
			<% }
			if (searchList.length == 0 && reviewList.length == 0) { %>
			<hr size="1" width="700"> <h3>아직 발도장과 후기를 남기지 않으셨군요!<br><a href="main.jsp">발도장 찍으러 가기</a></h3>
			<% } else {} } 
			
			else if (choice.equals("1")) { %>
			<% for(int i = 0; i<searchList.length ; i++) {
				String[] recipeInfo = recipeDAO.recipeInfo(searchList[i]);
			%>
				<hr size="1" width="700"> 
				<div id="recipeContent" onclick="openInfoForm(<%=searchList[i]%>);">
					<table><tr>
					<th>
					<% if (recipeInfo[4] == null) { %><img src="/recipe/cateImg/food.png" style="display: block; max-width: 100px; max-heigt:100px; width: auto; height: auto;">
					<% } else { %><img src="<%=recipeInfo[4]%>" style="display: block; max-width: 100px; max-heigt:100px; width: auto; height: auto;">
					<% } %>
					</th>
					<td>
					&nbsp;<b><%=recipeInfo[0]%></b><br>
					&nbsp;재료 : <%=recipeInfo[3]%><br>
					&nbsp;요리도구 : <%=recipeInfo[1]%><br>
					</td>
					</tr></table>
				</div>
			<% } 
			if (searchList.length == 0) { %>
			<hr size="1" width="700"> <h3>아직 발도장을 찍지 않으셨군요!<br><a href="main.jsp">발도장 찍으러 가기</a></h3>
			<% } else {} } 

			else if (choice.equals("2")) { 
			 for(int i = 0; i<reviewList.length ; i++) {
				String[] recipeInfo = recipeDAO.recipeInfo(reviewList[i]);
			%>
				<hr size="1" width="700"> 
				<div id="recipeContent" onclick="openInfoForm(<%=reviewList[i]%>);">
					<table><tr>
					<th>
					<% if (recipeInfo[4] == null) { %><img src="/recipe/cateImg/food.png" style="display: block; max-width: 100px; max-heigt:100px; width: auto; height: auto;">
					<% } else { %><img src="<%=recipeInfo[4]%>" style="display: block; max-width: 100px; max-heigt:100px; width: auto; height: auto;">
					<% } %>
					</th>
					<td>
					&nbsp;<b><%=recipeInfo[0]%></b><br>
					&nbsp;재료 : <%=recipeInfo[3]%><br>
					&nbsp;요리도구 : <%=recipeInfo[1]%><br>
					</td>
					</tr></table>
				</div>
			<% } 
				if (reviewList.length == 0) { %>
				<hr size="1" width="700"> <h3>아직 후기를 남기지 않으셨군요!<br><a href="main.jsp">후기 남기러 가기</a></h3>
				<% } else {} } %>
			<hr size="1" width="700"> 
		</section>
		<%
		Cookie[] ck = request.getCookies();
		
		if (ck != null) {
			String[] relist = new String[ck.length];
			int check = 0;
			if (relist.length > 4) {
				for (Cookie c : ck) {
					check++;
					if (check >= ck.length-4)
						relist[check-ck.length+4] = c.getValue();
				}
			}
			else {
				for (Cookie c : ck) {
					relist[check] = c.getValue();
					check++;
				}
			}	%>
			<div id="sidebar">
			최근 본 레시피
		<%	for (int i = relist.length-2; i >=0 ; i--) {
			String[] recipeInfo = recipeDAO.recipeInfo(relist[i]);
				%>
			<div onclick="openInfoForm(<%=relist[i]%>);">
			<hr size="1" width="80"> 
				<% if (recipeInfo[4] == null) { %><img src="/recipe/cateImg/food.png" style="display: block; max-width: 80px; max-heigt:80px; width: auto; height: auto;">
				<% } else { %><img src="<%=recipeInfo[4]%>" style="display: block; max-width: 80px; max-heigt:80px; width: auto; height: auto;">
				<% } %>
				<br><%= recipeInfo[0] %>
			</div>
		<%
			} %>
		<hr size="1" width="80"> 
		</div>
		<%
		}
		%>
	<div id="footer">
	컴퓨터공학과 심나영/장효정/조민지
	</div>
</body>
</html>