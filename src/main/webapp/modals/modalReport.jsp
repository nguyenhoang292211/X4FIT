<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Report</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<style type="text/css">
.modal-dialog {
    max-width: 50% !important;
}
</style>
</head>
<body>
	<div class="modal fade" id="modelReport" tabindex="-1" role="dialog"
		aria-labelledby="modelReportTitle" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLongTitle">Report</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					 <form action="${pageContext.request.contextPath}/report?p=${post.getUrl()}&type=POST" method="post">
					  <div class="form-group">
					    <label for="report">Mô tả</label>
					    <input type="text" class="form-control" id="report" name="report">
					    <small id="emailHelp" class="form-text text-muted">Mô tả chi tiết nội dung báo cáo.</small>
					  </div>
					  
					  <div align="center">
								<input type="hidden" name="report_postID" value="${postID}">
					  		<button type="submit" class="btn btn-primary">Submit</button>
							<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>