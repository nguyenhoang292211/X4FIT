<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!-- Add category Modal -->
<div class="modal fade" id="add-category">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title">Thêm thể loại</h3>
            </div>
            <div class="modal-body">
                <form action="${pageContext.request.contextPath}/mod/add-category" method="post">
                    <div class="form-group">
                        <label for="category-name">Tên thể loại</label>
                        <input type="text" class="form-control" id="category-name" required
                            placeholder="Enter Category Name" name="category-name">
                    </div>
                    <div class="form-group">
                        <label for="description">Mô tả</label>
                        <textarea class="form-control" id="description" rows="3" required placeholder="Description here"
                            name="description"></textarea>
                    </div>
                    <button type="submit" class="btn btn-primary text-xs-center" style="width: 100%;">Thêm ngay!</button>
                </form>
            </div>
        </div>
    </div>
</div>