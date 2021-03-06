package org.coreplatform.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.BasicConfigurator;
import org.apache.log4j.Logger;
import org.coreplatform.entity.Group;
import org.coreplatform.entity.User;
import org.coreplatform.entity.UserGroup;
import org.coreplatform.service.GroupService;
import org.coreplatform.util.CoRePlatformConstants;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class GroupController {
	
	static Logger log = Logger.getLogger(GroupController.class.getName());
	
	@RequestMapping(value = "/deleteGroup", method = RequestMethod.POST)
	public String deleteGroup(@RequestParam(value="groupId", required = false) Integer groupId){

		GroupService gs = new GroupService();
		gs.deleteGroup(groupId);
		return "redirect:/groups";
	}
	
	@RequestMapping(value = "/updateGroup", method = RequestMethod.POST)
	public String updateGroup(@RequestParam(value="groupName", required = false) String groupName,
			@RequestParam(value="groupId", required = false) Integer groupId){

		GroupService gs = new GroupService();
		gs.updateGroup(groupId, groupName);
		return "redirect:/groups";
	}
	
	@RequestMapping(value = "/removeUserFromGroup", method = RequestMethod.POST)
	public String removeUserFromGroup(@RequestParam(value="userId", required = false) Integer userId,
			@RequestParam(value="groupId", required = false) Integer groupId,
			HttpServletRequest request){

		GroupService gs = new GroupService();
		Group group = gs.getGroupById(groupId);
		User user = gs.getUserById(userId);
		gs.removeUserFromGroup(user, group);
		return "redirect:/topics/group/"+groupId;
	}
	
	@RequestMapping(value = "/getUsers", method = RequestMethod.GET)
	public @ResponseBody
	String getUsers(HttpServletRequest request) {
		BasicConfigurator.configure();
		log.error("Hello this is a debug message");
		try {
			JSONObject obj = null;
			JSONArray ja = new JSONArray();
			GroupService gs = new GroupService();
			User currentUser = (User) request.getSession().getAttribute("user");
			List<User> users = gs.getUsers(currentUser);
			for (User user : users) {
				obj = new JSONObject();
				obj.put("id", user.getId());
				obj.put("username", user.getUsername());
				ja.put(obj);
			}

			return ja.toString();
		} catch (JSONException e) {
			log.error(CoRePlatformConstants.JSON_ADD_DATA_EXCEPTION + " - getUsers()", e);
		}
		return null;
	}
	
	@RequestMapping(value = "/getGroupById", method = RequestMethod.GET)
	public @ResponseBody
	String getGroupById(@RequestParam(value="groupId", required = false) Integer groupId,
			HttpServletRequest request) {
		
		try {
			JSONObject obj = null;
			GroupService gs = new GroupService();
			Group group = gs.getGroupById(groupId);
			obj = new JSONObject();
			obj.put("id", group.getId());
			obj.put("name", group.getName());

			return obj.toString();
		} catch (JSONException e) {
			log.error(CoRePlatformConstants.JSON_ADD_DATA_EXCEPTION + " - getGroupById()", e);
		}
		return null;
	}
	
	@RequestMapping(value = "/groups", method = RequestMethod.GET)
	public String getGroups(HttpServletRequest request, ModelMap model) {
		
		User user = (User)request.getSession().getAttribute("user");
		model.addAttribute("user",user);
		GroupService gs = new GroupService();
		List<UserGroup> ownerGroups = gs.getOwnerGroups(user);
		List<UserGroup> memberGroups = gs.getMemberGroups(user);
		if(user!=null && CoRePlatformConstants.ADMIN.equals(user.getUsername())==true){
			List<Group> allGroups = gs.getAllGroups();
			model.addAttribute("admin",CoRePlatformConstants.ADMIN);
			model.addAttribute("allGroups",allGroups);
		}
		model.addAttribute("ownerGroups", ownerGroups);
		model.addAttribute("memberGroups", memberGroups);
		
		return "groups";
	}
	
	@RequestMapping(value = "/createGroup", method = RequestMethod.POST)
	public @ResponseBody
	String createGroup(@RequestBody String data, HttpServletRequest request) {

		User user = (User)request.getSession().getAttribute("user");
		GroupService gs = new GroupService();
		gs.createGroup(user, data);
		return "ok";
	}
}
