package com.tutorialspoint;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.app.entities.User;
import org.app.service.CryptWithMD5;
import org.app.service.LoginService;
import org.app.service.RegisterService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.ui.ModelMap;

@Controller
@RequestMapping("/app/register") 
public class RegisterController{
   private String errorMessage=null;
   private String successMessage=null;
   
   @RequestMapping(method = {RequestMethod.POST, RequestMethod.GET})
   public String register(@RequestParam(value="firstName", required=false) String firstName,
		   @RequestParam(value="lastName", required=false) String lastName,
		   @RequestParam(value="username", required=false) String username,
		   @RequestParam(value="email", required=false) String email,
		   @RequestParam(value="password", required=false) String password,
		   @RequestParam(value="repeatPassword", required=false) String repeatPassword,
		   ModelMap model) throws IOException {


	        if(lastName!=null && firstName!=null && username!=null && email!=null && password!=null &&repeatPassword!=null){
		        RegisterService rs = new RegisterService();
		        LoginService ls = new LoginService();
		        
	        	
	            boolean result=rs.passwordsAreEqual(password, repeatPassword);
	            if(!result){
	            	errorMessage="Password and repeat password are not equal!";
	                model.addAttribute("errorMessage",errorMessage);
	                return "register";
	            }
	            User tempUser=ls.getUser(username);
	            if(tempUser!=null){
	            	errorMessage="Username already exists!";
	                model.addAttribute("errorMessage",errorMessage);
	                return "register";
	            }
	            result=rs.validEmail(email);
	            if(result){
	            	errorMessage="Email already exists!";
	                model.addAttribute("errorMessage",errorMessage);
	                return "register";
	            }
	            result=rs.validUsernameLength(username);
	            if(!result){
	            	errorMessage="Username length must be between 6 and 20 characters!";
	                model.addAttribute("errorMessage",errorMessage);
	                return "register";
	            }	            
	            result=rs.validPasswordLength(password);
	            if(!result){
	            	errorMessage="Password length must be between 6 and 20 characters!";
	                model.addAttribute("errorMessage",errorMessage);
	                return "register";
	            }
		        User user = new User(firstName,lastName,username, email, CryptWithMD5.cryptWithMD5(password),null,null,null,null,null);
	            successMessage="Successfully registered!";
	            rs.register(user);
	        }
	                 
            model.addAttribute("errorMessage",errorMessage);
            model.addAttribute("successMessage",successMessage);
            return "register";
   }
   
   

}