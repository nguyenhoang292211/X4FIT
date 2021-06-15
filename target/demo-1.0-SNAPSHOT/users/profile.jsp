<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Profile</title>
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/styles/profile.css" />
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/styles/footer.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/bootstrap.min.css">
  <script src="${pageContext.request.contextPath}/scripts/jquery-3.5.1.slim.min.js"></script>
  <script src="${pageContext.request.contextPath}/scripts/bootstrap.min.js"></script>
  <script src="${pageContext.request.contextPath}/scripts/bootstrap.min.js"></script>
  <link href="https://fonts.googleapis.com/css2?family=Bungee+Shade&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css">
<!--   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script> -->
<!--   <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script> -->
<!--   <script src="https://kit.fontawesome.com/f93b4d7888.js" crossorigin="anonymous"></script> -->
</head>

<body>
	<jsp:include page="../navbar.jsp"></jsp:include>
<!--     <header> -->
<!--         <nav class="navbar navbar-expand-md navbar-light sticky "> -->
<%--           <div class="logo"><a class="logo-link" href="${pageContext.request.contextPath}/home">4<span>FIT</span></a></div> --%>
<!--           <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation"> -->
<!--         <span class="navbar-toggler-icon"></span> -->
<!--         </button> -->
<!--           <div class="collapse navbar-collapse" id="navbarNavAltMarkup"> -->
<!--             <div class="navbar-nav"> -->
<%--               <a class="nav-item nav-link active" href="${pageContext.request.contextPath}/home">Home <span class="sr-only">(current)</span></a> --%>

<!--               <div class="input-group mb-10"> -->
<!--                 <input type="text" class="form-control" placeholder="Search" aria-label="Username" aria-describedby="basic-addon1"> -->
<!--                 <div class="input-group-prepend"> -->
<!--                   <span class="input-group-text" id="basic-addon1"><i class="fas fa-search"></i></span> -->
<!--                 </div> -->
<!--               </div> -->
<!--               <button class="btn btn-primary mt-1 " type="button" id="information"> -->
<!--            	 <i class="fas fa-bell"></i> -->
<!--          	 </button> -->
<!--               <div class="dropdown-menu dropdown dropdown-menu-right " aria-labelledby="dropdownMenu2"> -->

<!--               </div> -->
<!--               <button class="btn btn-secondary mt-1" type="button"> -->
<%--             <a href="${pageContext.request.contextPath}/posts/create.jsp"><i class="fas fa-edit"></i></a> --%>
<!--           </button> -->
<!--             </div> -->
<!--           </div> -->
<!--           <div class="img-pro"> -->
<!--           </div> -->
<!--           <button type="button" id="dropdownMenu2" class="btn dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> -->
<%--         		<img class="img-profile" src="${pageContext.request.contextPath}/images/${usermain.getAvatar() }" alt=""> --%>

<!--      			 </button> -->
<!--           <div class="dropdown-menu dropdown dropdown-menu-right " aria-labelledby="dropdownMenu2"> -->
<!--             <div class="dropdown-item profile-popup"> -->
<%--               <img class="img-profile" src="${pageContext.request.contextPath}/images/${usermain.getAvatar() }" alt=""> --%>
<!--               <div class="info-popup"> -->
<%--                 <h5 class="name-info"><a href="${pageContext.request.contextPath}/profile">${usermain.getUsername(usermain)}</a> </h5> --%>
<%--                 <p class="gmail-info">${usermain.getEmail(usermain.getId())}</p> --%>
<!--                 <form action="/profile" method="get"> -->
<%--                   <a href="${pageContext.request.contextPath}/posts/create.jsp"><button class="btn btn-primary btn-edit" type="submit">Edit</button></a> --%>

<!--                 </form> -->

<!--               </div> -->
<!--             </div> -->
<!--             <div class="dropdown-divider"></div> -->
<%--             <a class="dropdown-item" href="${pageContext.request.contextPath}/profile">Profile</a> --%>
<!--             <div class="dropdown-divider"></div> -->
<!--             <a class="dropdown-item" href="#">Sign out</a> -->
<!--           </div> -->
<!--         </nav> -->
<!--       </header> -->


  <!-----------------------------BANNER PROFILE----------------------------------->
   <div class="profile-banner container-fluid ">
        <div class="container  ml-2">
            <img class="img-profile-ban  float-left" src="${pageContext.request.contextPath}/images/${curUser.getAvatar() }">
            <div class="info-ban">
                <h5 class="name-ban">${curUser.getFullname()}</h5>
                <p class="gmail-ban">${acc.getEmail()}</p>
                <div class="follow">
                <c:if test="${curUser.getId()!=usermain.getId()}">
                 
                     <input type="hidden" class="mainuser" value="${usermain.getId()}">
                      <input type="hidden" class="id-author" value="${curUser.getId()}">
                 <c:if test="${usermain.getUserFromFollowing(curUser)==true }">
                   	<button class="btn btn-follow" style="background: rgb(68, 68, 231);color: white; " type="button">
                 			  Following
             		</button>
                  </c:if>
                  <c:if test="${usermain.getUserFromFollowing(curUser)==false }">
                   	<button class="btn btn-follow" style="background: white; color: blue;" type="button">
                 			  Follow+
             		</button>
             		
                  </c:if>                                  
           		</c:if>
           		</div>
            </div>
        </div>
    </div>


    <!-----------------------CONTENT----------------------------->


    <div class="container-fluid">
    	
        <div class="row">
            <div class="col-lg-9 content-main ">
                <c:choose>
                    <c:when test="${updateSuccess==true or updateSuccess==null}">
                        <button class="tablink" onclick="openPage('Post',this)" id="defaultOpen"> Bài viết của tôi</button>
                        <button class="tablink" onclick="openPage('Bookmarks', this)">Đánh dấu</button>
                        <button class="tablink" onclick="openPage('Following', this)">Đang theo dõi</button>
                        <button class="tablink" onclick="openPage('Follower',this)">Người theo dõi</button>
                        <button class="tablink" <c:if test="${ curUser.getId()== usermain.getId() }">
	                        	onclick="openPage('Setting',this)"
	                        </c:if>>	Tài khoản
                              </button>
                    </c:when>
                    <c:when test="${updateSuccess==false}">
                                <button class="tablink" onclick="openPage('Post',this)"> Bài viết của tôi</button>
                                <button class="tablink" onclick="openPage('Bookmarks', this)">Đánh dấu</button>
                                <button class="tablink" onclick="openPage('Following', this)">Đang theo dõi</button>
                                <button class="tablink" onclick="openPage('Follower',this)">Người theo dõi</button>
                                <button class="tablink" id="defaultOpen" <c:if test="${ curUser.getId()== usermain.getId() }">
                       		 onclick="openPage('Setting',this)" 
                        </c:if>>Tài khoản
                        </button>
                            </c:when>
                </c:choose>


                <!---------------------------------POSTS------------------------------->
			
                <div id="Post" class="tabcontent">
                    <div class="jumbotron jumbotron-fluid" id="list-post">
                        <c:forEach items="${listpost}" var="post">
                            <div class="post-div container">
                                <img class="img-pro-post float-left" src="${pageContext.request.contextPath}/images/${curUser.getAvatar() }" alt="${curUser.getFullname() }">
                                <a class="name-pro-post display-9">${curUser.getFullname()}</a>
                                <c:if test="${post.getIs_public()==true}">
                                	<span class="status">Public</span>
                                </c:if>
                                <c:if test="${post.getIs_public()==false}">
                                	<span class="status">Private</span>
                                </c:if>
                                 
                                <p class="postime">Create at: ${post.getPublished_at()}</p>
                                <p class="lead ml-2 title-post"><a href="${pageContext.request.contextPath}/post?p=${post.getUrl()}">${post.getTitle() }</a>
                                </p>
                                <p class="card-text">${post.getShortContent()}...</p>
                                <div class="tag d-flex">
                                    <button class="btn-secondary">${post.getCategory() }</button>

                                </div>
                                <span class="viewtag t ml-20">
                                <i class="far fa-eye"></i><label class="view">${post.getViews_count()} </label>
                            </span>
                                <span class="viewtag t ">
                                <i class="fas fa-paperclip"></i><label class="view">${post.getClips_count(post) }</label>
                            </span>
                                <span class="viewtag t">
                                <i class="far fa-comment"></i><label class="view">${post.getComments_Count()}</label>
                            </span>
                            </div>
                            <div class="divider ml-5 mr-5"></div>
                        </c:forEach>

                    </div>
                </div>
                <script>
                    function openPage(nampage, element) {
                        var i, tabcontent, tablink;
                        tabcontent = document.getElementsByClassName("tabcontent");
                        for (i = 0; i < tabcontent.length; i++) {
                            tabcontent[i].style.display = "none";
                        }

                        tablink = document.getElementsByClassName("tablink");
                        for (i = 0; i < tablink.length; i++) {
                            tablink[i].style.backgroundColor = "rgb(161, 161, 161)";
                        }

                        document.getElementById(nampage).style.display = "block";

                        element.style.backgroundColor = "rgb(20, 20, 20)";
                    }
                    // openPage('Post',document.getElementById("defaultOpen"));     
                    document.getElementById("defaultOpen").onclick();
                </script>

                <!----------------------------------BOOKMARKS--------------------------------------->

                <div id="Bookmarks" class="tabcontent">
                    <div class="jumbotron jumbotron-fluid">
                        <c:forEach items="${clipspost}" var="post">
                            <div class="post-div container">
                                <img class="img-pro-post float-left" src="${pageContext.request.contextPath}/images/${post.GetAuthor().getAvatar() }" alt="">
                                <a class="name-pro-post display-9" style="cursor: pointer;" href="${pageContext.request.contextPath}/viewprofile?email=${user.getEmail(post.getAuthor_id())}">${post.GetAuthor().getFullname()}</a>
                                <c:if test="${post.getIs_public()==true}">
                                	<span class="status">Public</span>
                                </c:if>
                                <c:if test="${post.getIs_public()==false}">
                                	<span class="status">Private</span>
                                </c:if>
                                <p class="postime">Create at :  ${post.getPublished_at()}</p>
                                <p class="lead ml-2 title-post"><a href="${pageContext.request.contextPath}/post?p=${post.getUrl()}">${post.getTitle() }</a>
                                </p>
                                <p class="card-text">${post.getShortContent()}...</p>
                                <div class="tag d-flex">
                                    <button class="btn-secondary">${post.getCategory() }</button>

                                </div>
                                <span class="viewtag t ml-20">
                                <i class="far fa-eye"></i><label class="view">${post.getViews_count()} </label>
                            </span>
                                <span class="viewtag t ">
                                <i class="fas fa-paperclip"></i><label class="view">${post.getClips_count(post) }</label>
                            </span>
                                <span class="viewtag t">
                                <i class="far fa-comment"></i><label class="view">${post.getComments_Count()}</label>
                            </span>
                            </div>
                            <div class="divider ml-5 mr-5"></div>
                        </c:forEach>

                    </div>
                </div>
                <!----------------------------FOLLOWING----------------------------------------->
                <div id="Following" class="tabcontent">
                    <div class="row following-row">
                        <c:forEach items="${following}" var="user">
                            <div class="col-sm-6 col-md-4 anuser">
                                <div class="d-flex exhibition-item user mt-4">
                                    <a class="d-flex img-user-div pt-1" href="#">
                                        <img class="avatar-user float-left img-fluid" src="${pageContext.request.contextPath}/images/${user.getAvatar() }">
                                    </a>
                                    <div class="user-info overflow-hidden">

                                        <a class="username" style="cursor: pointer;" href="${pageContext.request.contextPath}/viewprofile?email=${user.getEmail(user.getAccount_id())}">${user.getFullname()}</a>
                                        <div class="user-icon">
                                            <span class="viewtag t ">
                                            <i class="fas fa-user-plus"></i><label class="view">${user.countFollowing(user)}</label>
                                        </span>
                                            <span class="viewtag t">
                                            <i class="far fa-edit"></i><label class="view">${user.countPost(user.getId())}</label>
                                        </span>
                                        </div>
                                        <div class="follow">
                                        	<input type="hidden" class="mainuser" value="${usermain.getId()}">
                                            <input type="hidden" class="id-author" value="${user.getId()}">
                                           <c:if test="${ curUser.getId() != usermain.getId() }">
	                                          	 <c:if test="${usermain.getUserFromFollowing(user)==false }">
	                                            	<button class="btn btn-follow" style="background: white; color: blue;" type="button">
	                                           			 Follow+
	                                        		</button>
	                                        	</c:if>
	                                        	<c:if test="${usermain.getUserFromFollowing(user)==true }">
	                                            	<button class="btn btn-follow" style="background: rgb(68, 68, 231);color: white; " type="button">
	                                           			 Following
	                                        		</button>
	                                        	</c:if>
                                        	</c:if>
                                        	<c:if test="${ curUser.getId() == usermain.getId() }">
                                        		<button class="btn btn-follow" style="background: rgb(68, 68, 231);color: white; " type="button">
                                           			 Following
                                        		</button>
                                        	</c:if>
                                        	
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
                <!--------------------------FOLLOWER-------------------------------------->
                <div id="Follower" class="tabcontent">
                    <div class="row following-row">
                        <c:forEach items="${follower}" var="user">
                            <div class="col-sm-6 col-md-4 anuser">
                                <div class="d-flex exhibition-item user mt-2">
                                    <a class="d-flex img-user-div pt-1" href="#">
                                        <img class="avatar-user float-left img-fluid" src="${pageContext.request.contextPath}/images/${user.getAvatar() }">
                                    </a>
                                    <div class="user-info overflow-hidden">
                                        <a class="username" style="cursor: pointer;" href="${pageContext.request.contextPath}/viewprofile?email=${user.getEmail(user.getAccount_id())}">${user.getFullname()}</a>
                                        <div class="user-icon">
                                            <span class="viewtag t ">
                                            <i class="fas fa-user-plus"></i><label class="view">${user.countFollowing(user)}</label>
                                        </span>
                                            <span class="viewtag t">
                                            <i class="far fa-edit"></i><label class="view">${user.countPost(user.getId())}</label>
                                        </span>
                                        </div>
                                        <div class="follow">
                                        	<input type="hidden" name="email" value="${user.getEmail(user.getAccount_id())}">
                                            <input type="hidden" class="mainuser" value="${usermain.getId()}">
                                            <input type="hidden" class="id-author" value="${user.getId()}">
                                            <c:if test="${usermain.getUserFromFollowing(user)==true }">
                                            	<button class="btn btn-follow" style="background: rgb(68, 68, 231);color: white; " type="button">
                                          			  Following
                                      			  </button>
                                            </c:if>
                                            <c:if test="${usermain.getUserFromFollowing(user)==false }">
                                            	<button class="btn btn-follow" style="background: white; color: blue;" type="button">
                                          			  Follow+
                                      			  </button>
                                            </c:if>
                                            
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </c:forEach>

                    </div>
                </div>
                <div id="Setting" class="tabcontent">
                    <div class="row content">
                        <div class="col-md-2 setting-btn">
                            <button type="button" class="btn profile">PROFILE </button>
                            <button type="button" class="btn account">ACCOUNT </button>
                        </div>
                        <div class="col-md-10 setting-row">
                            <input type="radio" name="name" id="profile" checked="checked" />
                            <div class="container">

                                <div class="row">
                                    <div class="col-md-3 avatar">
                                       
                                    </div>
                                    <div class="col-md-9">
                                        <h3 style="margin-bottom: 10px;">Your information</h3>
                                        <c:if test="${updateSuccess==true}">
                                            <h5 style="color: red; margin-top: 10px;">Cập nhật thông tin thành công</h5>
                                        </c:if>

                                        <form action="${pageContext.request.contextPath}/profile?action=editaccount" method="POST">
                                            <div class="form-group">
                                                <%--@declare id="exampleinputemail1"--%><label for="exampleInputEmail1">Họ tên </label>
                                                <input type="text" class="form-control" name="fullname" placeholder="Enter fullname" value="${usermain.getFullname()}" >
                                                <label>${nameError}</label>
                                            </div>
                                            <div class="form-group">
                                                <label for="exampleInputEmail1">Email</label>
                                                <input type="email" class="form-control" name="email" aria-describedby="emailHelp" placeholder="Enter email" value="${acc.getEmail() }" >
                                                <label>${emailError}</label>
                                            </div>
                                            <label class="advance">Thay đổi thông tin đăng nhập</label>
                                            <div id="advance">
                                                <div class="form-group">
                                                    <label for="exampleInputEmail1">Tên đăng nhập</label>
                                                    <input type="text" class="form-control" name="username" placeholder="username" value="${acc.getUsername() }" >
                                                    <label>${usernameError}</label>
                                                </div>
                                                <div class="form-group">
                                                    <label for="exampleInputEmail1">Mật khẩu hiện tại</label>
                                                    <input type="password" class="form-control" name="currentpass"  placeholder="current password" value="${acc.getPassword() }" disabled>

                                                </div>

                                                <span> <label class="changepass">Thay đổi mật khẩu </label> or  <a href="${pageContext.request.contextPath}/login/forgot.jsp" class="forgotpass">Quên mật khẩu ?</a></span>

                                            </div>
                                            <button class="btnsave" type="submit">Lưu thay đổi</button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                            <input type="radio" id="account" name="name" />
                            <div class="container">
                                <div id="changepass">
                                    <h3>Change your password</h3>
                                    <form  action="${pageContext.request.contextPath}/profile?action=editpass" method="post">
                                    	<div class="form-group">
	                                        <label for="exampleInputEmail1">Mật khẩu hiện tại</label>
	                                        <input type="password" class="form-control" name="oldpass" placeholder="type your old password">
	                                        <label>${oldpassError}</label>
	                                    </div>
	                                    <div class="form-group">
	                                        <label for="exampleInputEmail1">Mật khẩu mới</label>
	                                        <input type="password" class="form-control" name="newpass" placeholder="type new password">
	                                        <label>${newpassError}</label>
	                                    </div>
	                                    <div class="form-group">
	                                        <label for="exampleInputEmail1">Xác nhận mật khẩu</label>
	                                        <input type="password" class="form-control" name="confirmnewpass" placeholder="confirm new password">
	                                        <label>${confirmError}</label>
	                                    </div>
	                                    <button class="btnsave" type="submit">Lưu thay đổi</button>
                                    	
                                    </form>
                                    
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
            <div class="list-static col-lg-3 hidden-md-down float-right">
                <ul class="list-group ">
                    <li class="list-group-item  d-flex justify-content-between align-items-center">
                       Tổng lượt xem 
                        <span class="badge badge-primary badge-pill">${curUser.countTotalPostView(curUser.getAccount_id())}</span>
                    </li>
                    <li class="list-group-item d-flex w-100 justify-content-between align-items-center">
						Số người đang theo dõi
                        <span class="badge badge-primary badge-pill">${curUser.countFollowing(curUser)}</span>
                    </li>
                    <li class="list-group-item d-flex justify-content-between align-items-center">
                        Số người theo dõi
                        <span class="badge badge-primary badge-pill">${curUser.countFollower(curUser)}</span>
                    </li>
                    <li class="list-group-item d-flex justify-content-between align-items-center">
                        Tổng bài đăng
                        <span class="badge badge-primary badge-pill">${listpost.size()}</span>
                    </li>
                    <li class="list-group-item d-flex justify-content-between align-items-center">
                        Tổng bài đánh dấu
                        <span class="badge badge-primary badge-pill">${curUser.countClips(curUser) }</span>
                    </li>
                </ul>
            </div>


        </div>
    </div>
  </div>

  <jsp:include page="../common/footer.jsp"/>
  <script>
  
	  document.getElementById("dropdownMenu2").onclick = function() {
	    if (document.getElementsByClassName("dropdown-menu")[1].style.display == "block") {
	      document.getElementsByClassName("dropdown-menu")[1].style.display = "none";
	      document.getElementsByClassName("dropdown-menu")[1].style.top = "60%";
	    } else {
	      document.getElementsByClassName("dropdown-menu")[1].style.display = "block";
	      document.getElementsByClassName("dropdown-menu")[1].style.transition = "2s ease"
	      document.getElementsByClassName("dropdown-menu")[1].style.top = "95%";
	    }
	
	
	  }
    document.getElementsByClassName("advance")[0].onclick = function() {
      if (document.getElementById("advance").style.display == "none")
        document.getElementById("advance").style.display = "block";
      else
        document.getElementById("advance").style.display = "none";
    }

    document.getElementsByClassName("changepass")[0].onclick = function() {
      document.getElementsByClassName("account")[0].onclick();
    }

    document.getElementsByClassName("account")[0].onclick = function() {
      document.getElementById("account").checked=true;
    }
    document.getElementsByClassName("profile")[0].onclick = function() {
      document.getElementById("profile").checked = true;
    }
    
    document.getElementsByClassName("permit-edit")[0].onclick= function(){
    	
    	alert(document.getElementsByClassName("form-control")[0].disabled);
    }
     
    
  </script>
     <script type="text/javascript" src="scripts/Follow.js"></script>

</body>

</html>