package controller;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.bson.types.ObjectId;

import model.User;

@WebServlet("/gallery")
public class galleryController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public galleryController() {
        super();
    }

    private void GetGallery(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
    {
    	ObjectId account_id = User.GetAccountIdFromCookies(request.getCookies());
    	User user = User.GetUserByAccountID(account_id);
    	
    	String action = request.getParameter("action");
    	try {
        	request.setAttribute("images_gallary", user.getImages());
        	request.setAttribute("list_follower", user.getFollower());
        	request.setAttribute("list_following", user.getFollowing());
        	if (action.equals("uploaded"))
        	{
        		String url = "/upload.jsp";
    			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(url);
    			dispatcher.forward(request, response);
        	}
    	}
    	catch (Exception e) {
		}
    }
    
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		
		GetGallery(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
