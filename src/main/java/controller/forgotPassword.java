package controller;

import model.*;
import x4fit.Utilities;

import java.io.IOException;

import javax.mail.MessagingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.codec.digest.DigestUtils;
import org.bson.Document;

@WebServlet("/forgot")
public class forgotPassword extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public forgotPassword() {
        super();
    }
    
    protected void process(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
    	String url = "";
    	// get email
    	String email = request.getParameter("email");
    	
    	///send email to user
    	
    	
    	
    	// thêm hàm kiểm tra email đã đăng kí rồi hay không ?
    	
    	if(Account.checkExitEmail(email))
    	{
    		// sau đó lấy user dùng email đó
        	String from  = "ngocyen174308@gmail.com";
        	String pass = "18110402yen";
        	String username = ""; //userDoc.getString("username");
        	String subject = "Change you password to X4FIT";
        	String newPass = "123456@"; // Viết hàm tạo pass mới
        	String body = "Dear " + username + ",\n\n"
        	+ "new password for you: " + newPass + "\n\n\n login: " + "https://x4fit.herokuapp.com/login/login.jsp" ;
        	boolean isBodyHTML = false;
        	
        	try {
        		
        		Utilities.sendMail(from,pass, email,  subject, body, isBodyHTML);
        		String hashedPassword = DigestUtils.sha256Hex(newPass);
        		Account.updateNewPassword(hashedPassword, username);
        		System.out.println("sSend ddc mail");
        		url = "/login/success.jsp";
        	}catch(MessagingException e)
        	{
        		System.out.println("Khong send ddc mail");
        		System.out.println(e);
        	}
        	
    	}
    	else
    		{url = "/login/forgot.jsp";
    		
    		response.sendRedirect(url);
    		}
    	
    	RequestDispatcher d = request.getRequestDispatcher(url);
    	d.forward(request, response);
    }

    

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		process(request, response);
	}

}
