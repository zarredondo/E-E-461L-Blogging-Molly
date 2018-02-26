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
	
	<title>Blogging Molly</title>
	
</head>

<%

	String title = request.getParameter("title");

	String content = request.getParameter("content");
	
	//String n = ObjectifyService.ofy().load().key().get();
%>


<body>

	<p><% %></p>
	
	<p></p>

</body>

</html>
