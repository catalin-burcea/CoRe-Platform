<% 	String logged = (String)request.getSession().getAttribute("logged");
	if(logged!=null && logged.equals("true")){
		response.sendRedirect("topics.jsp");
	}
%>