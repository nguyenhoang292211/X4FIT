package controller;

import model.Account;
import model.Model;
import model.User;
import x4fit.Utilities;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;

import javax.mail.MessagingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.codec.digest.DigestUtils;
import org.bson.Document;
import org.bson.types.ObjectId;

@WebServlet("/signUp")
public class signUpController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public signUpController() {
		super();
	}

	protected void process(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, NoSuchAlgorithmException {
		String url = "";
		response.setContentType("text/html");
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		ObjectId account_id = new ObjectId();

		if (request.getParameter("userCurrentAction") != null) {
			if (request.getParameter("userCurrentAction").equals("btn")) {
				account_id = (ObjectId)session.getAttribute("account_id");
				String code = request.getParameter("code");
				if (isUserCode(account_id, code)) {
					//TODO
					User.updateUserStatusByAccountID(account_id, "ACTIVE");
					url = "/login/success.jsp";
					request.setAttribute("is_active", true);
				} else {

					url = "/login/confirm.jsp";
					request.setAttribute("is_active", false);
				}
			}
		} else {
			String username = request.getParameter("username");
			String password = request.getParameter("password");
			String email = request.getParameter("email");
			String fullname = request.getParameter("fullname");

			int error = 0;
			if (username.equals("")) {
				request.setAttribute("errUsername", " have not null !");
				error = error + 1;
			}

			if (email.equals("")) {
				request.setAttribute("errEmail", " have not null !");
				error = error + 1;
			}

			if (password.equals("")) {
				request.setAttribute("errPass", " have not null !");
				error = error + 1;
			}

			if (Account.checkExitUsername(username)) {
				request.setAttribute("errUsername", "Username already exist !");
				error = error + 1;
			}

			if (Account.checkExitEmail(email)) {
				request.setAttribute("errEmail", "Email already exist !");
				error = error + 1;
			}

			String hashedPassword = DigestUtils.sha256Hex(password);
			request.setAttribute("username", username);
			request.setAttribute("password", password);
			request.setAttribute("email", email);
			request.setAttribute("fullname", fullname);

			if (error == 0) {
				Account.createNewAccount(username, hashedPassword, email, fullname);

				if (Account.checkExitUsername(username)) {
					account_id = Account.GetAccountByUsername(username).getId();
					url = "/login/confirm.jsp";
					session.setAttribute("account_id", account_id);
					sendmail(email, fullname, hashedPassword);
				} else
					url = "/login/signup.jsp";
			} else
				url ="/login/signup.jsp";
		}
		RequestDispatcher dispatcher = request.getRequestDispatcher(url);
		dispatcher.forward(request, response);
	}

	public boolean isUserCode(ObjectId account_id, String code) {
		String password = Account.GetAccountByID(account_id).getPassword();
		if (code.equals(password.substring(0, 5)))
			return true;
		return false;
	}

	public void sendmail(String email, String fullname, String hashedPassword) {
		String from = "ngocyen174308@gmail.com";
		String pass = "18110402yen";
		String OTP = hashedPassword.substring(0, 5); // Lấy 6 số đầu trong đoạn mã hash để người dùng xác nhận
		String subject = "Wellcome to X4FIT";

//		String body = "Dear " + fullname + ",\n\n" + "Your code:" + OTP + "\n\n" + "Confirm: " ;
		String body = "Dear " + fullname + ",<br/><br/><br/>" + "Your code:" + OTP + "<br/><br/><br/>" + "Confirm:   "+ "https://x4fit.herokuapp.com/login/confirm.jsp" ;
		boolean isBodyHTML = true;

		try {
			Utilities.sendMail(from, pass, email, subject, body, isBodyHTML);
		} catch (MessagingException e) {
			System.out.println(e);
		}

	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			process(request, response);
		} catch (NoSuchAlgorithmException | ServletException | IOException e) {
			e.printStackTrace();
		}
	}

}