<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!-- Create Mod Modal -->
<div class="modal fade" id="create-mod">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title">Tạo mod</h3>
            </div>
            <div class="modal-body">
                <form action="${pageContext.request.contextPath}/admin/create-mod" method="post">
                    <div class="form-group">
                        <label for="username">Tên đăng nhập</label>
                        <input class="form-control" id="username" required type="username" placeholder="Tên đăng nhập"
                            name="username">
                    </div>
                    <div class="form-group">
                        <label for="email">Email</label>
                        <input class="form-control" id="email" required type="email" placeholder="Nhập email của mod"
                            name="email">
                    </div>
                    <div class="form-group">
                        <label for="fullname">Họ Tên</label>
                        <input class="form-control" id="fullname" required type="name" placeholder="Nhập họ tên"
                            name="fullname">
                    </div>
                    <div class="form-group">
                        <label for="password">Mật khẩu</label>
                        <input class="form-control" id="password" required type="password" placeholder="Nhập mật khẩu"
                            minlength="8" name="password">
                    </div>
                    <div class="alert alert-danger d-none" id="alert" role="alert">
                        Mật khẩu không khớp
                    </div>
                    <div class="form-group">
                        <label for="confirm-password">Nhập lại mật khẩu</label>
                        <input class="form-control" id="confirm-password" required type="password" minlength="8"
                            placeholder="Nhập lại mật khẩu">
                    </div>
                    <button type="button" id="btnCreateMod" onclick="createMod()"
                        class="btn btn-primary text-xs-center">Tạo mod ngay!</button>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    function createMod() {
        const pass = document.getElementById('password').value;
        const rePass = document.getElementById('confirm-password').value;
        if (String(pass) === String(rePass)) {
            document.getElementById('btnCreateMod').type = 'submit';
        } else {
            let divAlert = document.getElementById('alert');
            divAlert.className = divAlert.className.replace(/\bd-none\b/g, "d-block");
        }
    }
</script>