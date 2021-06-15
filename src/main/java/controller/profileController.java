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

@WebServlet("/profile")
public class profileController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	Post post = new Post();
	User user = new User();

	public User ValidateUser(HttpServletRequest request) {
		Cookie[] cookies = request.getCookies();
		// if(cookies[0].getName()!="selector" && cookies[1].getName()!=" validator")
		{

			user = User.GetUserInfoFromCookies(cookies);
			if (user != null) {
				request.setAttribute("usermain", user);
				return user;
			}
			return null;
		}
		// else return null;

	}

	public void getListBookmark(User user1, HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html");
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");

		request.setAttribute("clipspost", user.getBookmarkPost(user1));

	}

	public void getFollowingUser(User user1, HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html");
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		request.setAttribute("following", user.getListFollowing(user1));

	}

	public void getFollowerUser(User user1, HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html");
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		request.setAttribute("follower", user.getListFollower(user1));

	}

	public void getListPost(User user1, HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html");
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");

		// System.out.print(user.getEmail()+ user.getId());
		List<Post> posts = Post.GetAllPostByAccountID(user1.getAccount_id());
		request.setAttribute("listpost", posts);
	}

	@SuppressWarnings("static-access")
	public boolean updateInfo(HttpServletRequest request) {
		String fullname = request.getParameter("fullname") == null ? "" : request.getParameter("fullname").toString();
		String email = request.getParameter("email") == null ? "" : request.getParameter("email").toString();
		String username = request.getParameter("username") == null ? "" : request.getParameter("username").toString();

		User currentuser = ValidateUser(request);
		boolean valid = true;
		if (fullname.equals("")) {
			request.setAttribute("nameError", "You have to fill full name!");
			valid = false;
		} else
			request.setAttribute("nameError", "");

		if (email.equals("")) {
			request.setAttribute("emailError", "You have to fill your email!");
			valid = false;
		} else
			request.setAttribute("emailError", "");
		if (username.equals("")) {
			valid = false;
			request.setAttribute("usernameError", "You have to fill username!");
		} else {
			User user = User.GetUserByUsername(username);
			// System.out.print( "USER " +user.getUsername());
			if (user != null) {
				if (user.getId() != currentuser.getId()) {
					valid = false;
					request.setAttribute("usernameError", "This username is exists!");
				}
			} else
				request.setAttribute("usernameError", "");
		}

		// System.out.print("Minh là valid" +valid);
		if (valid == true) {
			// System.out.print(changeAccount);
			return User.updateInforUser(currentuser.getAccount_id(), fullname, email, username);
		}

		return false;

	}

	public boolean updateAccount(HttpServletRequest request) {
		String newpass = request.getParameter("newpass") == null ? "" : request.getParameter("newpass").toString();
		String oldpass = request.getParameter("oldpass") == null ? "" : request.getParameter("oldpass").toString();
		String confirm = request.getParameter("confirmnewpass") == null ? "": request.getParameter("confirmnewpass").toString();
		User currentuser = ValidateUser(request);

		boolean changeAccount = true;

		if (!(oldpass.equals("") && newpass.equals("") && confirm.equals(""))) {
			if (oldpass.equals("")) {
				changeAccount = false;
				request.setAttribute("oldpassError", "You have to confirm your old password!");
			} else
				request.setAttribute("oldpassError", "");
			if (confirm.equals("")) {
				changeAccount = false;
				request.setAttribute("confirmError", "Your have to fill confirm your new Password!");
			} else
				request.setAttribute("confirmError", "");
			if (newpass.equals("")) {
				changeAccount = false;
				request.setAttribute("newpassError", "Your have to fill your new Password!");
			} else
				request.setAttribute("newpassError", "");

			if (!oldpass.equals("") && !newpass.equals("") && !confirm.equals("")) {
				if (!newpass.equals(confirm)) {
					changeAccount = false;
					request.setAttribute("confirmError", "Your confirm Password is not correct!");
				}

				if (checkPassword(oldpass, request) == false) {

					changeAccount = false;
					request.setAttribute("oldpassError", "Your old password is not correct!");
				}

			}

			//System.out.print(changeAccount);
		} else {
			changeAccount = false;
		}

		if (changeAccount == true) {

			return User.updatePassword(currentuser.getAccount_id(), newpass);

		}
		return false;
	}

	public boolean checkPassword(String pass, HttpServletRequest request) {
		User u = ValidateUser(request);
		return u.checkPassword(u, pass);
	}

	public void showProfile(HttpServletRequest request, User user) {
		Account acc = Account.GetAccountByID(user.getAccount_id());
		request.setAttribute("acc", acc);
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String url = "/404.jsp";
		User usercurrent = ValidateUser(request);

		if (usercurrent != null) {
			request.setAttribute("is_logged", true);
			request.setAttribute("curUser", usercurrent);
			if (request.getParameter("action") != null
					&& request.getParameter("action").toString().equals("editaccount")) {
				Boolean result = updateInfo(request);
				// System.out.print("account "+ result);
				usercurrent = ValidateUser(request);
				request.setAttribute("updateSuccess", result);
			} else if (request.getParameter("action") != null
					&& request.getParameter("action").toString().equals("editpass")) {
				Boolean result = updateAccount(request);
				usercurrent = ValidateUser(request);
				request.setAttribute("updateSuccess", result);
			}

			showProfile(request, usercurrent);
			getListPost(usercurrent, request, response);
			getListBookmark(usercurrent, request, response);

			getFollowingUser(usercurrent, request, response);
			getFollowerUser(usercurrent, request, response);
			url = "/users/profile.jsp";
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(url);
			dispatcher.forward(request, response);
			// response.sendRedirect(request.getContextPath()+url);
		} else {
			url = "/login/login.jsp";
			response.sendRedirect(request.getContextPath() + url);
		}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
