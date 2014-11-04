<%@ include file="loginTest.jsp" %> 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Register page</title>
<%@ include file="head.jsp" %> 
</head>

<body>
<%@ include file="header.jsp" %> 
<div class="container my-container">
	<div class="login-container">
		<c:if test="${errorMessage !=null}" >
			<div id="output" class="alert alert-danger animated fadeInUp">${errorMessage}</div>
		</c:if> 
		<c:if test="${successMessage !=null}" >
			<div id="output" class="alert alert-success animated fadeInUp">${successMessage}
			<a href="login.jsp" class="no-bottom-line">Now, you can log in.</a></div>
		</c:if> 
            <div class="">
      
                 <form id="loginform" class="form-horizontal" role="form" method="POST" action="register">
                            
                            <div style="margin-bottom: 25px" class="input-group">
                                   <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                                   <input name="firstName" id="firstName" type="text" class="form-control" placeholder="firstname" required>                                        
                            </div>
                            
                            <div style="margin-bottom: 25px" class="input-group">
                                   <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                                   <input name="lastName" id="lastName" type="text" class="form-control" placeholder="lastname" required>                                        
                            </div>
                            
                            <div style="margin-bottom: 25px" class="input-group">
                                   <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                                   <input name="username" id="username" type="text" class="form-control" placeholder="username" required>                                        
                            </div>
                                                         
                            <div style="margin-bottom: 25px" class="input-group">
                                   <span class="input-group-addon"><i class="glyphicon glyphicon-envelope"></i></span>
                                   <input name="email" id="email" type="email" class="form-control"  value="" placeholder="email" required>                                        
                            </div>
                                
                            <div style="margin-bottom: 25px" class="input-group">
                                    <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
                                    <input name="password" id="password" type="password" class="form-control" placeholder="password" required>
                            </div>
                            <div style="margin-bottom: 25px" class="input-group">
                                    <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
                                    <input name="repeatPassword" id="repeatPassword" type="password" class="form-control" placeholder="repeat password" required>
                            </div>
                           	<div>Already have an account?<a href="login.jsp" class="no-bottom-line"> Sign in here</a></div>

                    <button class="btn btn-info btn-block login" type="submit">Register</button>
                </form>
            </div>
        </div>
        
</div>

</body>
</html>