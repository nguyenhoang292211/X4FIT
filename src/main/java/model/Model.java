package model;

import java.text.Normalizer;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.regex.Pattern;

import org.bson.Document;
import org.bson.codecs.configuration.CodecRegistries;
import org.bson.codecs.configuration.CodecRegistry;
import org.bson.codecs.pojo.PojoCodecProvider;
import org.bson.codecs.pojo.annotations.BsonIgnore;
import org.bson.types.ObjectId;

import com.mongodb.BasicDBObject;
import com.mongodb.ConnectionString;
import com.mongodb.MongoClientOptions;
import com.mongodb.MongoClientSettings;
import com.mongodb.MongoClientOptions.Builder;
import com.mongodb.MongoClientURI;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Filters;

import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;

public class Model {
	public static ConnectionString connectionString = new ConnectionString("mongodb+srv://tiennhm:m1nht13n@cluster0.brj3o.mongodb.net/X4FIT2?retryWrites=true&w=majority");
	//public static ConnectionString connectionString = new ConnectionString("mongodb://tiennhm:m1nht13n@cluster0-shard-00-00.brj3o.mongodb.net:27017,cluster0-shard-00-01.brj3o.mongodb.net:27017,cluster0-shard-00-02.brj3o.mongodb.net:27017/X4FIT?ssl=true&replicaSet=atlas-emonwf-shard-0&authSource=admin&retryWrites=true&w=majority");
	public static CodecRegistry pojoCodecRegistry = CodecRegistries.fromProviders(PojoCodecProvider.builder().automatic(true).build());
	public static CodecRegistry codecRegistry = CodecRegistries.fromRegistries(MongoClientSettings.getDefaultCodecRegistry(), pojoCodecRegistry);
//	MongoClient mongoClient = MongoClients.create(MongoClientSettings.builder()
//            .codecRegistry(pojoCodecRegistry).build());
	public static MongoClientSettings clientSettings = MongoClientSettings.builder()
            .applyConnectionString(connectionString)
            .codecRegistry(codecRegistry)
            .build();
	public static MongoClient mongoClient = MongoClients.create(clientSettings);
    public static MongoDatabase db = mongoClient.getDatabase("X4FIT2");
	
    @BsonIgnore
	public static MongoCollection<Post> POST = db.getCollection("POST", Post.class);
    @BsonIgnore
	public static MongoCollection<User> USER = db.getCollection("USER", User.class);
    @BsonIgnore
	public static MongoCollection<Comment> COMMENT = db.getCollection("COMMENT", Comment.class);
    @BsonIgnore
	public static MongoCollection<Account> ACCOUNT = db.getCollection("ACCOUNT", Account.class);
    @BsonIgnore
	public static MongoCollection<Authentication> AUTHENTICATION = db.getCollection("AUTHENTICATION", Authentication.class);
	@BsonIgnore
    public static MongoCollection<Category> CATEGORY = db.getCollection("CATEGORY", Category.class);
	@BsonIgnore
	public static MongoCollection<Report> REPORT = db.getCollection("REPORT", Report.class);
	@BsonIgnore
	Logger logger = Logger.getLogger("org.mongodb.driver");

	public Model() {
		logger.setLevel(Level.SEVERE);
	}

	public static int isExitInArray(List<Integer> list, int x) {
		for (int i = 0; i < list.size(); i++)
			if (list.get(i) == x)
				return 1;
		return 0;
	}

	public static int getLastestID(String collectionName) {
		MongoCollection<Document> collection = db.getCollection(collectionName);
		Document lastInsertion = collection.find().sort(new BasicDBObject("_id", -1)).first();
		if (lastInsertion.get("id") == null)
			return 0;
		int id = Integer.parseInt(lastInsertion.get("id").toString());
		return id;
	}

	public static int getLastestID(MongoCollection<Document> collection) {
		Document lastInsertion = collection.find().sort(new BasicDBObject("_id", -1)).first();
		int id = 0;
		try 
		{
			id = Integer.parseInt(lastInsertion.get("id").toString());
		} 
		catch (Exception e)
		{

		}
		return id;
	}

	// Dùng để lấy account_id từ session
	public static ObjectId Authenticator(String selector, String validator) {
		Authentication auth = AUTHENTICATION.find(
				Filters.and(
						Filters.eq("selector", selector), 
						Filters.eq("validator", validator))
				).first();
		if (auth == null)
			return null;
		return auth.getAccount_id();
	}
	
//	@BsonIgnore
//	public static MongoClient getMongoClient()
//	{
//		return MongoClients.create(clientSettings);
//	}
//	
//	@BsonIgnore
//	public static MongoDatabase getDB()
//	{
//		return getMongoClient().getDatabase("X4FIT2");
//	}
//	
//	@BsonIgnore
//	public static MongoCollection<Post> getPOST()
//	{
//		POST = getDB().getCollection("POST", Post.class);
//		return POST;
//	}
//	
//	@BsonIgnore
//	public static MongoCollection<Comment> getCOMMENT()
//	{
//		COMMENT = getDB().getCollection("COMMENT", Comment.class);
//		return COMMENT;
//	}
//	
//	@BsonIgnore
//	public static MongoCollection<User> getUSER()
//	{
//		USER = getDB().getCollection("USER", User.class);
//		return USER;
//	}
//	
//	@BsonIgnore
//	public static MongoCollection<Account> getACCOUNT()
//	{
//		ACCOUNT = getDB().getCollection("ACCOUNT", Account.class);
//		return ACCOUNT;
//	}
//	
//	public static MongoCollection<Authentication> getAUTH()
//	{
//		AUTHENTICATION = getDB().getCollection("AUTHENTICATION", Authentication.class);
//		return AUTHENTICATION;
//	}
//	
//	@BsonIgnore
//	public static MongoCollection<Category> getCATEGORY()
//	{
//		return getDB().getCollection("CATEGORY", Category.class);
//	}
//	
//	@BsonIgnore
//	public static MongoCollection<Report> getREPORT()
//	{
//		return getDB().getCollection("REPORT", Report.class);
//	}
//	
//	@BsonIgnore
//	public static void CloseConnection()
//	{
//		mongoClient.close();
//	}
}
