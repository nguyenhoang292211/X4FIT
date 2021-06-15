<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
	 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>

<head>
    <title>Xác thực</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
     <link rel="stylesheet" href="../styles/status.css">
</head>

<body style="background-color: #6FC9E7; margin: 0 !important; padding: 0 !important;">
    <!-- HIDDEN PREHEADER TEXT -->
    <div style="display: none; font-size: 1px; color: #fefefe; line-height: 1px; font-family: 'Lato', Helvetica, Arial, sans-serif; max-height: 0px; max-width: 0px; opacity: 0; overflow: hidden;"> We're thrilled to have you here! Get ready to dive into your new account. </div>
    <form  action = "${pageContext.request.contextPath}/status" method = "post">
    <table border="0" cellpadding="0" cellspacing="0" width="100%">
        <!-- LOGO -->
        <tr>
            <td bgcolor="#6FC9E7" align="center">
                <table border="0" cellpadding="0" cellspacing="0" width="100%" style="max-width: 600px;">
                    <tr>
                        <td align="center" valign="top" style="padding: 40px 10px 40px 10px;"> </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td bgcolor="#6FC9E7" align="center" style="padding: 0px 10px 0px 10px;">
                <table border="0" cellpadding="0" cellspacing="0" width="100%" style="max-width: 600px;">
                    <tr>
                        <td bgcolor="#ffffff" align="center" valign="top" style="padding: 40px 20px 20px 20px; border-radius: 4px 4px 0px 0px; color: #111111; font-family: 'Lato', Helvetica, Arial, sans-serif; font-size: 48px; font-weight: 400; letter-spacing: 4px; line-height: 48px;">
                            <h1 style="font-size: 48px; font-weight: 400; margin: 2;">Welcome <b>X4FIT </b>!</h1> <img src=" https://img.icons8.com/clouds/100/000000/handshake.png" width="125" height="120" style="display: block; border: 0px;" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td bgcolor="#f4f4f4" align="center" style="padding: 0px 10px 0px 10px;">
            <c:choose>
            	<c:when test = "${status == 'BLOCK' }">
               	 <jsp:include page = "block.jsp"/>
                </c:when>
                <c:otherwise>
               	 <jsp:include page = "notactive.jsp"/>
                </c:otherwise>
            </c:choose>
                        </td>
                    </tr> <!-- COPY -->
                    
                    <tr>
                        <td bgcolor="#ffffff" align="left" style="padding: 0px 30px 20px 30px; color: #666666; font-family: 'Lato', Helvetica, Arial, sans-serif; font-size: 18px; font-weight: 400; line-height: 25px;">
                            <p style="margin: 0;">Mọi thắc mắc, xin vui lòng liên hệ mail <b> ngocyen174308@gmail.com </b> để được hỗ trợ. Chúng tôi rất vui lòng để hỗ trợ.</p>
                        </td>
                    </tr>
                    <tr>
                        <td bgcolor="#ffffff" align="left" style="padding: 0px 30px 40px 30px; border-radius: 0px 0px 4px 4px; color: #666666; font-family: 'Lato', Helvetica, Arial, sans-serif; font-size: 18px; font-weight: 400; line-height: 25px;">
                            <p style="margin: 0;">Admin,<br>X4FIT Team</p>
                            <br/>
       						 <a style = "color: #de6600; text-decoration: none; margin-left: 80%;" href = "${pageContext.request.contextPath}/home">Về trang chủ</a>

                        </td>
                    </tr>
                </table>
            </td>
        </tr>
       
        <tr>
            <td bgcolor="#f4f4f4" align="center" style="padding: 30px 10px 0px 10px;">
                
            </td>
        </tr>
        
    </table>
    </form>
    
    <script>
   document.getElementById('code').onkeyup=function(){
      
	   
       var code = document.getElementById("code").value;  
       //check empty code field  
       if(pw == "") {  
          document.getElementById("message").innerHTML = "**Fill the code please!";  
          document.getElementById("btn").disabled = true;
          
       } 
       
       else
           
       { 
    	   document.getElementById("message").innerHTML = "";  
	       document.getElementById("btn").disabled = false;
       }
  
   }
   
   </script>
</body>

</html>