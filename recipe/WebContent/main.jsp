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
	function openInfoForm(recipeNum) {
		window.open("infoFormAction.jsp?recipeNum="+recipeNum,"_blank", "width=425, height=700, resizable=no, scrollbars=yes");
	}
</script>
</head>
<body>
   <%
	String[] searchList = null;
	RecipeDAO recipeDAO = new RecipeDAO();
	String[][] recipeList = recipeDAO.listing(searchList);
	
    String userID = null;
    String userName = null;
    String userProfile = null;
    String userMode = null;
    if(session.getAttribute("userID") != null){
  	  userID = (String) session.getAttribute("userID");
  	  userName = (String) session.getAttribute("userName");
  	  userProfile = (String) session.getAttribute("userProfile");
  	  userMode = (String) session.getAttribute("diet");
  	  }
      if(session.getAttribute("category") != null)
    	  session.setAttribute("category", null);
      session.setAttribute("prev", "main.jsp");
   %>
	<div id="container">
		<div id="navi">
		<div id = "title">
				<a class="h active" href="main.jsp"><img src="/cateImg/title.png" width = "120px"></a>
		</div>
			<ul class="h">
 		<%
            if(userID == null) // 로그인이 되어 있지 않을 시에만 보여줌
            {
         %>
         <div id="menubar">
               <ul class="h">
                  <li class="l"><a class="h" href="#">로그인</a>
                     <ul class="h">
                        <form method="post" action="loginAction.jsp">
                        	<div class = "p">
		                       	<input type="text" placeholder="아이디" name="userID" maxlength="20" style = "width: 100px;"><br>
		                       	<input type="password" placeholder="비밀번호" name="userPassword" maxlength="20" style = "width: 100px;"><br>
		                       	<input type="submit" value="로그인">
	                       	</div>
                        </form>        
                     </ul>
                   <li class="l"><a class="h" href="join.jsp">회원가입</a></li>
                  </li>
               </ul></div>
         <%
            }
            else // 로그인 되어 있을 시에만 보여줌
            {
         %>
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
         <%
            }
         %>
			</ul>
		</div>
	</div>
	<section><br>
		<div id="category">
			<ul class="c">
				<li class="c"><a href="submain.jsp?category=korean"><img src="/recipe/cateImg/korean.jpg"><br>한식</a></li>
				<li class="c"><a href="submain.jsp?category=chinese"><img src="/recipe/cateImg/chinese.jpg"><br>중식</a></li>
				<li class="c"><a href="submain.jsp?category=japenese"><img src="/recipe/cateImg/japanese.jpg"><br>일식</a></li>
				<li class="c"><a href="submain.jsp?category=western"><img src="/recipe/cateImg/western.jpg"><br>양식</a></li>
				<li class="c"><a href="submain.jsp?category=school"><img src="/recipe/cateImg/tt.jpg"><br>분식</a></li>
				<li class="c"><a href="submain.jsp?category=fast"><img src="/recipe/cateImg/fast.jpg"><br>패스트푸드</a></li>
				<li class="c"><a href="submain.jsp?category=dessert"><img src="/recipe/cateImg/dessert.jpg"><br>디저트</a></li>
				<li class="c"><a href="submain.jsp?category=easy"><img src="/recipe/cateImg/simple.jpg"><br>간편식</a></li>
				<li class="c"><a href="submain.jsp?category=other"><img src="/recipe/cateImg/etc.png"><br>기타</a></li>
			</ul>
		</div>
		<div id="recipeSection">
			<% for(int i = 0; i<recipeList.length ; i++) {%>
				<hr size="1" width="700"> 
				<div id="recipeContent" onclick="openInfoForm(<%=recipeList[i][0]%>);">
					<table><tr>
					<th>
					<% if (recipeList[i][5] == null) { 
					if (userID != null && userMode.equals("1")) { %>
						<img src="/recipe/cateImg/dietfood.png" style="display: block; max-width: 100px; max-heigt:100px; width: auto; height: auto;">
						<% }
						else { %>
						<img src="/recipe/cateImg/food.png" style="display: block; max-width: 100px; max-heigt:100px; width: auto; height: auto;">
					<% } }
					else {
						if (userID != null && userMode.equals("1")) { %>
							<div class="container-fulid" style="max-width: 100px; max-heigt:100px; width: auto; height: auto; position:relative">
							<div style="position:absolute; background-color:rgba(0, 255, 255, 0.5); z-index:10; height:100%; width:100% "></div>
							<img src="<%=recipeList[i][5]%>" style="position:relative; z-index:1; display: block; max-width: 100px; max-heigt:100px; width: auto; height: auto;">
							</div> <% }
						else { %>
						<img src="<%=recipeList[i][5]%>" style="display: block; max-width: 100px; max-heigt:100px; width: auto; height: auto;">
						<% } } %>
					</th>
					<td style="padding-left:20px;">
					<b><%=recipeList[i][1]%></b><br><br>
					재료 : <%=recipeList[i][4]%><br>
					요리도구 : <%=recipeList[i][2]%><br>
					</td>
					</tr></table>
				</div>
			<% } %>
			<hr size="1" width="700"> 
		</div></section>
		<%
		Cookie[] ck = request.getCookies();
		
		if (ck != null) {
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
			<div id="sidebar"><br>
			<b>최근 본 레시피</b>
		<%	for (int i = relist.length-1; i >=0 ; i--) {
			String[] recipeInfo = recipeDAO.recipeInfo(relist[i]);
				%>
			<div onclick="openInfoForm(<%=relist[i]%>);">
			<hr size="1" width="100"> 
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
				<br><%= recipeInfo[0] %>
			</div>
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