    <script>
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
			if(description=='' || code==''){
				return false;
			}
			return true;
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
	
</script>

<!-- Modal -->
<div class="modal fade bs-example-modal-lg" id="reviewModal"
	tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
	aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content ">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">Post a review</h4>
			</div>
			<div class="modal-body">
				<div class="row">
					<div id="reviewError" style="display:none" class="alert alert-danger text-center"></div>
				</div>
				<div class="row">
					<div class="col-md-7">
						<div class="panel panel-primary">
							<div class="panel-heading">
								<h3 class="panel-title">Code</h3>
							</div>
							<div class="panel-body">
								<div class="myeditor" id="answerEditor" style="height: 450px;"></div>
							</div>

						</div>

					</div>
					<div class="col-md-5">
						<div>
							<input type="file" id="createReviewFile" class="" name="files" value="upload a file">
						</div>
						<br/>
						<div class="panel panel-primary">
							<div class="panel-heading">
								<h3 class="panel-title">Description</h3>
							</div>
							<div class="panel-body">
								<div class="required-field-block">
									<textarea id="postAnswerDescription"
										style="overflow: auto; resize: none" rows="10"
										class="form-control" placeholder="Message"></textarea>
								</div>
							</div>

						</div>


					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				<button id="postAnswerButton" type="button" class="btn btn-primary">Post</button>
			</div>
		</div>
	</div>
</div>