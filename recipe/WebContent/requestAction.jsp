<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<%@ page import="java.util.*" %>
<%@ page import="recipeList.RecipeDAO" %>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<link href="css/style.css" rel="stylesheet" type="text/css">
<title>��Ƹ�� ������</title>
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
	materialList.put("pork", "�������");	materialList.put("vegetable", "ä��");
	materialList.put("cow", "�Ұ��");	materialList.put("milk", "����");
	materialList.put("chicken", "�߰��");	materialList.put("alchol", "��");
	materialList.put("rice", "��");	materialList.put("jam", "��");
	materialList.put("cheese", "ġ��");	materialList.put("ramen", "���");
	materialList.put("egg", "���");	materialList.put("snack", "����");
	materialList.put("bread", "��");	materialList.put("dressing", "�巹�̱�");
	materialList.put("noodle", "��");	materialList.put("can", "������");
	materialList.put("fruit", "����");	materialList.put("microwave", "���ڷ�����");
	materialList.put("airfryer", "���������̾�");	materialList.put("oven", "����");
	materialList.put("fryingpan", "�Ķ�����");	materialList.put("pot", "����");

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
		script.println("alert('������ �̸��� ī�װ�, ���� ����� �� �Է����ּž� �մϴ�!')");
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
		script.println("alert('�����ͺ��̽��� ������ �߻��߽��ϴ�!')");
		script.println("history.back()");
		script.println("</script>");
	}
	else if(result == 0)
	{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('�̹� �����ϴ� �������Դϴ�!')");
		script.println("history.back()");
		script.println("</script>");
	}
	else {
		session.setAttribute("newNum", Integer.toString(result));
	
	UserDAO userDAO = new UserDAO();
	String[] personal = userDAO.personal(userID);
 %>
 	<div id="container">
		<div id="navi">
		<div id = "title">
				<a class="h active" href="main.jsp"><img src="/cateImg/title.png" width = "120px"></a>
		</div>
			<ul class="h">
		<li class="h"><font color = "white">Ÿ��Ʋ�ڸ�Ÿ��Ʋ��</font></li>
         <li class="h"><a class="h" href="viewLike.jsp?choice=0">�ߵ���</a></li>
         <li class="h"><a class="h" href="question.jsp?choice=0">������Q&A</a></li>
         <li class="h"><a class="h" href="request.jsp">�����ǿ�û</a></li>
         <div id="menubar">
               <ul class="h">
                  <li class="l">
                  <a class="h" href="#"><img src="<%=personal[2]%>" style="width: 17px; height: 17px; object-fit: contain; overflow: hidden; border-radius: 70px; -moz-border-radius: 70px; -khtml-border-radius: 70px; -webkit-border-radius: 70px;"/><%=userName%> ��</a>
                     <ul class="h">
                     	<li class="l"><a class="ha" href="logoutAction.jsp">�α׾ƿ�</a></li> 
                        <li class="l"><a class="ha" href="rename.jsp">ȸ����������</a></li>                  
                     </ul>
                  </li>
               </ul></div>
			</ul>
		</div>
	</div>
		 <section>
   <div id = "reque">
       <h3>(����`)<br>�������� ������ ������ּ���!</h3>
      <img src="/recipe/cateImg/food.png" style="width: 150px; height: 150px; object-fit: contain; overflow: hidden; border-radius: 70px; -moz-border-radius: 70px; -khtml-border-radius: 70px; -webkit-border-radius: 70px;"/>
      <br><br>
      <a href="#" onclick="openFile(); return false;">������ ���� ����</a><br><br>
      <a href="main.jsp">�� �ϰ� �Ѿ��</a><br><br>
      </div></section>
 <% } %>
</body>
</html>