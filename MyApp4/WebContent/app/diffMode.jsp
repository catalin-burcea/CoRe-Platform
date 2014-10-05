<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Diff Mode</title>

<link rel="stylesheet" type="text/css" href="http://eclipse.org/orion/compare/releases/3.0/built-compare.css"/>

<%@ include file="head.jsp"%>
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
	
	  window.getTopicById = function(topicId, handleTopic){
	        $.ajax({
	            url: path+"/app/getTopicById",
	            type: "GET",
	            contentType: 'application/json; charset=utf-8',
	            dataType: "json",
	            data: "topicId="+topicId,
	            success: function(topic){
	            	handleTopic(topic);
	            },
	            error:function(msg,er,t){
	            	//$("#errorMessage").show();
	              	//$("#errorMessage h1 strong").text("No topic was found!");
	              	//$(".removeAll").text("");
	            } 
	        });
	    }
	    
	    window.setBackButtonURL = function(){
	    	var topicId = GetURLParameter("topicId");
	    	getTopicById(topicId, function(topic){
	    		$("#backButton").attr('href','viewTopic?topicId='+topicId+'&groupId='+topic["groupId"]);
	    	});
	    }
	    
	    
	    window.getReviewById = function(reviewId, handleReviewId){
	    	 $.ajax({
	             url: path+"/app/getReviewById",
	             type: "GET",
	             data: "reviewId="+reviewId,
	             contentType: 'application/json; charset=utf-8',
	             dataType: "json",
	             success: function(data){
	                 handleReviewId(data["code"]);
	             },
	             error:function(msg,er,t){
						 	
	             } 
	         });
	    }
	    
		window.compareFiles = function(topicCode, reviewCode){
			
			require(["http://eclipse.org/orion/compare/releases/3.0/built-compare.min.js"], function(Compare) {
			    var options = {
			        parentDivId: "compareParentDiv",
			        newFile: {
			        	Name: "left.js",
			            Content: topicCode
			        },
			        oldFile: {
			        	Name: "right.js",
			            Content: reviewCode
			        }
			    };
			    //Constructing the Compare widget instance starts the compare view automatically
				var compare = new Compare(options, "compareCommandHolder", "twoWay", true/*toggleable*/); //$NON-NLS-1$ //$NON-NLS-0$
			});
		}
	    
	    $(document).ready(function(){
	    	var topicId = GetURLParameter("topicId");
	    	var reviewId = GetURLParameter("reviewId");
	    	var topicCode = null;
	    	var reviewCode = null;
	    	setBackButtonURL();
	    	getTopicById(topicId,function(topic){
	    		topicCode = topic["code"];
		    	getReviewById(reviewId,function(rc){
		    		reviewCode = rc;
		    		compareFiles(topicCode, reviewCode);
		    	});
	    	});
	
	    });


	
</script>


</head>
<body>
	<%@ include file="header.jsp"%>
	<div class="my-container">
		<div class="row">
			<div class="col-md-12 pull-left">
				<a href="" id="backButton"><button class="btn btn-primary">
						Back
				</button></a>
			</div>
		</div>

		<div class="row">
		  <div style="display:none">
				<span id="compareCommandHolder"></span>
		  </div>
			 <hr>
			 <div>
				<div id="compareParentDiv" class="compareContainer" ></div>
			 </div>		
		</div>
	</div>

</body>
</html>