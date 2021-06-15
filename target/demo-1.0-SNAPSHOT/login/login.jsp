<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet"
		href="${pageContext.request.contextPath}/styles/login.css">
	<link
		href="https://fonts.googleapis.com/css?family=Poppins:600&display=swap"
		rel="stylesheet">
	<script src="https://kit.fontawesome.com/f93b4d7888.js"></script>
	<title>Login</title>
</head>

<body>
	<div class="login">
		<img class="wave" src="${pageContext.request.contextPath}/images/bgLogin.jpg">
		<div class="container">
			<div class="img">
				<img src="${pageContext.request.contextPath}/images/loginmain.jpg">
			</div>
			
			<div class="login-content">
			
				<form action="${pageContext.request.contextPath}/login" method="post">
					<h2 class="title">Welcome</h2>
					
					<div class="input-div one">
						<div class="i">
							<i class="fas fa-user"></i>
						</div>
						<div class="div">
							<input type="text" class="form-control" placeholder="Tên đăng nhập"
								name="username" value = "${username }">
						</div>
					</div>
					
					<div class="input-div pass">
						<div class="i">
							<i class="fas fa-lock"></i>
						</div>
						<div class="div">
							<input type="password" class="form-control"
								placeholder="Mật khẩu" name="password" value = "${password }">
						</div>
					</div>
					<a style = "color: #de6600; text-decoration: none; margin-top:15px;" href="forgot.jsp"> Forgot password/username ?</a> 
					
					<input type="submit" style = "background-color: #625bff;" class="btn btn-primary" value="login"> 
					
					<a href="signup.jsp" class="btn-signup">Sign up</a>
					
					<a  class="btn-signup" style = "color: #AAA" href="${pageContext.request.contextPath}/home"> HOME</a>
				</form>
				
			</div>
		</div>
	</div>
	<script type="text/javascript" src="js/main.js"></script>
</body>

</html>