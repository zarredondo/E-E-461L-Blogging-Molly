<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="java.util.List" %>

<%@ page import="java.util.Collections" %> 

<%@ page import="bloggingmolly.BlogPost" %>

<%@ page import="com.googlecode.objectify.Objectify" %>

<%@ page import="com.googlecode.objectify.ObjectifyService" %>

<%@ page import="com.google.appengine.api.users.User" %>

<%@ page import="com.google.appengine.api.users.UserService" %>

<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<html>

<head>

	<link type="text/css" rel="stylesheet" href="/stylesheets/main.css" />

	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	
	<title>New Blog Post</title>
	
</head>

<body>

<%

	String blogName = request.getParameter("blogName");
	
	if (blogName == null) {
		
		blogName = "Blogging Molly";
		
	}

	pageContext.setAttribute("blogName", blogName);

%>

<p><a href="landing.jsp">Go Back</a></p>

<form action="/newblogpost" method="post">

	<p>Write your blog title here:</p>
	
	<div><textarea name="title" rows="1" cols="30"></textarea></div>
	
	<p>Write your blog post here:</p>
    
    <div><textarea name="content" rows="3" cols="60"></textarea></div>

	<br>

    <div><input type="submit" value="Post Blog Entry" /></div>

    <input type="hidden" name="blogName" value="${fn:escapeXml(blogName)}"/>
    
</form>

</body>

</html>
