package bloggingmolly;

import com.googlecode.objectify.ObjectifyService;

import com.googlecode.objectify.Key;

import static com.googlecode.objectify.ObjectifyService.ofy;

import com.google.appengine.api.users.User;

import com.google.appengine.api.users.UserService;

import com.google.appengine.api.users.UserServiceFactory;

import java.io.IOException;

import javax.servlet.http.HttpServlet;

import javax.servlet.http.HttpServletRequest;

import javax.servlet.http.HttpServletResponse;

public class SubscribeServlet extends HttpServlet {
	
	static {
		
		ObjectifyService.register(Subscriber.class);
		
	}
	
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {

		Boolean subscribe = (req.getParameter("subscribe").equals("true") ? true : false);
		
		String emailAddress = req.getParameter("emailAddress");
		
		String blogName = req.getParameter("blogName");
		
		Subscriber subscriber = new Subscriber(emailAddress, blogName);
		 
		if (subscribe) {
			ofy().save().entity(subscriber).now();
		} else {
			ofy().delete().entity(subscriber).now();  // synchronous
		}
		resp.sendRedirect("/landing.jsp?blogName=" + blogName);
		
	}
	
}
