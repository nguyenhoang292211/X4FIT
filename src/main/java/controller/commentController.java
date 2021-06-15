package controller;

import java.util.Date;

import model.*;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.bson.types.ObjectId;

@WebServlet("/comment")
public class commentController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public commentController() {
		super();
	}

	protected void process(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html");
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		
		ObjectId postID = new ObjectId(request.getParameter("postID"));
		ObjectId userID = User.GetAccountIdFromCookies(request.getCookies());
		
		String p = request.getParameter("url");
		String content = request.getParameter("comment");
		Comment cmt = new Comment(userID, postID, content);
		cmt.Insert();
		
		String url = "post?p=" + p;
		response.sendRedirect(url);

	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		process(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		process(request, response);
	}

}
