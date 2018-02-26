package bloggingmolly;

import com.google.appengine.api.users.User;
import java.util.Date;
import com.googlecode.objectify.Key;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import com.googlecode.objectify.annotation.Index;
import com.googlecode.objectify.annotation.Parent;

@Entity
public class BlogPost implements Comparable<BlogPost> {
	@Parent Key<Blog> blogName;
	@Id Long id;
	@Index User user;
	@Index String title;
	@Index String content;
	@Index Date date;
	
	private BlogPost() {}
	
	public BlogPost(User user, String title, String content, String blogName) {
		this.user = user;
		this.title = title;
		this.content = content;
		this.blogName = Key.create(Blog.class, blogName);
	}
	
	public User getUser() {
		return user;
	}
	
	public String getTitle() {
		return title;
	}
	
	public String getContent() {
		return content;
	}

	@Override
	public int compareTo(BlogPost o) {
		if (date.after(o.date)) {
			return 1;
		} else if (date.before(o.date)) {
			return -1;
		}
		return 0;
	}
	
	
}
