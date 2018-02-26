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

<body>

<%

	String blogName = request.getParameter("blogName");
		
	if (blogName == null) {

		blogName = "Blogging Molly";
		
	}
	
	pageContext.setAttribute("blogName", blogName);
	
	UserService userService = UserServiceFactory.getUserService();
	
	User user = userService.getCurrentUser();
	
	if (user != null) {
		
		pageContext.setAttribute("user", user);
	
%>

<p>Hello, ${fn:escapeXml(user.nickname)}! (You can

<a href="<%= userService.createLogoutURL(request.getRequestURI()) %>">log out</a>.)</p>

<%

	} else {

%>

<p>Hello!

<a href="<%= userService.createLoginURL(request.getRequestURI()) %>">Sign in</a>

to include your name with blogs you post.</p>

<%

	}

%>

<%

	ObjectifyService.register(BlogPost.class);

	List<BlogPost> blogPosts = ObjectifyService.ofy().load().type(BlogPost.class).list();
	
	//Collections.sort(blogPosts);

	if (blogPosts.isEmpty()) {
		
%>
		
<p>${fn:escapeXml(blogName)} has no blog posts.</p>
	
<%

} else {
	
	int i = 0;
	
	for (BlogPost blogPost : blogPosts) {
		
		pageContext.setAttribute("blogPost_title", blogPost.getTitle());
		
		pageContext.setAttribute("blogPost_user", blogPost.getUser());
		
%>
	
<p><a href="readblogpost.jsp">${fn:escapeXml(blogPost_user.nickname)} : ${fn:escapeXml(blogPost_title)}</a></p>
	
<%
		i++;

		if (i == 5) {
			
			break;
			
		}
		
	}
	
}
	
%>

<form action="newblogpost.jsp">
	
    <div><input type="submit" value="Add New Blog Post" /></div>
	
	<input type="hidden" name="blogName" value="${fn:escapeXml(blogName)}"/>

</form>

</body>

</html>