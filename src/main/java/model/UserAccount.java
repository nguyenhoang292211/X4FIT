package model;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.bson.Document;
import org.bson.types.ObjectId;

import com.mongodb.client.FindIterable;

import x4fit.Utilities;

public class UserAccount extends Model {
	protected ObjectId userID;
	protected String username;
	protected String email;
	protected String user_type;
	protected String fullname;
	protected String avatar;
	protected String url;
	protected String status;
	
	public ObjectId getUserID() {
		return userID;
	}

	public void setUserID(ObjectId userID) {
		this.userID = userID;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getUser_type() {
		return user_type;
	}

	public void setUser_type(String user_type) {
		this.user_type = user_type;
	}

	public String getFullname() {
		return fullname;
	}

	public void setFullname(String fullname) {
		this.fullname = fullname;
	}

	public String getAvatar() {
		return avatar;
	}

	public void setAvatar(String avatar) {
		this.avatar = avatar;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public UserAccount(ObjectId userID, String username, String email, String user_type, String fullname,
			String avatar, String url, String status) {
		super();
		this.userID = userID;
		this.username = username;
		this.email = email;
		this.user_type = user_type;
		this.fullname = fullname;
		this.avatar = avatar;
		this.url = url;
		this.status = status;
	}
	
	public static List<UserAccount> getAllUserInfo() {
		List<User> allUserList = User.getAllUsers();
		ArrayList<UserAccount> data = new ArrayList<UserAccount>();
		for (int i = 0; i < allUserList.size(); i++) {
			User user = allUserList.get(i);
			Account account = Account.GetAccountByID(user.getAccount_id());
			UserAccount userAccount = new UserAccount(
					user.getId(),
					account.getUsername(), 
					account.getEmail(), 
					account.getUser_type(), 
					user.getFullname(), 
					user.getAvatar(), 
					user.getUrl(), 
					user.getStatus());
			if (!userAccount.getUser_type().equals("ADMIN")) {
				data.add(userAccount);
			}
		}
		return data;
	}
	
	public static List<UserAccount> SearchUser(String query) {
		query = Utilities.removeAccent(query).toLowerCase();
		List<User> allUserList = User.getAllUsers();
		ArrayList<UserAccount> data = new ArrayList<UserAccount>();
		for (int i = 0; i < allUserList.size(); i++) {
			User user = allUserList.get(i);
			Account account = Account.GetAccountByID(user.getAccount_id());
			UserAccount userAccount = new UserAccount(
					user.getId(),
					account.getUsername(), 
					account.getEmail(), 
					account.getUser_type(), 
					user.getFullname(), 
					user.getAvatar(), 
					user.getUrl(), 
					user.getStatus());
			String id = Utilities.removeAccent(userAccount.getUserID().toString()).toLowerCase();
			String username = Utilities.removeAccent(userAccount.getUsername()).toLowerCase();
			String email = Utilities.removeAccent(userAccount.getEmail()).toString();
			String accountType = Utilities.removeAccent(userAccount.getUser_type()).toLowerCase();
			String status = Utilities.removeAccent(userAccount.getStatus()).toLowerCase();
			
			if (id.indexOf(query) != -1 
					|| username.indexOf(query) != -1
					|| email.indexOf(query) != -1
					|| accountType.indexOf(query) != -1
					|| status.indexOf(query) != -1) {
				data.add(userAccount);
			}
		}
		return data;
	}
	
	public static List<UserAccount> GetUserFilter(String accountType, String status) {
		List<User> allUserList = User.getAllUsers();
		ArrayList<UserAccount> data = new ArrayList<UserAccount>();
		for (int i = 0; i < allUserList.size(); i++) {
			User user = allUserList.get(i);
			Account account = Account.GetAccountByID(user.getAccount_id());
			UserAccount userAccount = new UserAccount(
					user.getId(),
					account.getUsername(), 
					account.getEmail(), 
					account.getUser_type(), 
					user.getFullname(), 
					user.getAvatar(), 
					user.getUrl(), 
					user.getStatus());
			if (accountType.equals("ALL")) {
				if (userAccount.getStatus().equals(status)) {
					data.add(userAccount);
				}
			} else {
				if (userAccount.getUser_type().equals(accountType) && userAccount.getStatus().equals(status)) {
					data.add(userAccount);
				}
			}
		}
		return data;
	}
}
