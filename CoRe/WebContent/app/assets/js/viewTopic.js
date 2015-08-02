    
    //-----init------------------------
    
    var editor1;
    var editor2;
    var Reviews=null;
    var next=-1;
    var language=null;

    $(function() {
        editor1 = ace.edit("editor1");
        editor1.setTheme("ace/theme/monokai");  
        editor1.setOption("showInvisibles", true);
      //  editor1.renderer.setShowGutter(false); 
        editor1.setReadOnly(true);  
       // editor1.getSession().setMode('ace/mode/diff');
        editor2 = ace.edit("editor2");
        editor2.setTheme("ace/theme/monokai");  
        editor2.setReadOnly(true); 
       // editor2.renderer.setShowGutter(false); 
        //editor2.getSession().setMode('ace/mode/diff');
    });
    
    
    $(function(){		 
		var topicId=GetURLParameter("topic");
        getTopicById(topicId);
        getTopicComments(topicId);
    });
    
    window.setSearchParameters = function(){
    	var topicId = GetURLParameter("topic");
    	if(Reviews.length>0){
    		var reviewId = Reviews[next];
        	var diffModeURL = projectPath+"/diffMode?topicId="+topicId+"&reviewId="+reviewId;
        	$("#diffModeURL").attr('href',diffModeURL);
    	}
    }
    
    window.getTopicById = function(topicId){
        $.ajax({
            url: path+"/getTopicById/"+topicId,
            type: "GET",
            contentType: 'application/json; charset=utf-8',
            dataType: "json",
            success: function(data){
            	Reviews = data["ids"].replace('[','').replace(']','').split(",").map(Number);
            	language = data["language"];
                editor1.getSession().setMode("ace/mode/"+language);
                editor2.getSession().setMode("ace/mode/"+language);
                answerEditor.getSession().setMode("ace/mode/"+language);
                editor1.setValue(data["code"]);
                editor1.clearSelection();
                $("#topicTitle").text(data["title"]);
                $("#OwnerDescription").text(data["description"]);
                $("#topicUser").text(data["username"]);
                $("#topicDate").text(data["date"]);
                $("#topicTag").text(data["language"]);
                setReview();
            },
            error:function(msg,er,t){
            	$("#errorMessage").show();
              	$("#errorMessage h1 strong").text("No topics were found!");
              	$(".removeAll").text("");
            } 
        });
    }
    
    window.getTopicComments = function(topicId){
    	
    	$.ajax({
            url: path+"/getTopicComments",
            type: "GET",
            contentType: 'application/json; charset=utf-8',
            dataType: "json",
            data: "topicId="+topicId,
            success: function(comments){
            	getAdmin(function(admin, groupAdmin){
            		var topicId=GetURLParameter("topic");
            		var groupId=GetURLParameter("group");
            		comments.forEach( function( item ) {
                    	var trash="";
                		if((admin != null && admin!='')||(groupAdmin!=null && groupAdmin!='')){

                			trash='<form  role="form" method="POST" action="'+projectPath+'/deleteComment">'	
        						+'<button type="submit" class="btn btn-danger glyphicon glyphicon-trash pull-right" ></button>'					
        						+'<input type="hidden" name="commentId" value="'+item.id+'">'
        						+'<input type="hidden" name="topicId" value="'+topicId+'">'
        						+'<input type="hidden" name="groupId" value="'+groupId+'">'
        						+'</form>';
                		}

    	        		var comment='<div class="message-item" id="m1">'
    	                	+'<div class="message-inner">'
    	    				 +'<div class="message-head clearfix">'
    	    					+'<div class="avatar1 pull-left"><a href="#"><img src="https://ssl.gstatic.com/accounts/ui/avatar_2x.png"></a></div>'
    	    					+'<div class="user-detail">'
    	    						+trash
    	    						+'<h5 class="handle">'+item.name+'</h5>'
    	    						+'<div class="post-meta">'
    	    							+'<div class="asker-meta">'
    	    								+'<span class="qa-message-what"></span>'
    	    								+'<span class="qa-message-when">'
    	    									+'<span class="qa-message-when-data">'+item.date+' </span>'
    	    								+'</span> '
    	    								+' <span class="qa-message-who">'
    	    									+'<span class="qa-message-who-pad">by </span>'
    	    									+'<span class="qa-message-who-data"><a href="">'+item.username+'</a></span>'
    	    								+'</span>'
    	    							+'</div>'
    	    						+'</div>'
    	    					+'</div>'
    	    				+'</div>'
    	    				+'<div class="qa-message-content">'+item.content
    	    			+'</div></div></div>';
    	        		$("#wallmessages[name='topicWallMessages']").append(comment);
    	        	});
            	});
            },
            error:function(msg,er,t){
				//alert(msg+"   "+er+"  "+t);
            } 
        });
    }
    
	window.getAdmin = function(handleAdmin){
		var groupId = GetURLParameter("group");
    	$.ajax({
            url: path+"/getAdmin",
            type: "GET",
            contentType: 'application/json; charset=utf-8',
            dataType: "json",
           	data:"groupId="+groupId,
            success: function(data){
            	handleAdmin(data["admin"], data["groupAdmin"]);
            },
            error:function(msg,er,t){
				//alert(msg+"   "+er+"  "+t);
            } 
        });
    }
    

    window.getReviewComments = function(){
    	var reviewId=Reviews[next];
    	$.ajax({
            url: path+"/getReviewComments",
            type: "GET",
            contentType: 'application/json; charset=utf-8',
            dataType: "json",
            data: "reviewId="+reviewId,
            success: function(comments){
            	$("#wallmessages[name='reviewWallMessages']").text("");
            	getAdmin(function(admin, groupAdmin){
            		var topicId=GetURLParameter("topic");
            		var groupId=GetURLParameter("group");
            		comments.forEach( function( item ) {
                    	var trash="";
                		if((admin != null && admin!='')||(groupAdmin!=null && groupAdmin!='')){
                			trash='<form  role="form" method="POST" action="'+projectPath+'/deleteComment">'	
        						+'<button type="submit" class="btn btn-danger glyphicon glyphicon-trash pull-right" ></button>'					
        						+'<input type="hidden" name="commentId" value="'+item.id+'">'
        						+'<input type="hidden" name="topicId" value="'+topicId+'">'
        						+'<input type="hidden" name="groupId" value="'+groupId+'">'
        						+'</form>';
                		}

    	        		var comment='<div class="message-item" id="m1">'
    	                	+'<div class="message-inner">'
    	    				 +'<div class="message-head clearfix">'
    	    					+'<div class="avatar1 pull-left"><a href="#"><img src="https://ssl.gstatic.com/accounts/ui/avatar_2x.png"></a></div>'
    	    					+'<div class="user-detail">'
	    							+trash
    	    						+'<h5 class="handle">'+item.name+'</h5>'
    	    						+'<div class="post-meta">'
    	    							+'<div class="asker-meta">'
    	    								+'<span class="qa-message-what"></span>'
    	    								+'<span class="qa-message-when">'
    	    									+'<span class="qa-message-when-data">'+item.date+' </span>'
    	    								+'</span>'
    	    								+'<span class="qa-message-who">'
    	    									+'<span class="qa-message-who-pad">by </span>'
    	    									+'<span class="qa-message-who-data"><a href="#">'+item.username+'</a></span>'
    	    								+'</span>'
    	    							+'</div>'
    	    						+'</div>'
    	    					+'</div>'
    	    				+'</div>'
    	    				+'<div class="qa-message-content">'+item.content
    	    			+'</div></div></div>';
    	        		$("#wallmessages[name='reviewWallMessages']").append(comment);
    	        	});
            	});
            },
            error:function(msg,er,t){
				//alert(msg+"   "+er+"  "+t);
            } 
        });
    }
    
    window.setReview = function() {
		if(Reviews==null || Reviews.length==0 ||Reviews==0){
        	$(".removeReply").text("");
        	$('#errorDiv').html("<div class='alert alert-danger text-center' id='errorMessageReply'><h1><strong></strong></h1></div>");
           	$("#errorMessageReply h1 strong").text("No reviews yet!");
          
		}else{
			getReview(function(data){	
				getAdmin(function(admin, groupAdmin){
            		if((admin != null && admin!='')||(groupAdmin!=null && groupAdmin!='')){

						var topicId=GetURLParameter("topic");
						var groupId=GetURLParameter("group");
						$("#deleteReviewForm").show();
						$("[name=reviewId]").val(data["id"]);
						$("[name=topicId]").val(topicId);
						$("[name=groupId]").val(groupId);
					}
				});
                editor2.setValue(data["code"]);
                editor2.clearSelection();
                $("#ReplyDescription").text(data["description"]);
                $("#reviewUser").text(data["username"]);
                $("#reviewDate").text(data["date"]);
                setSearchParameters();

			});
			checkRating();
            getReviewStars(function(stars){
	    		$("#reviewStars").text(stars+"/5");
	    	});
			getReviewComments();
			setSearchParameters();
			
		}   
    };
    
    //-----end of init-------------------------
    
    window.isLoggedIn = function(handleIsLoggedIn){
    	 $.ajax({
             url: path+"/isLoggedIn",
             type: "GET",
             success: function(isLoggedIn){
				handleIsLoggedIn(isLoggedIn);
             },
             error:function(msg,er,t){
				//alert(msg+er+t+" isloggedin error");
             } 
         });
    }
    
    window.checkRating = function(){
   		 isLoggedIn(function(logged){
      		if(logged=="true"){
      			getUserReviewStars(Reviews[next],function(rating){
      				
      				if(rating == 0){
      					$("#stars").show();
    	    	   		$("#rating").hide();

      				}else{
      					$("#stars").hide();
    	    	   		$('#count').html(rating);
    	    	   		$("#rating").show();
      				}
      			});	
     		}else{
     			$("#rateError").show();	
     			$("#rateError").text("You must be logged in to rate a review!");	
     		}
   		 });
    }
    
    window.getReviewStars = function(handleReviewStars){
	   	 	$.ajax({
	            url: path+"/getReviewStars",
	            type: "GET",
	            data: "reviewId="+Reviews[next],
	            contentType: 'application/json; charset=utf-8',
	            success: function(data){
	         	  	handleReviewStars(data);
	            },
	            error:function(msg,er,t){
						
	            } 
	        });
   }
    
    window.setNextReviewIt = function(){
    	if((next+1)>=Reviews.length){
    		next=0;
    	}else{
    		next++;
    	}
    	$("#Review").text(next+1);
    }
   
    
    window.getReview = function(handleReview){
      	 setNextReviewIt();
    	 $.ajax({
             url: path+"/getReviewById",
             type: "GET",
             data: "reviewId="+Reviews[next],
             dataType: "json",
             success: function(data){
            	 handleReview(data);
             },
             error:function(msg,er,t){
					
             } 
         });
    }
    
      $(document).ready(function() {
		    $("#next").click(function(){
		    	
				getReview(function(data){
					var topicId=GetURLParameter("topic");
					var groupId=GetURLParameter("group");
					$("[name=reviewId]").val(data["id"]);
					$("[name=topicId]").val(topicId);
					$("[name=groupId]").val(groupId);
	                editor2.setValue(data["code"]);
	                editor2.clearSelection();
	                $("#ReplyDescription").text(data["description"]);
	                $("#reviewUser").text(data["username"]);
	                $("#reviewDate").text(data["date"]);
	                setSearchParameters();
				});
                getReviewStars(function(stars){
                	$("#reviewStars").text(stars+"/5");;
		    	});
				checkRating();
		    	getReviewComments();
		    });
		    
		    $("#postTopicComment").click(function(){
		    	isLoggedIn(function(logged){
					if(logged=="true"){
						var postTopicComment = $("#topicComment").val();
				    	var topicId=GetURLParameter("topic");
				    	var groupId=GetURLParameter("group");
				    	var groupParameter = "";
				    	if(groupId!=null){
				    		groupParameter="/group/"+groupId;
				    	}
				    	$.ajax({
							url : path+"/insertTopicComment",
							type : "POST",
							data : {
								"postTopicComment" : postTopicComment,
								"topicId" : topicId
							},
							success : function(data) {
								window.location = projectPath+"/viewTopic/topic/" + topicId+groupParameter;
							},
							error : function(msg, er, t) {
								//alert(msg + er + t);
							}
						});
					}else{
						$("#postTopicCommentError").show();
						$("#postTopicCommentError h1").text("You must be logged in to leave a comment!");
					}
		    		
		    	});		    	
		    });
		    
		    $("#postReviewComment").click(function(){
		    	isLoggedIn(function(logged){
					if(logged=="true"){
				    	var postReviewComment = $("#reviewComment").val();
				    	var reviewId=Reviews[next];
				    	var topicId=GetURLParameter("topic");
				    	var groupId=GetURLParameter("group");
				    	var groupParameter = "";
				    	if(groupId!=null){
				    		groupParameter="/group/"+groupId;
				    	}
				    	$.ajax({
							url : path+"/insertReviewComment",
							type : "POST",
							data : {
								"postReviewComment" : postReviewComment,
								"reviewId" : reviewId
							},
							success : function(data) {
								window.location = projectPath+"/viewTopic/topic/" + topicId+groupParameter;
							},
							error : function(msg, er, t) {
								//alert(msg + er + t);
							}
						});
					}else{
						$("#postReviewCommentError").show();
						$("#postReviewCommentError h1").text("You must be logged in to leave a comment!");
					}
				});
		    });
      });
    

    $( document ).ready(function() {

    	  $('#stars').on('starrr:change', function(e, value) {
    		  	if(value != null){
			    	addStars(value,function() {
				    	checkRating();
				    	getReviewStars(function(stars){
				    		$("#reviewStars").text(stars+"/5");
				    	});
			    	});
    		  	}
    	  });
    	  
    	  window.getUserReviewStars = function(reviewId, handle){

    		 	$.ajax({
    	            url: path+"/getUserReviewStars",
    	            type: "GET",
    	            contentType: 'application/json; charset=utf-8',
    	            data: "reviewId="+reviewId,
    	            success: function(data){
    	            	handle(data);	
    	            },
    	            error:function(msg,er,t){
    					//alert(msg+"   "+er+"  "+t+" getUserReviewStars error");
    	            } 
    	        });
    	  };
    	  
    	  window.addStars = function(numberOfStars, handleAddStars){
    		  var reviewId = Reviews[next];
    		  $.ajax({
					url : path+"/addStars",
					type : "POST",
					data : {
						"numberOfStars" : numberOfStars,
						"reviewId":reviewId
					},
					success : function(data) {
						handleAddStars();
					},
					error : function(msg, er, t) {
						//alert(msg + er + t+"insert vote error");
					}
				});
    	  }
    });
    
    //--------arrow--------------------------------
    $(document).ready(function(){
    	
       	   $(window).scroll(function () {
               if ($(this).scrollTop() > 50) {
                   $('#back-to-top').fadeIn();
               } else {
                   $('#back-to-top').fadeOut();
               }
           });
           $('#back-to-top').click(function () {
               $('#back-to-top').tooltip('hide');
               $('body,html').animate({
                   scrollTop: 0
               }, 800);
               return false;
           });
   });