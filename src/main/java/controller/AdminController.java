package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.bson.types.ObjectId;

import model.Account;
import model.Report;
import model.User;
import model.UserAccount;
import x4fit.Utilities;

@WebServlet(urlPatterns = {
		"/admin/all-users", 
		"/admin/create-mod",
		"/admin/update-status",
		"/admin/all-reports",
		"/admin/user/filter",
		"/admin/delete-report",
		"/admin/delete-user",
		"/admin/search-report",
		"/admin/search-user",
		"/admin/filter-report",
		})
public class AdminController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AdminController() {
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
		Cookie[] cookies = request.getCookies();
		if (cookies!=null)
		{
			ObjectId accountID = User.GetAccountIdFromCookies(cookies);
			
			if (accountID != null)
			{
				User user = User.GetUserByAccountID(accountID);
				request.setAttribute("user", user);
				request.setAttribute("is_logged", true);
			}
			else
			{
				request.setAttribute("is_logged", false);
			}
		}
		else
		{
			request.setAttribute("is_logged", false);
		}
		
		String action = request.getServletPath();
		switch (action) {
			case "/admin/all-users":
				getAllUsersInfo(request, response);
				return;
			case "/admin/create-mod":
				createMod(request, response);
				return;
			case "/admin/update-status":
				updateAccountStatus(request, response);
				return;
			case "/admin/all-reports":
				getAllReports(request, response);
				return;
			case "/admin/user/filter":
				getUserFilter(request, response);
				return;
			case "/admin/delete-report":
				deleteReport(request, response);
				return;
			case "/admin/delete-user":
				deleteUser(request, response);
				return;
			case "/admin/search-report":
				searchReport(request, response);
				return;
			case "/admin/search-user":
				searchUser(request, response);
				return;
			case "/admin/filter-report":
				filterReport(request, response);
				return;
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
	
	protected void deleteUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String username = (String)request.getParameter("username");
		try {
			Account.deleteAccountByUsername(username);
			List<UserAccount> allUserInfoList = UserAccount.getAllUserInfo();
			request.setAttribute("userInfoList", allUserInfoList);
			request.getRequestDispatcher("/admin/users.jsp").forward(request, response);
		} catch (Exception e) {
			System.out.println(e.getMessage());
			response.sendRedirect("../500.jsp");
		}
	}
	
	protected void getUserFilter(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String accountType = (String)request.getParameter("accountType");
		String status = (String)request.getParameter("status");
		try {
			List<UserAccount> allUserInfoList = UserAccount.GetUserFilter(accountType, status);
			request.setAttribute("accountType", accountType);
			request.setAttribute("status", status);
			request.setAttribute("userInfoList", allUserInfoList);
			request.getRequestDispatcher("/admin/users.jsp").forward(request, response);
		} catch (Exception e) {
			System.out.println(e.getMessage());
			response.sendRedirect("../500.jsp");
		}
	}
	
	protected void filterReport(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String reportType = (String)request.getParameter("reportType");
		String timeFrom = (String)request.getParameter("timeFrom");
		String timeTo = (String)request.getParameter("timeTo");
		try {
			List<Report> allReportsList = Report.GetReportFilter(reportType, timeFrom, timeTo);
			List<User> lstUserReported = new ArrayList<User>();
			for (Report report : allReportsList) {
				User user = User.GetUserByAccountID(report.getAccount_id());
				lstUserReported.add(user);
			}
			request.setAttribute("reportType", reportType);
			request.setAttribute("timeFrom", timeFrom);
			request.setAttribute("timeTo", timeTo);
			request.setAttribute("allReportsList", allReportsList);
			request.setAttribute("lstUserReported", lstUserReported);
			request.getRequestDispatcher("/admin/reports.jsp").forward(request, response);
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e.getMessage());
			response.sendRedirect("../500.jsp");
		}
	}
	
	protected void searchReport(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String returnQuery = (String)request.getParameter("query");
		String query = Utilities.removeAccent(returnQuery).toLowerCase(); 
		try {
			List<Report> allReportsList = Report.getAllReports();
			List<User> lstUserReported = new ArrayList<User>();
			for (Report report : allReportsList) {
				User user = User.GetUserByAccountID(report.getAccount_id());
				lstUserReported.add(user);
			}
			
			for (int i = 0; i < allReportsList.size(); i++) {
				Report report = allReportsList.get(i);
				User user = lstUserReported.get(i);
				
				// Xử lý data trước khi lọc
				String fullName = Utilities.removeAccent(user.getFullname()).toLowerCase();
				String description = Utilities.removeAccent(report.getDescription()).toLowerCase();
				String reportType = Utilities.removeAccent(report.getType()).toLowerCase();
				String time = report.getTime();
				String reportId = report.getObj_id().toString();
				
				if (!(fullName.indexOf(query) != -1
						|| description.indexOf(query) != -1
						|| reportType.indexOf(query) != -1
						|| time.indexOf(query) != -1
						|| reportId.indexOf(query) != -1)) {
					allReportsList.remove(i);
					lstUserReported.remove(i);
				}
			}
			
			request.setAttribute("allReportsList", allReportsList);
			request.setAttribute("lstUserReported", lstUserReported);
			request.setAttribute("query", returnQuery);
			request.getRequestDispatcher("/admin/reports.jsp").forward(request, response);
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e.getMessage());
			response.sendRedirect("../500.jsp");
		}
	}
	
	protected void searchUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String query = (String)request.getParameter("query");
		try {
			List<UserAccount> allUserInfoList = UserAccount.SearchUser(query);
			request.setAttribute("query", query);
			request.setAttribute("userInfoList", allUserInfoList);
			request.getRequestDispatcher("/admin/users.jsp").forward(request, response);
		} catch (Exception e) {
			System.out.println(e.getMessage());
			response.sendRedirect("../500.jsp");
		}
	}

	protected void getAllUsersInfo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			List<UserAccount> allUserInfoList = UserAccount.getAllUserInfo();
			request.setAttribute("userInfoList", allUserInfoList);
			request.getRequestDispatcher("/admin/users.jsp").forward(request, response);
		} catch (Exception e) {
			System.out.println(e.getMessage());
			response.sendRedirect("../500.jsp");
		}
	}
	
	protected void getAllReports(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			List<Report> allReportsList = Report.getAllReports();
			List<User> lstUserReported = new ArrayList<User>();
			for (Report report : allReportsList) {
				User user = User.GetUserByAccountID(report.getAccount_id());
				lstUserReported.add(user);
			}
			request.setAttribute("allReportsList", allReportsList);
			request.setAttribute("lstUserReported", lstUserReported);
			request.getRequestDispatcher("/admin/reports.jsp").forward(request, response);
		} catch (Exception e) {
			System.out.println(e.getMessage());
			response.sendRedirect("../500.jsp");
		}
	}
	
	protected void createMod(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String username = (String)request.getParameter("username");
		String email = (String)request.getParameter("email");
		String fullname = (String)request.getParameter("fullname");
		String password = (String)request.getParameter("password");
		try {
			if (Account.checkExitEmail(email) || Account.checkExitUsername(username)) {
				String errorMessage = "Username or Email already exist!";
				request.setAttribute("errorMessage", errorMessage);
			} else {
				Account.createNewMod(username, password, email, fullname);
				System.out.println("New Mod Created!");
			}
			List<UserAccount> allUserInfoList = UserAccount.getAllUserInfo();
			request.setAttribute("userInfoList", allUserInfoList);
			request.getRequestDispatcher("/admin/users.jsp").forward(request, response);
		} catch (Exception e) {
			System.out.println(e.getMessage());
			response.sendRedirect("../500.jsp");
		}
	}
	
	protected void updateAccountStatus(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String status = (String)request.getParameter("status");
		ObjectId userId = new ObjectId(request.getParameter("accountId"));
		try {
			User.updateUserStatusByAccountID(userId, status);
			List<UserAccount> allUserInfoList = UserAccount.getAllUserInfo();
			request.setAttribute("userInfoList", allUserInfoList);
			request.getRequestDispatcher("/admin/users.jsp").forward(request, response);
		} catch (Exception e) {
			System.out.println(e.getMessage());
			response.sendRedirect("../500.jsp");
		}
	}
	
	protected void deleteReport(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ObjectId reportId = new ObjectId(request.getParameter("reportId"));
		try {
			Report.Delete(reportId);
			List<Report> allReportsList = Report.getAllReports();
			List<User> lstUserReported = new ArrayList<User>();
			for (Report report : allReportsList) {
				User user = User.GetUserByAccountID(report.getAccount_id());
				lstUserReported.add(user);
			}
			request.setAttribute("allReportsList", allReportsList);
			request.setAttribute("lstUserReported", lstUserReported);
			request.getRequestDispatcher("/admin/reports.jsp").forward(request, response);
		} catch (Exception e) {
			System.out.println(e.getMessage());
			response.sendRedirect("../500.jsp");
		}
	}
}
