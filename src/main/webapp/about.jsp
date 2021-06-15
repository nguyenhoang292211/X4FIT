<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>X4FIT</title>
  <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/logo.png"/>
	<link rel="icon" type="image/png" href="images/logo.png"/>
	<link rel="Stylesheet" href="styles/style.css" type="text/css" />
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" 
					integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" 
					crossorigin="anonymous">
	</script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" 
					integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" 
					crossorigin="anonymous"></script>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" 
				integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" 
				crossorigin="anonymous">
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" 
					integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" 
					crossorigin="anonymous">
	</script>
	<link href="https://fonts.googleapis.com/css2?family=Bungee+Shade&display=swap" rel="stylesheet">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/simplemde/latest/simplemde.min.css">
	<script src="https://cdn.jsdelivr.net/simplemde/latest/simplemde.min.js"></script>
	<script src="https://cdn.jsdelivr.net/highlight.js/latest/highlight.min.js"></script>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/highlight.js/latest/styles/github.min.css">
</head>
<body style="background-image: url('https://images.unsplash.com/photo-1557683304-673a23048d34?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=600&q=60'); background-size: cover; color: whitesmoke">
    <div class="container mt-3"> 
    		<h1 class="text-center" style="font-family: 'Bungee Shade', cursive; font-size:8vw">X4FIT</h1>
        <h2 class="text-center mt-5 mb-5">HỎI ĐÁP VỀ CÔNG NGHỆ VÀ LẬP TRÌNH DÀNH CHO SINH VIÊN</h2>
        <div>
        	<h3>1. Mô tả đề tài</h3>
        	<p>
        		Nhằm hướng tới một cộng đồng chia sẻ kinh nghiệm lập trình, nhất là cho sinh viên chuyên ngành công nghệ thông tin hoặc cho các sinh viên có đam mê và tìm hiểu công nghệ thông tin thì đề tài này mong muốn tạo ra một website đáp ứng các nhu hỏi đáp giúp giải đáp những thắc mắc cho sinh viên về lĩnh vực công nghệ lập trình.
        	</p>
        	<p>
        		Website này sẽ lưu trữ những bài viết thảo luận, những câu hỏi hay những câu trả lời được cộng đồng sinh viên giải đáp. Mỗi cá nhân khi truy cập vào trang web đều có thể tìm kiếm trực tiếp mà không cần tài khoản hoặc tạo tài để đưa lên những câu hỏi hoặc chia sẻ những kinh nghiệm về đề tài công nghệ.
        	</p>
        </div>
        
        <div>
        	<h3>2. Các đối tượng</h3>
        	<ul>
        		<li>
        		Đây là một website về hỏi đáp, nên website cần quản lý các user bao gồm: admin (người quản trị hệ thống) và user là thành viên của hệ thống, quản lý các bài đăng.
        		</li>
        		<li>
        		Mỗi user được cấp một ID riêng để phân biệt với các user khác, thông tin user bao gồm họ tên, ngày tháng năm sinh, giới tính,… và được cung cấp tài khoản đăng nhập vào hệ thống đã được phân quyền.
        		</li>
        		<li>
        		Mỗi bài đăng (post) chứa thêm các tác nhân: loại bài viết (tags), số lượng bình chọn (votes) và bình luận (các câu trả lời hoặc góp ý).
        		</li>
        		<li>
        		Bài đăng cũng được cấp một ID riêng, tiêu đề, nội dung, trạng thái, user viết bài đăng,… Đính kèm tags để dễ dàng phân loại bài viết, cập nhập số lượng bình chọn và bình luận.
        		</li>
        		<li>
        		Mỗi tags cũng có ID riêng và tên loại tags đó.
        		</li>
        	</ul>
        </div>
        <div class="feature">
            <h3>3. Chức năng</h3>
            <ol>
                <li>Đăng nhập</li>
                <p>
                	Chức năng đăng nhập còn thực hiện việc đăng ký tài khoản, lấy lại mật khẩu, ở chức năng này sẽ phân quyền người dùng khi vào hệ thống. Những người dùng khác không thực hiện thao tác đăng nhập vẫn có thể truy cập vào trang web để xem tìm kiếm các bài viết.
                </p>
                
                <li>Tạo, thêm, xóa, sửa bài viết</li>
                <p>
                	Chức năng này có hiệu lực khi người dùng đó đã có tài khoản cá nhân của website và người dùng là chủ của bài viết. 
                </p>
                
                <li>Xem bài viết</li>
                <p>
                	Chức năng này giúp cho người dùng xem nội dung các câu hỏi đã được đặt vấn đề trước đó.
                </p>
                
                <li>Bình luận</li>
                <p>
                	Đây là chức năng quan trọng, người dùng trả lời các thắc mắc tại các bài viết. 
                </p>
                
                <li>Chỉnh sửa thông tin cá nhân</li>
                <p>
                	Người dùng có quyền thêm sửa xóa thông tin cá nhân của chính tài khoản người dùng đó.
                </p>
                
                <li>Tìm kiếm</li>
                <p>
                	Đây cũng là một chức năng quan trọng, người dùng không cần có tài khoản cá nhân vẫn thực hiện được việc tìm kiếm theo từng chủ đề - được nhiều lượt bình chọn - theo câu hỏi,…
                </p>
                
                <li>Đánh dấu bài viết (bookmark)</li>
                <p>
                	Mục đích của chức năng này để lưu lại những bài viết mà người dùng yêu thích hoặc để tiếp tục tìm hiểu sau, điều kiện người dùng sử dụng tài khoản cá nhân.
                </p>
            </ol>
        </div>

        <div class="page">
            <h3>4. Giao diện và chức năng chuyên biệt từng trang</h3>
            <table class="table table-bordered">
                <thead class="thead-light">
                <tr>
                    <th scope="col">#</th>
                    <th scope="col">Trang</th>
                    <th scope="col">Các chức năng</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                	<th scope="row" rowspan="3" class="align-middle">1</th>
                  <td rowspan="3" class="align-middle">Login</td>
                	<td>
                 	<h5>Đăng nhập (user, admin)</h5>
                 	<p>Người dùng đăng nhập bằng username, password đã được đăng kí từ trước, hệ thống sẽ kiểm tra và nếu thành công thì đưa người dùng vào trang web trước đó, nếu sai một hai thông tin đưa ra, hệ thống sẽ báo lỗi và yêu cầu người dùng cung cấp lại thông tin. Ở phần đăng nhập có chức năng “remember me” để tự động điền password cho lần đăng nhập tiếp theo.</p>
                	</td>
                </tr>
                <tr>
                    <td>
                    	<h5>Tạo tài khoản</h5>
                    	<p>Hệ thống nhận các thông tin mà người dùng cung cấp để tạo một tài khoản và yêu cầu là mỗi gmail chỉ đăng ký một tài khoản duy nhất.</p>
                    </td>
                </tr>
                <tr>
                    <td>
                    	<h5>Quên mật khẩu</h5>
                    	<p>Hệ thống sẽ gửi một password mới về mail do người dùng cung cấp.</p>
                    </td>
                </tr>
                <tr>
                    <th scope="row" class="align-middle" rowspan="3">2</th>
                    <td rowspan="3" class="align-middle">Home</td>
                    <td>
                    	<h5>Xem danh sách bài viết</h5>
                    	<p>Hệ thống cho phép người dùng lọc xem các bài viết mới nhất, các bài viết nổi bật, xem được số lượng bình chọn, lượt xem, lượt bình chọn.</p>
                    </td>
                </tr>
                <tr>
                    <td>
                    	<h5>Tìm kiếm</h5>
                    	<p>Tìm kiếm người dùng, bài viết, chủ đề.</p>
                    </td>
                </tr>
                <tr>
                    <td>
                    	<h5>Lọc</h5>
                    	<p>Lọc bài viết theo thời gian, theo chủ đề, theo chủ bài viết, theo tags.</p>
                    </td>
                </tr>

                <tr>
                    <th scope="row" class="align-middle">3</th>
                    <td class="align-middle">Tạo bài viết</td>
                    <td>
                    	<h5>Tạo nội dung</h5>
                    	<p>Chức năng tạo bài viết thực hiện khi người dùng - đã có tài khoản cá nhân và mong muốn giải đáp một vấn đề nào đó hoặc muốn chia sẻ những kiến thức liên quan đến công nghệ thông tin.</p>
                    	<p>Hệ thống web cung cấp phần viết tên tiêu đề - đây là phần bắt buộc của bài viết. Dưới khung viết nội dung bài viết, người dùng có thể chèn hình ảnh và file đính kèm nếu có, định dạng font chữ, kiểu chữ, … Đặt quyền truy cập (public, private). Sau khi hoàn thành xong các thao tác viết bài, người dùng có quyền chỉnh sửa lại nội dung khi đã xuất bài viết.</p>
                    </td>
                </tr>

                <tr>
                    <th scope="row" class="align-middle" rowspan="4">4</th>
                    <td rowspan="4" class="align-middle">Chi tiết bài viết</td>
                    <td>
                    	<h5>Xem nội dung</h5>
                    	<p>Cho phép người dùng đọc toàn bộ nội dung bài viết.</p>
                    </td>
                </tr>
                <tr>
                    <td>
                    	<h5>Bình luận</h5>
                    	<p>Nếu người dùng đang xem bài viết của người khác và đang đăng nhập vào hệ thống thì người dùng có thể bình luận, tham gia vào thảo luận chủ đề của bài viết.</p>
                    	<p>Hệ thống sẽ hiển thị danh sách các bình luận gần nhất của bài viết, tên, số lượng bình chọn của người đã bình luận, có khung bình luận để người dùng dùng quyền viết, sau khi hoàn tất các thao tác viết, thêm ảnh,.. người dùng cập nhập bình luận của mình lên và tất nhiên người khác cũng có thể xem bình luận mà người dùng mới tạo.</p>
                    </td>
                </tr>
                <tr>
                    <td>
                    	<h5>Ghim bài viết (bookmark)</h5>
                    	<p>Khi muốn ghim lại bài viết, người dùng có thể dùng chức năng đặt bookmark. Lưu ý: tính năng này chỉ khả dụng khi người dùng đăng nhập, do đó, nếu là khách truy cập thì trang web sẽ yêu cầu người dùng đăng nhập vào.</p>
                    </td>
                </tr>
                <tr>
                    <td>
                    	<h5>Nút chỉnh sửa bài viết</h5>
                    	<p>Dành cho chủ của bài post có thể chỉnh sửa nội dung của bài.</p>
                    </td>
                </tr>

                <tr>
                    <th scope="row" class="align-middle" rowspan="2">5</th>
                    <td rowspan="2" class="align-middle">Chỉnh sửa bài viết</td>
                    <td>
                    	<h5>Chỉnh sửa nội dung và title</h5>
                    </td>
                </tr>
                <tr>
                    <td>
                    	<h5>Đặt lại quyền xem bài viết</h5>
                    </td>
                </tr>

                <tr>
                    <th scope="row" class="align-middle" rowspan="4">6</th>
                    <td rowspan="4" class="align-middle">Profile</td>
                    <td>Xem bài viết của mình</td>
                </tr>
                <tr>
                    <td>Thông tin cá nhân</td>
                </tr>
                <tr>
                    <td>Chỉnh sửa thông tin cá nhân</td>
                </tr>
                <tr>
                    <td>Cài đặt tài khoản và hiển thị trên trang web</td>
                </tr>

                <tr>
                    <th scope="row" class="align-middle">7</th>
                    <td>About</td>
                    <td>Thông tin về trang web</td>
                </tr>

                <tr>
                    <th scope="row" class="align-middle" rowspan="4">8</th>
                    <td rowspan="4" class="align-middle">Admin</td>
                    <td>Quản lý user (thêm, xóa)</td>
                </tr>
                <tr>
                    <td>Quản lý bài viết</td>
                </tr>
                <tr>
                    <td>Duyệt bài viết</td>
                </tr>
                <tr>
                    <td>Thống kê lượt xem theo tháng, số bài viết theo chủ đề (tags), số lượng thành viên</td>
                </tr>
                </tbody>
            </table>
        </div>

        <div class="phanviec">
            <h3>3. Phân công nhiệm vụ</h3>
            <h5 class="mt-3">a. Phân công theo trang</h5>
            <table class="table table-bordered">
                <thead class="thead-light">
                  <tr>
                    <th scope="col">#</th>
                    <th scope="col">Trang</th>
                    <th scope="col">Người đảm nhận</th>
                  </tr>
                </thead>
                <tbody>
                  <tr>
                    <th scope="row" class="align-middle">1</th>
                    <td>Admin, About</td>
                    <td>Cụi</td>
                  </tr>
                  <tr>
                    <th scope="row" class="align-middle">2</th>
                    <td>Login, Chi tiết bài viết</td>
                    <td>Yến</td>
                  </tr>
                  <tr>
                    <th scope="row" class="align-middle">3</th>
                    <td>Tạo bài viết, Chỉnh sửa bài viết</td>
                    <td>Tiến</td>
                  </tr>
                  <tr>
                    <th scope="row" class="align-middle">4</th>
                    <td>Profile, Home</td>
                    <td>Hoàng</td>
                  </tr>
                </tbody>
              </table>

              <h5 class="mt-3">b. Phân công theo công việc</h5>
              <table class="table table-bordered">
                <thead class="thead-light">
                  <tr>
                    <th scope="col">#</th>
                    <th scope="col">Công việc</th>
                    <th scope="col">Người đảm nhận</th>
                  </tr>
                </thead>
                <tbody>
                  <tr>
                    <th scope="row" class="align-middle">1</th>
                    <td>Thiết kế CSDL</td>
                    <td>Tiến, Cụi, Hoàng, Yến</td>
                  </tr>
                  <tr>
                    <th scope="row" class="align-middle">2</th>
                    <td>Tạo CSDL</td>
                    <td>Cụi, Tiến</td>
                  </tr>
                  <tr>
                    <th scope="row" class="align-middle">3</th>
                    <td>Nhập dữ liệu</td>
                    <td>Yến, Hoàng</td>
                  </tr>
                  <tr>
                    <th scope="row" class="align-middle">4</th>
                    <td>Vẽ mockup</td>
                    <td>Tiến, Cụi, Hoàng, Yến</td>
                  </tr>
                  <tr>
                    <th scope="row" class="align-middle">5</th>
                    <td>Tạo test case</td>
                    <td>Tiến, Cụi, Hoàng, Yến (mỗi người tạo theo trang mà mình đảm nhận)</td>
                  </tr>
                  <tr>
                    <th scope="row" class="align-middle">5</th>
                    <td>Testing</td>
                    <td>Tiến, Cụi, Hoàng, Yến (mỗi người tạo theo trang mà mình đảm nhận)</td>
                  </tr>
                  <tr>
                    <th scope="row" class="align-middle">6</th>
                    <td>Viết đặc tả</td>
                    <td>Yến</td>
                  </tr>
                  <tr>
                    <th scope="row" class="align-middle">7</th>
                    <td>Tạo powerpoint báo cáo</td>
                    <td>Hoàng</td>
                  </tr>
                </tbody>
              </table> 
        </div>
    </div>
</body>
</html>