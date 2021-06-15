<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Upload</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/styles/post.css">
<script src="${pageContext.request.contextPath}/scripts/post.js"></script>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
</head>
<body>
	<jsp:include page="/gallery" />
	<div class="file-upload">
		<div class="image-upload-wrap">
			<input class="file-upload-input" type='file' name="fileToUpload"
				id="fileToUpload" onchange="readURL(this, 'div.preview');"
				accept="image/*" multiple />
			<div class="drag-text">
				<h3>Drag and drop a file or select add Image</h3>
			</div>
		</div>
		<div class="file-upload-content">
			<div class="preview"></div>
		</div>
		<br>
		<div align="center">
			<div class="upload-btn">
				<input type="hidden" name="action" value="${action}">
				<button type="button"
					onclick="FileUpload('${pageContext.request.contextPath}/upload', 'div.preview')"
					class="btn btn-primary">Upload</button>
			</div>
			<div class="remove-btn">
				<button type="button" onclick="removeUpload()"
					class="btn btn-danger image-title-wrap">Remove ALL</button>
			</div>
		</div>
	</div>
	<div class="gallary" align="center">
		<h5>Gallery</h5>
		<c:forEach var="img" items="${images_gallary}">

				<img src="${pageContext.request.contextPath}/upload/${img}" alt="${img}" height="64px" width="64px"
							onclick="insertImage(content, '${pageContext.request.contextPath}/upload/${img}')"/>
		</c:forEach>
	</div>
</body>
</html>