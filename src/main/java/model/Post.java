package model;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;

import org.bson.Document;
import org.bson.codecs.pojo.annotations.BsonIgnore;
import org.bson.types.ObjectId;
//import org.eclipse.persistence.nosql.annotations.Field;

import com.mongodb.BasicDBObject;
import com.mongodb.client.FindIterable;
import com.mongodb.client.model.Filters;
import com.mongodb.client.model.Updates;

import x4fit.Utilities;

public final class Post extends Model {
	private ObjectId id;
	private String title;
	private ObjectId author_id;
	private String url;
	private String content;
	private String published_at;
	private String updated_at;
	private int views_count;
	private int points;
	private boolean is_public;
	private String thumbnail_url;
	private String status;
	private String category;
	private List<ObjectId> upvote;	// chứa DS userID đã upvote cho bài viết
	private List<ObjectId> downvote;// chứa DS userID đã downvote cho bài viết
	private List<ObjectId> clips;	// chứa DS userID đã ghim bài viết

	public List<ObjectId> getClips() {
		return clips;
	}
	
	public void setClips(List<ObjectId> clips) {
		this.clips = clips;
	}
	public List<ObjectId> getUpvote() {
		return upvote;
	}
	public void setUpvote(List<ObjectId> upvote) {
		this.upvote = upvote;
	}
	public List<ObjectId> getDownvote() {
		return downvote;
	}

	public void setDownvote(List<ObjectId> downvote) {
		this.downvote = downvote;
	}

	public ObjectId getId() {
		return id;
	}
	public void setId(ObjectId id) {
		this.id = id;
	}
	
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}

	public ObjectId getAuthor_id() {
		return author_id;
	}

	public void setAuthor_id(ObjectId author_id) {
		this.author_id = author_id;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}

	public String getPublished_at() {
		return published_at;
	}
	public void setPublished_at(String published_at) {
		this.published_at = published_at;
	}

	public String getUpdated_at() {
		return updated_at;
	}
	public void setUpdated_at(String updated_at) {
		this.updated_at = updated_at;
	}

	public int getViews_count() {
		return views_count;
	}
	public void setViews_count(int views_count) {
		this.views_count = views_count;
	}

	public int getPoints() {
		return points;
	}
	public void setPoints(int points) {
		this.points = points;
	}

	public int getClips_count(Post post) {
		return post.getClips().size();
	}

	public boolean getIs_public() {
		return is_public;
	}
	public void setIs_public(boolean is_public) {
		this.is_public = is_public;
	}

	public String getThumbnail_url() {
		if (thumbnail_url == null || thumbnail_url.equals(""))
			return "thumbnail.jpg";
		return thumbnail_url;
	}
	public void setThumbnail_url(String thumbnail_url) {
		this.thumbnail_url = thumbnail_url;
	}

	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
	public Post() {
	}


	public Post(String title, ObjectId author_id, String content, boolean is_public, String thumbnail_url, String category) 
	{
		this.id = new ObjectId();
		this.title = title;
		this.author_id = author_id;
		this.url = Utilities.createURL(title);
		this.content = content;
		this.published_at = this.updated_at = Utilities.GetCurrentDateTime();
		this.views_count = 0;
		this.points = 0;
		this.is_public = is_public;
		this.thumbnail_url = thumbnail_url;
		this.category = category;
		this.status = "Chờ duyệt";
		this.setClips(new ArrayList<ObjectId>());
		this.setUpvote(new ArrayList<ObjectId>());
		this.setDownvote(new ArrayList<ObjectId>());
	}
	
	// Duyệt bài post
	public static boolean acceptPost(ObjectId postId) {
		try {
//			POST.updateOne(Filters.eq("_id", postId), new Document("$set", new Document("status", "Đã duyệt")));
			POST.updateOne(Filters.eq("_id", postId), 
					Updates.combine(Updates.set("status", "Đã duyệt"), Updates.set("is_public", true)));
			System.out.println("Accepted post!");
			return true;
		} catch (Exception ex) {
			System.out.println(ex.getMessage());
			return false;
		}
	}

	public ArrayList<Comment> GetAllComments() {
		FindIterable<Comment> cursor = COMMENT.find(Filters.eq("post_id", this.getId()));
		Iterator<Comment> it = cursor.iterator();
		ArrayList<Comment> listComments = new ArrayList<Comment>();
		if (it.hasNext()) {
			while (it.hasNext()) {
				listComments.add(it.next());
			}
		}
		return listComments;
	}

	@BsonIgnore
	public static List<Post> getAllPosts() {
		FindIterable<Post> cursor = POST.find();
		Iterator<Post> it = cursor.iterator();
		List<Post> data = new ArrayList<Post>();
		if (it.hasNext()) {
			while (it.hasNext()) {
				data.add(it.next());
			}
		}
		return data;
	}

	public void Insert()
	{
		POST.insertOne(this);
	}
	
	public static List<Post> search(String query) {
		query = Utilities.removeAccent(query.toLowerCase());
		String isPublic = "cong khai";
		String isPrivate = "rieng tu";
		FindIterable<Post> cursor = POST.find();
		Iterator<Post> it = cursor.iterator();
		List<Post> data = new ArrayList<Post>();
		if (it.hasNext()) {
			while (it.hasNext()) {
				Post post = it.next();
				
				// Handle data in database
				String tilte = Utilities.removeAccent(post.getTitle().toLowerCase());
				String category = Utilities.removeAccent(post.getCategory().toLowerCase());
				String status = Utilities.removeAccent(post.getStatus().toLowerCase());
				
				if (tilte.indexOf(query) != -1
						|| category.indexOf(query) != -1
						|| String.valueOf(post.getViews_count()).indexOf(query) != -1
						|| String.valueOf(post.getPoints()).indexOf(query) != -1
						|| status.indexOf(query) != -1) {
					data.add(post);
				}
				
				// Tìm kiếm theo trạng thái
				String statusQuery = "";
				if (isPublic.indexOf(query) != -1) {
					statusQuery = "true";
				} else if (isPrivate.indexOf(query) != -1) {
					statusQuery = "false";
				}
				
				if (String.valueOf(post.is_public).equals(statusQuery)) {
					data.add(post);
				}
			}
		}
		return data;
	}

	public static Post GetPost(String p) {
		Post post = POST.findOneAndUpdate(Filters.eq("url", p), Updates.inc("views_count", 1));
		return post;
	}
	
	public static ArrayList<Post> GetLastestPost(int skip, int lim)
	{
		FindIterable<Post> cursor = POST.find(Filters.eq("is_public", true))
										.sort(new BasicDBObject("_id", -1))
										.skip(skip).limit(lim);
		Iterator<Post> it = cursor.iterator();
		ArrayList<Post> topPost = new ArrayList<Post>();
		if (it.hasNext()) {
			while (it.hasNext()) {
				topPost.add(it.next());
			}
		}
		return topPost;
	}

	public static void Vote(ObjectId id, int point)
	{
		POST.findOneAndUpdate(Filters.eq("_id", id), Updates.inc("points", point));
	}
	
	public static List<Post> GetAllPostByAccountID(ObjectId account_id) {
		FindIterable<Post> cursor = POST.find(new BasicDBObject("author_id", account_id));
		Iterator<Post> it = cursor.iterator();
		List<Post> lstPost = new ArrayList<Post>();
		if (it.hasNext()) {
			while (it.hasNext()) {
				lstPost.add(it.next());
			}
		}
		//System.out.print(lstPost.size());
		return lstPost;
	}

	public static String Update(String p, String title, String new_title, String content, 
			boolean is_public, String thumbnail_url, String category) {
		
		String newURL = p;
		if (!new_title.equals(title))
			newURL = Utilities.createURL(title);
		POST.updateOne(Filters.eq("url", p),
				Updates.combine(Updates.set("url", newURL), 
						Updates.set("title", new_title), 
						Updates.set("content", content),
						Updates.set("category", category), 
						Updates.set("is_public", is_public),
						Updates.set("updated_at", Utilities.GetCurrentDateTime()),
						Updates.set("thumbnail_url", thumbnail_url)));
		return newURL;
		
	}
	
	public static void Delete(ObjectId postId) {
		POST.deleteOne(Filters.eq("_id", postId));
	}

	public void updateVote(ObjectId userID, int point)
	{
		String field = "upvote";
		if (point < 0) field = "downvote";
		POST.findOneAndUpdate(
				Filters.eq("_id", this.getId()), 
				Updates.combine(
						Updates.inc("points", point),
						Updates.addToSet(field, userID)
						)
				);
		
	}

	public static Post GetPostByID(ObjectId id) {
		return POST.find(Filters.eq("_id", id)).first();
	}

	public List<Post> getPostOfUser(int idUser) {
		List<Post> lPost = new ArrayList<Post>();
		FindIterable<Post> listPost = POST.find(Filters.eq("author_id", idUser));
		Iterator<Post> list = listPost.iterator();
		while (list.hasNext()) {
			lPost.add(list.next());
		}

		return lPost;
	}
	
	public static void InsertClips(String url, int userID)
	{
		POST.findOneAndUpdate(Filters.eq("url", url), Updates.addToSet("clips", userID));
	}
	
	@BsonIgnore
	public long getComments_Count()
	{
		long count = COMMENT.countDocuments(Filters.eq("post_id", this.getId()));
		return count;

	}
	
	public static List<Post> SearchPost(String textSearch)
	{
		int checkContent = 0;
		List<Post> lPost = new ArrayList<Post>();
		BasicDBObject regexQuery = new BasicDBObject();
		BasicDBObject regexQueryContent = new BasicDBObject();
		BasicDBObject regexQueryUser = new BasicDBObject();
		if(textSearch.contains(":"))
		{
			// tìm kiếm theo tên field
			String fieldName = "";
			String content = "";
			String[] parts = textSearch.split(":");
			fieldName = parts[0];
			content = parts[1];
			
			if(fieldName.contains("user"))
				{
					regexQueryUser.put("fullname", new BasicDBObject("$regex", ".*" + content + ".*").append("$options", "i"));
					FindIterable<User>  fListUser = USER.find(regexQueryUser);
					Iterator<User> iListUser = fListUser.iterator();
					while(iListUser.hasNext())
					{
						addListPostByUserID(lPost, iListUser.next().getId());
					}
				}
			else if(fieldName.contains("NOT"))
			{
				regexQuery.put("title", new BasicDBObject("$not", new BasicDBObject("$regex", ".*" + content + ".*").append("$options", "i")));
			}
			else if(fieldName.contains("tag"))
			{
				regexQuery.put("category", new BasicDBObject("$regex", ".*" + content + ".*").append("$options", "i"));
			}
			else
				regexQuery.put(fieldName, new BasicDBObject("$regex", ".*" + content + ".*").append("$options", "i"));
		}
		
		else			
			{
				regexQuery.put("title", new BasicDBObject("$regex", ".*" + textSearch + ".*").append("$options", "i"));
				
				//tìm kiếm trong content
				regexQueryContent.put("content", new BasicDBObject("$regex", ".*" + textSearch + ".*").append("$options", "i"));
				checkContent = 1;
			}
		
		FindIterable<Post>  listPost = Model.POST.find(regexQuery);
		Iterator<Post> list = listPost.iterator();
	
		while(list.hasNext())
		{
			lPost.add(list.next());			
		}
		
		if(checkContent == 1)
		{
			FindIterable<Post>  listPostContent = Model.POST.find(regexQueryContent);
			Iterator<Post> listContent = listPostContent.iterator();
			
			while(listContent.hasNext())
			{
				lPost.add(listContent.next());			
			}
		}
		
		
		return lPost;
	}
	
	public static void addListPostByUserID(List<Post> lPost, ObjectId userID)
	{
		FindIterable<Post> listPost = Model.POST.find(Filters.eq("author_id", userID));
		Iterator<Post> list = listPost.iterator();
		while(list.hasNext())
		{
			lPost.add(list.next());
		}
	}
	
	public static List<User> searchAuthor(String textSearch)
	{
		List<User> lUser = new ArrayList<User>();
		
		
		BasicDBObject regexQuery = new BasicDBObject();
		regexQuery.put("fullname", new BasicDBObject("$regex", ".*" + textSearch + ".*").append("$options", "i"));
		FindIterable<User>  listUser = Model.USER.find(regexQuery);
		
		Iterator<User> list = listUser.iterator();
		while(list.hasNext())
		{
			lUser.add(list.next());	
		}
		return lUser;
	}
	
	public String getShortContent()
	{
		if(this.getContent().length() < 150)
			return this.getContent();
		return (this.getContent().substring(0, 150) + "...");
		
	}
	
	public int getClips_count()
	{
		return this.getClips().size();
	}
	
	public User GetAuthor()
	{
		return USER.find(Filters.eq("account_id", this.getAuthor_id())).first();
	}
}
