<%@ page language="java" contentType="text/html; charset= UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*,model.User,java.util.Date,java.text.SimpleDateFormat,java.util.ArrayList,javax.annotation.Resource,javax.sql.DataSource"%>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Kết quả tìm kiếm</title>
	<link rel="icon" type="image/png" href="images/logo2.png" />
	<link href="https://fonts.googleapis.com/css2?family=Bungee+Shade&display=swap" rel="stylesheet">
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
  <scr src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></scr>
  <scr src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" crossorigin="anonymous"></scr>
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
  <script src="https://kit.fontawesome.com/f93b4d7888.js"
	crossorigin="anonymous"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/styles/footer.css" />
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/styles/home.css" />
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/styles/search.css" />
</head>
<body>
		<jsp:include page="../navbar.jsp"></jsp:include>
    <div class="row">
    <div class = "col-md-9">
       <div class="content-main ">
				<div  align="center" style="margin-left: 40%;">
				 <button class="tablink" onclick="openPage('Bookmarks',this)"  id="defaultOpen"> Post</button>
		     <button class="tablink" onclick="openPage('searchAuthor', this)">Author</button>
				</div>
            <!----------------------------------BOOKMARKS--------------------------------------->

            <div id="Bookmarks" class="tabcontent">
                <div class="jumbotron jumbotron-fluid">
               <c:choose>
        	 		<c:when test ="${listPost.size() == 0}" >
                <span class="text-dark" style="margin-left: 40%; color: black; margin-top: 50px;"> <b>Không tìm thấy bài viết !</b></span>
              </c:when> 
            </c:choose>
                 
                 <c:forEach var="p" items="${listPost}" begin="0" end="${listPost.size()}" varStatus="loop">
                 					
										<div class="card bg-light" style="margin-top: 1.5em; margin-bottom: 1.5em; ">
										  <h6 class="card-header text-dark" style="padding: 0.5rem 1.25rem;">
										  	<a class="h3" href="${pageContext.request.contextPath}/post?p=${p.getUrl()}">
												 			${p.getTitle() }
												</a>
												<br>
												<a style="margin: 10px;" href="#">
													${post.getAuthor().getFullname()}
												</a>
												<br>
												<small><span style="margin: 10px;">${p.getPublished_at()}</span></small>
											</h6>
										  <div class="card-body">
										    <h3 class="card-title">
													<span class="viewtag t ml-20 h6"> 
														<i class="far fa-eye"></i>
														<label class="view"> ${p.getViews_count()}</label>
													</span> 
													<span class="viewtag t h6"> 
														<i class="fas fa-paperclip"></i>
														<label class="view"> ${p.getClips_count()}</label>
													</span> 
													<span class="viewtag t h6"> 
														<i class="far fa-comment"></i>
														<label class="view"> ${p.getComments_Count()}</label>
													</span>
													<a class="badge badge-info h6" style="margin-left: 20px;" href="#">${p.getCategory() }</a>
										    </h3>
										    <p class="card-text text-dark">${p.getShortContent()}...</p>
										    <a href="${pageContext.request.contextPath}/post?p=${p.getUrl()}" 
										    		class="btn btn-primary">Đọc tiếp...</a>
										  </div>
										</div>
										
									</c:forEach>
                </div>
                
                <c:choose>
        	 		<c:when test ="${listPost.size() != 0}" >
                 <div align="center" >
						<form action="${pageContext.request.contextPath}/search" method="get">
							<input type="hidden" name="page" value="${page}">
							<input type="hidden" name="textSearchHidden" value="${textSearchHidden}">
							<button type="submit" class="btn btn-secondary">XEM THÊM >>></button>
						</form>      
           <!-- end block -->
        	
                        </div>
              </c:when> 
            </c:choose>
               
            </div>
        	<div id = "searchAuthor" class="tabcontent">
        	<div class="row following-row " style = "margin-top: 50px;">
        	
        	
        	
        		<!-- block author  -->
        		<c:choose>
        	 		<c:when test ="${lenListauthor == 0}" >
                <span class="text-dark" style="margin-left: 40%;"> <b> Không tìm thấy tác giả!</b></span>
              </c:when> 
            </c:choose>
        	<c:forEach var = "user" items = "${listAuthor}" >
            <div class="col-sm-6 col-md-4">
                <div class="d-flex exhibition-item user mt-2">
                    <a class="d-flex img-user-div pt-1" href="#">
                        <img class="avatar-user float-left" src="images/A-Field-of-Eternal-Blue-Bluebonnet-Texas.jpg">
                    </a>
                    <div class="user-info overflow-hidden">
                        <a class="username">${ user.getUsername(user.getUserID())}</a>
                        <div class="user-icon">
                            <span class="viewtag t ">
                                <i class="fas fa-user-plus"></i><label class="view">16</label>
                            </span>
                            <span class="viewtag t">
                                <i class="far fa-edit"></i><label class="view">16</label>
                            </span>
                        </div>
                        <div class="follow">
                            <button class="btn btn-follow" type="button">
                                Follow
                            </button>
                        </div>
                    </div>

                </div>
            </div>
                        
                 </c:forEach> 
                 
        	</div>
        </div>
		</div>
		</div>
		 <!------------------------------Top SYCHTACH---------------------------->
        
		<div class = "col-md-3">
       
	        <div class="section-title-line mb-1">
	        <h4 class="text-uppercase text-muted" style = "margin-top: 30px">
	            Search syntax
	        </h4><hr class="filler-line"></div>
	        
	        <div class = "main-search-syntax">
		        <div>
		        <a class = "btn btn-secondary" data-v-1ebc36b8="" href="${pageContext.request.contextPath}/search?textSearch=title:Overfitting&userCurrentAction=search_home" class="el-tag tag active el-tag--info el-tag--default">
	                title:Overfitting </a> 
	            <p class="text-muted">
	                Containing "Overfitting" in title </p>
	            </div>
		        
			        <div>
			        <a class = "btn btn-secondary" data-v-1ebc36b8="" href="${pageContext.request.contextPath}/search?textSearch=tag:new&userCurrentAction=search_home" class="el-tag tag active el-tag--info el-tag--default">
	                tag:new </a> 
	            <p class="text-muted">Tagged with "new"</p>
	            </div>
           
           
           		<div><a class = "btn btn-secondary" data-v-1ebc36b8="" href="${pageContext.request.contextPath}/search?textSearch=NOT:xuân&userCurrentAction=search_home" class="el-tag tag active el-tag--info el-tag--default">
                NOT:xuân
            </a> <p class="text-muted">
                Must not contain "xuân"
            </p></div>
            
            
            <div><a class = "btn btn-secondary" data-v-1ebc36b8="" href="${pageContext.request.contextPath}/search?textSearch=user:Tien&userCurrentAction=search_home" class="el-tag tag active el-tag--info el-tag--default">
                user:Tien
            </a> <p class="text-muted">
                Created by user "Tien"
            </p></div>
            
            
		        </div>
		        
		        
        
		</div>
    </div>
    </div>
    
    <jsp:include page="../common/footer.jsp"/>
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
    
    <script>

    window.onload = function()
    {
    	highlightTextHome();
    };
     
	    function highlightTextHome() {
    		var text = document.getElementById("text_search").value;
    		
    	  var inputText = document.getElementsByClassName("title-post");
    	  for (var i = 0; i < inputText.length; i++)
    	 { 	var innerHTML = inputText[i].innerHTML;
		   	  var index = innerHTML.indexOf(text);
			  if (index >= 0) { 
			   innerHTML = innerHTML.substring(0,index) + "<span class='highlight'>" + innerHTML.substring(index,index+text.length) + "</span>" + innerHTML.substring(index + text.length);
			   inputText[i].innerHTML = innerHTML;
	  			}
    	 }
	    }
    </script>
</body>
</html>