package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.bson.types.ObjectId;

import model.Category;
import model.Post;

@WebServlet("/edit")
public class editController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public editController() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html");
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");

		String p = request.getParameter("p");
		ObjectId post_id = new ObjectId((String)request.getParameter("postID"));
		Post post = Post.GetPostByID(post_id);
		String title = post.getTitle();
		String content = post.getContent();
		String category = post.getCategory();
		boolean is_public = post.getIs_public();
		List<Category> lstCategories = Category.GetAllCategories();
		request.setAttribute("lstCat", lstCategories);
		request.setAttribute("title", title);
		request.setAttribute("content", content);
		request.setAttribute("category", category);
		request.setAttribute("is_public", is_public);
		request.setAttribute("is_logged", true);
		request.setAttribute("p", p);

		String url = "/posts/edit.jsp";
		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(url);
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
