<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="org.app.service.TopicService"%>
<%@page import="org.app.entities.Topic"%>
<%@page import="org.app.entities.Test"%>
<%@page import="org.hibernate.Hibernate"%>
<%@page import="java.util.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>topics</title>

<%@ include file="../head.jsp"%>
<style>

body {
	margin-top: 20px;
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

</head>
<body>
	<%@ include file="../header.jsp"%>
	<%@ include file="../createTopicModal.jsp"%>
	<%@ include file="../notLoggedInModal.jsp"%>
	<div class="container my-container">
			<div class="row">
			<div class="col-md-10">
		<%
			try{
				
				TopicService topicService = new TopicService();
				List<Topic> list = null;
				String groupParameter="";
				if(request.getParameter("groupId")!=null){
					Integer groupId  = Integer.parseInt(request.getParameter("groupId"));
					list  = topicService.getTopicsByGroupId(groupId);
					groupParameter="&groupId="+groupId;
				}else{
					list = topicService.getTopics();
				}
				if(list.size()==0){
		%>
				<div class="row">
					<div class="alert alert-danger"><h1 class="text-center"><strong>
					     No topics were found!</strong></h1></div>
				</div>
		<%
				}else{
									
					for (Topic t : list) {
			
		%>
					<div class="row">
						<div class="well well-sm">
							<div class="row">
								<div class="col-xs-1 col-md-1 text-center">
									<img src="https://ssl.gstatic.com/accounts/ui/avatar_2x.png"
										alt="jQuery2DotNet" class="img-rounded img-responsive">
								</div>
								<div class="col-xs-9 col-md-9 section-box">
									<h2>
										<%
																
											if(t.getTitle().length()>40){
												out.println(t.getTitle().substring(0, 40)+"...");
											}else{
												out.println(t.getTitle());
											}
										%>
	
										<a class="no-bottom-line"
											href="viewTopic.jsp?topicId=<%=t.getId()+groupParameter%>"><strong
											style="">see post</strong></a>
									</h2>
									<p>
										<%
											if(t.getDescription().length()>100){
												out.println(t.getDescription().substring(0, 100)+"...");
											}else{
												out.println(t.getDescription());
											}
										%>
									</p>
									<hr>
									<div class="row rating-desc">
										<div class="col-md-12">
											<p>
												<i class="glyphicon glyphicon-user"></i> by <a href="#"><%=t.getUser().getUsername()%></a>
												| <i class="glyphicon glyphicon-calendar"></i>
												<%=t.getDate()%>
												| <i class="glyphicon glyphicon-comment"></i> <a href="#"><%=t.getComments().size()%>
													Comment(s)</a> | <i class="glyphicon glyphicon-share"></i>
												Tag : <a href="#"><span class="label label-info"><%=t.getTag().getTitle()%></span></a>
	
	
	
											</p>
										</div>
									</div>
								</div>
							</div>
						</div>
	
	
					</div>
					<%
						}
					}
				}catch(Exception e){
					//out.println(e);
				}
			%>

			</div>
			<%
				User currentUser = (User)request.getSession().getAttribute("user");
				String modal="createTopicModal";
				if(currentUser==null){
					modal="notLoggedInModal";
				}
			%>
			<div class="col-md-2">
				<button id="openCreateTopicModal" class="btn btn-primary" data-toggle="modal"
					data-target="#<%=modal%>">create a topic</button>
			</div>
		</div>
		<% 
			String groupId = request.getParameter("groupId");
			if(currentUser!=null && groupId!=null){
		%>
		
		<%@ include file="../sidepanel.jsp"%>
		
		<%} %>
			
	</div>


</body>
</html>