package bloggingmolly;

import com.googlecode.objectify.ObjectifyService;

import static com.googlecode.objectify.ObjectifyService.ofy;

import com.google.appengine.api.users.User;

import com.google.appengine.api.users.UserService;

import com.google.appengine.api.users.UserServiceFactory;

import java.io.IOException;

import javax.servlet.http.HttpServlet;

import javax.servlet.http.HttpServletRequest;

import javax.servlet.http.HttpServletResponse;

public class SignInBlogServlet extends HttpServlet {
	
	static {
		ObjectifyService.register(BlogPost.class);
	}
	
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		UserService userService = UserServiceFactory.getUserService();
		User user = userService.getCurrentUser();
		
		String blogName = req.getParameter("blogName");
		String title = req.getParameter("title");
		String content = req.getParameter("content");
		BlogPost blogPost = new BlogPost(user, title, content, blogName);
		ofy().save().entity(blogPost).now();
		resp.sendRedirect("/landing.jsp?blogName=" + blogName);
	}
}
