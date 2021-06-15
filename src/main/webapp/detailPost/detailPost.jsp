<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="ISO-8859-1"%>
<%@ page
	import="java.io.*,model.User,java.util.Date,java.text.SimpleDateFormat,java.util.ArrayList,javax.annotation.Resource,javax.sql.DataSource"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.1/jquery.min.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css"
	integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2"
	crossorigin="anonymous">
<link
	href="https://netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.min.css"
	rel="stylesheet">
<link rel="stylesheet" href="styles/detailPost.css">
<script src="https://cdn.jsdelivr.net/simplemde/latest/simplemde.min.js"></script>
<script src="https://kit.fontawesome.com/f93b4d7888.js"
	crossorigin="anonymous"></script>
<script src="c"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/simplemde/latest/simplemde.min.css">
<script
	src="https://cdn.jsdelivr.net/highlight.js/latest/highlight.min.js"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/highlight.js/latest/styles/github.min.css">
<title>DETAIL POST</title>
</head>

<style>

	* {
	margin: 0%;
}

div {
	display: block;
}

button {
	outline: none !important;
}

.text-muted {
	color: #9b9b9b !important;
}

*, ::after, ::before {
	box-sizing: border-box;
}

header {
	position: absolute;
	z-index: 10;
	width: 100%;
	margin: 0%;
}

#home-nav {
	margin-left: 0px;
}

.navbar {
	padding: 5px 0px;
	margin-left: 0px;
	width: 100%;
}

.navbar-light {
	width: 100%;
	background-color: white;
}

.p-0 {
	padding: 0 !important;
}

@media ( min-width : 992px) {
	.col-lg-1 {
		flex: 0 0 8.33333%;
		max-width: 8.33333%;
	}
}

.container-fluid {
	margin-left: 0px;
	padding-left: 0px;
	padding-right: 0px;
	margin-right: 0px;
}

nav {
	position: sticky;
	box-shadow: 0 3px 8px rgba(0, 0, 0, .20);
}

ul {
	display: flex;
	list-style: none;
}

button {
	background-color: transparent;
	color: #0099CC;
}

.nav-item {
	display: inline-block;
	margin-left: 15px;
}

#group-notication {
	margin-top: 15px;
	padding: 0 5px;
}

.banner {
	width: 100%;
	position: relative;
	background-color: #3895D3;
	min-height: 40vh;
	background-size: cover;
	background-position: center;
}

#noti_Container {
	position: relative;
}

/* A CIRCLE LIKE BUTTON IN THE TOP MENU. */
#noti_Button {
	width: 22px;
	height: 22px;
	line-height: 22px;
	border-radius: 50%;
	-moz-border-radius: 50%;
	-webkit-border-radius: 50%;
	background: black;
	margin: -3px 10px 0 10px;
	cursor: pointer;
}

/* THE POPULAR RED NOTIFICATIONS COUNTER. */
#noti_Counter {
	display: block;
	position: absolute;
	background: #E1141E;
	color: #FFF;
	font-size: 12px;
	font-weight: normal;
	padding: 1px 3px;
	margin: -8px 0 0 25px;
	border-radius: 2px;
	-moz-border-radius: 2px;
	-webkit-border-radius: 2px;
	z-index: 1;
}

/* THE NOTIFICAIONS WINDOW. THIS REMAINS HIDDEN WHEN THE PAGE LOADS. */
#notifications {
	display: none;
	width: 170px;
	position: absolute;
	top: 30px;
	right: 0;
	background: #FFF;
	border: solid 1px rgba(100, 100, 100, .20);
	box-shadow: 0 3px 8px rgba(0, 0, 0, .20);
	z-index: 0;
}
/* AN ARROW LIKE STRUCTURE JUST OVER THE NOTIFICATIONS WINDOW */
#notifications:before {
	content: '';
	display: block;
	width: 0;
	height: 0;
	color: transparent;
	border: 10px solid #CCC;
	border-color: transparent transparent #FFF;
	margin-top: -20px;
	margin-left: 100px;
}

h3 {
	display: block;
	color: #333;
	background: #FFF;
	font-weight: bold;
	font-size: 13px;
	padding: 8px;
	margin: 0;
	border-bottom: solid 1px rgba(100, 100, 100, .30);
}

.seeAll {
	background: #F6F7F8;
	padding: 8px;
	font-size: 12px;
	font-weight: bold;
	border-top: solid 1px rgba(100, 100, 100, .30);
	text-align: center;
}

.seeAll a {
	color: #3b5998;
}

.seeAll a:hover {
	background: #F6F7F8;
	color: #3b5998;
	text-decoration: underline;
}

/* THE NOTIFICAIONS WINDOW. THIS REMAINS HIDDEN WHEN THE PAGE LOADS. */
#infoWeb {
	display: none;
	width: 170px;
	position: absolute;
	top: 30px;
	right: 0;
	background: #FFF;
	border: solid 1px rgba(100, 100, 100, .20);
	box-shadow: 0 3px 8px rgba(0, 0, 0, .20);
	z-index: 0;
}

.votes .post-actions__vote .mb-1 {
	display: block;
}

button {
	border: none;
}

/*
.subscribe .mb-2{
    display: block;
} */
.subscribe button {
	width: 30px;
	height: 30px;
	line-height: 30px;
	text-align: center;
	border-radius: 50%;
	border: 1px solid #dbe3e8;
	display: block;
	color: rgb(100, 100, 100);
}

.fa {
	display: inline-block;
	font: normal normal normal 14px/1 FontAwesome;
	font-size: inherit;
	text-rendering: auto;
	-webkit-font-smoothing: antialiased;
	-moz-osx-font-smoothing: grayscale;
}

.social-sharing {
	margin-top: 10px;
	width: 30px;
	height: 30px;
	line-height: 30px;
	text-align: center;
	border-radius: 50%;
	border: 1px solid #dbe3e8;
}

.subscribe_follow {
	margin-left: 5px;
	border: 1px solid #dbe3e8;
	color: rgb(100, 100, 100);
}

.post-author__info {
	margin-top: 20px;
	padding-top: 15px;
	display: inline-block;
}

.post-author__avatar {
	display: inline-block;
}

.avatar {
	margin-top: -45px;
	height: 40px;
	width: 40px;
	border-radius: 50%;
}

.following {
	color: gray;
}

.post-meta {
	margin-left: auto;
	margin-top: 35px;
	margin-right: 0px;
}

.dropdown-content {
	display: none;
	position: absolute;
	background-color: #f9f9f9;
	min-width: 50px;
	box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, .20);
	z-index: 1;
}

.dropdown {
	margin-left: 700px;
	position: relative;
}

.dropdown-content a {
	display: block;
	color: black;
	padding: 12px 16px;
	text-decoration: none;
}

.dropdown:hover .dropdown-content {
	display: block;
}

.points .carets {
	display: inline-flex;
	flex-direction: column;
	margin-right: .25rem;
	margin-left: .25rem;
}

.points {
	/* display:flex; */
	/* align-items: center; */
	display: flex;
	cursor: pointer;
	text-align: center;
	margin-left: 10px;
}

.card {
	position: relative;
	display: flex;
	flex-direction: column;
	min-width: 0;
	background-color: #fff;
	background-clip: initial;
	border-radius: .25rem;
	border: 1px solid rgba(27, 27, 27, .125);
	width: 270px;
	height: 150px;
}

.card-body {
	flex: 1 1 auto;
	min-height: 1px;
	padding: 1.25rem;
	box-shadow: 0 .125rem .25rem rgba(27, 27, 27, .075) !important;
}

.pb-2, .py-2 {
	padding-bottom: 1.5rem !important;
}

.points .carets .fa {
	font-size: 1rem;
	color: #9b9b9b;
}

.post-stats {
	display: inline-flex;
}

@media ( max-width : 1199.98px) {
	.related-posts-widget .related-posts-box .item {
		flex: 0 0 50%;
		max-width: 50%;
	}
}

.related-posts-widget .related-posts-box .item {
	padding: 5px;
	flex: 0 0 25%;
	max-width: 25%;
}

.related-posts-widget .related-posts-box .card {
	height: 100%;
	margin: 0;
}

/* .shadow-sm {
    box-shadow: 0 .125rem .25rem rgba(27,27,27,.075)!important;
} */
.post-stats span {
	margin-left: 10px;
}

#points-carets-votes {
	margin-right: 10px;
}

.carets {
	margin-top: 7px;
}

.carets .fa {
	margin-top: -7px;
}

.points .text-muted {
	margin-left: -5px !important;
}

.post-related__box {
	display: block;
}

.item {
	display: inline-block;
	margin-left: 4px;
	margin-top: 4px;
}

#Write {
	display: block;
	margin-top: 5px;
}

.form_comment {
	display: inline-block;
	width: 95%;
	background-color: white;
	border: 1px solid rgba(0, 0, 0, .1);
	border-radius: 3px;
}

#comment__contents {
	display: inline-block;
	margin-left: 10px;
	width: 95%;
	border: none;
	outline: none;
}

.submit_comment {
	display: block;
}

#btnPostComment {
	margin-left: 62vw;
	background-color: #0099CC;
	color: #F6F7F8;
	display: block;
	margin-top: 2px;
	margin-bottom: 5px;
}

.comment-form__edit-element {
	display: inline-block;
}

/* Style the tab */
.tab_comment {
	overflow: hidden;
	border: 1px solid #ccc;
	background-color: #f1f1f1;
}

/* Style the buttons that are used to open the tab content */
.tab_comment button {
	background-color: inherit;
	float: left;
	border: none;
	outline: none;
	cursor: pointer;
	padding: 14px 16px;
	transition: 0.3s;
}

/* Change background color of buttons on hover */
.tab_comment button:hover {
	background-color: #ddd;
}

/* Create an active/current tablink class */
.tab_comment button.active {
	background-color: #ccc;
}

/* Style the tab content */
.tabcontent {
	display: none;
	padding: 6px 12px;
	border: 1px solid #ccc;
	border: none;
	box-shadow: 0 1px 2px rgba(0, 0, 0, .20);
}

.list-comments {
	display: block;
	width: 100%;
}

.user_comment_post {
	margin-top: 10px;
	padding-top: 5px;
	display: block;
	padding-left: 10px;
	height: 150px;
	background-color: #fff;
	border-radius: 3px;
	box-shadow: 0 1px 2px rgba(0, 0, 0, .20);
}

.info_user_comment {
	display: block;
	height: 50px;
}

.img_user_comment_post {
	display: inline-block;
	height: 40px;
	width: 40px;
	border-radius: 50%;
}

#avt_comment {
	height: 40px;
	width: 40px;
	border-radius: 50%;
}

.info_username_comment {
	display: inline-block;
	width: 70%;
}

.time_comment {
	display: inline-block;
	width: 20%;
}

.content_comment {
	display: block;
}

.vote_comment {
	display: block;
	padding-top: 5px;
	padding-bottom: 5px;
}

.score {
	display: inline-block;
	width: 8%;
}

.action_with_comment {
	display: inline-block;
	width: 84%;
	margin-left: 0px;
}

.more_comment {
	display: inline-block;
	text-align: center;
	margin-left: -10px;
	width: 8%;
}

.dropdown_comment {
	margin-left: 0px;
}

.main_footer {
	background: #16222A;
	background: -webkit-linear-gradient(59deg, #3A6073, #16222A);
	background: linear-gradient(59deg, #3A6073, #16222A);
	color: white;
	margin-top: 100px;
	padding-top: 20px;
	height: 70vh;
}

a {
	text-decoration: none;
}

.footer-pad h5 {
	margin-bottom: 15px;
	font-weight: lighter;
	font-size: 15px;
	letter-spacing: 2px;
	text-transform: uppercase;
}

.about_x4fit {
	color: #ccc;
}

ul.social-network {
	list-style: none;
	display: inline;
	margin-left: 0 !important;
	padding: 0;
}

ul.social-network li {
	display: inline;
	margin: 0 5px;
}

.iconFooter {
	background-color: #F9F9F9;
	border-radius: 45%;
	height: 25px;
	width: 25px;
	text-align: center;
	display: inline-block;
	transition: all 1s;
}

.iconFooter:hover, .iconFooter:active{
background-color: #D5F3FE;
color:#66D3FA;

}

.copy {
	margin-top: 120px;
	font-size: 12px;
	
	border-top: 1px solid #AAA;
}

.h5_footer_contact {
	margin-bottom: 15px;
	font-weight: lighter;
	font-size: 15px;
	letter-spacing: 2px;
	text-transform: uppercase;
}

.a_footer {
	color: #ffffff;
}

#footer{
margin-top: 40px;
display: block;
}
</style>
<body>

	<%
		/*User user=(User)session.getAttribute("USER");
	String ver=(String)session.getAttribute("Verification");
	if(user==null){
		System.out.print("Vào rồi nahaaaaaaaaaaaaaaa");
		response.sendRedirect("/login/signup.jsp");
		
	}
	else{
		  String nameuser= user.getName();*/
	// String idPostCurrent = request.getparameter();	 

	int userIdCurrent = 2;
	session.setAttribute("userIdCurrent", userIdCurrent);
	%>

	<header>
		<div class="container-fluid">
			<nav class="navbar navbar-light bg-light">
				<a class="navbar-brand" href="#"> <img
					src="/docs/4.0/assets/brand/bootstrap-solid.svg" width="30"
					height="30" class="d-inline-block align-top" alt=""> 4XFIT
				</a>

				<ul class="navbar-nav mr-auto">
					<li class="nav-item active"><a class="nav-link" href="#">POST
							<span class="sr-only">(current)</span>
					</a></li>


				</ul>
				<form class="form-inline">
					<input class="form-control" type="search" placeholder="Search"
						aria-label="Search">
					<button class="btn btn-outline-primary my-2 my-sm-0" type="submit">
						<i class="fa fa-search"></i>
					</button>
				</form>

				<div id="group-notication">
					<ul>
						<li class="nav-item">
							<button type="button" id="btnInfoWeb" style="border: none;">
								<i class="fa fa-info"></i>
							</button> <!--THE INFO DROPDOWN BOX.-->
							<div id="infoWeb">
								<h3>Infomations</h3>
								<div style="height: 300px;"></div>
								<div class="seeAll">
									<a href="#">See All</a>
								</div>
							</div>
						</li>
						<div id="noti_Container">
							<li id="noti_Counter">
						</div>
						<button id="btnNotication" type="button" class="nav-item"
							style="border: none;">
							<i class="fa fa-bell-o"></i>
						</button>
						<!--THE NOTIFICAIONS DROPDOWN BOX.-->
						<div id="notifications">
							<h3>Notifications</h3>
							<div style="height: 300px;"></div>
							<div class="seeAll">
								<a href="#">See All</a>
							</div>
						</div>
						</li>

						<li class="nav-item">
							<button type="button" style="border: none;">
								<i class="far fa-edit"></i>
							</button>
						</li>
						<li class="nav-item">
							<button type="button" style="border: none;" id="avatar">
								<i class="fas fa-user-astronaut"></i>
							</button>
						</li>
					</ul>
				</div>
			</nav>
		</div>
	</header>

	<div class="banner"></div>

	<div class="main-content">
		<div class="container post-body position-relative" >
			<div class="row">
				<div class="p-0 hidden-md-down col-lg-1">
					<form
						class="post-actions d-flex flex-column align-items-center mx-auto"
						action="detailPost" method="post">
						<div class="votes post-actions__vote mb-1">
							<button type="submit" name="userCurrentAction" value="add_upvote"
								class="icon-btn vote" data-toggle="tooltip"
								data-placement="bottom" title="Upvote">
								<i aria-hidden="true" style="color: rgb(100, 100, 100);"
									class="fa fa-caret-up"></i>
							</button>

							<div class="points text-muted">0</div>
							<button class="icon-btn vote" data-toggle="tooltip"
								data-placement="bottom" title="Downvote"
								name="userCurrentAction" value="add_downvote">
								<i aria-hidden="true" style="color: rgb(100, 100, 100);"
									class="fa fa-caret-down"></i>
							</button>
						</div>

						<div class="subscribe mb-2">
							<button type="submit "
								class=" button post-actions__clip el-button--default"
								data-toggle="tooltip" data-placement="bottom" title="Clip"
								name="userCurrentAction" value="add_clips">
								<i class="fa fa-paperclip"> </i>
							</button>
							<div class="social-sharing mb-2">
								<a href="#"
									onclick="
										    window.open(
										      'https://www.facebook.com/sharer/sharer.php?u='+encodeURIComponent(location.href), 
										      'facebook-share-dialog', 
										      'width=626,height=436'); 
										    return false;"
									data-toggle="tooltip" data-placement="bottom"
									title="Share to facebook"> <i aria-hidden="true"
									class="fa fa-facebook"></i>
								</a>
							</div>
						</div>
					</form>
				</div>

				<div class="post-body__main col-lg-8">
					<article class="post-content">

						<div class="mb-05">
							<div class="d-sm-flex align-items-start mb-2">
								<div class="post-author mb-2 mb-sm-0">
									<div class="post-author__avatar">
										<a class="d-flex mr-05" href="#" target="_blank">
											<div class="d-inline-block avatar--lg">
												<img
													src="${pageContext.request.contextPath}/images/mainAboutMe.jpg"
													alt="" class="avatar avatar--lg img-fluid">
											</div>
										</a>
									</div>
									<div class="post-author__info overflow-hidden mr-1">
										<div class="d-flex">
											<div class="overflow-hidden flex-fix mr-05">
												<a class="text-bold post-author__name" href="#">${name_author}</a>
												<span class="text-muted"> @<c:out
														value="${username_author}"></c:out></span>
											</div>
											<form class="subscribe_follow"
												action="${pageContext.request.contextPath}/detailPost"
												method="post">
												<button type="submit" class="following" value="follow"
													name="userCurrentAction">
													<span>Follow</span>
												</button>
											</form>
										</div>
										<div class="stats align-items-center">
											<span class="stat-item text-muted" data-toggle="tooltip"
												data-placement="bottom" title="Follower: 1"> <i
												aria-hidden="true" class="stat-item__icon fa fa-user-plus"></i>
												1
											</span> <span class="stat-item text-muted" data-toggle="tooltip"
												data-placement="bottom" title="Post: 1"> <i
												aria-hidden="true" class="stat-item__icon fa fa-pencil"></i>
												1
											</span>
										</div>
									</div>

								</div>
								<div
									class="post-meta d-flex flex-column flex-wrap align-items-sm-end">
									<div class="text-muted">Published about 4 hours ago</div>
									<div class="d-flex align-items-center">
										<div class="post-meta__item mr-1">
											<button type="button " class=" button " data-toggle="tooltip"
												data-placement="bottom" title="Views: ${view_post}">
												<i class="fa fa-eye"> </i> <span>${view_post}</span>
											</button>
										</div>
										<div class="post-meta__item mr-1">
											<button type="button " class=" button " data-toggle="tooltip"
												data-placement="bottom" title="Comment:  ${countComment} ">
												<i class="fa fa-comments"> </i> <span>
													${countComment} </span>
											</button>
											<button type="button " class=" button " data-toggle="tooltip"
												data-placement="bottom" title="Clip: ${Clip_post_count}">
												<i class="fa fa-paperclip"> </i> <span>${Clip_post_count}</span>
											</button>
										</div>
									</div>
								</div>
							</div>
							<div class="post-title">
								<h1>${title_post}</h1>
							</div>
						</div>
						<div class="d-md-flex align-items-top justify-content-between">
							<div class="menu__post">
								<div class="dropdown">
									<button type="button" class="dropbtn" data-toggle="tooltip"
										data-placement="bottom" title="Show more active">
										<i class="fa fa-ellipsis-h"></i>
									</button>
									<div class="dropdown-content">
										<a href="#"> repost</a> <a href="#"> repost</a>
									</div>
								</div>
							</div>
						</div>
						<div class="md-contents article-content__body my-2 flex-fill">
							<textarea id="content" name="content" style="color: black">${content}
                          
                         	# printf("hello world");
                          </textarea>
							<p data-markdown="${content }"></p>
						</div>
					</article>
				</div>

				<div class="post-body__right px-0 hidden-md-down col-lg-3">
					<div class="sticky-sidebar post-sidebar post-body__sidebar">
						<div class="sticky-sidebar__inner" style="width: 285px">
							<div class="post-index hidden-sm-down"></div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="post-recommendations bg-light">
			<div class="container py-2">
				<div class="post-section">
					<div class="v-ctr-section related-posts-widget pb-2">
						<h3>Related</h3>
						<div class="post-related__box">


							<c:forEach var="postByAuthor" items="${listPost}">
								<div class="item">
									<div class="card shadow-sm">
										<div class="card-body">
											<div class="card-body__title text-dark word-break mb-05">
												<span><a href="#"><c:out
															value="${postByAuthor.title}"></c:out></a></span>
											</div>
											<div class="card-body__author">
												<span> <a href="#" class="text-primary">${name_author}</a></span>
											</div>
											<span title="21 min read"
												class="text-muted post-reading__time"> 21 min read </span>
											<div class="d-flex">
												<div class="post-stats text-muted">
													<span class="stat-item mr-05" data-toggle="tooltip"
														data-placement="bottom" title="Views"> <i
														aria-hidden="true" class="fa fa-eye"><c:out
																value="${postByAuthor.views_count}"></c:out></i>
													</span> <span class="stat-item mr-05" data-toggle="tooltip"
														data-placement="bottom" title="Clips"> <i
														aria-hidden="true" class="fa fa-paperclip"> <c:out
																value="${postByAuthor.clips_count}"></c:out></i>
													</span> <span class="stat-item mr-05" data-toggle="tooltip"
														data-placement="bottom" title="Comment"> <i
														aria-hidden="true" class="fa fa-comments"> <c:out
																value="${postByAuthor.clips_count}"></c:out></i>
													</span>
													<div class="points" data-toggle="tooltip"
														data-placement="bottom" title="Votes">
														<div class="carets" id="points-carets-votes">
															<i aria-hidden="true" class="fa fa-caret-up text-muted"></i>
															<i aria-hidden="true" class="fa fa-caret-down text-muted"></i>

														</div>
														<span class="text-muted">11</span>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>

							</c:forEach>


						</div>
					</div>
				</div>

				<div class="post-comments">
					<h3>Comments</h3>
					<div class="tab_comment">
						<button class="tablinks" onclick="openComment(event, 'Write')"
							id="btnWrite">Write</button>
						<button class="tablinks" onclick="openComment(event, 'Preview')">Preview</button>

					</div>

					<div id="Write" class="tabcontent">
						<div class="img_user_comment_post">
							<img src="#" alt="avatar">
						</div>
						<form class="form_comment" action="commentDetailPost"
							method="post">
							<textarea id="comment__contents" name="comment_contents"
								placeholder="Test comment" style="height: 120px;"> </textarea>
							<div class="comment-form__edit-element">
								<div class="element">
									<Button class="smile" data-toggle="tooltip"
										data-placement="bottom" title="Like">
										<i class="fa fa-smile-o text-muted"></i>
									</Button>
								</div>
								<div class="element">
									<Button class="image" data-toggle="tooltip"
										data-placement="bottom" title="Add image">
										<i class="fa fa-image text-muted"></i>
									</Button>
								</div>
								<div class="element">
									<Button class="mackdown" data-toggle="tooltip"
										data-placement="bottom" title="Mardown">
										<i class="fa fa-question-circle text-muted"></i>
									</Button>
								</div>
							</div>
							<div class="submit_comment bg-light">
								<input type="submit" id="btnPostComment"
									class="el-button btn btn-outline-primary" value="Post comment">
							</div>
						</form>
					</div>

					<div id="Preview" class="tabcontent">
						<h3>Paris</h3>
						<p>Paris is the capital of France.</p>
					</div>
				</div>

				<div class="list-comments">
					<c:forEach var="cmt" items="${listCmt}">
						<div class="user_comment_post">
							<div class="info_user_comment">
								<div class="img_user_comment_post">
									<img id="avt_comment" class="avatar--lg img-fluid"
										src="${pageContext.request.contextPath}/images/mainAboutMe.jpg"
										alt="">
								</div>
								<div class="info_username_comment">
									<a href="${cmt.url_user}"><c:out value="${cmt.name_user}"></c:out></a>
									<span class="text-muted">@author</span>
								</div>
								<div class="time_comment">
									<span class="text-muted"><c:out
											value="${cmt.created_at}"></c:out></span>
								</div>
							</div>
							<div class="content_comment">
								<p>
									<c:out value="${cmt.contents}"></c:out>
								</p>
							</div>
							<footer class="vote_comment">
								<div class="score">
									<button class="icon-btn vote" data-toggle="tooltip"
										data-placement="bottom" title="Upvote">
										<i aria-hidden="true" class="fa fa-chevron-up text-muted"></i>
									</button>

									<span class="point_vote_comment"><c:out
											value="${cmt.points}"></c:out></span>
									<button class="icon-btn vote" data-toggle="tooltip"
										data-placement="bottom" title="downvote">
										<i aria-hidden="true" class="fa fa-chevron-down text-muted"></i>
									</button>

								</div>
								<div class="action_with_comment d">
									<a class="reply_comment"> <span class="text-muted"
										id="reply">Reply</span>
									</a> <a class="share_comment"> <span class="text-muted">Share</span>
									</a>
								</div>
								<div class="more_comment">
									<div class="menu__post">
										<div class="dropdown_comment">
											<button type="button" class="dropbtn" data-toggle="tooltip"
												data-placement="bottom" title="Show more active">
												<i class="fa fa-ellipsis-h text-muted"></i>
											</button>
											<div class="dropdown-content">
												<a href="#"> repost</a>

											</div>
										</div>
									</div>
								</div>

							</footer>
						</div>
					</c:forEach>
					
				</div>
			</div>
		</div>
	</div>
	<footer class="main_footer">
		<div class="container" id = "footer">
			<div class="row">
				<div class="col-md-3 col-sm-6">
					<!-- infoFIT  -->
					<div class="footer-pad">
						<h5>A LITTLE ABOUT X4FIT</h5>
						<p class="about_x4fit">We share everything about infomation
							technology</p>
						<p>
							<a style = "margin-top: 25px;" class="btn btn-primary" href="../login/signup.jsp">Become A Member</a>
						</p>
					</div>

				</div>
				<div class="col-md-3 col-sm-6">
					<!-- RESOURCES  -->
					<div class="footer-pad">
						<h5>RESOURCES</h5>
						<ul style = "display:block" class="list-unstyled">
							<li style = "display:block; margin-top: 10px;"><a class="a_footer" href="../index.jsp">Post</a></li>
							
							<li style = "display:block; margin-top: 10px;" ><a class="a_footer" href="#">Search</a></li>
						</ul>
					</div>

				</div>

				<div class="col-md-3 col-sm-6">
					<!-- About us  -->
					<div class="footer-pad">
						<h5>ABOUT US</h5>
						<ul class="list-unstyled">
							<li><a class="a_footer" href="#">About us</a></li>

						</ul>
					</div>

				</div>
				<div class="col-md-3">
					<h5 class="h5_footer_contact">Contact</h5>
					<ul class="social-network social-circle">
						<li><a href="#" class="iconFooter" title="Facebook"><i
								class="fa fa-facebook text-muted"></i></a></li>
						<li><a href="#" class="iconFooter" title="Github"><i
								class="fa fa-github text-muted"></i></a></li>
					</ul>
				</div>
			</div>
			<div class="row">
				<div class="col-md-12 copy">
					<p class="text-center text-muted">Copyright x4fit</p>
				</div>
			</div>
		</div>
	</footer>

	<%
		//}
	%>

	<script type="text/javascript">
    
		    // $(function (){
		//     $('[data-toggle="popover"]').popover();
		// });
		
		$(document).ready(function () {
			
		//document.getElementById("btnWrite").onclick();
		
		    // ANIMATEDLY DISPLAY THE NOTIFICATION COUNTER.
		    $('#noti_Counter')
		        .css({ opacity: 0 })
		        .text('7')      // ADD DYNAMIC VALUE (YOU CAN EXTRACT DATA FROM DATABASE OR XML).
		        .css({ top: '-10px' })
		        .animate({ top: '-2px', opacity: 1 }, 500);
		
		    $('#btnNotication').click(function () {
		
		        // TOGGLE (SHOW OR HIDE) NOTIFICATION WINDOW.
		        $('#notifications').fadeToggle('fast', 'linear', function () {
		            if ($('#notifications').is(':hidden')) {
		                $('#btnNotication').css('background-color', 'transparent');
		            }
		            // CHANGE BACKGROUND COLOR OF THE BUTTON.
		            else $('#btnNotication').css('background-color', 'transparent');
		        });
		
		        $('#noti_Counter').fadeOut('slow');     // HIDE THE COUNTER.
		
		        return false;
		    });
		
		    $('#btnInfoWeb').click(function () {
		
		        // TOGGLE (SHOW OR HIDE) INFOWWEB WINDOW.
		        $('#infoWeb').fadeToggle('fast', 'linear', function () {
		            if ($('#infoWeb').is(':hidden')) {
		                $('#infoWeb').css('background-color', 'transparent');
		            }
		            // CHANGE BACKGROUND COLOR OF THE BUTTON.
		            else $('#btnInfoWeb').css('background-color', 'transparent');
		        });
		        return false;
		    });
		
		
		     // HIDE INFOWWEB WHEN CLICKED ANYWHERE ON THE PAGE.
		     $(document).click(function () {
		        $('#infoWeb').hide();
		    });
		
		    $('#notifications').click(function () {
		        return false;       // DO NOTHING WHEN CONTAINER IS CLICKED.
		    });
		
		    // HIDE NOTIFICATIONS WHEN CLICKED ANYWHERE ON THE PAGE.
		    $(document).click(function () {
		        $('#notifications').hide();
		
		        // CHECK IF NOTIFICATION COUNTER IS HIDDEN.
		        if ($('#noti_Counter').is(':hidden')) {
		            // CHANGE BACKGROUND COLOR OF THE BUTTON.
		            $('#btnNotication').css('background-color', 'transparent');
		        }
		    });
		
		    $('#notifications').click(function () {
		        return false;       // DO NOTHING WHEN CONTAINER IS CLICKED.
		    });
		});
		
		const inputs = document.querySelectorAll(".form-control");
		
		function AddClass(){
		    let parent = this.parentNode.parentNode;
		    parent.classList.add("focus");
		}
		
		function RemoveClass(){
		   let parent = this.parentNode.parentNode;
		   if(this.value == ''){
		       parent.classList.remove("focus");
		   }
		}
		
		inputs.forEach(input => {
		   input.addEventListener("focus", AddClass);
		   input.addEventListener("blur", RemoveClass);
		});
		
		
		
		function openComment(evt, nameAct) {
		    // Declare all variables
		    var i, tabcontent, tablinks;
		  //alert(nameAct);
		    // Get all elements with class="tabcontent" and hide them
		    tabcontent = document.getElementsByClassName("tabcontent");
		    for (i = 0; i < tabcontent.length; i++) {
		        tabcontent[i].style.display = "none";
		    }
		  
		    // Get all elements with class="tablinks" and remove the class "active"
		    tablinks = document.getElementsByClassName("tablinks");
		    for (i = 0; i < tablinks.length; i++) {
		      tablinks[i].className = tablinks[i].className.replace(" active", "");
		    }
		  
		    //show the current tab, and add an "active" class to the button that opened the tab
		    document.getElementById(nameAct).style.display = "block";
		    evt.currentTarget.className += " active";


		
		// Chuyển markdown sang HTML

	
	}
  
  </script>
	<script type="text/javascript">
  let content = new SimpleMDE({
		element: document.getElementById("content"),
		toolbar: ["bold", "italic", "strikethrough", "|",
							"heading-1", "heading-2", "heading-3","|",
							"unordered-list", "ordered-list", "link", "image", "table", "horizontal-rule", "|",
							"quote", "code", "|",
							"preview", "side-by-side", "fullscreen", "clean-block", "|",
							"guide",],
		status: false,
		toolbar: false,
		spellChecker: false,
		renderingConfig: {
	        codeSyntaxHighlighting: true,
	  },
	});
	content.togglePreview();
  </script>

</body>

</html>