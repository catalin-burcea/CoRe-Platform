$(document).ready(function(){
    window.getGroupById = function(groupId, handleGroup){
        $.ajax({
            url: path+"/getGroupById",
            type: "GET",
            contentType: 'application/json; charset=utf-8',
            dataType: "json",
            data: "groupId="+groupId,
            success: function(group){
            	handleGroup(group);
            },
            error:function(msg,er,t){
            	log.error("Error getting group by id in editGroupModal" + er + t);
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
			url : path+"/updateGroup",
			method : "POST",
			data : {
				"groupName" : name,
				"groupId":groupId,
			},
			success : function(data) {
				window.location = "groups";
			},
			error : function(msg, er, t) {
				log.error("Error update group" + er + t);
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
	
	window.isValidGroup = function(name) {
		return !(name == '');
	}
    
});