package com.tutorialspoint;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.app.entities.User;
import org.app.service.ActiveUsersService;
import org.app.service.GroupService;
import org.app.service.TopicService;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.ui.ModelMap;

@Controller

public class UserController{
 
	   @RequestMapping(value="/app/isLoggedIn",method = RequestMethod.GET)
	   public @ResponseBody String isLoggedIn(HttpServletRequest request) {
		   
		  User user = (User) request.getSession().getAttribute("user");
		  if(user!=null){
			  return "true";
		  }
	      return "false";
	   }
   
   @RequestMapping(value="/app/getActiveUsers",method = RequestMethod.GET)
   public @ResponseBody String getActiveUsers() throws JSONException {
	   
		JSONObject obj = null;
		JSONArray ja = new JSONArray();
		for(int i=0;i<ActiveUsersService.activeUsers.size();i++){
			obj = new JSONObject();
			obj.put("id", ActiveUsersService.activeUsers.get(i));
			ja.put(obj);
		}

      return ja.toString();
   }
   
	@RequestMapping(value = "/app/users", method = RequestMethod.GET)
	public String getUsers(ModelMap model){
		
		GroupService gs= new GroupService();
		List<User> users = gs.getUsers();
		model.addAttribute("users", users);
		model.addAttribute("groupService", gs);
	    return "users";

	}
}