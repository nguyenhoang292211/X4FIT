<%@page import="model.Account"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% boolean is_logged = Account.isLogged(request.getCookies()); %>
<script src="https://www.w3schools.com/lib/w3.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>

<% if (is_logged) { %>
	<div class="row">
        <div class="col-sm-0 col-md-2" style="border-right: 1px solid #ccc;">
            <div class="logo" style="border-bottom: 1px solid #ccc">
                <a href="${pageContext.request.contextPath}/mod/all-categories">
                    <img src="https://colorlib.com/polygon/adminator/assets/static/images/logo.png">
                    <span>X4FIT</span>
                </a>
            </div>

            <div class="nav-left">
                <ul>
	                <li id="post">
	                        <a id="a3" href="${pageContext.request.contextPath}/mod/all-posts">
	                            <i class="fa fa-book" aria-hidden="true"></i>
	                            <span>Bài viết</span>
	                        </a>
	                    </li>
                    <li id="category">
                        <a id="a2" href="${pageContext.request.contextPath}/mod/all-categories">
                            <i class="fa fa-list-alt" aria-hidden="true"></i>
                            <span>Thể loại</span>
                        </a>
                    </li>
                    
                </ul>
            </div>

        </div>
        <div class="col-md-10 col-sm-12">
            <div class="navbar-top" style="border-bottom: 1px solid #ccc;">
                <nav class="navbar navbar-expand-lg navbar-light">
                    <button class="navbar-toggler" type="button" data-toggle="collapse"
                        data-target="#navbarTogglerDemo03" aria-controls="navbarTogglerDemo03" aria-expanded="false"
                        aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse">
                        <ul class="navbar-nav ml-auto mt-2 mt-lg-0 mr-5">
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button"
                                    data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    <span><img class="avata" src="${pageContext.request.contextPath}/images/${user.getAvatar()}"></span>
                                   ${user.getFullname() }
                                </a>
                                <div class="dropdown-menu" aria-labelledby="navbarDropdown">
<!--                                     <a class="dropdown-item" href="#">Setting</a> -->
                                    <div class="dropdown-divider"></div>
                                    <a class="dropdown-item" href="${pageContext.request.contextPath}/logout">Đăng xuất</a>
                                </div>
                            </li>
                        </ul>
                    </div>
                </nav>
            </div>
		<% } else {%>
				
		<% } %>
    