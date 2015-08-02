<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>HTML</title>
    <style>
        #editor { 
                position: absolute;
                top: 0;
                right: 0;
                bottom: 0;
                left: 0;
            }
    </style>
    <%@ include file="head.jsp" %> 
</head>
<body>


<div class="row">
    <div class="col-md-5">
        <div class="myeditor" id="editor1" style="height: 550px; width: 500px">some text 2
   package org.coreplatform.controller;

import javax.servlet.http.HttpServletRequest;

import org.app.model.User;
import org.coreplatform.service.LoginService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.ui.ModelMap;

@Controller
@RequestMapping("/login")
public class LoginController{
	private String errorMessage=null;
	
   @RequestMapping(method = {RequestMethod.POST,RequestMethod.GET})
   public String login(@RequestParam(value="username", required=false) String username,
		   @RequestParam(value="password", required=false) String password,
		   ModelMap model,HttpServletRequest request) {
       
       LoginService loginService = new LoginService();
       boolean result = loginService.authenticate(username, password);
       User user = loginService.getUserByUsername(username);
       if(result == true){
           request.getSession().setAttribute("user", user);            
           return "redirect:/home.jsp";
       }
       else{
    	   errorMessage="Username or password is incorrect! ";
    	   model.addAttribute("errorMessage",errorMessage);
           return "login";
       }
	   

   }

}</div>
    </div>

    <div class="col-md-5">
        <div class="myeditor" id="editor2" style="height: 550px; width: 500px">
        
	var textfield = $("input[name=user]");
	            $('button[type="submit"]').click(function(e) {
	                e.preventDefault();
	                //little validation just to check username
	                if (textfield.val() != "") {
	                    //$("body").scrollTo("#output");
	                    $("#output").addClass("alert alert-success animated fadeInUp").html("Welcome back " + "<span style='text-transform:uppercase'>" + textfield.val() + "</span>");
	                    $("#output").removeClass(' alert-danger');
	                    $("input").css({
	                    "height":"0",
	                    "padding":"0",
	                    "margin":"0",
	                    "opacity":"0"
	                    });
	                    //change button text 
	                    $('button[type="submit"]').html("continue")
	                    .removeClass("btn-info")
	                    .addClass("btn-default").click(function(){
	                    $("input").css({
	                    "height":"auto",
	                    "padding":"10px",
	                    "opacity":"1"
	                    }).val("");
	                    });
	                    
	                    //show avatar
	                    $(".avatar").css({
	                        "background-image": "url('http://api.randomuser.me/0.3.2/portraits/women/35.jpg')"
	                    });
	                } else {
	                    //remove success mesage replaced with error message
	                    $("#output").removeClass(' alert alert-success');
	                    $("#output").addClass("alert alert-danger animated fadeInUp").html("sorry enter a username ");
	                }
	                //console.log(textfield.val());

	            });</div>
    </div>
</div>
    <script>
    var editor1;
    var editor2;
    $(function() {
        editor1 = ace.edit("editor1");
        editor1.getSession().setMode("ace/mode/java");
        editor1.setTheme("ace/theme/cobalt");  
        editor1.setReadOnly(true);  // false to make it editable
        editor2 = ace.edit("editor2");
          editor2.getSession().setMode("ace/mode/javascript");
          editor2.setTheme("ace/theme/monokai");  
          editor2.setReadOnly(true);  // false to make it editable
    });

    
    function f(){

    	editor1.setValue(editor2.getValue());
    }
    
    </script>
    <input type="button" id="test" value="test" onclick="f()">
</body>
</html>