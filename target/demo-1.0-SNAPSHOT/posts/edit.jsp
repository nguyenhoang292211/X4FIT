<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>[Edit] ${title}</title>
	<link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/logo.ico" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/styles/post.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/styles/home.css">
	<script src="${pageContext.request.contextPath}/scripts/post.js"></script>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/styles/bootstrap.min.css">
	<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Bungee+Shade&display=swap">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/styles/font-awesome.min.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/styles/simplemde.min.css">
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css">
	<script src="${pageContext.request.contextPath}/scripts/highlight.min.js"></script>
	<script src="${pageContext.request.contextPath}/scripts/bootstrap.min.js"></script>
	<script src="${pageContext.request.contextPath}/scripts/simplemde.min.js"></script>
	<script src="${pageContext.request.contextPath}/scripts/jquery-3.5.1.slim.min.js"></script>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/styles/footer.css" />
</head>
<body>
	<jsp:include page="../navbar.jsp"></jsp:include>
	<div class="container">
		<h1 align="center" style="margin-top: 20px;">CHỈNH SỬA BÀI VIẾT</h1>
		<form action="${pageContext.request.contextPath}/save?p=${p}" method="post">
			<input type="hidden" name="title" value="${title}">
			<div class="form-group">
				<div class="mb-3" style="display: flex;" align="center">
					<div class="input-group-prepend">
						<span class="input-group-text" id="basic-addon1">Tiêu đề</span>
					</div>
					<input type="text" class="form-control" name="new_title" value="${title}">
					<!-- Status -->
						<div class="input-group-prepend">
							<span class="" id="basic-addon2">
								<span class="input-group-text custom-control custom-switch">
									<label class="custom-control-label" for="is_public" >Public</label>
							  	<input type="checkbox" class="custom-control-input" 
							  		<c:if test="${is_public == true}">checked</c:if>
							  		id="is_public" name="is_public">
								  
								</span>
							</span>
						</div>
				</div>
				<div>
					<div class="input-group mb-3">
					  <div class="input-group-prepend">
					    <%--@declare id="inputgroupselect01"--%>
							<label class="input-group-text" for="inputGroupSelect01">Chủ đề</label>
					  </div>
					  <select class="custom-select" id="category" name="category">
					    <option selected>Chọn chủ đề cho bài viết...</option>
					    <c:forEach var="cat" items="${lstCat}">
					    	<option value="${cat.getName()}">${cat.getName()}</option>
					    </c:forEach>
					  </select>
					</div>
				</div>
				<textarea name="content" id="content">${content}</textarea>
				<input class="btn btn-primary btn-sm btn-block" type="submit" value="LƯU">
			</div>
		</form>
	</div>
	
	<jsp:include page="../common/footer.jsp"/>
	<jsp:include page="../modals/modalUpload.jsp"></jsp:include>
	<hr>

	<script src="${pageContext.request.contextPath}/scripts/post.js"></script>
	<script type="text/javascript">
		content = Editor();

		$('.image-upload-wrap').bind('dragover', function() {
			$('.image-upload-wrap').addClass('image-dropping');
		});
		$('.image-upload-wrap').bind('dragleave', function() {
			$('.image-upload-wrap').removeClass('image-dropping');
		});

		$('.upload-btn').hide();
		$('.remove-btn').hide();

	</script>
</body>
</html>