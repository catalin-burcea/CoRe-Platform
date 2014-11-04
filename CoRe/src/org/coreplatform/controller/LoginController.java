package org.coreplatform.controller;

import javax.servlet.http.HttpServletRequest;

import org.coreplatform.entity.User;
import org.coreplatform.service.ActiveUsersService;
import org.coreplatform.service.LoginService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.ui.ModelMap;

@Controller 
@RequestMapping("/app/login") 
public class LoginController{
	
	private String errorMessage=null;
	
   @RequestMapping(method = {RequestMethod.POST,RequestMethod.GET})
   public String login(@RequestParam(value="username", required=false) String username,
		   @RequestParam(value="password", required=false) String password,
		   ModelMap model, HttpServletRequest request) {
       
       LoginService ls = new LoginService();
       boolean result = ls.authenticate(username, password);
       User user = ls.getUser(username);
       if(result == true){
           request.getSession().setAttribute("user", user);    
           request.getSession().setAttribute("logged", "true");
           ActiveUsersService.activeUsers.add(user.getId());
           return "redirect:"+CoRePlatformConstants.APP+"/topics";
       }
       else{
    	   errorMessage="Username or password is incorrect! ";
    	   model.addAttribute("errorMessage",errorMessage);
           return "login";
       }
	   
   }

}