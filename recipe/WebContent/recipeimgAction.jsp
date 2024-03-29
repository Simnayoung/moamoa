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
<title>Hello World</title>
</head>
<body>
	<%	
	String newNum = null;
	if(session.getAttribute("newNum") != null)
		newNum = (String) session.getAttribute("newNum");
	MultipartRequest multi = null;
	int sizeLimit = 1*1024*1024;
	String saveFolder = "cate/"+newNum+"/";
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

			RecipeDAO recipeDAO = new RecipeDAO();
			int result = recipeDAO.profile(newNum, savePath+filename);
		}

		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('레시피를 추가해주셔서 감사합니다!')");
		script.println("opener.parent.location.href = 'main.jsp'");
		script.println("window.close()");
		script.println("</script>");
	}
	catch (Exception e) {
		e.printStackTrace();
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('변경이 실패되었습니다!')");
		script.println("history.back()");
		script.println("</script>");
	}
	 %>
</body>
</html>