<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="recipeList.RecipeDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" charset="text/html; charset=UTF-8">
<title>✿모아모아 레시피✿</title>
</head>
<body>
	<%
		String content = request.getParameter("reviewContent");
		String recipeNum = request.getParameter("number");
	
		String userID=null;
		String userName = null;
		String userReview = null;
		if(session.getAttribute("userID") != null)
		{
			userID = (String) session.getAttribute("userID");
			userName = (String) session.getAttribute("userName");
		}
		if(session.getAttribute("userReview") != null)
			userReview = (String) session.getAttribute("userReview");
	
		RecipeDAO recipeDAO = new RecipeDAO();
		int result = recipeDAO.reviewInput(userID, content.replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">","&gt;").replaceAll("\n","<br>"), userReview, recipeNum, userName);
		
		if(result == 1)
		{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('(๑•̀ㅂ•́)و'\n등록이 완료되었습니다!')");
			script.println("window.location = document.referrer");
			session.setAttribute("userReview", null);
			script.println("</script>");
		}
		else if(result == 0)
		{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('( ⁰▱⁰ )!!!\n오류가 발생했습니다!')");
			script.println("history.back()");
			script.println("</script>");
		}
		else if(result == -1)
		{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('(❁´▽`❁)\n이미 후기가 등록되어 있습니다!')");
			script.println("history.back()");
			script.println("</script>");
		}
	%>
</body>
</html>