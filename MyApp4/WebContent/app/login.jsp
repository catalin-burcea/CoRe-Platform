
<%@ include file="loginTest.jsp" %> 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib
    prefix="c"
    uri="http://java.sun.com/jsp/jstl/core" 
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Login page</title>
<%@ include file="head.jsp" %> 
</head>

<body>
<%@ include file="header.jsp" %> 
<div class="container my-container">

	
	<div class="login-container">
		<c:if test="${errorMessage !=null}" >
			<div id="output" class="alert alert-danger animated fadeInUp">${errorMessage}</div>
		</c:if> 
            <div class="avatar"></div>
            <div class="">
      			
                 <form id="loginform" class="form-horizontal" role="form" method="POST" action="login">
                                    
                            <div style="margin-bottom: 25px" class="input-group">
                                        <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                                        <input name="username" id="username" type="text" class="form-control"  value="" placeholder="username" required>                                        
                                    </div>
                                
                            <div style="margin-bottom: 25px" class="input-group">
                                        <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
                                        <input name="password" id="password" type="password" class="form-control" placeholder="password" required>
                            </div>
							<div>Don't have an account?<a href="register.jsp" class="no-bottom-line"> Sign up here</a></div>

                    <button class="btn btn-info btn-block login" type="submit">Login</button>
                </form>
            </div>
        </div>
        
</div>

</body>
</html>
