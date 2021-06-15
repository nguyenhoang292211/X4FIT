package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.bson.types.ObjectId;

import model.Account;
import model.Comment;
import model.Post;

@WebServlet(name = "vote", urlPatterns = { "/vote" })
public class voteController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public voteController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		
		if (Account.isLogged(request.getCookies())== false)
		{
			String url = "/login";
			response.sendRedirect(request.getContextPath() + url);
			return;
		}
		
		ObjectId id = new ObjectId(request.getParameter("id"));
		String type = request.getParameter("type");
		int point = Integer.parseInt((String)request.getParameter("point"));
		
		if (type.equals("COMMENT"))
		{
			Comment.Vote(id, point);
		}
		else if (type.equals("POST"))
		{
			Post.Vote(id, point);	
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
