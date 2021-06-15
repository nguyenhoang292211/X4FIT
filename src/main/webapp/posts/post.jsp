<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>${post.getTitle()}</title>
	<link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/logo.ico" />
	<link rel="image_src" href="${post.getThumbnail_url()}">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/styles/style.css" />
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/styles/post.css" />
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/styles/home.css" />
	<link href="https://fonts.googleapis.com/css2?family=Bungee+Shade&display=swap" rel="stylesheet">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/styles/font-awesome.min.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/styles/simplemde.min.css">
 	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css">
	<script src="${pageContext.request.contextPath}/scripts/jquery-3.5.1.slim.min.js"></script>
<!-- 	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script> -->
	<script src="${pageContext.request.contextPath}/scripts/bootstrap.min.js"></script>
	<script src="${pageContext.request.contextPath}/scripts/simplemde.min.js"></script>
	<script src="${pageContext.request.contextPath}/scripts/highlight.min.js"></script>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/styles/footer.css" />
</head>
<body>
	<jsp:include page="../navbar.jsp"></jsp:include>
	
	<div class="container-fluid" style="margin-top: 30px">
		<div class="row">

			<!-- Left -->
			<div class="col-sm-2">
				<div class="post-actions d-flex flex-column mx-auto">
					<c:if test="${is_logged == true }">
						<!-- Points -->
						<div class="vote" align="center">
							<button class="icon-btn" data-original-title="Upvote" 
											onclick="Vote('${postID}', 'POST', 1, '${pageContext.request.contextPath}/vote');
															 incrementValue('${postID}');">
								<i class="fa fa-caret-up"></i>
							</button>
							<br>
							<input	style="font-weight: bolder; height: 1em; background-color: transparent; border: none;" 
										disabled size="1" class="points" id="${postID}" value="${post.getPoints()}">
							<br>
							<button class="icon-btn" data-original-title="Downvote"
											onclick="Vote('${postID}', 'POST', 1, '${pageContext.request.contextPath}/vote');
															 decrementValue('${postID}');">
								<i class="fa fa-caret-down"></i>
							</button>
						</div>
	
						<!-- Clips -->
						<div align="center">
							<button type="button" class="clip"
								data-original-title="Clip this post">
								<i class="fa fa-paperclip"></i>
							</button>
						</div>
					</c:if>
					<div align="center">
						<!-- Share -->
						<a
							href="https://www.facebook.com/sharer.php?u=http://x4fit.herokuapp.com/post?p=${post.getUrl()}"
							target="_blank" type="button" class="share link--muted" data-original-title="Share bài viết lên Facebook"> 
							<img src="https://img.icons8.com/color/48/000000/facebook.png" />
						</a> 
						<a class="zalo-share-button share" data-href="" data-oaid="579745863508352884" data-layout="2" data-color="white" data-customize=true> 
							<img src="https://img.icons8.com/ios-filled/48/4a90e2/zalo.png" />
						</a>
						
						<br>
						
						<c:if test="${is_author == true}">
							<!-- Edit -->
							<form action="${pageContext.request.contextPath}/edit?p=${post.getUrl()}" method="post">
								<input type="hidden" name="postID" value="${postID }">
								<button type="submit" value="EDIT" class="btn btn-primary">
									<i class="fa fa-edit"></i>
								</button>
							</form>
							<br>
						</c:if>
						
						<c:if test="${is_logged == true }">
							<!-- Báo cáo -->
							<button type="button" data-toggle="modal" data-target="#modelReport"
											value="REPORT"  class="btn btn-danger">
								<i class="fa fa-flag"></i>
							</button>
						</c:if>
					</div>
				</div>
			</div>

			<!-- Content -->
			<div class="col-sm-8">
				<h1 align="center" style="margin: 20px;">
					<b>${post.getTitle()}</b>
				</h1>
				<div class="mb-05">
							<div class="d-sm-flex align-items-start mb-2">
								<div class="post-author mb-2 mb-sm-0">
									<div class="post-author__avatar">
										<a class="d-flex mr-05" href="#" target="_blank">
											<div class="d-inline-block avatar--lg">
												<img
													src="${pageContext.request.contextPath}/images/mainAboutMe.jpg"
													alt="" class="avatar avatar--lg">
											</div>
										</a>
									</div>
									<div class="post-author__info overflow-hidden mr-1">
										<div class="d-flex">
											<div class="overflow-hidden flex-fix mr-05">
												<a class="text-bold post-author__name" href="#">${post.GetAuthor().getFullname()}</a>
												<br>
												<span class="text-muted">@${post.GetAuthor().getUsername()}</span>
											</div>
										</div>
										<div class="stats align-items-center">
											<span class="stat-item text-muted" data-toggle="tooltip"
												data-placement="bottom" title="Follower: 1"> <i
												aria-hidden="true" class="stat-item__icon fa fa-user-plus"></i>
											</span> <span class="stat-item text-muted" data-toggle="tooltip"
												data-placement="bottom" title="Post: 1"> <i
												aria-hidden="true" class="stat-item__icon fa fa-pencil"></i>
											</span>
										</div>
									</div>

								</div>
								<div
									class="post-meta d-flex flex-column flex-wrap align-items-sm-end">
									<div class="text-muted">${post.getPublished_at()}</div>
									<div class="d-flex align-items-center">
										<div class="post-meta__item mr-1">
											<button type="button" class=" button " data-toggle="tooltip"
															data-placement="bottom" 
															title="Views: ${post.getViews_count()}">
												<i class="fa fa-eye"> </i> 
												<span> ${post.getViews_count()} </span>
											</button>
										</div>
										<div class="post-meta__item mr-1">
											<button type="button" class=" button " data-toggle="tooltip"
															data-placement="bottom" 
															title="Comment:  ${post.getComments_Count()} ">
												<i class="fa fa-comments"> </i> 
												<span> ${post.getComments_Count()} </span>
											</button>
											<button type="button" class=" button " data-toggle="tooltip"
															data-placement="bottom" title="Clip: ${post.getClips_count()}">
												<i class="fa fa-paperclip"> </i> 
												<span> ${post.getClips_count()} </span>
											</button>
										</div>
									</div>
								</div>
							</div>
						</div>
						
				<textarea id="content" name="content">${post.getContent()}</textarea>
				<br>
				<c:if test="${is_logged }">
					<h4>Bình luận</h4>
					<form action="${pageContext.request.contextPath}/comment" method="post">
						<textarea id="comment" name="comment"></textarea>
						<br>
						<div class="align-middle text-center">
							<input type="hidden" value="${post.getId()}" name="postID">
							<input type="hidden" value="${post.getUrl()}" name="url">
							<input class="btn btn-primary" type="submit" value="Bình luận">
						</div>
					</form>
				</c:if>
				<br>
				<%
					int i = 0;
				%>
				<c:forEach var="cmt" items="${comments}">
					<div class="list-comments">
						<div class="user_comment_post">
							<div class="info_user_comment">

								<div class="img_user_comment_post">

									<img id="avt_comment" class="avatar--lg img-fluid"
										src="${pageContext.request.contextPath}/images/${listUserCmt.get(i).getAvatar()}"
										alt="">
								</div>

								<div class="info_username_comment">
									<a href="${listUserCmt.get(i).getUrl()}">
										<c:out value="${listUserCmt.get(i).getFullname()}"></c:out>
									</a> 
									<br /> 
									<c:if test="${is_author}">
										<span class="badge badge-info">@author</span>
									</c:if>
									<div class="time_comment">
										<span class="text-muted">${cmt.getCreated_at()}</span>
									</div>
								</div>
								
							</div>

							<div class="content_comment" >
								<textarea id="comment" name="comment" rows="5">${cmt.getContent()}</textarea>
							</div>

							<div class="vote_comment">
								<div class="action_with_comment">
									<span class="btn btn-danger btn-sm font-weight-bold">
										<input style="cursor: none; background-color:transparent; color:white; font-weight:bolder; border:none; text-align: right;" 
														disabled size="1" id="cmt${cmt.getId()}" value="${cmt.getPoints()}"/> 
										<i class="fa fa-heart" aria-hidden="true"></i>
									</span>
									<button type="submit" value="Upvote" class="btn btn-warning btn-sm font-weight-bold"
													onclick="Vote('${cmt.getId()}', 'COMMENT', 1, '${pageContext.request.contextPath}/vote');
																	 incrementValue('cmt${cmt.getId()}');">
										<i class="fas fa-thumbs-up"></i>&nbsp;Upvote
									</button>
									<button type="submit" value="Downvote" class="btn btn-dark btn-sm font-weight-bold"
													onclick="Vote('${cmt.getId()}', 'COMMENT', -1, '${pageContext.request.contextPath}/vote');
																	 decrementValue('cmt${cmt.getId()}');">
										<i class="fas fa-thumbs-down"></i>&nbsp;Downvote
									</button>
									
									<!-- More -->
									<div class="btn-group dropup">
									  <button type="button" class="btn btn-secondary btn-sm dropdown-toggle font-weight-bold" 
									  				data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
									    More
									  </button>
									  <div class="dropdown-menu">
									    <a class="dropdown-item" href="#">Sửa</a>
									    <a class="dropdown-item" href="#">Xóa</a>
									    <hr>
									    <form class="dropdown-item" 
									    		  action="${pageContext.request.contextPath}/report?p=${post.getUrl()}&comment_id=${cmt.getId()}&type=COMMENT" method="post">
									    	<input type="submit" value="Báo cáo spam" class="btn btn-primary"/>
									    </form>
									  </div>
									</div>
								
								</div>
								
							</div>
						</div>
						<%
							i += 1;
						%>
						</div>
				</c:forEach>
				
			</div>
			<!-- Right -->
			<div class="col-sm-2">
				
			</div>
		</div>
		<hr>
	</div>
	
	<jsp:include page="../common/footer.jsp"/>
	<!-- Modal Upload -->
	<jsp:include page="../modals/modalUpload.jsp"></jsp:include>
	
	<!-- Modal Report -->
	<jsp:include page="../modals/modalReport.jsp"></jsp:include>

	<script src="${pageContext.request.contextPath}/scripts/post.js"></script>
	<script type="text/javascript">
		detailPost = ViewContent(); 
		detailPost.togglePreview();
		var listComments = ViewComments();
		listComments.forEach((comment) => comment.togglePreview());
		
		content = Comment();
		$('.image-upload-wrap').bind('dragover', function() {
			$('.image-upload-wrap').addClass('image-dropping');
		});
		$('.image-upload-wrap').bind('dragleave', function() {
			$('.image-upload-wrap').removeClass('image-dropping');
		});

		$('.upload-btn').hide();
		$('.remove-btn').hide();
  </script>
	<script src="https://sp.zalo.me/plugins/sdk.js"></script>
</body>
</html>