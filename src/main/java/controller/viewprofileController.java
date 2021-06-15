package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Account;
import model.Post;
import model.User;

@WebServlet("/viewprofile")
public class viewprofileController extends HttpServlet {
	
	Post post= new Post();
	User user= new User();

	
	public User ValidateUser(HttpServletRequest request)
	{
		Cookie[]  cookies = request.getCookies();
		//if(cookies[0].getName()!="selector" && cookies[1].getName()!=" validator")
		{
			user=User.GetUserInfoFromCookies(cookies);
			if(user!= null)
			{
				request.setAttribute("usermain", user);
				return user;
			}
			return null;
		}
		//else return null;		
	
	}
	
	
	
	public void getListBookmark(User user1, HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException{
		response.setContentType("text/html");
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		//System.out.print(user.getUsername());
		request.setAttribute("clipspost", User.getBookmarkPost(user1));
		
	}
	
	public void getFollowingUser(User user1 ,HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException{
		response.setContentType("text/html");
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		request.setAttribute("following", user1.getListFollowing(user1));
		
		
	}	
	
	public void getFollowerUser(User user1 ,HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException{
		response.setContentType("text/html");
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		request.setAttribute("follower", user1.getListFollower(user1));
		
		
	}	
	
	public void getListPost(User user1 ,HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException{
		response.setContentType("text/html");
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		
			// System.out.print(user.getEmail()+ user.getId());
		List<Post> posts = Post.GetAllPostByAccountID(user1.getAccount_id());
		request.setAttribute("listpost", posts);
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		if (Account.isLogged(request.getCookies()) == false)
		{
			String url = "/login";
			response.sendRedirect(request.getContextPath() + url);
			return;
		}
		
		ValidateUser(request);
		if(request.getParameter("email")!=null)
		{
			User userprofile= User.GetUserByEmail(request.getParameter("email").toString());
			request.setAttribute("curUser", userprofile);
			Account acc= Account.GetAccountByID(userprofile.getAccount_id());
		    request.setAttribute("acc", acc);
			getListPost(userprofile,request, response);
			getListBookmark(userprofile, request, response);
			
			getFollowingUser(userprofile, request, response);
			getFollowerUser(userprofile,request, response);
		}
		
		String url="/users/profile.jsp";
		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher (url);
		dispatcher.forward(request, response);
	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
