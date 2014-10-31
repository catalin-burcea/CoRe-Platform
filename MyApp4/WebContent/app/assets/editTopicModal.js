$(document).ready(function(){

	var updateTopicEditor="";
	var topicId = null;
	$(function() {
		updateTopicEditor = ace.edit("updateTopicEditor");
		updateTopicEditor.getSession().setMode("ace/mode/java");
		updateTopicEditor.setTheme("ace/theme/monokai");
		updateTopicEditor.setOption("showInvisibles", true);
		//topicEditor.renderer.setShowGutter(false);
		//topicEditor.getSession().setMode('ace/mode/diff');
	});
	
	var language = {"id":null, "title":null};
	
	window.getTags = function (handleTags){
	
		$.ajax({
	        url: path+"/app/getTags",
	        type: "GET",  
            contentType: 'application/json; charset=utf-8',
            dataType: "json",
	        success: function(tags){
					handleTags(tags);
	        },
	        error:function(msg,er,t) {
	        	//alert(msg+er+t);
	        } 
	    });
	}
	
    window.getTopicById = function(topicId, handleTopic){
        $.ajax({
            url: path+"/app/getTopicById/"+topicId,
            type: "GET",
            contentType: 'application/json; charset=utf-8',
            dataType: "json",
            success: function(data){
            	handleTopic(data);
            },
            error:function(msg,er,t){
            	
            } 
        });
    }

	
	$("[name=openEditTopicModal]").click(function(){
		$("#editTopicError").hide();
		getTags(function(tags){
		
        	language.title = tags[0]["title"];
        	language.id = tags[0]["id"];
        	$("#editTags").text("");
        	tags.forEach( function( item ) {
        		$("#editTags").append("<option value='"+item.id+"'>"+item.title+"</option>");
        	});
		});
		
		topicId = $(this).children().first().val();
		getTopicById(topicId, function(data){
	
			updateTopicEditor.setValue(data["code"]);
			$("#editTopicTitle").val(data["title"]);
			$("#editTopicDescription").val(data["description"]);
			updateTopicEditor.getSession().setMode("ace/mode/"+data["language"]);
		});
	});
	
	$("#editTags").change(function(){
		language.title = $( "#editTags option:selected" ).text();
		language.id = $( "#editTags option:selected" ).val();
		updateTopicEditor.getSession().setMode("ace/mode/"+language.title);
	});
	
	window.updateTopic = function(title, description, code, tagId, groupId, groupParameter,topicId){
		$.ajax({
			url : path+"/app/updateTopic",
			type : "POST",
			data : {
				"topicTitle" : title,
				"topicDescription" : description,
				"topicCode":code,
				"tagId":tagId,
				"groupId":groupId,
				"topicId":topicId
			},
			success : function(data) {
				window.location = projectPath+"/topics"+groupParameter;
			},
			error : function(msg, er, t) {
				//alert(msg + er + t);
			}
		});
	}
	
	$("#editTopicButton").click(function() {
		var topicCode = updateTopicEditor.getValue();
		var topicDescription = $("#editTopicDescription").val();
		var topicTitle = $("#editTopicTitle").val();
		if(isValidTopic(topicTitle,topicDescription,topicCode)==true){
			
			var groupId = GetURLParameter("group");
			var groupParameter = groupId != null ? "/group/"+groupId : "";
			updateTopic(topicTitle, topicDescription, topicCode,language.id,groupId, groupParameter,topicId);
			
		}else{
			$("#editTopicError").show().text("Title, description and code fields must be filled!");
		}
		
	});
	
	window.isValidTopic = function(name, description, code){
		return !(name == '' || description=='' || code=='');
	}
	
	$("#editTopicFile").change(function(evt) {
	    var file = document.getElementById('editTopicFile').files[0];
	    if (file) {
	          getAsText(file,updateTopicEditor);
	    }else{
	    	////alert("file error");
	    }
	});

});