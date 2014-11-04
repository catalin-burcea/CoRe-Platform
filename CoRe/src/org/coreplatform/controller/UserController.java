package org.coreplatform.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.coreplatform.entity.User;
import org.coreplatform.service.ActiveUsersService;
import org.coreplatform.service.GroupService;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class UserController {

	@RequestMapping(value = "/app/isLoggedIn", method = RequestMethod.GET)
	public @ResponseBody String isLoggedIn(HttpServletRequest request) {

		User user = (User) request.getSession().getAttribute("user");
		return user != null ? "true" :"false";
	}

	@RequestMapping(value = "/app/getActiveUsers", method = RequestMethod.GET)
	public @ResponseBody String getActiveUsers() throws JSONException {

		JSONObject obj = null;
		JSONArray ja = new JSONArray();
		for (int i = 0; i < ActiveUsersService.activeUsers.size(); i++) {
			obj = new JSONObject();
			obj.put("id", ActiveUsersService.activeUsers.get(i));
			ja.put(obj);
		}

		return ja.toString();
	}

	@RequestMapping(value = "/app/users", method = RequestMethod.GET)
	public String getUsers(ModelMap model) {

		GroupService gs = new GroupService();
		List<User> users = gs.getUsers();
		model.addAttribute("users", users);
		model.addAttribute("groupService", gs);
		
		return "users";
	}
}