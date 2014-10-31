<script type="text/javascript"><%@ include file="assets/createReviewModal.js" %> </script>

<!-- Modal -->
<div class="modal fade bs-example-modal-lg" id="reviewModal"
	tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
	aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content ">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">Post a review</h4>
			</div>
			<div class="modal-body">
				<div class="row">
					<div id="reviewError" style="display:none" class="alert alert-danger text-center"></div>
				</div>
				<div class="row">
					<div class="col-md-7">
						<div class="panel panel-primary">
							<div class="panel-heading">
								<h3 class="panel-title">Code</h3>
							</div>
							<div class="panel-body">
								<div class="myeditor" id="answerEditor" style="height: 450px;"></div>
							</div>

						</div>

					</div>
					<div class="col-md-5">
						<div>
							<input type="file" id="createReviewFile" class="" name="files" value="upload a file">
						</div>
						<br/>
						<div class="panel panel-primary">
							<div class="panel-heading">
								<h3 class="panel-title">Description</h3>
							</div>
							<div class="panel-body">
								<div class="required-field-block">
									<textarea id="postAnswerDescription"
										style="overflow: auto; resize: none" rows="10"
										class="form-control" placeholder="Message"></textarea>
								</div>
							</div>

						</div>


					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				<button id="postAnswerButton" type="button" class="btn btn-primary">Post</button>
			</div>
		</div>
	</div>
</div>