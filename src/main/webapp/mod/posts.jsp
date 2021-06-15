<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
		<!DOCTYPE html>
		<html>

		<head>
			<meta charset="UTF-8">
			<meta name="viewport" content="width=device-width, initial-scale=1.0">
			<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css"
				integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2"
				crossorigin="anonymous">
			<link rel="stylesheet"
				href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
			<link rel="stylesheet" href="./style.css">
			<title>Posts - Mod</title>
		</head>

<body>
	<jsp:include page="../common/modHeader.jsp" />
	<div class="main-panel mt-3">
		<div class="content">
			<div class="container-fluid">
				<div class="row">
					<div class="col-md-12">
				        <form class="mb-2 form-inline my-2 ml-auto mr-5" action="${pageContext.request.contextPath}/mod/search-post">
			            	<input class="form-control mr-sm-1 search-bar" style="width: 500px; border: 1px solid #007bff;" name="query" value="${query}" type="search" placeholder="Tìm trong bài viết.">
			                <button class="btn btn-outline-primary my-2 my-sm-0" type="submit">Tìm kiếm</button>
				        </form>
						<div class="card card-plain">
							<div class="card-header card-header-primary"
								style="background-color: #007bff; color: #fff">
								<h4 class="card-title mt-0">Quản lý bài viết - [Tổng: ${allPosts.size()}]</h4>
							</div>
							<div class="card-body">
								<c:choose>
									<c:when test="${allPosts.size() > 0}">
										<div class="table-responsive">
											<table class="table table-hover">
												<thead class="">
													<th class="align-middle">
														Tiêu đề
													</th>
													<th class="align-middle">
														Thể loại
													</th>
													<th class="align-middle">
														Lược xem
													</th>
													<th class="align-middle">
														Điểm
													</th>
													<th class="align-middle">
														Chế độ
													</th>
													<th>
														Trạng thái
													</th>
													<th class="align-middle">
														Thao tác
													</th>
												</thead>
												<tbody>

													<c:forEach items="${allPosts}" var="post">
														<tr>
															<td>
																${post.getTitle()}
															</td>
															<td>
																${post.getCategory()}
															</td>
															<td class="align-middle">
																${post.getViews_count()}
															</td>
															<td class="align-middle">
																${post.getPoints()}
															</td>
															<td class="align-middle">
																<c:if test="${post.getIs_public() == true}">
																	<c:out value="Công khai" />
																</c:if>
																<c:if test="${post.getIs_public() == false}">
																	<c:out value="Riêng tư" />
																</c:if>
															</td>
															<td>
																${post.getStatus()}
															</td>
															<td class="align-center d-flex">
																<c:set var="accepted" value="Đã duyệt" />
																<c:set var="unaccepted" value="Chờ duyệt" />
																<c:if test="${post.getStatus() == accepted}">
																	<button disabled style="border: none; background-color: transparent;" type="button" data-toggle="modal" data-target="#allow-post${post.getId()}">
																		<i class="fa fa-check"></i>
																	</button>	
																</c:if>
																<c:if test="${post.getStatus() == unaccepted}">
																	<button style="border: none; background-color: transparent;" type="button" data-toggle="modal" data-target="#allow-post${post.getId()}">
																		<i class="fa fa-check"></i>
																	</button>	
																</c:if>
																<button style="border: none; background-color: transparent;" type="button" data-toggle="modal" data-target="#delete-post${post.getId()}">
																	<i class="fa fa-trash"></i>
																</button>
																<!-- Allow post Modal -->
																<div class="modal fade" id="delete-post${post.getId()}" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
																	<div class="modal-dialog" role="document">
																		<div class="modal-content">
																			<div class="modal-header">
																				<h5 class="modal-title"
																					id="exampleModalLabel">Xóa bài viết
																				</h5>
																				<button type="button"
																					class="close"
																					data-dismiss="modal"
																					aria-label="Close">
																					<span
																						aria-hidden="true">&times;</span>
																				</button>
																			</div>
																			<div class="modal-body">
																				Xóa bài viết khỏi cơ sở dữ liệu?
																			</div>
																			<div class="modal-footer">
																				<button type="button"
																					class="btn btn-secondary"
																					data-dismiss="modal">Đóng</button>
																				<form
																					action="${pageContext.request.contextPath}/mod/delete-post"
																					method="get">
																					<input type="hidden"
																						name="postId"
																						value="${post.getId()}" />
																						<button type="submit"
																							class="btn btn-danger">Xóa</button>
																					</form>
																				</div>
																			</div>
																		</div>
																	</div>
																	
																	<!-- Delete post Modal -->
																<div class="modal fade" id="allow-post${post.getId()}" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
																	<div class="modal-dialog" role="document">
																		<div class="modal-content">
																			<div class="modal-header">
																				<h5 class="modal-title"
																					id="exampleModalLabel">Duyệt bài viết
																				</h5>
																				<button type="button"
																					class="close"
																					data-dismiss="modal"
																					aria-label="Close">
																					<span
																						aria-hidden="true">&times;</span>
																				</button>
																			</div>
																			<div class="modal-body">
																				Cho phép bài viết được đăng lên X4FIT?
																			</div>
																			<div class="modal-footer">
																				<button type="button"
																					class="btn btn-secondary"
																					data-dismiss="modal">Đóng</button>
																				<form
																					action="${pageContext.request.contextPath}/mod/accept-posts"
																					method="get">
																					<input type="hidden"
																						name="postId"
																						value="${post.getId()}" />
																						<button type="submit"
																							class="btn btn-primary">Duyệt</button>
																					</form>
																				</div>
																			</div>
																		</div>
																	</div>
															</td>
														</tr>
													</c:forEach>
												</tbody>
											</table>
										</div>
									</c:when>
									<c:otherwise>
										<h5>Không có dữ liệu.</h5>
									</c:otherwise>
								</c:choose>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	</div>
	</div>
	<script>
		w3.addClass('#post', 'active-nav')
		w3.addClass('#a3', 'color-white')
	</script>
	<jsp:include page="../common/footer.jsp" />
</body>

</html>

