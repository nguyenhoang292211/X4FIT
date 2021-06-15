package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class logoutController
 */
@WebServlet(name = "logout", urlPatterns = { "/logout" })
public class logoutController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public logoutController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		
		HttpSession session = request.getSession();
		session.setAttribute("is_logged", false);
		session.setAttribute("is_create", false);
		
		for (Cookie c : request.getCookies()) {
			if (c.getName().equals("selector"))
			{
				c.setMaxAge(0);
				response.addCookie(c);
			}
			if (c.getName().equals("validator"))
			{
				c.setMaxAge(0);
				response.addCookie(c);
			}
				
		}
		session.setAttribute("user", null);
		Cookie cookieIsLogged = new Cookie("is_logged", "false");
		cookieIsLogged.setMaxAge(604800);
		response.addCookie(cookieIsLogged);
		response.sendRedirect(getServletContext().getContextPath() + "/login/login.jsp");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
