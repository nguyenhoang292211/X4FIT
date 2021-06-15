
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet"
	href="${pageContext.request.contextPath}/styles/signup.css">
	<link
		href="https://fonts.googleapis.com/css?family=Poppins:600&display=swap"
		rel="stylesheet">
	
	<script src="https://kit.fontawesome.com/f93b4d7888.js"></script>
	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	<title>Sign Up</title>
</head>

<body>

<div class="main-w3layouts wrapper">
		<h1>Đăng ký tài khoản</h1>
		<div class="main-agileinfo">
			<div class="agileits-top">
				<form action="${pageContext.request.contextPath}/signUp" method = "post">
					
					<input  class="text" type="text" value = "${fullname}" name="fullname" placeholder="Họ và tên" required="">
					<span class = "error_signup"> <c:out value = "${errName}"></c:out></span>
					<input id = "txtFullname" class="text" type="text"name = "username" value = "${username}" placeholder="Tên đăng nhập" required="">
					<span class = "error_signup"> <c:out value = "${errUsername}"></c:out></span>
					
					<input class="text email" type="email" name = "email" value = "${email}"placeholder="Email" required="">
					 <span class = "error_signup"> <c:out value = "${errEmail}"></c:out></span>
					<input id = "password" class="text" type="password" name = "password" value = "${password}"  placeholder="Mật khẩu" required="">
					<span id = "message"> </span>  
					<input id = "password2"  class="text w3lpass" type="password" name="password2" placeholder="Nhập lại mật khẩu" required="">
					
					<input id = "btnSignup" type="submit" value="SIGNUP">
				</form>
				<p>Bạn đã có tài khoản ? <a href="login.jsp"> Đăng nhập ngay !</a></p>
			</div>
		</div>
		<!-- copyright -->
		<div class="colorlibcopy-agile">
			<a href = "${pageContext.request.contextPath}/home">Về home</a>
		</div>
		<!-- //copyright -->
		<ul class="colorlib-bubbles">
			<li></li>
			<li></li>
			<li></li>
			<li></li>
			<li></li>
			<li></li>
			<li></li>
			<li></li>
			<li></li>
			<li></li>
		</ul>
	</div>

	<!-- //main -->
	
	 <script>

       document.getElementById('password2').onkeyup=function(){
           var password = $("#password").val();
           var confirm_password = $("#password2").val();
           if(password != confirm_password) {
                  $("#password2").css('color', "red");
                  document.getElementById("btnSignup").disabled = true;
           }
               else{
                  $("#password2").css('color', "#fff");
                  document.getElementById("btnSignup").disabled = false;
               }
       }
   </script>
   
   <script>
   document.getElementById('password').onkeyup=function(){
      
	   var format = /[!@#$%^&*()_+\-=\[\]{}:\\|,.<>\/?]+/;
       var pw = document.getElementById("password").value;  
       //check empty password field  
       if(pw == "") {  
          document.getElementById("message").innerHTML = "**Không để trống !";  
          document.getElementById("btnSignup").disabled = true;
          
       } 
       else
    
      //minimum password length validation  
       if(pw.length < 6) {  
          document.getElementById("message").innerHTML = "**Mật khẩu tối đa 6 kí tự";  
          document.getElementById("btnSignup").disabled = true;
         
       }
       else
       if(format.test(pw) == false){
    	 
    	   document.getElementById("message").innerHTML = "**Cần có một ký tự đặc biệt ";  
           document.getElementById("btnSignup").disabled = true;
       }
       
       //maximum length of password validation  
       else if(pw.length > 10) {  
           document.getElementById("message").innerHTML = "**Độ dài mật khẩu tối đa là 10 ký tự";  
           document.getElementById("btnSignup").disabled = true;
          
        }
     
       else
           
       { 
    	   document.getElementById("message").innerHTML = "**Password syntax correct";  
	       document.getElementById("btnSignup").disabled = false;
       }
  
   }
   
   </script>

</body>



</html>