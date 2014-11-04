<script type="text/javascript"><%@ include file="assets/js/editTopicModal.js" %> </script>

<style>
#op{
  width:900px;
  height:600px;
  overflow:auto;
  background-color:rgba(221,214,221,0.3);
  border:1px dashed black;
}
</style>

<!-- Modal -->
<form>
<div class="modal fade bs-example-modal-lg" id="editTopicModal"
	tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
	aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content ">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">Update the topic</h4>
			</div>
			<div class="modal-body">
				<div class="row">
					<div class="col-md-12">
						<div id="editTopicError" style="display:none" class="alert alert-danger text-center"></div>
						<div class="input-group">
							<span class="input-group-addon">Title</span> <input id="editTopicTitle" type="text"
								class="form-control" required>
						</div>
					</div>
				</div>
				</br>
				<div class="row">
					<div class="col-md-7">
						<div class="panel panel-primary">
							<div class="panel-heading">
								<h3 class="panel-title">Code</h3>
							</div>
							<div class="panel-body">
								<div class="myeditor" id="updateTopicEditor" style="height: 450px;"></div>
							</div>

						</div>

					</div>
					<div class="col-md-5">
						<div>
							<input type="file" id="editTopicFile" class="form-control" name="files" value="upload a file">
						</div>
						<br/>
						<div class="panel panel-primary">
							<div class="panel-heading">
								<h3 class="panel-title">Language</h3>
							</div>
							<div class="panel-body">
								<select class="form-control" data-size="3" size="3" id="editTags">
								</select>
							</div>
						</div>

						<div class="panel panel-primary">
							<div class="panel-heading">
								<h3 class="panel-title">Description</h3>
							</div>
							<div class="panel-body">
								<div class="required-field-block">
									<textarea id="editTopicDescription"
										style="overflow: auto; resize: none" rows="10"
										class="form-control" placeholder="Describe your problem"></textarea>
								</div>
							</div>
						</div>
					</div>

				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				<button id="editTopicButton" type="button" class="btn btn-primary">Update</button>
			</div>
		</div>
	</div>
</div>
</form>
