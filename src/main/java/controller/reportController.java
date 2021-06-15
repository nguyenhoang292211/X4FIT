package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.bson.types.ObjectId;

import model.Account;
import model.Model;
import model.Report;
import model.User;

@WebServlet(name = "report", urlPatterns = { "/report" })
public class reportController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public reportController() {
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
		
		ObjectId account_id = User.GetAccountIdFromCookies(request.getCookies());
		if (account_id == null)
		{
			response.sendRedirect(request.getContextPath() + "/login/login.jsp");
			return;
		}
		
		String type = request.getParameter("type");
		if (type.equals("POST"))
		{
			String id = request.getParameter("report_postID");
			ObjectId post_id = new ObjectId(id);
			String description = request.getParameter("report");
			if (description==null) description = "Spam";
			Report report = new Report(post_id, type, description, account_id);
			report.Insert();
		}
		else if (type.equals("COMMENT"))
		{
			String id = request.getParameter("comment_id");
			ObjectId comment_id = new ObjectId(id);
			Report report = new Report(comment_id, type, "Spam", account_id);
			report.Insert();
		}
		String p = request.getParameter("p");
		String url = request.getContextPath() + "/post?p="+p;
		response.sendRedirect(url);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
