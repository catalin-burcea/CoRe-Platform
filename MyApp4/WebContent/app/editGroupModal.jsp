<script type="text/javascript"><%@ include file="assets/editGroupModal.js" %> </script>

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
<div class="modal fade bs-example-modal-lg" id="editGroupModal"
	tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
	aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content ">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">Edit</h4>
			</div>
			<div class="modal-body">
				<div class="row">
					<div class="col-md-12">
						<div id="editGroupError" style="display:none" class="alert alert-danger text-center"></div>
						<div class="input-group">
							<span class="input-group-addon">Name</span> <input id="editGroupName" type="text"
								class="form-control" required>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				<button id="editGroupButton" type="button" class="btn btn-primary">Update</button>
			</div>
		</div>
	</div>
</div>
</form>
