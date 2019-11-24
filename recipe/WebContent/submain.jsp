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
<script type="text/javascript">
	function openInfoForm(recipeNum) {
		window.open("infoFormAction.jsp?recipeNum="+recipeNum, "_blank", "width=350, height=400, resizable=no, scrollbars=yes");
	}
</script>
</head>
<body>
<%
	String category = request.getParameter("category");
	session.setAttribute("category", category);
	
	String[] searchList = {category};
	RecipeDAO recipeDAO = new RecipeDAO();
	String[][] recipeList = recipeDAO.listing(searchList);
	
    String userID = null;
    String userName = null;
    String userProfile = null;
    if(session.getAttribute("userID") != null){
  	  userID = (String) session.getAttribute("userID");
  	  userName = (String) session.getAttribute("userName");
  	  userProfile = (String) session.getAttribute("userProfile");
  	  }
	session.setAttribute("prev", "submain.jsp?category="+category);
 %>
	<div id="container">
		<div id="navi">
		<div id = "title">
				<a class="h active" href="main.jsp"><img src="/recipe/cateImg/title.png" width = "120px"></a>
			</div>
			<ul class="h">
 		<%
            if(userID == null) // 로그인이 되어 있지 않을 시에만 보여줌
            {
         %>
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
                   <li class="l"><a class="h" href="join.jsp">회원가입</a></li>
                  </li>
               </ul></div>
         <%
            }
            else // 로그인 되어 있을 시에만 보여줌
            {
         %>
         <font color = "white">타이틀자리타이틀자</font>
         <li class="h"><a class="h" href="viewLike.jsp">발도장</a></li>
         <li class="h"><a class="h" href="question.jsp?choice=0">레시피Q&A</a></li>
         <li class="h"><a class="h" href="request.jsp">레시피요청</a></li>
         <div id="menubar">
               <ul class="h">
                  <li class="l">
                  <a class="h" href="#"><img src="<%=userProfile%>" style="width: 17px; height: 17px; object-fit: contain; overflow: hidden; border-radius: 70px; -moz-border-radius: 70px; -khtml-border-radius: 70px; -webkit-border-radius: 70px;"/><%=userName%> 님</a>
                     <ul class="h">
                     	<li class="l"><a class="h" href="logoutAction.jsp">로그아웃</a></li> 
                        <li class="l"><a class="h" href="rename.jsp">정보수정</a></li>                  
                     </ul>
                  </li>
               </ul></div>
         <%
            }
         %>
			</ul>
		</div>
	</div><br>
	<section id = "cate">
		<div id="category">
			<table><form method="post" action="listmain.jsp">
				<tr>
					<th rowspan="2" align="center" width=100px>카테고리</th>
					<td align="center" width=100px>재료</td>
					<td align="left">
						<label><input type="checkbox" name="ingredient" value="pork">돼지고기</label>
						<label><input type="checkbox" name="ingredient" value="cow">소고기</label>
						<label><input type="checkbox" name="ingredient" value="chicken">닭고기</label>
						<label><input type="checkbox" name="ingredient" value="rice">밥</label>
						<label><input type="checkbox" name="ingredient" value="cheese">치즈</label>
						<label><input type="checkbox" name="ingredient" value="egg">계란</label>
						<label><input type="checkbox" name="ingredient" value="bread">빵</label>
						<label><input type="checkbox" name="ingredient" value="noodle">면</label>
						<label><input type="checkbox" name="ingredient" value="fruit">과일</label>
						<label><input type="checkbox" name="ingredient" value="vegetable">채소</label>
						<label><input type="checkbox" name="ingredient" value="milk">우유</label>
						<label><input type="checkbox" name="ingredient" value="alchol">술</label>
						<label><input type="checkbox" name="ingredient" value="jam">잼</label>
						<label><input type="checkbox" name="ingredient" value="ramen">라면</label>
						<label><input type="checkbox" name="ingredient" value="snack">과자</label>
						<label><input type="checkbox" name="ingredient" value="dressing">드레싱</label>
						<label><input type="checkbox" name="ingredient" value="can">통조림</label>
					</td>
					<td rowspan="2" align="center" width=100px><input type="submit" value="검색"></td>
				</tr>
				<tr><td align="center">조리기구</td><td align="left">
					<label><input type="checkbox" name="tool" value="microwave">전자레인지</label>
					<label><input type="checkbox" name="tool" value="airfryer">에어프라이어</label>
					<label><input type="checkbox" name="tool" value="oven">오븐</label>
					<label><input type="checkbox" name="tool" value="fryingpan">후라이팬</label>
					<label><input type="checkbox" name="tool" value="pot">냄비</label>
				</td></tr>
			</form></table>
		</div>
	</section><br>
		<section><div id="recipeSection">
			<% for(int i = 0; i<recipeList.length ; i++) {%>
				<hr size="1" width="700"> 
				<div id="recipeContent" onclick="openInfoForm(<%=recipeList[i][0]%>);">
					<table><tr>
					<th>
					<% if (recipeList[i][5] == null) { %><img src="/recipe/cateImg/food.png" style="display: block; max-width: 100px; max-heigt:100px; width: auto; height: auto;">
					<% } else { %><img src="<%=recipeList[i][5]%>" style="display: block; max-width: 100px; max-heigt:100px; width: auto; height: auto;">
					<% } %>
					</th>
					<td>
					&nbsp;<b><%=recipeList[i][1]%></b><br>
					&nbsp;재료 : <%=recipeList[i][4]%><br>
					&nbsp;요리도구 : <%=recipeList[i][2]%><br>
					</td>
					</tr></table>
				</div>
			<% }
			if (recipeList.length == 0) { %>
			<hr size="1" width="700"> <h3>레시피가 없어요 ㅠ_ㅠ<br>여러분의 레시피를 공유해주세요!<br><a href="request.jsp">레시피 공유하러 가기</a></h3>
			<% } %>
			<hr size="1" width="700"> 
		</div></section>
	<div id="footer">
	컴퓨터공학과 심나영/장효정/조민지
	</div>
</body>
</html>