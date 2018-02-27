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
	
	<title>Subscribe</title>
	
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

<form action="/subscribe" method="post">

	<p>Your email address:</p>
	
	<div><textarea name="emailAddress" rows="1" cols="30"></textarea></div>
	
	<br>
	
    <div><input type="submit" value="Subscribe" /></div>
    
    <input type="hidden" name="subscribe" value="true"/>
    
    <input type="hidden" name="blogName" value="${fn:escapeXml(blogName)}"/>

</form>

</body>

</html>
