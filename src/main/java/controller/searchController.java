package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Post;
import model.User;

/**
 * Servlet implementation class searchController
 */
@WebServlet("/search")
public class searchController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public searchController() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    private static int skip = 0;
    int limit = 5;
    
    private void process(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
    {
    	/*
    	if(request.getParameter("userCurrentAction")!= null)
    	{
    		
    		
    		if(request.getParameter("userCurrentAction").equals("search_home"))
        	{
        		String textSearch = request.getParameter("textSearch");
    	    	if(textSearch != "")
    	    	{
    	    		List<Post> listPost = getListPostForSearch( textSearch);
    	    		List<User> listAuthor = getListAuthorForSearch(textSearch);
    	    		
    	    		request.setAttribute("listPost",listPost);
    	    		request.setAttribute("listAuthor",listAuthor);
    	    		request.setAttribute("lenListpost",listPost.size());
    	    		request.setAttribute("lenListauthor",listAuthor.size());
    	    		request.setAttribute("textSearch",textSearch);
    	    	}
        	}
    	}

    	RequestDispatcher dis = getServletContext().getRequestDispatcher("/detailPost/search.jsp");	          
   	   	dis.forward(request, response);
   	   	
   	   	*/
    	 
    	
    	if(request.getParameter("textSearch")!= null || request.getParameter("textSearchHidden")!= null)
    	{
    		String textSearch  = "";
    		
    		if(request.getParameter("textSearchHidden")!= null)
    			textSearch = request.getParameter("textSearchHidden");
    		else
    		 textSearch = request.getParameter("textSearch");
    		
    		List<Post> listPost = getListPostForSearch( textSearch);
    		List<User> listAuthor = getListAuthorForSearch(textSearch);
    		
    		if (request.getParameter("page") == null)
    		{
    			listPost = listPostSearch(listPost, 0 , limit);
    			request.setAttribute("page", limit);
    			skip = limit;
    		}
    		else
    		{
    			
    			limit = limit + 5;
    			System.out.print(": "  + skip + ":" + limit);
    			listPost = listPostSearch(listPost, skip, limit);
    			
    			
    			if (listPost.size() == 0)
    			{
    				listPost = listPostSearch(listPost, 0 , limit);
    				request.setAttribute("page", limit);
    				skip = limit;
    			}
    			else
    			{
    				skip+=2;
    			}
    			
    			if(request.getParameter("page") != "")
    			{
    				int page = Integer.parseInt(request.getParameter("page"));
        			request.setAttribute("page", page);
    			}
    		}
    		
    		request.setAttribute("listPost",listPost);
    		request.setAttribute("listAuthor",listAuthor);
    		request.setAttribute("lenListpost",listPost.size());
    		request.setAttribute("lenListauthor",listAuthor.size());
    		request.setAttribute("textSearch",textSearch);
    		request.setAttribute("textSearchHidden", textSearch);
    		
    	}
    	
    	
    	else
    		System.out.print("null");
	

    	RequestDispatcher dis = getServletContext().getRequestDispatcher("/detailPost/search.jsp");	          
   	   	dis.forward(request, response);
    	
    }
    
    public List<Post> listPostSearch(List<Post> lPost, int skip, int limit)
    {
    	List<Post> post = new ArrayList<Post>();
    	
    	if(lPost.size() != 0)
    	{
    		if(lPost.size() < limit )
        		limit = lPost.size();
        	
        	for(int i = skip; i < limit ; i++)
        		post.add(lPost.get(i));
    	}
    	
    	return post;
    }
    
    public List<User> listUserSearch(List<User> lUser, int skip, int limit)
    {
    	List<User> user = new ArrayList<User>();
    	
    	if(lUser.size() < limit)
    		limit = lUser.size();
    	
    	for(int i = skip; i <= limit ; i++)
    		user.add(lUser.get(i));
    	
    	return user;
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
    

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		process(request,response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
