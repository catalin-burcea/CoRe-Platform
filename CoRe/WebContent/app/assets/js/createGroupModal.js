    $(document).ready(function () {
			var groupMembers=[];
        	window.getUsers = function (){
        		$.ajax({
        	        url: path+"/getUsers",
        	        type: "GET", 
                    dataType: "json",
        	        success: function(users){
        	        	users.forEach( function( item ) {
        	        		$("#allUsers").append("<option value='"+item.id+"'>"+item.username+"</option>");
        	        	});
        	        },
        	        error:function(msg,er,t) {
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
					url : path+"/createGroup",
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
        		return !(groupName == '' || groupMembers.length == 0);
        	}
        });