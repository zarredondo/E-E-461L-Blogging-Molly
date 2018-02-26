<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="java.util.List" %>

<%@ page import="com.google.appengine.api.users.User" %>

<%@ page import="com.google.appengine.api.users.UserService" %>

<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ page import="java.util.Collections" %> 

<%@ page import="com.googlecode.objectify.Objectify" %>

<%@ page import="com.googlecode.objectify.ObjectifyService" %>

<%@ page import="bloggingmolly.BlogPost" %>

<html>

<head>
	<link type="text/css" rel="stylesheet" href="/stylesheets/main.css" />
</head>

<body>

<h1>Title:</h1>

<form action="/ofysign" method="post">

      <div><textarea name="content" rows="3" cols="60"></textarea></div>

      <div><input type="submit" value="Post Blog Entry" /></div>

      <input type="hidden" name="blogName" value="${fn:escapeXml(blogName)}"/>

</form>

<h1>Write the content of your blog here:</h1>

<form action="/ofysign" method="post">

      <div><textarea name="content" rows="3" cols="60"></textarea></div>

      <div><input type="submit" value="Post Blog Entry" /></div>

      <input type="hidden" name="blogName" value="${fn:escapeXml(blogName)}"/>

</form>

</body>

</html>
