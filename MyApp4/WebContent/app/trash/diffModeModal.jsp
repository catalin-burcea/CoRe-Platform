	<style type="text/css">
		.compareContainer {
			position: absolute;
			top: 36px;
			bottom: 0;
			width: 99%;
			overflow-y: auto;
			margin-left:5px;
			border:1px solid #bebebe;
		}

	</style>

	<script src="http://requirejs.org/docs/release/2.1.4/minified/require.js"></script>
	<script>
	/*global require window */
	require(["http://eclipse.org/orion/compare/releases/3.0/built-compare.min.js"], function(Compare) {
	    var options = {
	        parentDivId: "compareParentDiv",
	        newFile: {
	        	Name: "left.js",
	            Content: ""
	        },
	        oldFile: {
	        	Name: "right.js",
	            Content: "var right = something;\nvar same = 123;\nvar right1 = bar\nvar right = something;\nvar same = 123;\nvar right1 = bar\n"
	        }
	    };
	    //Constructing the Compare widget instance starts the compare view automatically
		var compare = new Compare(options, "compareCommandHolder", "twoWay", true/*toggleable*/); //$NON-NLS-1$ //$NON-NLS-0$
	});
</script>

<!-- Modal -->
<div class="modal fade bs-example-modal-lg" id="diffModeModal"
	tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
	aria-hidden="true" >
	
	<div class="modal-dialog " style="width:85%">
		<div class="modal-content " >
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">Diff Mode</h4>
			</div>
			<div class="modal-body ">
				<div class="row">
				
					    <div style="height:500px; width:99%;">
							<span id="compareCommandHolder"></span>
					    </div>
					    <hr>
					    <div>
					        <div id="compareParentDiv" class="compareContainer" ></div>
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