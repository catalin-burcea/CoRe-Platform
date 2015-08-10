package org.coreplatform.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.coreplatform.entity.User;
import org.coreplatform.service.ActiveUsersService;
import org.coreplatform.service.GroupService;
import org.coreplatform.util.CoRePlatformConstants;
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
	
	static Logger log = Logger.getLogger(UserController.class.getName());

	@RequestMapping(value = "/isLoggedIn", method = RequestMethod.GET)
	public @ResponseBody
	String isLoggedIn(HttpServletRequest request) {

		User user = (User) request.getSession().getAttribute("user");
		return user != null ? "true" : "false";
	}

	@RequestMapping(value = "/getActiveUsers", method = RequestMethod.GET)
	public @ResponseBody String getActiveUsers() {

		try {
			JSONObject obj = null;
			JSONArray ja = new JSONArray();
			for (int i = 0; i < ActiveUsersService.activeUsers.size(); i++) {
				obj = new JSONObject();
				obj.put("id", ActiveUsersService.activeUsers.get(i));
				ja.put(obj);
			}
			return ja.toString();
		} catch (JSONException e) {
			log.error(CoRePlatformConstants.JSON_ADD_DATA_EXCEPTION + " - getActiveUsers()", e);
			return null;
		}
	}

	@RequestMapping(value = "/users", method = RequestMethod.GET)
	public String getUsers(ModelMap model) {

		GroupService gs = new GroupService();
		List<User> users = gs.getUsers();
		model.addAttribute("users", users);
		model.addAttribute("groupService", gs);

		return "users";
	}
}