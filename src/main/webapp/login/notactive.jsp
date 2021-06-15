<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<table border="0" cellpadding="0" cellspacing="0" width="100%"
	style="max-width: 600px;">
	<tr>
		<td bgcolor="#ffffff" align="left"
			style="padding: 20px 30px 40px 30px; color: #666666; font-family: 'Lato', Helvetica, Arial, sans-serif; font-size: 18px; font-weight: 400; line-height: 25px;">

			<p style="margin: 0;">
				Tài khoản của bạn <b>chưa được</b> kích hoạt. Vui lòng chờ kích hoạt.
			</p>
		</td>
	</tr>
	
		<tr>
			<td bgcolor="#ffffff" align="left">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td bgcolor="#ffffff" align="center"
							style="padding: 20px 30px 60px 30px;">
							<c:if test="${status.equals('NOT ACTIVE') == false}">
							<form action="#" mothod="post">
								<table border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td style="padding: 0px 0px 0px 0px;"><input type="email"
											name="email" value="${email}" placeholder="email"
											style="width: 250px; height: 55px; text-align: center;"></td>
										<td align="center" style="border-radius: 3px;"
											bgcolor="#6FC9E7">

											<button id="btn" type="submit" name="btnStatus" value="btn"
												style="font-size: 20px; font-family: Helvetica, Arial, sans-serif; color: #ffffff; color: #ffffff; padding: 15px 25px; border-radius: 2px; border: 1px solid #6FC9E7; display: inline-block; background-color: #6FC9E7; line: none;">Confirm
												Account</button>
										</td>
									</tr>
									<span id="message" name="message" value="${message }"></span>
								</table>
							</form>
							</c:if>
						</td>
					</tr>
					
				</table>