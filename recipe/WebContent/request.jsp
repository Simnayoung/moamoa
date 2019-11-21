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
<title>Insert title here</title>
</head>
<body>
<%
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
		script.println("alert('로그인이 필요한 서비스 입니다.')");
		script.println("location.href = 'main.jsp'");
		script.println("</script>");
	}
%>
	<div id="container">
		<div id="navi">
			<ul class="h">
				<li class="h"><a class="h active" href="main.jsp">모아모아 레시피</a></li>
         <li class="h"><a class="h" href="viewLike.jsp">발도장</a></li>
         <li class="h"><a class="h" href="question.jsp?choice=0">레시피Q&A</a></li>
         <li class="h"><a class="h" href="request.jsp">레시피요청</a></li>
         <div id="menubar">
               <ul class="h">
                  <li class="l">
                  <a class="h" href="#"><img src="<%=userProfile%>" style="width: 30px; height: 30px; object-fit: contain; overflow: hidden; border-radius: 70px; -moz-border-radius: 70px; -khtml-border-radius: 70px; -webkit-border-radius: 70px;"/><%=userName%> 님</a>
                     <ul class="h">
                     	<li class="l"><a class="h" href="logoutAction.jsp">로그아웃</a></li> 
                        <li class="l"><a class="h" href="rename.jsp">회원정보수정</a></li>                  
                     </ul>
                  </li>
               </ul></div>
			</ul>
		</div>
	</div><br>
	<section>
		<h3>여러분의 소중한 레시피를 공유해주세요!</h3>
		<img src="/recipe/cateImg/food.png" style="width: 150px; height: 150px; object-fit: contain; overflow: hidden; border-radius: 70px; -moz-border-radius: 70px; -khtml-border-radius: 70px; -webkit-border-radius: 70px;"/>
		<br><br>
		<form method="post" action="requestAction.jsp">
		<div id="recipeContent" style="width: 770px;">
		<table>
			<tr>
			<th width=100px align="left">레시피 이름 </th>
			<td><input type="text" style="width: 300px;" placeholder="ex) 후루룩 라면" name="recipeName" maxlength="20"></td>
			</tr>
			<tr>
			<th align="left">카테고리</th>
			<td align="left">
			<select name="cate">
				<option value="korean">한식</option>
				<option value="chinese">중식</option>
				<option value="japenese">일식</option>
				<option value="western">양식</option>
				<option value="school">분식</option>
				<option value="fast">패스트푸드</option>
				<option value="dessert">디저트</option>
				<option value="easy">간편식</option>
				<option value="other">기타</option>
			</select></td>
			</tr>
			<tr>
			<th align="left">조리 도구</th>
			<td align="left">
					<label><input type="checkbox" name="tool" value="microwave">전자레인지</label>
					<label><input type="checkbox" name="tool" value="airfryer">에어프라이어</label>
					<label><input type="checkbox" name="tool" value="oven">오븐</label>
					<label><input type="checkbox" name="tool" value="fryingpan">후라이팬</label>
					<label><input type="checkbox" name="tool" value="pot">냄비</label></td>	
			</tr>
			<tr>
			<th align="left">레시피 재료</th>
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
			</tr>
			<tr>
			<th align="left">조리 순서</th>
			<td><textarea rows="15" cols="80" name="recipeContent">
1) 양파 자르기<br>
2) 당근 자르기<br>
3) 후라이팬에 볶기
<-- 양식 꼭 지켜주세요! -->
<-- 띄어쓰기하기 전에 꼭 br 붙여주세요! --></textarea></td>	
			</tr>
		</table></div>
			<input type="submit" value="레시피요청"><br><br>
		</form>
	</section>
	<div id="footer">
	컴퓨터공학과 심나영/장효정/조민지
	</div>
</body>
</html>