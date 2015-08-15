package org.coreplatform.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.coreplatform.entity.User;
import org.coreplatform.service.LoginService;
import org.coreplatform.service.OnlineUsersService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class LoginController {

	private String errorMessage = null;

	@RequestMapping(value = "/login", method=RequestMethod.GET)
    public ModelAndView displayLogin(HttpServletRequest request, HttpServletResponse response) {
        ModelAndView model = new ModelAndView("login","user",new User());
        return model;
    }
	
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login( @ModelAttribute("user") User user, ModelMap model, HttpServletRequest request) {

		LoginService ls = new LoginService();
		boolean result = ls.authenticate(user.getUsername(), user.getPassword());
		user = ls.getUser(user.getUsername());
		if (result == true) {
			request.getSession().setAttribute("user", user);
			request.getSession().setAttribute("logged", "true");
			OnlineUsersService.onlineUsers.add(user.getId());
	    	OnlineUsersService.changed = 0;
			return "redirect:/topics";
		} else {
			this.errorMessage = "Username or password is incorrect! ";
			model.addAttribute("errorMessage", this.errorMessage);
			return "login";
		}
	}
	
	@RequestMapping(value = "/logout", method=RequestMethod.GET)
    public String displayLogout(HttpServletRequest request, HttpServletResponse response) {
		
    	User user  = (User)request.getSession().getAttribute("user");
    	if(user == null) {
    		return "login";
    	}
    	OnlineUsersService.onlineUsers.remove(user.getId());
    	OnlineUsersService.changed = 0;
    	request.getSession().removeAttribute("logged");
    	request.getSession().removeAttribute("user");
    	request.getSession().invalidate();
        return "login";
    }

}