package model;

import java.util.Iterator;

import javax.servlet.http.Cookie;

import org.apache.commons.codec.digest.DigestUtils;
import org.bson.Document;
import org.bson.types.ObjectId;

import com.mongodb.BasicDBObject;
import com.mongodb.client.FindIterable;
import com.mongodb.client.model.Filters;
import com.mongodb.client.model.Updates;

public final class Account extends Model {
	protected ObjectId id;
	protected String username;
	protected String password;
	protected String email;
	protected String user_type;
	
	public ObjectId getId() {
		return id;
	}

	public void setId(ObjectId id) {
		this.id = id;
	}

	public String getUser_type() {
		return user_type;
	}

	public void setUser_type(String user_type) {
		this.user_type = user_type;
	}

	public String getUsername() {
		return this.username;
	}

	public String getPassword() {
		return this.password;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Account() {

	}

	public Account(String username, String password, String email, String user_type) {
		this.setId(new ObjectId());
		this.setUsername(username);
		this.setPassword(password);
		this.setEmail(email);
		this.setUser_type(user_type);
	}

	public Account(String username, String password, String email) {
		this.setId(new ObjectId());
		this.setUsername(username);
		this.setPassword(password);
		this.setEmail(email);
		this.setUser_type("USER");
	}
	
	public static void createNewAccount(String username, String password, String email, String fullname)
	{
		
		Account user_acc = new Account(username, password, email);
		user_acc.Insert();
		ObjectId account_id = ACCOUNT.find(
					Filters.and(
							Filters.eq("username",username), 
							Filters.eq("email", email))
					).first()
					.getId();
		
		
		User user = new User(fullname, account_id, username);
		System.out.print("new user");
		user.Insert();
	}
	
	public static void createNewMod(String username, String password, String email, String fullname)
	{
		String hashPass = DigestUtils.sha256Hex(password);
		Account mod = new Account(username, hashPass, email, "MOD");
		mod.Insert();
		
		ObjectId account_id = ACCOUNT.find(
				Filters.and(
						Filters.eq("username",username), 
						Filters.eq("email", email))
				).first().getId();
		User user = new User(fullname, account_id, username);
		user.Insert();
	}
	
	public static void deleteAccountByUsername(String username)
	{
		ObjectId userId = User.GetUserByUsername(username).getId();
		USER.deleteOne(Filters.eq("_id", userId));
		ACCOUNT.deleteOne(Filters.eq("username", username));
		System.out.println("delete thanh cong");
	}
	
	public static boolean checkExitUsername(String username)
	{
		Account acc = ACCOUNT.find(Filters.eq("username", username)).first();
		if (acc==null) return false;
		return true;
	}
	
	public static Account GetAccountByUsername(String username)
	{
		return ACCOUNT.find(Filters.eq("username", username)).first();	
	}
	
	public static Account GetAccountByEmail(String email)
	{
		return ACCOUNT.find(Filters.eq("email", email)).first();	
	}
	
	public static Account GetAccountByID(ObjectId id)
	{
		return ACCOUNT.find(Filters.eq("_id", id)).first();
	}
	
	public static boolean checkExitEmail(String email)
	{
		Account acc = ACCOUNT.find(Filters.eq("email", email)).first();
		if (acc==null) return false;
		return true;
	}
	
	public static void updateNewPassword(String newPassword, String username) 
	{
		ACCOUNT.updateOne(Filters.eq("username", username), Updates.set("password", newPassword));
	}
	
	public void Insert()
	{
		ACCOUNT.insertOne(this);
	}
	
	public boolean isMod()
	{
		return this.getUser_type().equals("MOD");
	}
	
	public boolean isAdmin()
	{
		return this.getUser_type().equals("ADMIN");
	}
	
	public boolean isUser()
	{
		return this.getUser_type().equals("USER");
	}
	
	public static boolean isMod(ObjectId accout_id)
	{
		return ACCOUNT.find(Filters.eq("_id", accout_id)).first().getUser_type().equals("MOD");
	}
	
	public static boolean isAdmin(ObjectId accout_id)
	{
		return ACCOUNT.find(Filters.eq("_id", accout_id)).first().getUser_type().equals("ADMIN");
	}
	
	public static boolean isUser(ObjectId accout_id)
	{
		return ACCOUNT.find(Filters.eq("_id", accout_id)).first().getUser_type().equals("USER");
	}
	
	public static boolean isLogged(Cookie[] cookies)
	{
		if (cookies == null)
			return false;
		String is_logged = "";
		String selector ="";
		String validator = "";
		for (Cookie cookie : cookies) {
			if (cookie.getName().equals("is_logged"))
				is_logged = cookie.getValue();
			else if (cookie.getName().equals("selector"))
				selector = cookie.getValue();
			else if (cookie.getName().equals("validator"))
				validator = cookie.getValue();
		}
		ObjectId account_id = Model.Authenticator(selector, validator);
		if (account_id != null)
		{
			User user = User.GetUserByAccountID(account_id);
			if (user.getStatus().equals("ACTIVE"))
				if (is_logged.equals("true"))
					return true;
		}
		return false;
	}
}
