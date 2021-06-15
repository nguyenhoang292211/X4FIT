package controller;

import java.io.IOException;
import java.util.ArrayList;

import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.bson.types.ObjectId;

import model.Account;
import model.Post;
import model.User;

@WebServlet("/home")
public class homeController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
    public homeController() {
        super();
    }

    private static int skip = 0;
    int limit = 5;
    
	private void process(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{	
		ArrayList<Post> topPosts;
		if (request.getParameter("page") == null)
		{
			topPosts = Post.GetLastestPost(0, limit);
			request.setAttribute("page", limit);
			skip = limit;
		}
		else
		{
			topPosts = Post.GetLastestPost(skip, limit);
			if (topPosts.size() == 0)
			{
				topPosts = Post.GetLastestPost(0, limit);
				request.setAttribute("page", limit);
				skip = limit;
			}
			else
			{
				skip+=limit;
			}
			int page = Integer.parseInt(request.getParameter("page"));
			request.setAttribute("page", page);
		}
		
		Cookie[] cookies = request.getCookies();
		if (cookies!=null)
		{
			ObjectId accountID = User.GetAccountIdFromCookies(cookies);
			
			if (accountID != null)
			{
				User user = User.GetUserByAccountID(accountID);
				request.setAttribute("user", user);
			}
			if (Account.isLogged(request.getCookies()))
				request.setAttribute("is_logged", true);
			else request.setAttribute("is_logged", false);
		}
		else
		{
			request.setAttribute("is_logged", false);
		}
		
		request.setAttribute("topPosts", topPosts);
		
		String url = "/index2.jsp";
		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(url);
		dispatcher.forward(request, response);     
    }
    
    public List<Post> getListPostForSearch(String textSearch)
    {
    	
    	List<Post> listPost = new ArrayList<Post>();

    	listPost = Post.SearchPost(textSearch);
    	return listPost;
    }

    
    public List<User> getListAuthorForSearch(String textSearch)
    {
    	
    	List<User> listUser = new ArrayList<User>();
    	listUser = Post.searchAuthor(textSearch);
    	return listUser;
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		
		HttpSession session = request.getSession();
		process(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
