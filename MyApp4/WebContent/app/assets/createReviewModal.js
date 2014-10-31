	var answerEditor;
	$(function() {
		answerEditor = ace.edit("answerEditor");
		answerEditor.setTheme("ace/theme/monokai");
		answerEditor.setOption("showInvisibles", true);
		//answerEditor.renderer.setShowGutter(false);
	});
	
	window.insertReview = function(code, description, topicId, groupParameter){
		$.ajax({
			url : path+"/app/insertReview",
			type : "POST",
			data : {
				"reviewCode" : code,
				"reviewDescription" : description,
				"topicId" : topicId
			},

			success : function(data) {
				window.location = projectPath+"/viewTopic/topic/" + topicId + groupParameter;
			},
			error : function(msg, er, t) {
				//alert(msg + er + t);
			}
		});
	}
	
	$(document).ready(function() {
		
    	$("#openCreateReviewModal").click(function(){
    		$("#reviewError").hide();
    	});
		
		$("#postAnswerButton").click(function() {
			var reviewCode = answerEditor.getValue();
			var reviewDescription = $("#postAnswerDescription").val();
			if(isValidReview(reviewDescription, reviewCode)==true){
				var topicId = GetURLParameter("topic");
				var groupId = GetURLParameter("group");		
				var groupParameter = "";
				if(groupId!=null){
					groupParameter = "/group/"+groupId;
				}
				insertReview(reviewCode, reviewDescription, topicId, groupParameter);
			}else{
				$("#reviewError").show().text("Description and code fields must be filled!");
			}
			
		});
		
		window.isValidReview = function(description, code){
			return !(description=='' || code=='');
		}
		
		$("#createReviewFile").change(function(evt) {
		    var file = document.getElementById('createReviewFile').files[0];
		    if (file) {
		          getAsText(file,answerEditor);
		    }else{
		    	//alert("file error");
		    }
		});

	});