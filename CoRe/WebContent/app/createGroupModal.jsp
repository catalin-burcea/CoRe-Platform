<script type="text/javascript"><%@ include file="assets/js/bootstrap-select.js" %></script>
<style type="text/css"><%@ include file="assets/css/bootstrap-select.css" %></style>
<script type="text/javascript"><%@ include file="assets/js/createGroupModal.js" %> </script>


<!-- Create group modal -->
<form id="createGroupForm">
<div class="modal fade bs-example-modal-lg" id="createGroupModal"
	tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
	aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">Create a group</h4>
			</div>
			<div class="modal-body"  style="height:300px">
				<div class="row">
					<div class="col-md-12">
						<div id="groupError" style="display:none" class="alert alert-danger text-center"></div>
						<div class="input-group">
							<span class="input-group-addon">Name</span> <input id="createGroupName" type="text"
								class="form-control" required>
						</div>
					</div>
				</div>
				</br>
			<div class="row">
				<div class="col-md-6">
					  <h4><span class="label label-default">Add a member</span></h4>
					  <select id="allUsers"  title='Choose one of the following...' class="selectpicker form-control" data-live-search="true" data-size="4" data-style="btn-primary" size="4">
	
					  </select>
				  </div>
				  <div class="col-md-6">
				  	<h4><span class="label label-default">Members</span></h4>
				  	<ul id="selectedUsers"></ul>
				  </div>
			</div>

			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				<button id="createGroupButton" type="button" class="btn btn-primary">Create</button>
			</div>
		</div>
	</div>
</div>
</form>
