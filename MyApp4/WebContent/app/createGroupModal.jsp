<script type="text/javascript">
<%@ include file="assets/bootstrap-select.js" %>
</script>
<style type="text/css">
<%@ include file="assets/bootstrap-select.css" %>
</style>

<script type="text/javascript">

        $(document).ready(function () {
			var groupMembers=[];
        	window.getUsers = function (){
        		$.ajax({
        	        url: path+"/app/getUsers",
        	        type: "GET", 
                    dataType: "json",
        	        success: function(users){
        	        	users.forEach( function( item ) {
        	        		$("#allUsers").append("<option value='"+item.id+"'>"+item.username+"</option>");
        	        	});
        	        },
        	        error:function(msg,er,t){
        	        	
        	        	//alert(msg+er+t);
        	        } 
        	    });
        	};
        	

        	$("#openCreateGroupModal").click(function(){
	        	$("#allUsers").text("");
	        	$("#selectedUsers").text("");
	        	$("#createGroupName").val("");
	        	$("#groupError").hide();
	        	groupMembers=[];
				getUsers();
        	});
        	
        	$("#allUsers").change(function(){
        		var memberId = $( "#allUsers option:selected" ).val();
        		var memberUsername = $( "#allUsers option:selected" ).text();
        		groupMembers.push({"memberId":memberId});
        		$("#allUsers option:selected").remove();
        		$("#selectedUsers").append('<li id="member'+memberId+'"><span class="label label-primary">'+memberUsername+'</span> <input type="hidden" value="'+memberId+'"></li>');

        	});
        	
        	window.createGroup = function(data){
        		
        		$.ajax({
					url : path+"/app/createGroup",
					type : "POST",
					contentType: 'application/json', 
					data: JSON.stringify(data) ,

					success : function(data) {
						window.location = "groups";
					},
					error : function(msg, er, t) {

						//alert(msg + er + t);
					}
				});
        	}
        	
        	$("#createGroupButton").click(function(){
        		var groupName = $("#createGroupName").val();
        		if(isValidGroup(groupName)==true){
            		var data = {"name":groupName,"memberIds":groupMembers};
            		createGroup(data);
        		}else{        			
        			$("#groupError").show().text("You must have a non-empty name and at least one group member!");
        		}
        	});
        	
        	window.isValidGroup = function(groupName){
        		if(groupName == '' || groupMembers.length==0){
        			return false;
        		}
        		return true;
        	}
        	
        });
        
        
</script>


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
