<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../styles/login.css">
    <link href="https://fonts.googleapis.com/css?family=Poppins:600&display=swap" rel="stylesheet">
    <script src="https://kit.fontawesome.com/f93b4d7888.js" crossorigin="anonymous"></script>
    <title>FORGOT</title>
</head>

<body>
    <div class="login">
        <img class="wave" src="../images/bgLogin.jpg">
        <div class="container">
            <div class="img">
                <img src="../images/forgotmain.jpg">
            </div>
            <div class="login-content">
                <form action="${pageContext.request.contextPath}/forgot" method = "post">
                    
                    <h3 class="title"> Forgot password</h3>
                    <div class="input-div one">
                        <div class="i">
                            <i class="fas fa-envelope-open-text"></i>
                        </div>
                        <div class="div">
                            
                            <input type="email" class="form-control" placeholder = "email" name = "email">
                        </div>
                    </div>
                    <a href="signup.jsp"> Sign up</a>
                    <input type="submit" style = "background-color: #625bff;" class="btn" value="send mail" name = "forgot_password">
                    <a href="login.jsp" class = "btn-signup">Login</a>
                </form>
                
            </div>
            
        </div>
        <script type="text/javascript" src="js/main.js"></script>
</body>

</html>