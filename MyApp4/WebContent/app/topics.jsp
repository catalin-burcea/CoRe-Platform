<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>topics</title>

<%@ include file="head.jsp"%>
<script type="text/javascript"><%@ include file="assets/js/searchableList.js" %> </script>

<style type="text/css">
.panel>.list-group .list-group-item:first-child {
	/*border-top: 1px solid rgb(204, 204, 204);*/
	
}

@media ( max-width : 767px) {
	.visible-xs {
		display: inline-block !important;
	}
	.block {
		display: block !important;
		width: 100%;
		height: 1px !important;
	}
}

.c-search>.form-control {
	border-radius: 0px;
	border-width: 0px;
	border-bottom-width: 1px;
	font-size: 1.3em;
	padding: 12px 12px;
	height: 44px;
	outline: none !important;
}

.c-search>.form-control:focus {
	outline: 0px !important;
	-webkit-appearance: none;
	box-shadow: none;
}

.c-search>.input-group-btn .btn {
	border-radius: 0px;
	border-width: 0px;
	border-left-width: 1px;
	border-bottom-width: 1px;
	height: 44px;
}

.c-list {
	padding: 0px;
	min-height: 44px;
}

.title {
	display: inline-block;
	font-size: 1.7em;
	font-weight: bold;
	padding: 5px 15px;
}

ul.c-controls {
	list-style: none;
	margin: 0px;
	min-height: 44px;
}

ul.c-controls li {
	margin-top: 8px;
	float: left;
}

ul.c-controls li a {
	font-size: 1.7em;
	padding: 11px 10px 6px;
}

ul.c-controls li a i {
	min-width: 24px;
	text-align: center;
}

ul.c-controls li a:hover {
	background-color: rgba(51, 51, 51, 0.2);
}

.c-toggle {
	font-size: 1.7em;
}

.name {
	font-size: 1.7em;
	font-weight: 700;
}

.c-info {
	padding: 5px 10px;
	font-size: 1.25em;
}
</style>
<style>
body {
	margin-top: 20px;
}

.my-topic {
	background-color: #FFFFFF;
	border: 1px solid #9F9AC9;
}

.glyphicon {
	margin-right: 5px;
}

.section-box h2 {
	margin-top: 0px;
}

.section-box h2 a {
	font-size: 15px;
}

.glyphicon-heart {
	color: #e74c3c;
}

.glyphicon-comment {
	color: #27ae60;
}

.separator {
	padding-right: 5px;
	padding-left: 5px;
}

.section-box hr {
	margin-top: 0;
	margin-bottom: 5px;
	border: 0;
	border-top: 1px solid rgb(199, 199, 199);
}
</style>


<style type="text/css">

.topic-title-link {
	color:#383838;
}

.topic-title-link:hover {
	background-color:#F0F0F0;
	border-radius:5px;
	color:#000000;
}

</style>


</head>
<body>
	<%@ include file="header.jsp"%>
	<%@ include file="createTopicModal.jsp"%>
	<%@ include file="editTopicModal.jsp"%>
	<%@ include file="notLoggedInModal.jsp"%>
	<div class="container my-container">
		<div class="row">
			<c:choose>
				<c:when test="${groupId!=null && user == null}">
					<div class="row">
						<div class="alert alert-danger text-center">
							<h2>
								<strong> You must be logged in to view or create groups</strong>
							</h2>
						</div>
					</div>
				</c:when>
				<c:when
					test="${groupId!=null && user != null && usergroup == null && admin == null}">
					<div class="row">
						<div class="alert alert-danger text-center">
							<h2>
								<strong> You are not authorized to view this group</strong>
							</h2>
						</div>
					</div>
				</c:when>
				<c:otherwise>
					<div class="row">
						<div class="col-md-10">
							<c:choose>
								<c:when test="${topics.size() == 0}">
									<div class="row">
										<div class="alert alert-danger text-center">
											<h1 class="text-center">
												<strong> No topics were found!</strong>
											</h1>
										</div>
									</div>
								</c:when>
								<c:otherwise>

									<div class="col-xs-12  col-sm-12">
										<div class="panel panel-default">
											<div class="panel-heading c-list">
												<span class="title">Topics</span>
												<ul class="pull-right c-controls">
													<li><a href="#" class="hide-search"
														data-command="toggle-search" data-toggle="tooltip"
														data-placement="top" title="Toggle Search"><i
															class="glyphicon glyphicon-search"></i></a></li>
												</ul>
											</div>

											<div class="row" style="display: none;">
												<div class="col-xs-12">
													<div class="input-group c-search">
														<input type="text" class="form-control"
															id="contact-list-search"> <span
															class="input-group-btn">
															<button class="btn btn-default" type="button">
																<span class="glyphicon glyphicon-search text-muted"></span>
															</button>
														</span>
													</div>
												</div>
											</div>

											<ul class="list-group" id="contact-list">

												<c:forEach items="${topics}" var="topic">
													<li class="list-group-item">
														<div class="row" id="topic-item">
															<div class="col-xs-12 col-sm-12">
																<c:if
																	test="${admin != null || usergroup.ownership=='yes' || topic.getUser().getUsername()==user.getUsername()}">
																	<form role="form" method="POST" action="${projectPath}/deleteTopic">
																		<button type="button" onClick="this.form.submit();"
																			class="btn btn-danger glyphicon glyphicon-trash pull-right"></button>
																		<input type="hidden" name="topicId"
																			value="${topic.getId()}"> 
																		<input
																			type="hidden" name="groupId"
																			value="${topic.getGroup().getId()}">
																	</form>
																	<div>
																		<button name="openEditTopicModal" type="button"
																			class="btn btn-primary glyphicon glyphicon-pencil pull-right"
																			data-toggle="modal" data-target="#editTopicModal">
																			<input id="topicId-editModal" type="hidden" name="topic" value="${topic.getId()}">
																		</button>
																	</div>
																</c:if>
																<div class="row">

																	<div class="col-xs-1 col-md-1 text-center">
																		<img
																			src="https://ssl.gstatic.com/accounts/ui/avatar_2x.png"
																			alt="jQuery2DotNet"
																			class="img-rounded img-responsive">
																	</div>
																	<div class="col-xs-9 col-md-9 section-box">
																		
																			<c:choose>
																				<c:when test="${topic.getTitle().length()>35}">
																						<a class="no-bottom-line "
																						href="${projectPath}/viewTopic/topic/${topic.getId()}${groupParameter}"><strong
																						style=""> <h1 class="topic-title-link">${topic.getTitle().substring(0, 35)}...</h1> </strong></a>
																	   					
																	 				 </c:when>
																				<c:otherwise>
																						<a class="no-bottom-line"
																						href="${projectPath}/viewTopic/topic/${topic.getId()}${groupParameter}"><strong
																						style=""> <h1 class="topic-title-link">${topic.getTitle()} </h1></strong></a>
																						
																	   					 
																	 			</c:otherwise>
																			</c:choose>

																		
																		<c:choose>
																			<c:when
																				test="${topic.getDescription().length() > 100}">
																   					<div> ${topic.getDescription().substring(0, 100)}...</div>
																  				</c:when>
																			<c:otherwise>
																  					  <div>${topic.getDescription()}</div>
																  				</c:otherwise>
																		</c:choose>
																		<hr>
																		<div class="row rating-desc">
																			<div class="col-md-12">
																				<p>
																					<i class="glyphicon glyphicon-user"></i> by <a
																						href="#">${topic.getUser().getUsername()}</a> | <i
																						class="glyphicon glyphicon-calendar"></i>
																					${topic.getDate()} | <i
																						class="glyphicon glyphicon-comment"></i> <a
																						href="#">${topic.getComments().size()}
																						Comment(s)</a> |<i class="glyphicon glyphicon-comment"></i>
																					<a href="#">${topic.getReviews().size()}
																						Review(s)</a> <i class="glyphicon glyphicon-tag"></i>
																					Tag : <a href="#"><span
																						class="label label-info">${topic.getTag().getTitle()}</span></a>


																				</p>
																			</div>
																		</div>
																	</div>
																</div>
															</div>


														</div>
													</li>
												</c:forEach>

											</ul>
										</div>
									</div>

								</c:otherwise>
							</c:choose>
						</div>
						<div class="col-md-2">
							<button id="openCreateTopicModal" class="btn btn-primary"
								data-toggle="modal" data-target="#${modal}">create a
								topic</button>
						</div>
					</div>
				</c:otherwise>
			</c:choose>
		</div>

		<script
			src="http://cdn.rawgit.com/stidges/jquery-searchable/master/dist/jquery.searchable-1.0.0.min.js"></script>


		<c:if
			test="${user!=null && groupId!=null && (usergroup!=null || admin != null)}">
			<%@ include file="sidepanel.jsp"%>
		</c:if>
	</div>
</body>
</html>