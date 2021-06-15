<%@page import="model.User" %>
    <%@page import="model.Account" %>
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
                    <title>Người dùng báo cáo - X4FIT</title>
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
                                                <button type="button" class="close" data-dismiss="alert"
                                                    aria-label="Close">
                                                    <span aria-hidden="true">&times;</span>
                                                </button>
                                            </div>
                                        </c:if>
                                        <div class="d-flex">
                                            <form class="mb-2 form-inline my-2"
                                                action="${pageContext.request.contextPath}/admin/search-report">
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
                                                <h4 class="card-title mt-0">Quản lý báo cáo người dùng - [Tổng: ${allReportsList.size()}]</h4>
                                            </div>
                                            <div class="card-body">
                                                <form action="${pageContext.request.contextPath}/admin/filter-report">
                                                    <div class="filter-report d-flex row">
                                                        <div class="filter-report-item col-lg-3 form-group">
                                                            <label for="type">Loại báo cáo</label>
                                                            <select class="custom-select form-control" name="reportType" id="type">
                                                                <option value="${reportType}" selected disabled hidden>${reportType}</option>
                                                                <option value="POST">POST</option>
                                                                <option value="COMMENT">COMMENT</option>
                                                            </select>
                                                        </div>
                                                        <div class="filter-report-item col-lg-3 form-group">
                                                            <label for="from">Từ</label>
                                                            <input class="form-control" type="datetime-local" id="form" name="timeFrom" value="${timeFrom}">
                                                        </div>
                                                        <div class="filter-report-item col-lg-3 form-group">
                                                            <label for="to">Đến</label>
                                                            <input class="form-control" type="datetime-local" id="to" name="timeTo" value="${timeTo}">
                                                        </div>
                                                        <button class="filter-report-item col-lg-3 btn btn-primary btn-filter" type="submit">Lọc</button>
                                                    </div>
                                                </form>
                                                <div class="table-responsive">
                                                    <table class="table table-hover">
                                                        <thead>
                                                            <th class="align-middle align-center">
                                                                Tên 
                                                            </th>
                                                            <th  class="align-middle">
                                                                Nội dung báo cáo
                                                            </th>
                                                            <th>
                                                                Loại báo cáo
                                                            </th>
                                                            <th  class="align-middle align-center">
                                                                Thời gian báo cáo
                                                            </th>
                                                            <th  class="align-middle align-center">
                                                                Id bài báo cáo
                                                            </th>
                                                            <th>
                                                                Thao tác
                                                            </th>
                                                        </thead>
                                                        <tbody>
                                                            <c:forEach items="${allReportsList}" var="r" begin="0"
                                                                end="${allReportsList.size()}" varStatus="loop">
                                                                <tr>
                                                                    <td>
                                                                        ${lstUserReported.get(i).getFullname()}
                                                                    </td>
                                                                    <td>
                                                                        ${r.getDescription()}
                                                                    </td>
                                                                    <td>
                                                                        ${r.getType()}
                                                                    </td>
                                                                    <td>
                                                                        ${r.getTime() }
                                                                    </td>
                                                                    <td>
                                                                        ${r.getObj_id()}
                                                                    </td>
                                                                    <td class="align-middle align-center">
                                                                        <a type="button" data-toggle="modal"
                                                                            data-target="#delete${r.getId()}"><i
                                                                                class="fa fa-trash"></i></a>
                                                                    </td>
                                                                    <!-- Delete Modal -->
                                                                    <div class="modal fade" id="delete${r.getId()}"
                                                                        role="dialog">
                                                                        <div class="modal-dialog" role="document">
                                                                            <div class="modal-content">
                                                                                <div class="modal-header">
                                                                                    <h5 class="modal-title"
                                                                                        id="exampleModalLabel">
                                                                                        Xóa báo cáo
                                                                                    </h5>
                                                                                </div>
                                                                                <div class="modal-body">
                                                                                    Xóa báo cáo khỏi cơ sở dữ liệu?
                                                                                </div>
                                                                                <div class="modal-footer">
                                                                                    <form
                                                                                        action="${pageContext.request.contextPath}/admin/delete-report"
                                                                                        method="post">
                                                                                        <input type="hidden"
                                                                                            name="reportId"
                                                                                            value="${r.getId()}" />
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
                        w3.addClass('#report', 'active-nav');
                        w3.addClass('#a3', 'color-white');
                    </script>
                    <jsp:include page="../common/footer.jsp" />
                    <jsp:include page="../modals/createModModal.jsp" />
                </body>

                </html>