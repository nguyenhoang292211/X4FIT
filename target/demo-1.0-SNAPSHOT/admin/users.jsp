<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/scripts/bootstrap.min.js">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/bootstrap.min.css">
            <link rel="stylesheet"
                href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/mod/style.css">

            <title>Quản lý người dùng - X4FIT</title>
        </head>

        <body>
            <jsp:include page="../common/adminHeader.jsp" />
            <div class="main-panel mt-3 mr-3">
                <div class="content">
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-md-12">
                                <c:if test="${not empty errorMessage}">
                                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                        <c:out value="${errorMessage}" />
                                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                    </div>
                                </c:if>
                                <div class="d-flex">
                                    <button class="mb-2 btn btn-primary" data-toggle="modal"
                                        data-target="#create-mod">TẠO MOD</button>
                                    <form class="mb-2 form-inline my-2 ml-auto"
                                        action="${pageContext.request.contextPath}/admin/search-user">
                                        <input class="form-control mr-sm-1 search-bar"
                                            style="width: 400px; border: 1px solid #007bff;" name="query"
                                            value="${query}" type="search" placeholder="Nhập từ khóa tìm kiếm">
                                        <button class="btn btn-primary my-2 my-sm-0" type="submit">Tìm
                                            kiếm</button>
                                    </form>
                                </div>
                                <div class="card card-plain">
                                    <div class="card-header card-header-primary"
                                        style="background-color: #007bff; color: #fff">
                                        <h4 class="card-title mt-0">Quản lý người dùng - [Tổng: ${userInfoList.size()}]</h4>
                                    </div>
                                    <div class="card-body">
                                        <div class="filter">
                                            <form class="d-flex row"
                                                action="${pageContext.request.contextPath}/admin/user/filter"
                                                method="get">
                                                <div class="filter-item col-sm-6 col-lg-4 col-md-6 mb-2">
                                                    <label for="account-type">Loại tài khoản:</label>
                                                    <select name="accountType" id="account-type" class="custom-select">
                                                        <option value="${accountType}" selected disabled hidden>
                                                            ${accountType}</option>
                                                        <option value="USER">USER</option>
                                                        <option value="MOD">MOD</option>
                                                        <option value="ALL">ALL</option>
                                                    </select>
                                                </div>
                                                <div class="filter-item col-sm-6 col-lg-4 col-md-6">
                                                    <label for="status">Trạng thái:</label>
                                                    <select name="status" id="status" class="custom-select">
                                                        <option value="${status}" selected disabled hidden>${status}
                                                        </option>
                                                        <option value="ACTIVE">ACTIVE</option>
                                                        <option value="NOT ACTIVE">NOT ACTIVE</option>
                                                        <option value="BLOCK">BLOCK</option>
                                                    </select>
                                                </div>
                                                <button class="col-sm-12 col-lg-4 col-md-12 filter-item btn-filter btn btn-primary"
                                                    type="submit">Lọc</button>
                                            </form>
                                        </div>
                                        <div class="table-responsive">
                                            <table class="table table-hover">
                                                <tr>
                                                    <th>
                                                        ID
                                                    </th>
                                                    <th>
                                                        Tên đăng nhập
                                                    </th>
                                                    <th>
                                                        Email
                                                    </th>
                                                    <th>
                                                        Loại tài khoản
                                                    </th>
                                                    <th>
                                                        Trạng thái
                                                    </th>
                                                    <th>
                                                        Thao tác
                                                    </th>
                                                </tr>
                                                <tbody>
                                                    <c:forEach items="${userInfoList}" var="user">
                                                        <tr>
                                                            <td>
                                                                ${user.getUserID()}
                                                            </td>
                                                            <td>
                                                                ${user.getUsername()}
                                                            </td>
                                                            <td>
                                                                ${user.getEmail() }
                                                            </td>
                                                            <td>
                                                                ${user.getUser_type() }
                                                            </td>
                                                            <td>
                                                                ${user.getStatus() }
                                                            </td>
                                                            <td>
                                                                <a type="button" data-toggle="modal"
                                                                    data-target="#disable${user.getUserID()}"><i
                                                                        class="fa fa-wrench"></i></a>
                                                                <a type="button" data-toggle="modal"
                                                                    data-target="#delete${user.getUserID()}"><i
                                                                        class="fa fa-trash" aria-hidden="true"></i></a>
                                                            </td>

                                                            <!-- Status Modal -->
                                                            <div class="modal fade" id="disable${user.getUserID()}"
                                                                tabindex="-1" role="dialog"
                                                                aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                                <div class="modal-dialog" role="document">
                                                                    <div class="modal-content">
                                                                        <div class="modal-header">
                                                                            <h5 class="modal-title"
                                                                                id="exampleModalLabel">
                                                                                Thay đổi trạng thái tài khoản
                                                                                [<i>${user.getUsername()}</i>]
                                                                            </h5>
                                                                            <button type="button" class="close"
                                                                                data-dismiss="modal" aria-label="Close">
                                                                                <span aria-hidden="true">&times;</span>
                                                                            </button>
                                                                        </div>
                                                                        <div class="modal-body">
                                                                            <form
                                                                                action="${pageContext.request.contextPath}/admin/update-status"
                                                                                method="post">
                                                                                <h5>Trạng thái hiện tại:
                                                                                    <b>${user.getStatus()}</b>
                                                                                </h5>
                                                                                <div class="form-group">
                                                                                    <label for="status">Trạng
                                                                                        thái</label>
                                                                                    <select class="form-control"
                                                                                        name="status" id="status">
                                                                                        <option
                                                                                            value="${user.getStatus()}"
                                                                                            selected disabled hidden>
                                                                                            ${user.getStatus()}
                                                                                        </option>
                                                                                        <option value="ACTIVE">
                                                                                            ACTIVE
                                                                                        </option>
                                                                                        <option value="BLOCK">BLOCK
                                                                                        </option>
                                                                                        <option value="NOT ACTIVE">
                                                                                            NOT
                                                                                            ACTIVE</option>
                                                                                    </select>
                                                                                </div>
                                                                                <input type="hidden" name="accountId"
                                                                                    value="${user.getUserID()}">
                                                                                <button type="submit"
                                                                                    class="btn btn-primary btn-block">ĐẶT
                                                                                    LẠI</button>
                                                                            </form>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <!-- Delete Modal -->
                                                            <div class="modal fade" id="delete${user.getUserID()}"
                                                                role="dialog">
                                                                <div class="modal-dialog" role="document">
                                                                    <div class="modal-content">
                                                                        <div class="modal-header">
                                                                            <h5 class="modal-title"
                                                                                id="exampleModalLabel">
                                                                                Xóa tài khoản
                                                                            </h5>
                                                                            <button type="button" class="close"
                                                                                data-dismiss="modal" aria-label="Close">
                                                                                <span aria-hidden="true">&times;</span>
                                                                            </button>
                                                                        </div>
                                                                        <div class="modal-body">
                                                                            Xóa vĩnh viễn tài khoản
                                                                            <b>${user.getUsername()}</b> khỏi cơ sở dữ
                                                                            liệu?
                                                                        </div>
                                                                        <div class="modal-footer">
                                                                        	<form action="${pageContext.request.contextPath}/admin/delete-user">
                                                                        		<input type="hidden" name="username" value="${user.getUsername()}">
                                                                        		<button type="submit"
                                                                                class="btn btn-danger">Xóa</button>
                                                                        	</form>
                                                                            
                                                                            <button type="button"
                                                                                class="btn btn-secondary"
                                                                                data-dismiss="modal">Đóng</button>
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
                w3.addClass('#user', 'active-nav');
                w3.addClass('#a2', 'color-white');
            </script>
            <jsp:include page="../common/footer.jsp" />
            <jsp:include page="../modals/createModModal.jsp" />
        </body>

        </html>