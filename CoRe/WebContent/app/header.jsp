<%@page import="org.coreplatform.controller.CoRePlatformConstants"%>
<%@page import="org.coreplatform.entity.User"%>
<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
	<div class="container-fluid">
		<!-- Brand and toggle get grouped for better mobile display -->
		<div class="navbar-header">
			<button type="button" class="navbar-toggle" data-toggle="collapse"
				data-target="#bs-example-navbar-collapse-1">
				<span class="sr-only">Toggle navigation</span> <span
					class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="#">CoRe Platform</a>
		</div>

		<!-- Collect the nav links, forms, and other content for toggling -->
		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href=<%=CoRePlatformConstants.PROJECT_PATH+"/topics"%>>Topics</a></li>
				<li><a href=<%=CoRePlatformConstants.PROJECT_PATH+"/groups"%>>Groups</a></li>
				<li><a href=<%=CoRePlatformConstants.PROJECT_PATH+"/users"%>>Users</a></li>
			</ul>

			<%
				User user = (User) session.getAttribute("user");
				if (user != null) {
			%>

			<ul class="nav navbar-nav navbar-right">
					<li><a href="#"><span class="glyphicon glyphicon-user"></span> Welcome, <%=user.getLastName()+" "+user.getFirstName()%></a></li>
					<li><a href="logout"><i class="glyphicon glyphicon-off"></i> Logout</a></li>
			</ul>

			<%
				} else {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li><a href="login">Login</a></li>
				<li><a href="register">Register</a></li>
			</ul>
			<%
				}
			%>
		</div>
		<!-- /.navbar-collapse -->
	</div>
	<!-- /.container-fluid -->
</nav>