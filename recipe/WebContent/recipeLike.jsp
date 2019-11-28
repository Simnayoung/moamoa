<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="recipeList.RecipeDAO" %>
    
<%
	RecipeDAO recipeDAO = new RecipeDAO();
	String userID = (String)session.getAttribute("userID");
	String recipeNumber = (String)request.getParameter("recipeNumber");
	int type = Integer.parseInt((String) request.getParameter("type"));
	
	if(type == 2 || type == 3) recipeDAO.recipeLike(recipeNumber, userID, type);
%>