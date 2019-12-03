<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="recipeList.RecipeDAO" %>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" charset="text/html; charset=UTF-8">
<title>✿모아모아 레시피✿</title>
</head>
<body>
	<%	
	String userID = null;
	if(session.getAttribute("userID") != null)
	  userID = (String) session.getAttribute("userID");
	else {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('( ⁰▱⁰ )!!!\n로그인이 필요한 서비스입니다!')");
		script.println("window.close()");
		script.println("</script>");
	}
	MultipartRequest multi = null;
	int sizeLimit = 1*1024*1024;
	String saveFolder = "userImg/"+userID+"/";
	String encType="euc-kr";
	ServletContext context = getServletContext();
	String savePath = context.getRealPath(saveFolder);

	File file = new File(savePath);
	if(!file.exists())
		file.mkdirs();
	
	try {
		multi = new MultipartRequest(request, savePath, sizeLimit, encType, new DefaultFileRenamePolicy());

		Enumeration params = multi.getParameterNames();

		while(params.hasMoreElements())
		{
			String name = (String)params.nextElement();
		}
		
		Enumeration files = multi.getFileNames();

		while(files.hasMoreElements())
		{
			String name = (String)files.nextElement();
			String filename = multi.getFilesystemName(name);
			String recipeNumber = null;
			if (session.getAttribute("tempNumber")!=null) {
				recipeNumber = (String) session.getAttribute("tempNumber");
				RecipeDAO recipeDAO = new RecipeDAO();
				int resultt = recipeDAO.modifyReview(userID, recipeNumber, null, savePath+filename);
			}
			
			session.setAttribute("userReview", savePath+filename);
		}

		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('(๑•̀ㅂ•́)و'\n변경이 완료되었습니다!')");
		script.println("window.close()");
		script.println("opener.parent.location.reload()");
		script.println("</script>");
	}
	catch (Exception e) {
		e.printStackTrace();
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('( ⁰▱⁰ )!!!\n변경을 실패했습니다!')");
		script.println("history.back()");
		script.println("</script>");
	}
	 %>
</body>
</html>