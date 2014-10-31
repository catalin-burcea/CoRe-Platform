$(document).ready(function(){

	var topicEditor="";
	$(function() {
		topicEditor = ace.edit("topicEditor");
		topicEditor.getSession().setMode("ace/mode/java");
		topicEditor.setTheme("ace/theme/monokai");
		topicEditor.setOption("showInvisibles", true);
		//topicEditor.renderer.setShowGutter(false);
		//topicEditor.getSession().setMode('ace/mode/diff');
	});
	
	var language = {"id":null, "title":null};
	
	
	$("#openCreateTopicModal").click(function(){
		$("#topicError").hide();
		getTags(function(tags){
        	language.title = tags[0]["title"];
        	language.id = tags[0]["id"];
        	$("#allTags").text("");
        	tags.forEach( function( item ) {
        		$("#allTags").append("<option value='"+item.id+"'>"+item.title+"</option>");
        	});
		});
		
	});
	
	$("#allTags").change(function(){
		language.title = $( "#allTags option:selected" ).text();
		language.id = $( "#allTags option:selected" ).val();
		topicEditor.getSession().setMode("ace/mode/"+language.title);
	});

	window.insertTopic = function(title, description, code, tagId, groupId,groupParameter){
		$.ajax({
			url : path+"/app/insertTopic",
			type : "POST",
			data : {
				"createTopicTitle" : title,
				"createTopicDescription" : description,
				"createTopicCode":code,
				"tagId":tagId,
				"groupId":groupId
			},
			success : function(data) {
				window.location = projectPath+"/topics"+groupParameter;
			},
			error : function(msg, er, t) {
				//alert(msg + er + t);
			}
		});
	}
	

	
	$("#createTopicButton").click(function() {
		var createTopicCode = topicEditor.getValue();
		var createTopicDescription = $("#createTopicDescription").val();
		var createTopicTitle = $("#createTopicTitle").val();
		if(isValidTopic(createTopicTitle,createTopicDescription,createTopicCode)==true){
			var groupId = GetURLParameter("group");
			var groupParameter="";
			if(groupId!=null){
				groupParameter="/group/"+groupId;
			}
			insertTopic(createTopicTitle,createTopicDescription,createTopicCode,language.id,
					groupId, groupParameter);
		}else{
			$("#topicError").show().text("Title, description and code fields must be filled!");
		}
		
	});
	
	window.isValidTopic = function(name, description, code){
		return !(name == '' || description=='' || code=='');
	}
	
	//--------------file upload..................

	$("#createTopicFile").change(function(evt) {
		
	    var file = document.getElementById('createTopicFile').files[0];
	    if (file) {
	          getAsText(file,topicEditor);
	    }else{
	    	////alert("file error");
	    }
	});
});