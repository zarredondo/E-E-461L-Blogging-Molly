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
	
	String show_all_post = request.getParameter("show_all_post");
	
	Boolean flag;
	
	if (show_all_post == null) {
		flag = false;
	} else if (show_all_post.equals("false")) {
		flag = false;
	} else {
		flag = true;
	}

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
	
	Collections.sort(blogPosts, Collections.reverseOrder());

	if (blogPosts.isEmpty()) {
		
%>
		
<p>${fn:escapeXml(blogName)} has no blog posts.</p>
	
<%

} else {
	
	int i = 0;
	
	for (BlogPost blogPost : blogPosts) {
		
		pageContext.setAttribute("blogPost_title", blogPost.getTitle());
		
		pageContext.setAttribute("blogPost_user", blogPost.getUser());
		
		String content = blogPost.getContent();
		
		String preview;
		
		if (content.length() > 20) {
			
			preview = content.substring(0,20) + "..." ;
			
		} else {
			
			preview = content;
		
		}
		
		pageContext.setAttribute("blogPost_content", content);
		
		pageContext.setAttribute("blogPost_preview", preview);
		
		pageContext.setAttribute("blogPost_date", blogPost.getDate());
		
%>
	
	<form action="readblogpost.jsp" method="post">
			
		<input type="hidden" name="title" value="${fn:escapeXml(blogPost_title)}"/>
		
		<input type="hidden" name="content" value="${fn:escapeXml(blogPost_content)}"/>
		
		Author: ${fn:escapeXml(blogPost_user.nickname)} <br>
		Title: ${fn:escapeXml(blogPost_title)} <br>
		Date: ${fn:escapeXml(blogPost_date)} <br>
		Content: ${fn:escapeXml(blogPost_preview)}
		
		<div><input type="submit" value="Read Post" /></div>
		
	</form>
	

	
<%
		i++;

		if (i >= 5 && flag == false) {
			
			break;
		}
		
	}
	
}
		
%>

<% 
	if(flag == false) { 	
%>
<form action="landing.jsp" method="post">

	<div><input type="submit" value="Show All Posts" /></div>
	
	<input type="hidden" name="show_all_post" value="true"/>	

</form>

<% 
	} else {
%>

<form action="landing.jsp" method="post">

	<div><input type="submit" value="Show Fewer Posts" /></div>
	
	<input type="hidden" name="show_all_post" value="false"/>	

</form>

<% }

if (user != null) {

%>	
	
<form action="newblogpost.jsp" method="post">
	
    <div><input type="submit" value="Add New Blog Post" /></div>
	
	<input type="hidden" name="blogName" value="${fn:escapeXml(blogName)}"/>

</form>

<%
}
%>

<p><a href="subscribe.jsp">Subscribe to Our Mailing List</a></p>

</body>

</html>