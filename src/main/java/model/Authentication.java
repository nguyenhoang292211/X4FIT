package model;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpSession;

import org.bson.types.ObjectId;

import com.mongodb.client.model.Filters;
import com.mongodb.client.model.Updates;

public final class Authentication extends Model{
	private ObjectId id;
	private String selector;
	private String validator;
	private ObjectId account_id;
	
	public ObjectId getId() {
		return id;
	}
	public void setId(ObjectId id) {
		this.id = id;
	}
	public String getSelector() {
		return selector;
	}
	public void setSelector(String selector) {
		this.selector = selector;
	}
	public String getValidator() {
		return validator;
	}
	public void setValidator(String validator) {
		this.validator = validator;
	}
	public ObjectId getAccount_id() {
		return account_id;
	}
	public void setAccount_id(ObjectId account_id) {
		this.account_id = account_id;
	}
	
	public Authentication() {}
	
	public Authentication(ObjectId account_id, String selector, String validator)
	{
		this.setAccount_id(account_id);
		this.setSelector(selector);
		this.setValidator(validator);
	}
	
	public boolean Update()
	{
		if (account_id==null)
			return false;
		Authentication auth = AUTHENTICATION.find(Filters.eq("account_id", this.getAccount_id())).first();
		if (auth != null)
		{
			AUTHENTICATION.updateOne(Filters.eq("account_id", this.getAccount_id()), 
					Updates.combine(Updates.set("selector", this.getSelector()),
									Updates.set("validator", this.getValidator())));
		}
		else
		{
			this.Insert();
		}
		return true;
	}
	
	public void Insert() 
	{
		AUTHENTICATION.insertOne(this);
	}
}
