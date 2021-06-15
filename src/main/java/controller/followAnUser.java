package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.bson.types.ObjectId;

import model.Account;
import model.User;


@WebServlet("/followAnUser")
public class followAnUser extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		if (Account.isLogged(request.getCookies())== false)
		{
			String url = "/login";
			response.sendRedirect(request.getContextPath() + url);
			return;
		}
		
		ObjectId iduser=new ObjectId (  request.getParameter("iduser"));
		ObjectId  mainuser =new ObjectId( request.getParameter("mainuser"));
		
		if(request.getParameter("delete")!=null )
			{
				User.RemoveUserFromFollower(iduser, mainuser);
			}
		else
		{
			User.InsertUserToFollower(iduser, mainuser);
		}
		  response.setContentType("application/json");
		  response.getWriter().write("done");
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
