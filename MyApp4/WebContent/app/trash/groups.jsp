<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="org.app.service.GroupService"%>
<%@page import="org.app.entities.UserGroup"%>
<%@page import="org.app.entities.User"%>
<%@page import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>groups</title>
<%@ include file="../head.jsp"%>

<style>

/* Blue Flat Button
==================================================*/
.btn-xlarge{
  position: relative;
  vertical-align: center;
  margin: 30px;
  /*width: 100%;*/
  height: 100x;
  padding: 48px 48px;
  font-size: 22px;
  color: white;
  text-align: center;
  text-shadow: 0 1px 2px rgba(0, 0, 0, 0.25);

  border: 0;
  border-bottom: 3px solid #9FE8EF;
  cursor: pointer;
  -webkit-box-shadow: inset 0 -3px #9FE8EF;
  box-shadow: inset 0 -3px #9FE8EF;
}
.btn-xlarge:active {
  top: 2px;
  outline: none;
  -webkit-box-shadow: none;
  box-shadow: none;
}
.group-member:hover {
  background: #4169E1;
}  
.group-member {
 background: #62b1d0;
}
.group-owner{
  background: #FFA500;
}.group-owner:hover{
  background: #D2691E;
}

</style>
</head>
<body>

	<%@ include file="../header.jsp"%>
	<%@ include file="../createGroupModal.jsp"%>
	<div class="container my-container">
		
		<c:choose>
			  <c:when test="${user==null}">
					<div class="row">
						<div class="alert alert-danger text-center" id="errorMessage" ><h1><strong>
							You must be logged in to view or create groups
						</strong></h1></div>
					</div>
			  </c:when>
			  <c:otherwise>
			    <c:choose>
					  <c:when test="${ownerGroups.size()==0 && memberGroups.size()==0}">
					    <div class="row">
							<div class="col-md-10">
								<div class="alert alert-danger text-center" id="errorMessage" ><h1><strong>
									You are not a member of any group
								</strong></h1></div>
							</div>
							<div class="col-md-2">
							  <button id="openCreateGroupModal" class="btn btn-primary" data-toggle="modal"
								data-target="#createGroupModal">Create a group</button>
							</div>
						</div>
					  </c:when>
					  <c:otherwise>
					    	<div class="row">
								<div class="col-md-10">
									<div class="row">
									<c:if test="${ownerGroups.size()>0}">
   										 <div class="panel panel-primary">
							                <div class="panel-heading">
							                    <h3 class="panel-title">
							                        Owner</h3>
							                </div>
		                				 	<ul class="list-group">
		                				 	<c:forEach items="${ownerGroups}" var="ug">
		                				 		<a href="topics?groupId=${ug.getGroup().getId()}" class="list-group-item">${ug.getGroup().getName()}</a>
		                				 	</c:forEach>
		                				 	</ul>
		                				 </div>
									</c:if>
									</div>
									<div class="row">
									<c:if test="${memberGroups.size()>0}">
   										 <div class="panel panel-primary">
							                <div class="panel-heading">
							                    <h3 class="panel-title">
							                        Member</h3>
							                </div>
		                				 	<ul class="list-group">
		                				 	<c:forEach items="${memberGroups}" var="ug">
		                				 		<a href="topics?groupId=${ug.getGroup().getId()}" class="list-group-item">${ug.getGroup().getName()}</a>
		                				 	</c:forEach>
		                				 	</ul>
		                				 </div>
									</c:if>
									</div>
									</div>
									<div class="col-md-2">
					  					<button id="openCreateGroupModal" class="btn btn-primary" data-toggle="modal"
										data-target="#createGroupModal">Create a group</button>
									</div>
								</div>
					  </c:otherwise>
				 </c:choose>
			  </c:otherwise>
		</c:choose>
		
</div>
</body>
</html>