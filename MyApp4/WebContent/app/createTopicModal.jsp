
<script>
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
<div class="modal fade bs-example-modal-lg" id="createTopicModal"
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
						<div id="topicError" style="display:none" class="alert alert-danger text-center"></div>
						<div class="input-group">
							<span class="input-group-addon">Title</span> <input id="createTopicTitle" type="text"
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
								<div class="myeditor" id="topicEditor" style="height: 450px;"></div>
							</div>

						</div>

					</div>
					<div class="col-md-5">
						<div>
							<input type="file" id="createTopicFile" class="form-control" name="files" value="upload a file">
						</div>
						<br/>
						<div class="panel panel-primary">
							<div class="panel-heading">
								<h3 class="panel-title">Language</h3>
							</div>
							<div class="panel-body">
								<select class="form-control" data-size="3" size="3" id="allTags">
								</select>
							</div>
						</div>

						<div class="panel panel-primary">
							<div class="panel-heading">
								<h3 class="panel-title">Description</h3>
							</div>
							<div class="panel-body">
								<div class="required-field-block">
									<textarea id="createTopicDescription"
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
				<button id="createTopicButton" type="button" class="btn btn-primary">Create</button>
			</div>
		</div>
	</div>
</div>
</form>
