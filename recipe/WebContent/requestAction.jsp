<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<%@ page import="java.util.*" %>
<%@ page import="recipeList.RecipeDAO" %>
<%@ page import="java.io.PrintWriter" %>
<link href="css/style.css" rel="stylesheet" type="text/css">
<title>Insert title here</title>
<script type="text/javascript">
	var g_oInterval = null;
	function openFile() {
		var win = window.open("recipeimgUpload.jsp","_blank", "width=120, height=50, resizable=no, scrollbars=no");
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
</head>
<body>
<%
	HashMap<String, String> materialList = new HashMap<String, String>();
	materialList.put("pork", "돼지고기");	materialList.put("vegetable", "채소");
	materialList.put("cow", "소고기");	materialList.put("milk", "우유");
	materialList.put("chicken", "닭고기");	materialList.put("alchol", "술");
	materialList.put("rice", "밥");	materialList.put("jam", "잼");
	materialList.put("cheese", "치즈");	materialList.put("ramen", "라면");
	materialList.put("egg", "계란");	materialList.put("snack", "과자");
	materialList.put("bread", "빵");	materialList.put("dressing", "드레싱기");
	materialList.put("noodle", "면");	materialList.put("can", "통조림");
	materialList.put("fruit", "과일");	materialList.put("microwave", "전자레인지");
	materialList.put("airfryer", "에어프라이어");	materialList.put("oven", "오픈");
	materialList.put("fryingpan", "후라이팬");	materialList.put("pot", "냄비");

	String userID = null;
	String userName = null;
	if(session.getAttribute("userID") != null){
	  userID = (String) session.getAttribute("userID");
	  userName = (String) session.getAttribute("userName");
	  }
	
	String name = request.getParameter("recipeName");
	String content = request.getParameter("recipeContent");
	String cate = request.getParameter("cate");
	String[] ingredients = request.getParameterValues("ingredient");
	String[] tools = request.getParameterValues("tool");
	String material = "";
	String cookware = ""; 
	
	if (name == null || content == null || cate == null)
	{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('레시피 이름과 카테고리, 조리 방법은 꼭 입력해주셔야 합니다.')");
		script.println("history.back()");
		script.println("</script>");
	}
	
	int rowNum = 0;
	int colNum = 0;
	
	if (ingredients != null)
		rowNum = ingredients.length;
	if (tools != null)
		colNum = tools.length;
	
	for (int i = 0; i<rowNum; i++) {
		for (Map.Entry<String, String> entry : materialList.entrySet()) {
			if (ingredients[i].equals(entry.getKey()))
				material += entry.getValue();
		}
		if (i != rowNum -1)
			material += ", ";
	}
	
	for (int i = 0; i<colNum; i++) {
		for (Map.Entry<String, String> entry : materialList.entrySet()) {
			if (tools[i].equals(entry.getKey()))
				cookware += entry.getValue();
		}
		if (i != colNum -1)
			cookware += ", ";
	}
	
	RecipeDAO recipeDAO = new RecipeDAO();
	int result = recipeDAO.recipeInsert(name, content.replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">","&gt;").replaceAll("\n","<br>"), cate, ingredients, tools, material, cookware);
	
	if(result == -1)
	{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('데이터베이스 오류')");
		script.println("history.back()");
		script.println("</script>");
	}
	else if(result == 0)
	{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('이미 존재하는 레시피입니다!')");
		script.println("history.back()");
		script.println("</script>");
	}
	else {
		session.setAttribute("newNum", Integer.toString(result));
 %>
 		<h3>레시피의 사진도 등록해주세요!</h3>
		<img src="/recipe/cateImg/food.png" style="width: 150px; height: 150px; object-fit: contain; overflow: hidden; border-radius: 70px; -moz-border-radius: 70px; -khtml-border-radius: 70px; -webkit-border-radius: 70px;"/>
		<br><br>
		<a href="#" onclick="openFile(); return false;">레시피 사진 변경</a>
 <% } %>
</body>
</html>