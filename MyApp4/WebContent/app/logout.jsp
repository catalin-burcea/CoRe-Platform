<%@page import="org.coreplatform.service.ActiveUsersService"%>
<%@page import="org.coreplatform.entity.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">        
        <link rel="stylesheet" type="text/css" href="style.css">
        <title>logout Page</title>
    </head>
    <body>
        <%         
        	User user  = (User)request.getSession().getAttribute("user");  
        	ActiveUsersService.activeUsers.remove(user.getId());
            session.removeAttribute("logged");
			session.removeAttribute("user");
            session.invalidate();
            response.sendRedirect("login.jsp");
        %>

</body>
</html>
