package org.coreplatform.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.coreplatform.entity.User;
import org.coreplatform.service.GroupService;
import org.coreplatform.service.OnlineUsersService;
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

	@RequestMapping(value = "/getOnlineUsers", method = RequestMethod.GET)
	public void getOnlineUsers(HttpServletResponse response) {
		response.setContentType("text/event-stream");
		response.setCharacterEncoding("UTF-8");
		try {
			PrintWriter writer = response.getWriter();
			boolean updated = false;
			while (true) {
				if (OnlineUsersService.changed < OnlineUsersService.onlineUsers.size()) {
					if(!updated){
						updated = true;
						OnlineUsersService.changed++;
						writer.write("event:onlineUsers\n");
						writer.write("data: " + OnlineUsersService.onlineUsers.toString() + "\n\n");
						writer.flush();
					}
				}else{
					updated = false;
				}
			}
		} catch (IOException e1) {
			log.error("error getting response.getWriter()" + " - getOnlineUsers()", e1);
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