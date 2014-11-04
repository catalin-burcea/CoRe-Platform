<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>view topic</title>
<%@ include file="head.jsp"%>
<script type="text/javascript"><%@ include file="assets/js/stars.js" %></script>
<script type="text/javascript"><%@ include file="assets/js/viewTopic.js" %></script>
    
<style type="text/css">
    
    
    .back-to-top {
    cursor: pointer;
    position: fixed;
    bottom: 30px;
    right:30px;
    display:none;
}
</style>
</head>
<body>


<%@ include file="header.jsp"%>
<%@ include file="createReviewModal.jsp"%>
<%@ include file="notLoggedInModal.jsp"%>

	<div class="container my-container">
		<c:choose>
		  <c:when test="${user!=null && groupId!=null && usergroup == null}">
		  		<div class="alert alert-danger text-center"><h1><strong>
		  			You are not authorized to view this topic
		  		</strong></h1></div>
		  </c:when>
		
		  <c:otherwise>
				<div class="alert alert-danger text-center" id="errorMessage" style="display:none"><h1><strong></strong></h1></div>
				<div>
		  			<h2  class="text-center">
			  			<div class="panel panel-default">
						  <div class="panel-body" id="topicTitle" ></div>
						</div>
					</h2>
				</div>
				<div class="row removeAll ">
					<div class="col-md-6">
							<button id="openCreateReviewModal" class="btn btn-primary pull-left " data-toggle="modal" data-target="#${modal}">
							  Make a review
							</button>
							<c:if test="${groupId != null}">
		   						<a href="" id="diffModeURL">
		   							<button class="btn btn-primary pull-left">
							  		Diff Mode
									</button>
								</a>
							</c:if>
					</div>
					
					<div class="col-md-6">
							<div class="removeReply">
					        		  
								<button id="next" type="button" class="btn btn-primary pull-right ">next Review</button>
								<div class="text-left" id="rateError" style="display:none">
					  			 		<h3><strong></strong><h3>
					  			 </div>
								<div class="lead removeReply ">
					        		<div id="stars" class="starrr" style="display:none;"></div>
					        		<div id="rating" style="display:none" >Your rate: <span id="count"></span> star(s)  </div>
					        		<div>Average: <span id="reviewStars"></span></div>
								</div>	
							</div>
					</div>
				</div>
				<div class="row removeAll">
				   <div class="col-md-6">
					    <div class="panel panel-primary">
							  <div class="panel-heading">
							    <h3 class="panel-title">Request</h3>
					 	 	  </div>
							  <div class="panel-body">
					  			  <div class="myeditor" id="editor1" style="height: 450px;"></div>
							   </div>
						
				  		</div>
				  		
		
				  		<div class="blockquote-box clearfix">
				            <div class="blockquote-box blockquote-success clearfix well">
				                                <p>
								<i class="glyphicon glyphicon-user"></i> by <a href="#" id="topicUser"></a>
								| <i class="glyphicon glyphicon-calendar" id="topicDate"></i>
								| <i class="glyphicon glyphicon-tags"></i>
								Tag : <a href="#"><span class="label label-info" id="topicTag"></span></a>
				
								</p>
				                <p id="OwnerDescription"></p>
				            </div>
		        		</div>
		
						<div class="qa-message-list" id="wallmessages" name="topicWallMessages">				
						</div>
						<div class="alert alert-danger" id="postTopicCommentError" style="display:none"><h1><strong></strong></h1></div>
						<div style="margin-bottom:50px;">
							<textarea id="topicComment" style="resize:none; margin-top:50px; margin-bottom:10px;" 
							rows="4" class="form-control expand" placeholder="Leave a comment"></textarea>
							<input id="postTopicComment" type="button" class="btn btn-success pull-right" value="post">
						</div>
		
				  </div>
				  <div class="col-md-6 removeReply" id="errorDiv">
				 		 
					    <div class="panel panel-primary">
							  <div class="panel-heading">
									<form id="deleteReviewForm" role="form" method="POST" action="${projectPath}/deleteReview" class="pull-right" style="display:none">	
										<button type="button"  onClick="this.form.submit();" class="btn btn-danger glyphicon glyphicon-trash"></button>
										<input type="hidden" name="topicId" value="">
										<input type="hidden" name="reviewId" value="">
										<input type="hidden" name="groupId" value="">
									</form>
							    <h3 class="panel-title">Review 
							    	<span id="Review" class="badge"></span>
	
							    </h3>
					 	 	  </div>
							  <div class="panel-body">
					  			   <div class="myeditor" id="editor2" style="height: 450px;"></div>
							   </div>
						
				  		</div>
				  		
						<div class="blockquote-box clearfix">
				            <div class="blockquote-box blockquote-success clearfix well">
								<p>
									<i class="glyphicon glyphicon-user"></i> by <a href="#" id="reviewUser"></a>
									| <i class="glyphicon glyphicon-calendar" id="reviewDate"></i>
		
								</p>
				                <p id="ReplyDescription">
				                </p>
				            </div>
				        </div>
		 	  
				        
				        <div class="qa-message-list" id="wallmessages" name="reviewWallMessages">
									
						</div>
						<div class="alert alert-danger" id="postReviewCommentError" style="display:none"><h1><strong></strong></h1></div>
						<div style="margin-bottom:50px;">
								<textarea id="reviewComment" style="resize:none; margin-top:50px; margin-bottom:10px;" rows="4" class="form-control expand" placeholder="Leave a comment"></textarea>
								<input id="postReviewComment" type="button" class="btn btn-success pull-right" value="post">
						</div>
				
				  </div>
				</div>

				<c:if test="${user!=null && groupId!=null}">
				   	<%@ include file="sidepanel.jsp"%>
				</c:if>	
		  </c:otherwise>
		</c:choose>
		
	<a id="back-to-top" href="#" class="btn btn-primary btn-lg back-to-top" role="button" title="Click to return on the top page" data-toggle="tooltip" data-placement="left"><span class="glyphicon glyphicon-chevron-up"></span></a>

	</div>
		
</body>
</html>