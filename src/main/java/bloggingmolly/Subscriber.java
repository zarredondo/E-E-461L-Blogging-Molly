package bloggingmolly;

import com.google.appengine.api.users.User;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import com.googlecode.objectify.Key;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import com.googlecode.objectify.annotation.Index;
import com.googlecode.objectify.annotation.Parent;

@Entity
public class Subscriber {
	@Parent Key<Blog> blogName;
	@Id String emailAddress;

	private Subscriber() {}
	
	public Subscriber(String emailAddress, String blogName) {
		this.emailAddress = emailAddress;
		this.blogName = Key.create(Blog.class, blogName);
	}
	
	public String getEmailAddress() {
		return emailAddress;
	}
}