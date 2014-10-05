package com.tutorialspoint;

import java.util.List;
 
import javax.servlet.http.HttpServletRequest;

import org.app.entities.Group; 
import org.app.entities.User;
import org.app.entities.UserGroup;
import org.app.service.GroupService;
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
	
	private String admin="burceacatalin";
	
	@RequestMapping(value = "/app/deleteGroup", method = RequestMethod.POST)
	public String deleteGroup(@RequestParam(value="groupId", required = false) Integer groupId){

		GroupService gs = new GroupService();
		gs.deleteGroup(groupId);
		return "redirect:/app/groups";

	}
	
	@RequestMapping(value = "/app/updateGroup", method = RequestMethod.POST)
	public String updateGroup(@RequestParam(value="groupName", required = false) String groupName,
			@RequestParam(value="groupId", required = false) Integer groupId){

		GroupService gs = new GroupService();
		gs.updateGroup(groupId, groupName);
		return "redirect:/app/groups";

	}
	
	@RequestMapping(value = "/app/removeUserFromGroup", method = RequestMethod.POST)
	public String removeUserFromGroup(@RequestParam(value="userId", required = false) Integer userId,
			@RequestParam(value="groupId", required = false) Integer groupId,
			HttpServletRequest request){

		GroupService gs = new GroupService();
		Group group = gs.getGroupById(groupId);
		User user = gs.getUserById(userId);
		gs.removeUserFromGroup(user, group);
		return "redirect:/app/topics?groupId="+groupId;

	}
	
	@RequestMapping(value = "/app/getUsers", method = RequestMethod.GET)
	public @ResponseBody
	String getUsers(HttpServletRequest request) throws JSONException {

		JSONObject obj = null;
		JSONArray ja = new JSONArray();
		GroupService gs = new GroupService();
		User currentUser = (User)request.getSession().getAttribute("user");
		List<User> users = gs.getUsers(currentUser);
		for(User user: users){
			obj = new JSONObject();
			obj.put("id", user.getId());
			obj.put("username", user.getUsername());
			ja.put(obj);
		}

		return ja.toString();

	}
	@RequestMapping(value = "/app/getGroupById", method = RequestMethod.GET)
	public @ResponseBody
	String getGroupById(@RequestParam(value="groupId", required = false) Integer groupId,
			HttpServletRequest request) throws JSONException {

		JSONObject obj = null;
		GroupService gs = new GroupService();
		Group group = gs.getGroupById(groupId);
		obj = new JSONObject();
		obj.put("id", group.getId());
		obj.put("name", group.getName());

		return obj.toString();

	}
	
	@RequestMapping(value = "/app/groups", method = RequestMethod.GET)
	public String getGroups(HttpServletRequest request, ModelMap model) throws JSONException {
		
		User user = (User)request.getSession().getAttribute("user");
		model.addAttribute("user",user);
		GroupService gs = new GroupService();
		List<UserGroup> ownerGroups = gs.getOwnerGroups(user);
		List<UserGroup> memberGroups = gs.getMemberGroups(user);
		if(user!=null && admin.equals(user.getUsername())==true){
			List<Group> allGroups = gs.getAllGroups();
			model.addAttribute("admin",admin);
			model.addAttribute("allGroups",allGroups);
		}
		model.addAttribute("ownerGroups", ownerGroups);
		model.addAttribute("memberGroups", memberGroups);
		
		return "groups";

	}
	
	@RequestMapping(value = "/app/createGroup", method = RequestMethod.POST)
	public @ResponseBody
	String createGroup(@RequestBody String data,
			HttpServletRequest request) throws JSONException {

		User user = (User)request.getSession().getAttribute("user");
		GroupService gs = new GroupService();
		gs.createGroup(user, data);
		return "ok";

	}
}
