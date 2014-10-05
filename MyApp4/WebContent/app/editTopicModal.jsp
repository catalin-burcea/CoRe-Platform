
<script>
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
	        error:function(msg,er,t){
	        	
	        	//alert(msg+er+t);
	        } 
	    });
	}
	
    window.getTopicById = function(topicId, handleTopic){
        $.ajax({
            url: path+"/app/getTopicById",
            type: "GET",
            contentType: 'application/json; charset=utf-8',
            dataType: "json",
            data: "topicId="+topicId,
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
		
		topicId =$(this).children().first().val();
		
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
				window.location = "topics"+groupParameter;
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
			var groupId = GetURLParameter("groupId");
			var groupParameter="";
			if(groupId!=null){
				groupParameter="?groupId="+groupId;
			}
	
			updateTopic(topicTitle, topicDescription, topicCode,language.id,
					groupId, groupParameter,topicId);
			
		}else{
			$("#editTopicError").show().text("Title, description and code fields must be filled!");
		}
		
	});
	
	window.isValidTopic = function(name, description, code){
		if(name == '' || description=='' || code==''){
			return false;
		}
		return true;
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
