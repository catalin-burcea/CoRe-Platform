package org.coreplatform.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.coreplatform.entity.User;
import org.coreplatform.service.CryptWithMD5;
import org.coreplatform.service.LoginService;
import org.coreplatform.service.RegisterService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/register")
public class RegisterController {

	private String errorMessage = null;
	private String successMessage = null;

	@RequestMapping(method = RequestMethod.GET)
    public ModelAndView displayLogin(HttpServletRequest request, HttpServletResponse response) {
        ModelAndView model = new ModelAndView("register","user", new User());
        return model;
    }
	
	@RequestMapping(method = RequestMethod.POST)
	public String register(@ModelAttribute("user") User user, @RequestParam(value = "repeatPassword", required = false) String repeatPassword, ModelMap model) {

		if (user.getLastName() != null && user.getFirstName() != null && user.getUsername()!= null && user.getEmail() != null && user.getPassword() != null && repeatPassword != null) {

			RegisterService rs = new RegisterService();
			LoginService ls = new LoginService();
			boolean result = rs.passwordsAreEqual(user.getPassword(), repeatPassword);
			if (!result) {
				errorMessage = "Password and repeat password are not equal!";
				model.addAttribute("errorMessage", errorMessage);
				return "register";
			}
			User tempUser = ls.getUser(user.getUsername());
			if (tempUser != null) {
				errorMessage = "Username already exists!";
				model.addAttribute("errorMessage", errorMessage);
				return "register";
			}
			result = rs.validEmail(user.getEmail());
			if (result) {
				errorMessage = "Email already exists!";
				model.addAttribute("errorMessage", errorMessage);
				return "register";
			}
			result = rs.validUsernameLength(user.getUsername());
			if (!result) {
				errorMessage = "Username length must be between 6 and 20 characters!";
				model.addAttribute("errorMessage", errorMessage);
				return "register";
			}
			result = rs.validPasswordLength(user.getPassword());
			if (!result) {
				errorMessage = "Password length must be between 6 and 20 characters!";
				model.addAttribute("errorMessage", errorMessage);
				return "register";
			}
			user.setPassword(CryptWithMD5.cryptWithMD5(user.getPassword()));
			successMessage = "Successfully registered!";
			rs.register(user);
		}

		model.addAttribute("errorMessage", errorMessage);
		model.addAttribute("successMessage", successMessage);
		return "register";
	}

}