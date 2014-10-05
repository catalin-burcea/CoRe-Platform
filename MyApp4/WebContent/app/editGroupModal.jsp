
<script>
$(document).ready(function(){
    window.getGroupById = function(groupId, handleGroup){
        $.ajax({
            url: path+"/app/getGroupById",
            type: "GET",
            contentType: 'application/json; charset=utf-8',
            dataType: "json",
            data: "groupId="+groupId,
            success: function(group){
            	handleGroup(group);
            },
            error:function(msg,er,t){
            	
            } 
        });
    }
    
    $("[name=openEditGroupModal]").click(function(){
    	$("#editGroupError").hide();
    	groupId =$(this).children().first().val();
    	getGroupById(groupId, function(data){
			$("#editGroupName").val(data["name"]);
		});
    });
    
    window.updateGroup = function(name, groupId){
		$.ajax({
			url : path+"/app/updateGroup",
			type : "POST",
			data : {
				"groupName" : name,
				"groupId":groupId,
			},
			success : function(data) {
				window.location = "groups";
			},
			error : function(msg, er, t) {
				//alert(msg + er + t);
			}
		});
	}
    
	$("#editGroupButton").click(function() {
		var groupName = $("#editGroupName").val();
		if(isValidGroup(groupName)==true){
			updateGroup(groupName, groupId);
			
		}else{
			$("#editGroupError").show().text("Title field must be filled!");
		}
		
	});
	
	window.isValidGroup = function(name){
		if(name == ''){
			return false;
		}
		return true;
	}
    
});

</script>

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
