<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Tạo bài viết</title>
	<link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/logo.ico" />
	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	<script src="${pageContext.request.contextPath}/scripts/bootstrap.min.js"></script>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/styles/style.css" />
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/styles/post.css" />
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/styles/home.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/styles/bootstrap.min.css">
	<link href="https://fonts.googleapis.com/css2?family=Bungee+Shade&display=swap" rel="stylesheet">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/styles/simplemde.min.css">
	<script src="${pageContext.request.contextPath}/scripts/simplemde.min.js"></script>
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css">
	<script src="${pageContext.request.contextPath}/scripts/jquery-3.3.1.slim.min.js"></script>
	<script src="${pageContext.request.contextPath}/scripts/highlight.min.js"></script>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/highlight.js/latest/styles/github.min.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/styles/footer.css" />
</head>
<body>
	<jsp:include page="../navbar.jsp"></jsp:include>
	<div class="container">
		<h3 align="center">TẠO BÀI VIẾT</h3>
		<form action="${pageContext.request.contextPath}/create" method="post">
			<div class="form-group">
				<div class="input-group mb-3">
					<div class="input-group-prepend">
						<span class="input-group-text" id="basic-addon1">Tiêu đề</span>
					</div>
					<input type="text" class="form-control"
						placeholder="Tiêu đề bài viết" name="title">
				</div>
				<div>
					<div class="input-group mb-3">
					  <div class="input-group-prepend">
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
				<textarea name="content" id="content"></textarea>
				<input type="hidden" name="is_create" value="True">
				<input class="btn btn-primary btn-sm btn-block" type="submit"
					value="Post">
			</div>
		</form>
	</div>

	<jsp:include page="../common/footer.jsp"/>
	<jsp:include page="../modals/modalUpload.jsp"></jsp:include>
	
	<hr>

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
	<script type="text/javascript">
	function insertImage(simplemde, url)
	{
		var pos = simplemde.codemirror.getCursor();
		simplemde.codemirror.setSelection(pos, pos);
		simplemde.codemirror.replaceSelection("![Figure](" + url + ")");
		
	}
	</script>
</body>
</html>