	
	  window.getTopicById = function(topicId, handleTopic){
	        $.ajax({
	            url: path+"/getTopicById/"+topicId,
	            type: "GET",
	            contentType: 'application/json; charset=utf-8',
	            dataType: "json",
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
	    	var topicId = getRequestParameter("topicId");
	    	getTopicById(topicId, function(topic){
	    		$("#backButton").attr('href',projectPath+'/viewTopic/topic/'+topicId+'/group/'+topic["groupId"]);
	    	});
	    }
	    
	    
	    window.getReviewById = function(reviewId, handleReviewId){
	    	 $.ajax({
	             url: path+"/getReviewById",
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
	    	var topicId = getRequestParameter("topicId");
	    	var reviewId = getRequestParameter("reviewId");
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


	