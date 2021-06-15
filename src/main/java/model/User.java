package model;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpSession;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.lang3.RandomStringUtils;
import org.bson.codecs.pojo.annotations.BsonIgnore;
import org.bson.types.ObjectId;

import com.mongodb.client.FindIterable;
import com.mongodb.client.model.Filters;
import com.mongodb.client.model.Updates;
import com.mongodb.client.result.UpdateResult;

public final class User extends Model 
{
	private ObjectId id;
	private String fullname;
	private String avatar;
	private String url;
	private String status;
	private List<ObjectId> follower;
	private List<ObjectId> following;
	private List<ObjectId> clips;
	private List<String> images;
	private ObjectId account_id;

	public ObjectId getAccount_id() {
		return account_id;
	}

	public void setAccount_id(ObjectId account_id) {
		this.account_id = account_id;
	}

	public List<ObjectId> getFollower() {
		return follower;
	}

	public void setFollower(List<ObjectId> follower) {
		this.follower = follower;
	}

	public List<ObjectId> getFollowing() {
		return following;
	}

	public void setFollowing(List<ObjectId> following) {
		this.following = following;
	}

	public List<ObjectId> getClips() {
		return clips;
	}

	public void setClips(List<ObjectId> clips) {
		this.clips = clips;
	}

	public ObjectId getId() {
		return id;
	}

	public void setId(ObjectId id) {
		this.id = id;
	}

	public String getFullname() {
		return this.fullname;
	}

	public void setFullname(String fullname) {
		this.fullname = fullname;
	}

	public String getAvatar() {
		if (this.avatar == "")
			return "avt.png";
		return this.avatar;
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

	public String getUsername(User user) {
		Account acc = ACCOUNT.find(Filters.eq("_id", user.getAccount_id())).first();
		if (acc == null)
			return null;
		return acc.getUsername();
	}

	public List<String> getImages() {
		return images;
	}

	public void setImages(List<String> images) {
		this.images = images;
	}
	
	public String getEmail (ObjectId id)
	{
		Account acc = ACCOUNT.find(Filters.eq("_id", id)).first();
		if (acc == null)
			return null;
		return acc.getEmail();
	}

	public User() {
	
	}

	public User(String fullname, ObjectId account_id, String username) {
		this.setId(new ObjectId());
		this.setFullname(fullname);
		this.setAccount_id(account_id);
		this.setAvatar("avt.png");
		this.setStatus("NOT ACTIVE"); // Lúc mới tạo user chưa xác nhận email thì set not active
		this.setUrl(username + RandomStringUtils.random(5));
		this.setClips(new ArrayList<ObjectId>());
		this.setFollower(new ArrayList<ObjectId>());
		this.setFollowing(new ArrayList<ObjectId>());
		this.setImages(new ArrayList<String>());
	}

	@BsonIgnore
	public static ArrayList<User> getAllUsers() {
		FindIterable<User> cursor = USER.find();
		Iterator<User> it = cursor.iterator();
		ArrayList<User> data = new ArrayList<User>();
		if (it.hasNext()) {
			while (it.hasNext()) {
				data.add(it.next());
			}
		}
		return data;
	}
	
	@BsonIgnore
	public static User GetUserByEmail(String email) {
		Account acc = ACCOUNT.find(Filters.eq("email", email)).first();
		if (acc == null)
			return null;
		User user = USER.find(Filters.eq("account_id", acc.getId())).first();
		return user;
	}

	@BsonIgnore
	public static User GetUserByUsername(String username) {
		Account acc = ACCOUNT.find(Filters.eq("username", username)).first();
		if (acc != null) {
			ObjectId account_id = acc.getId();
			User user = USER.find(Filters.eq("account_id", account_id)).first();
			return user;
		} else
			return null;
	}
	
	@BsonIgnore
	public static ObjectId GetAccountIdFromCookies(Cookie[] cookie) {
		if (cookie == null)
			return null;
		String selector = "", validator = "";
		for (Cookie c : cookie) {
			if (c.getName().equals("selector")) {
				selector = c.getValue();
			}
			if (c.getName().equals("validator")) {
				validator = c.getValue();
			}
		}
		ObjectId account_id = Model.Authenticator(selector, validator);
		return account_id;
	}
	@BsonIgnore

	public static User GetUserInfoFromCookies(Cookie[] cookie) {
		ObjectId account_id = GetAccountIdFromCookies(cookie);
		return USER.find(Filters.eq("account_id", account_id)).first();

	}

	@BsonIgnore
	public static User GetUserByUserID(ObjectId userID) {
		return USER.find(Filters.eq("_id", userID)).first();
	}
	
	@BsonIgnore
	public static User GetUserByAccountID(ObjectId account_id) {
		return USER.find(Filters.eq("account_id", account_id)).first();
	}

	@BsonIgnore
	public static void updatePassword(String newPass, String username) {
		ACCOUNT.updateOne(Filters.eq("username", username), Updates.set("passwword", newPass));
	}

	@BsonIgnore
	public static void InsertUserToFollower(ObjectId userID, ObjectId followerID)
	{
		USER.updateOne(Filters.eq("_id", followerID),Updates.addToSet("following", userID));
		USER.updateOne(Filters.eq("_id", userID), Updates.addToSet("follower", followerID));
	}
	
	@BsonIgnore
	public static void RemoveUserFromFollower(ObjectId userID, ObjectId followerID)
	{
		USER.updateOne(Filters.eq("_id", followerID), Updates.pullByFilter(Filters.eq("following", userID)));

		
		USER.updateOne(Filters.eq("_id", userID), Updates.pullByFilter(Filters.eq("follower", followerID)));
	}
	
	@BsonIgnore
	public static void InsertUserToFollowing(ObjectId userID, ObjectId followingID)
	{
		USER.updateOne(Filters.eq("_id", userID), Updates.addToSet("following", followingID));
	}
	
	@BsonIgnore
	public static void RemoveUserFromFollowing(ObjectId userID, ObjectId followingID)
	{
		USER.updateOne(Filters.eq("_id", userID), Updates.pullByFilter(Filters.eq("following", followingID)));
	}
	
	@BsonIgnore
	public static void InsertNewClipPost(ObjectId userID, ObjectId postID)
	{
		USER.updateOne(Filters.eq("_id", userID), Updates.addToSet("clips", postID));

	}
	
	@BsonIgnore
	public static void RemovePostFromClips(ObjectId userID, ObjectId postID)
	{
		USER.updateOne(Filters.eq("_id", userID), Updates.pullByFilter(Filters.eq("clips", postID)));
	}
	
	@BsonIgnore
	public static User GetUserInfoFromSession(HttpSession session) {
		if (session == null)
			return null;
		String selector = session.getAttribute("selector").toString();
		String validator = session.getAttribute("validator").toString();
		ObjectId userID = Model.Authenticator(selector, validator);
		return USER.find(Filters.eq("_id", userID)).first();
	}

	@BsonIgnore
	public String getUsername() {
		return ACCOUNT.find(Filters.eq("_id", this.getAccount_id())).first().getUsername();
	}

	@BsonIgnore
	public static List<Post> getBookmarkPost(User user) {
		if (user.getClips()==null) 
			return null;
		List<Post> lstPosts = new ArrayList<Post>();
		List<ObjectId> lstPostIDs = user.getClips();
		for (ObjectId postID : lstPostIDs) {
			lstPosts.add(Post.GetPostByID(postID));
		}
		return lstPosts;
	}

	@BsonIgnore
	public boolean checkPassword(User user, String password) {
		Account acc = Model.ACCOUNT.find(Filters.eq("_id", user.getAccount_id())).first();
		if (acc != null) {
			System.out.print(acc.password);
			String _password_ = acc.getPassword();
			String hashed_password = DigestUtils.sha256Hex(password);
			 return hashed_password.equals(_password_);
		}
		return false;
	}

	@BsonIgnore
	public List<User> getListFollower(User user) {
		if (user.getFollower() == null)
			return null;
		List<User> users = new ArrayList<User>();
		int size = user.getFollower().size();
		for (int i = 0; i < size; i++) {
			users.add(User.GetUserByUserID(user.getFollower().get(i)));
		}
		return users;
	}

	@BsonIgnore
	public List<User> getListFollowing(User user) {
		if (user.getFollowing() == null)
			return null;
		List<User> users = new ArrayList<User>();
		int size = user.getFollowing().size();
		for (int i = 0; i < size; i++) {
			users.add(User.GetUserByUserID(user.getFollowing().get(i)));
		}
		return users;
	}

	public int countFollowing(User user) {

		return user.getFollowing().size();
	}

	public int countFollower(User user) {

		return user.getFollower().size();
	}

	@BsonIgnore
	public int countPost(ObjectId userID) {
		int count = 0;
		FindIterable<Post> cursor = POST.find(Filters.eq("user_id", userID));
		Iterator<Post> it = cursor.iterator();
		if (it.hasNext()) {
			while (it.hasNext()) {
				count++;
				it.next();
			}
		}
		return count;
	}


	public int countTotalPostView(ObjectId account_id) {
		int total = 0;
		List<Post> posts = Post.GetAllPostByAccountID(account_id);
		for (Post k : posts) {
			total += k.getViews_count();
		}
		return total;
	}

	public int countClips(User user) {
		return user.getClips().size();
	}


	public static boolean updateInforUser(ObjectId accId, String fullname, String email, String username) {

		UpdateResult result2;
		UpdateResult result1;
			result1 = ACCOUNT.updateOne(
					Filters.eq("_id", accId),
					Updates.combine(
							Updates.set("email", email), 
							Updates.set("username", username))
					);
		
			result2 = USER.updateOne(Filters.eq("account_id", accId), Updates.set("fullname", fullname));
			//System.out.print("bool : " +result1 + "||"+result2);
		if (result1.getModifiedCount() <= 0 || result2.getModifiedCount() <= 0)
			return false;
		return true;
	}
	
	public static boolean updatePassword (ObjectId accId, String password) {
		
		UpdateResult result2;
		String hashed_password = DigestUtils.sha256Hex(password);
		result2 = ACCOUNT.updateOne(Filters.eq("_id", accId), Updates.set("password", hashed_password));
		if ( result2.getModifiedCount() <= 0)
			return false;
		return true;

	}

	@BsonIgnore
	public static void updateUserStatusByAccountID(ObjectId userId, String newStatus) {
	
		USER.updateOne(Filters.eq("_id", userId), Updates.set("status", newStatus));
		System.out.println("update thanh cong");
	}
	
	public static void InsertImage(ObjectId account_id, String filePath)
	{
		USER.updateOne(Filters.eq("account_id", account_id), Updates.addToSet("images", filePath));
	}

	public void Insert()
	{
		USER.insertOne(this);
	}

	public  boolean getUserFromFollowing (User user)
	{
		for(int i=0; i<this.getFollowing().size(); i++)
			if(this.getFollowing().get(i).equals(user.getId()))	
				return true;
		return false;
	}
}
