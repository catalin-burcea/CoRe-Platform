<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
       <!-- <%@ include file="head.html" %>  -->
        <title>Login Page</title>
    </head>    
    <body>
	    <!--<%@ include file="header.jsp" %>--> 
        <div id="mystyle" class="myform">
            <form id="form" name="form" method="post" action="login">
                <h1>Login</h1>
                
                <p>Please enter your login information
                    <br/>New User? <a href="register.jsp">Register</a></p>
                <label>User ID
                    <span class="small">Enter your user ID</span>
                </label>
                <input type="text" name="userId" id="userId" />

                <label>Password
                    <span class="small">Min. size 6 chars</span>
                </label>
                <input type="password" name="password" id="password" />

                <button type="submit">Sign-in</button>
                <div class="spacer"></div>
            </form>
        </div>

</body>
</html>
