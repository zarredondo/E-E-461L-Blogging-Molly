package bloggingmolly;

import java.io.IOException;
import java.util.List;
import java.util.Properties;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import com.googlecode.objectify.ObjectifyService;

import static com.googlecode.objectify.ObjectifyService.ofy;

import com.google.appengine.api.users.User;

import com.google.appengine.api.users.UserService;

import com.google.appengine.api.users.UserServiceFactory;

@SuppressWarnings("serial")
public class CronServlet extends HttpServlet {
	
	public void doGet(HttpServletRequest req, HttpServletResponse resp)	throws IOException {
		String strCallResult = "";
		resp.setContentType("text/plain");

		ObjectifyService.register(Subscriber.class);

		List<Subscriber> subscribers = ObjectifyService.ofy().load().type(Subscriber.class).list();
		
		
		for (Subscriber subscriber: subscribers) {
			
			try {
				//Extract out the To, Subject and Body of the Email to be sent
				/*String strTo = req.getParameter("email_to");
				String strSubject = req.getParameter("email_subject");
				String strBody = req.getParameter("email_body");
				*/
				
				String strTo = subscriber.getEmailAddress();
				
				String strSubject = "Blog Digest";
				
				String strBody = "https://bloggingmolly-196222.appspot.com/landing.jsp?blogName=Blogging%20Molly";
				
				//Do validations here. Only basic ones i.e. cannot be null/empty
				//Currently only checking the To Email field
				if (strTo == null) throw new Exception("To field cannot be empty.");
				
				//Trim the stuff
				strTo = strTo.trim();
				
				if (strTo.length() == 0) throw new Exception("To field cannot be empty.");
		
				//Call the GAEJ Email Service
				Properties props = new Properties();
				
				Session session = Session.getDefaultInstance(props, null);
				
				Message msg = new MimeMessage(session);
	
				msg.setFrom(new InternetAddress("zach.arredondo@gmail.com"));
	
				msg.addRecipient(Message.RecipientType.TO,
						new InternetAddress(strTo));
				
				msg.setSubject(strSubject);
				
				msg.setText(strBody);
				
				Transport.send(msg);
				
				strCallResult = "Success: " + "Email has been delivered.";
				
				resp.getWriter().println(strCallResult);
				
			} catch (Exception ex) {
				
				strCallResult = "Fail: " + ex.getMessage();
				
				resp.getWriter().println(strCallResult);
		
			}
		}
	}
	
	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		doGet(req, resp);

	}
}