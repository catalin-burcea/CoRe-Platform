<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>view topic</title>
<!-- <link rel="stylesheet" type="text/css" href="http://eclipse.org/orion/compare/releases/3.0/built-compare.css"/>
 -->
<%@ include file="../head.jsp"%>
	<script type="../text/javascript">
<%@ include file="../assets/stars.js" %>
</script>
    
 <script>
    
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
        editor1.renderer.setShowGutter(false); 
        editor1.setReadOnly(true);  
       // editor1.getSession().setMode('ace/mode/diff');
        editor2 = ace.edit("editor2");
        editor2.setTheme("ace/theme/monokai");  
        editor2.setReadOnly(true); 
        editor2.renderer.setShowGutter(false); 
        //editor2.getSession().setMode('ace/mode/diff');
    });
    
    
    $(function(){		 
		var topicId=GetURLParameter("topicId");
        getTopicById(topicId);
        getTopicComments(topicId);
    });
    
    window.setSearchParameters = function(){
    	var topicId = GetURLParameter("topicId");
    	var groupId = GetURLParameter("groupId");
    	if(Reviews.length>0){
    		var reviewId = Reviews[next];
        	var diffModeURL = "diffMode.jsp?topicId="+topicId+"&reviewId="+reviewId;
        	$("#diffModeURL").attr('href',diffModeURL);
    	}
    }
    
    window.getTopicById = function(topicId){
        $.ajax({
            url: path+"/app/getTopicById",
            type: "GET",
            contentType: 'application/json; charset=utf-8',
            dataType: "json",
            data: "topicId="+topicId,
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
                checkReviews();
            },
            error:function(msg,er,t){
            	$("#errorMessage").show();
              	$("#errorMessage h1 strong").text("No topic was found!");
              	$(".removeAll").text("");
            } 
        });
    }
    
    window.getTopicComments = function(topicId){
    	
    	$.ajax({
            url: path+"/app/getTopicComments",
            type: "GET",
            contentType: 'application/json; charset=utf-8',
            dataType: "json",
            data: "topicId="+topicId,
            success: function(comments){
	        	comments.forEach( function( item ) {
	        		var comment='<div class="message-item" id="m1">'
	                	+'<div class="message-inner">'
	    				 +'<div class="message-head clearfix">'
	    					+'<div class="avatar1 pull-left"><a href="./index.php?qa=user&qa_1=admin"><img src="https://ssl.gstatic.com/accounts/ui/avatar_2x.png"></a></div>'
	    					+'<div class="user-detail">'
	    						+'<h5 class="handle">'+item.name+'</h5>'
	    						+'<div class="post-meta">'
	    							+'<div class="asker-meta">'
	    								+'<span class="qa-message-what"></span>'
	    								+'<span class="qa-message-when">'
	    									+'<span class="qa-message-when-data">'+item.date+' </span>'
	    								+'</span>'
	    								+'<span class="qa-message-who">'
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
	        	
            },
            error:function(msg,er,t){
				alert(msg+"   "+er+"  "+t);
            } 
        });
    }
    

    window.getReviewComments = function(){
    	var reviewId=Reviews[next];
    	$.ajax({
            url: path+"/app/getReviewComments",
            type: "GET",
            contentType: 'application/json; charset=utf-8',
            dataType: "json",
            data: "reviewId="+reviewId,
            success: function(comments){
            	$("#wallmessages[name='reviewWallMessages']").text("");
	        	comments.forEach( function( item ) {
	        		var comment='<div class="message-item" id="m1">'
	                	+'<div class="message-inner">'
	    				 +'<div class="message-head clearfix">'
	    					+'<div class="avatar1 pull-left"><a href="./index.php?qa=user&qa_1=admin"><img src="https://ssl.gstatic.com/accounts/ui/avatar_2x.png"></a></div>'
	    					+'<div class="user-detail">'
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
	        	
            },
            error:function(msg,er,t){
				alert(msg+"   "+er+"  "+t);
            } 
        });
    }
    
    window.checkReviews = function() {
		if(Reviews==null || Reviews.length==0 ||Reviews==0){
        	$(".removeReply").text("");
        	$('#errorDiv').html("<div class='alert alert-danger' id='errorMessageReply'><h1><strong></strong></h1></div>");
           	$("#errorMessageReply h1 strong").text("No reviews yet!");
          
		}else{
			getReview(function(data){
                editor2.setValue(data["code"]);
                editor2.clearSelection();
                $("#ReplyDescription").text(data["description"]);
                $("reviewUser").text(data["username"]);
                $("reviewDate").text(data["date"]);
                setSearchParameters();

			});
			checkRating();
            getReviewStars(function(stars){
	    		$("#reviewStars").text(stars);
	    	});
			getReviewComments();
			setSearchParameters();
			
		}   
    };
    
    //-----end of init-------------------------
    
    window.isLoggedIn = function(handleIsLoggedIn){
    	 $.ajax({
             url: path+"/app/isLoggedIn",
             type: "GET",
             success: function(isLoggedIn){
				handleIsLoggedIn(isLoggedIn);
             },
             error:function(msg,er,t){
				alert(msg+er+t+" isloggedin error");
             } 
         });
    }
    
    window.checkRating = function(){
   		 isLoggedIn(function(logged){
      		if(logged=="true"){
      			isRated(Reviews[next],function(rating){
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
	            url: path+"/app/getReviewStars",
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
             url: path+"/app/getReviewById",
             type: "GET",
             data: "reviewId="+Reviews[next],
             contentType: 'application/json; charset=utf-8',
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
	                editor2.setValue(data["code"]);
	                editor2.clearSelection();
	                $("#ReplyDescription").text(data["description"]);
	                $("reviewUser").text(data["username"]);
	                $("reviewDate").text(data["date"]);
	                setSearchParameters();
				});
                getReviewStars(function(stars){
		    		$("#reviewStars").text(stars);
		    	});
				checkRating();
		    	getReviewComments();
		    });
		    
		    $("#postTopicComment").click(function(){
		    	isLoggedIn(function(logged){
					if(logged=="true"){
						var postTopicComment = $("#topicComment").val();
				    	var topicId=GetURLParameter("topicId");
				    	$.ajax({
							url : path+"/app/insertTopicComment",
							type : "POST",
							data : {
								"postTopicComment" : postTopicComment,
								"topicId" : topicId
							},

							success : function(data) {
								window.location = "viewTopic.jsp?topicId=" + topicId;
							},
							error : function(msg, er, t) {

								alert(msg + er + t);
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
				    	var topicId=GetURLParameter("topicId");
				    	$.ajax({
							url : path+"/app/insertReviewComment",
							type : "POST",
							data : {
								"postReviewComment" : postReviewComment,
								"reviewId" : reviewId
							},
							success : function(data) {
								window.location = "viewTopic.jsp?topicId=" + topicId;
							},
							error : function(msg, er, t) {
								alert(msg + er + t);
							}
						});
					}else{
						$("#postReviewCommentError").show();
						$("#postReviewCommentError h1").text("You must be logged in to leave a comment!");
					}
				});
		    });
      });
    
   
   
    
    </script>
    
    <script>
    $( document ).ready(function() {
        
    	  $('#stars').on('starrr:change', function(e, value){
    		  	if(value!=null){
			    	insertStars(value,function(){
				    	checkRating();
				    	getReviewStars(function(stars){
				    		$("#reviewStars").text(stars);
				    	});
			    	});
    		  	}
    	  });
    	  
    	  window.isRated = function(reviewId, handleIsRated){
    		 	$.ajax({
    	            url: path+"/app/isRated",
    	            type: "GET",
    	            contentType: 'application/json; charset=utf-8',
    	            data: "reviewId="+reviewId,
    	            success: function(data){
    	            	handleIsRated(data);	
    	            },
    	            error:function(msg,er,t){
    					alert(msg+"   "+er+"  "+t+" israted error");
    	            } 
    	        });
    	  };
    	  
    	  window.insertStars = function(numberOfStars, handleInsertStars){
    		  var reviewId = Reviews[next];
    		  $.ajax({
					url : path+"/app/insertStars",
					type : "POST",
					data : {
						"numberOfStars" : numberOfStars,
						"reviewId":reviewId
					},
					success : function(data) {
						handleInsertStars();
					},
					error : function(msg, er, t) {
						alert(msg + er + t+"insert vote error");
					}
				});
    	  }
    });
    
    </script>
</head>
<body>
<%
		User currentUser = (User)request.getSession().getAttribute("user");
		String modal="reviewModal";
		if(currentUser==null){
			modal="notLoggedInModal";
		}
		String groupId = request.getParameter("groupId");
%>

<%@ include file="../header.jsp"%>
<%@ include file="../createReviewModal.jsp"%>
<%@ include file="../notLoggedInModal.jsp"%>
<%@ include file="diffModeModal.jsp"%>

	<div class="container my-container">
		<div class="alert alert-danger" id="errorMessage" style="display:none"><h1><strong></strong></h1></div>
		<div>
  			<h2  class="text-center">
	  			<div class="panel panel-default">
				  <div class="panel-body" id="topicTitle" ></div>
				</div>
			</h2>
		</div>
		<div class="row removeAll ">
			<div class="col-md-6">
					<button id="openCreateReviewModal" class="btn btn-primary pull-left " data-toggle="modal" data-target="#<%=modal%>">
					  Make a review
					</button>
					<%
						if (groupId!=null){
					%>
					<a href="" id="diffModeURL"><button class="btn btn-primary pull-left">
					  Diff Mode
					</button></a>
					<%} %>
			</div>
			<div class="col-md-6">
					<div class="removeReply">
			        		  
						<button id="next" type="button" class="btn btn-primary pull-right ">next Review</button>
						<div class="text-left" id="rateError" style="display:none">
			  			 		<h3><strong></strong><h3>
			  			 </div>
						<div class="lead removeReply ">
			        		<div id="stars" class="starrr" style="display:none;"></div>
			        		<div id="rating" style="display:none">Your rate: <span id="count"></span> star(s)  </div>
			        		<div>Total: <span id="reviewStars"></span> star(s)</div>
						</div>	
					</div>
			</div>
		</div>
		<div class="row removeAll">
			<div class="col-md-6">
				<div class="panel panel-primary">
					<div class="panel-heading">
						<h3 class="panel-title">Question</h3>
					</div>
					<div class="panel-body">
						<div class="myeditor" id="editor1" style="height: 450px;"></div>
					</div>

				</div>


				<div class="blockquote-box clearfix">
					<div class="blockquote-box blockquote-success clearfix well">
						<p>
							<i class="glyphicon glyphicon-user"></i> by <a href="#"
								id="topicUser"></a> | <i class="glyphicon glyphicon-calendar"
								id="topicDate"></i> | <i class="glyphicon glyphicon-tags"></i>
							Tag : <a href="#"><span class="label label-info"
								id="topicTag"></span></a>

						</p>
						<p id="OwnerDescription"></p>
					</div>
				</div>

				<div class="qa-message-list" id="wallmessages"
					name="topicWallMessages"></div>
				<div class="alert alert-danger" id="postTopicCommentError"
					style="display: none">
					<h1>
						<strong></strong>
					</h1>
				</div>
				<div style="margin-bottom: 50px;">
					<textarea id="topicComment"
						style="resize: none; margin-top: 50px; margin-bottom: 10px;"
						rows="4" class="form-control expand" placeholder="Leave a comment"></textarea>
					<input id="postTopicComment" type="button"
						class="btn btn-success pull-right" value="post">
				</div>

			</div>
			<div class="col-md-6 removeReply" id="errorDiv">

				<div class="panel panel-primary">
					<div class="panel-heading">
						<h3 class="panel-title">
							Review <span id="Review" class="badge"></span>
						</h3>
					</div>
					<div class="panel-body">
						<div class="myeditor" id="editor2" style="height: 450px;"></div>
					</div>

				</div>



				<div class="blockquote-box clearfix">
					<div class="blockquote-box blockquote-success clearfix well">
						<p>
							<i class="glyphicon glyphicon-user"></i> by <a href="#"
								id="reviewUser"></a> | <i class="glyphicon glyphicon-calendar"
								id="reviewDate"></i>

						</p>
						<p id="ReplyDescription"></p>
					</div>
				</div>


				<div class="qa-message-list" id="wallmessages"
					name="reviewWallMessages"></div>
				<div class="alert alert-danger" id="postReviewCommentError"
					style="display: none">
					<h1>
						<strong></strong>
					</h1>
				</div>
				<div style="margin-bottom: 50px;">
					<textarea id="reviewComment"
						style="resize: none; margin-top: 50px; margin-bottom: 10px;"
						rows="4" class="form-control expand" placeholder="Leave a comment"></textarea>
					<input id="postReviewComment" type="button"
						class="btn btn-success pull-right" value="post">
				</div>

			</div>
		</div>
		<% 
			if(currentUser!=null && groupId!=null){
		%>
		
		<%@ include file="../sidepanel.jsp"%>
		
		<% } %>
	
	</div>
		
</body>
</html>