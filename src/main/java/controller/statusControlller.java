package controller;

import java.io.IOException;

import javax.mail.MessagingException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.bson.types.ObjectId;

import model.Account;
import model.User;
import x4fit.Utilities;

/**
 * Servlet implementation class statusControlller
 */
@WebServlet("/status")
public class statusControlller extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public statusControlller() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    
    public void process(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    
    	String email = "";
    	String url;
    	
    	HttpSession session = request.getSession();
		if (session.getAttribute("user")== null)
		{
			response.sendRedirect(request.getContextPath() + "/login/login.jsp");
			return;
		}
		
    	
    	if(session.getAttribute("status") != null )
    	{
    		String status = (String)session.getAttribute("status");
    		request.setAttribute("status", status);
    		
    		email = request.getParameter("email");

    		if (Account.checkExitEmail(email) == false) {
				request.setAttribute("message", "** Email not already exist !");
				
				url = "login/status.jsp";
				request.setAttribute("email", email);
    		}
    		else
    		{
    			Account acc = Account.GetAccountByEmail(email);
    			User user = User.GetUserByAccountID(acc.getId());
    			
    			session.setAttribute("account_id", acc.getId());
    			sendmail(email, user.getFullname(), acc.getPassword());
    			url = "login/confirm.jsp"; // đã xác nhận thành công !
    			session.setAttribute("status", "ACTIVE");
    		}
    	}
    	else
    	{
    		url = "login/login.jsp";
    		
    	}
    	
    	response.sendRedirect(url);
    }
    
    
    public void sendmail(String email, String fullname, String hashedPassword) {
		String from = "ngocyen174308@gmail.com";
		String pass = "18110402yen";
		String OTP = hashedPassword.substring(0, 5); // Lấy 6 số đầu trong đoạn mã hash để người dùng xác nhận
		String subject = "Wellcome to X4FIT";

		String body = "Dear " + fullname + ",\n\n" + "Your code:" + OTP;
		boolean isBodyHTML = false;

		try {
			Utilities.sendMail(from, pass, email, subject, body, isBodyHTML);
		} catch (MessagingException e) {
			System.out.println(e);
		}

	}
   
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		process(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
