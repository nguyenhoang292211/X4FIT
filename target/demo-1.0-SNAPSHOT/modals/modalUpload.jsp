<style type="text/css">
.modal-dialog {
    max-width: 50% !important;
}
</style>
<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
	aria-labelledby="myModalTitle" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLongTitle">Images</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<jsp:include page="/upload.jsp" /> 
			</div>
			<hr>
			<div align="center">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>