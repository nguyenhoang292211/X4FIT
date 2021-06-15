package model;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.bson.Document;
import org.bson.types.ObjectId;

import com.mongodb.client.FindIterable;
import com.mongodb.client.model.Filters;
import com.mongodb.client.model.Updates;

import x4fit.Utilities;

public final class Comment extends Model
{
	private ObjectId id;
	private ObjectId account_id ;
	private ObjectId post_id ;
	private int level;
	private int points;
	private ObjectId reply_cmtID;
	private String created_at;
	private String updated_at;
	private String content;
	private String status;

	public ObjectId getId() {
		return id;
	}

	public void setId(ObjectId id) {
		this.id = id;
	}

	public ObjectId getAccount_id() {
		return account_id;
	}

	public void setAccount_id(ObjectId account_id) {
		this.account_id = account_id;
	}

	public ObjectId getPost_id() {
		return post_id;
	}

	public void setPost_id(ObjectId post_id) {
		this.post_id = post_id;
	}

	public int getLevel() {
		return level;
	}

	public void setLevel(int level) {
		this.level = level;
	}

	public int getPoints() {
		return points;
	}

	public void setPoints(int points) {
		this.points = points;
	}

	public ObjectId getReply_cmtID() {
		return reply_cmtID;
	}

	public void setReply_cmtID(ObjectId reply_cmtID) {
		this.reply_cmtID = reply_cmtID;
	}

	public String getCreated_at() {
		return created_at;
	}

	public void setCreated_at(String created_at) {
		this.created_at = created_at;
	}

	public String getUpdated_at() {
		return updated_at;
	}

	public void setUpdated_at(String updated_at) {
		this.updated_at = updated_at;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Comment() {}
	
	public Comment(ObjectId userID, ObjectId postID, String content) {
		this(userID, 
			 postID, 
			 1, 	//level
			 0, 	//points
			 null, 	//reply_cmtID
			 Utilities.GetCurrentDateTime(), 
			 "", 	//updated_at
			 content,
			 "OK"	//status
			 );
	}
	
	public Comment(ObjectId accountID, ObjectId postID, int level, int points, ObjectId reply_cmtID,
				   String created_at, String updated_at, String content, String status) {
		this.setPost_id(postID);
		this.setAccount_id(accountID);
		this.setLevel(level);
		this.setPoints(points);
		this.setReply_cmtID(reply_cmtID);
		this.setCreated_at(created_at);
		this.setUpdated_at(updated_at);
		this.setContent(content);
		this.setStatus(status);
	}
	
	public void Insert()
	{
		COMMENT.insertOne(this);
	}
	
	public static Comment GetCommentByID(ObjectId cmt_id)
	{
		Comment cmt = COMMENT.find(Filters.eq("cmt_id", cmt_id)).first();
		return cmt;
	}
	
	public static void Vote(ObjectId id, int point)
	{
		COMMENT.findOneAndUpdate(Filters.eq("_id", id), Updates.inc("points", point));
	}

	public static List<Comment> getAllCommentsByPostID(ObjectId post_id)
	{
		List<Comment> listCmt = new ArrayList<Comment>();
		FindIterable<Comment> cursor = COMMENT.find(Filters.eq("post_id", post_id));
		Iterator<Comment> list = cursor.iterator();
		while(list.hasNext())
		{
			listCmt.add(list.next());
		}
		return listCmt;
	}
	
	public User GetUser()
	{
		return User.GetUserByAccountID(this.getAccount_id());
	}
}
