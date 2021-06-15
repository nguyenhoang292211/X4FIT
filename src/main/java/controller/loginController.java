package controller;

import model.Account;
import model.Authentication;
import model.Model;
import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.lang3.RandomStringUtils;
import org.bson.Document;
import org.bson.types.ObjectId;

import com.mongodb.client.model.Filters;

import model.User;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/login")
public class loginController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public loginController() {
		super();
	}

	// Kiểm tra đăng nhập và trả lại account_id nếu đăng nhập thành công
	public ObjectId Login(String username, String password) {
		Account acc = Model.ACCOUNT.find(Filters.eq("username", username)).first();
		if (acc != null) {
			
			String _password_ = acc.getPassword();
			String hashed_password = DigestUtils.sha256Hex(password);

			//System.out.print(hashed_password +" AND " +_password_ );

			if (hashed_password.equals(_password_))
			{
				//Đăng nhập thành công
				return acc.getId();
			}
			else return null;
		} 
		return null;
	}

	protected void process(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, NoSuchAlgorithmException {
		response.setContentType("text/html");
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		
		HttpSession session = request.getSession();
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		
		if (username==null || password == null)
		{
			String url = "/login/login.jsp";
			//response.sendRedirect(url);
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher (url);
			dispatcher.forward(request, response);
			return;
		}
		
		ObjectId account_id = Login(username, password);
		
		if ( account_id != null) {
			//Lưu cookie
			String selector = RandomStringUtils.randomAlphanumeric(12);
			String rawValidator = RandomStringUtils.randomAlphanumeric(64);
			String hashedValidator = DigestUtils.sha256Hex(rawValidator);
			
			Authentication auth = new Authentication(account_id, selector, hashedValidator);
			auth.Update();
			
			Cookie cookieSelector = new Cookie("selector", selector);
			cookieSelector.setMaxAge(604800);
			 
			Cookie cookieValidator = new Cookie("validator", hashedValidator);
			cookieValidator.setMaxAge(604800);
			
			Cookie cookieIsLogged = new Cookie("is_logged", "true");
			cookieValidator.setMaxAge(604800);
			
			response.addCookie(cookieSelector);
			response.addCookie(cookieValidator);
			response.addCookie(cookieIsLogged);
			
			Account account = Account.GetAccountByID(account_id);
			User user = User.GetUserByAccountID(account_id);
			session.setAttribute("user", user);
			request.setAttribute("is_logged", true);
			
			String url = "";
			
			if(user.getStatus().equals("BLOCK"))
			{
				session.setAttribute("status", "BLOCK");
				url = "login/status.jsp";
			}
				
			else if(user.getStatus().equals("NOT ACTIVE"))
			{
				session.setAttribute("status", "NOT ACTIVE");
				url = "login/status.jsp";
			}
			else 
			{
			url = request.getContextPath() + "/home";
			
			if (account.getUser_type().equals("ADMIN"))
				url = request.getContextPath() + "/admin/all-users";
			else if (account.getUser_type().equals("MOD"))
				url = request.getContextPath() + "/mod/all-categories";
			}
			response.sendRedirect(url);
		} 
		else 
		{
			request.setAttribute("username", username);
			request.setAttribute("password", password);
			String url = "login/login.jsp";
			response.sendRedirect(url);
		}
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		try {
			process(request, response);
		} catch (NoSuchAlgorithmException | ServletException | IOException e) {
			e.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
