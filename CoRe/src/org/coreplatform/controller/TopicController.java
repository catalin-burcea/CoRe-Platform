package org.coreplatform.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.coreplatform.entity.Group;
import org.coreplatform.entity.Tag;
import org.coreplatform.entity.Topic;
import org.coreplatform.entity.User;
import org.coreplatform.entity.UserGroup;
import org.coreplatform.service.GroupService;
import org.coreplatform.service.TopicService;
import org.coreplatform.util.CoRePlatformConstants;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class TopicController {
	
	static Logger log = Logger.getLogger(TopicController.class.getName());

	@RequestMapping(value = "/getTags", method = RequestMethod.GET)
	public @ResponseBody String getTags() {
		try{
			JSONObject obj = null;
			JSONArray ja = new JSONArray();
			TopicService ts = new TopicService();
			List<Tag> tags = ts.getTags();
			for (Tag tag : tags) {
				obj = new JSONObject();
				obj.put("id", tag.getId());
				obj.put("title", tag.getTitle());
				ja.put(obj);
			}
			return ja.toString();
		}catch(JSONException e) {
			log.error(CoRePlatformConstants.JSON_ADD_DATA_EXCEPTION + " - getTags()", e);
			return null;
		}
	}

	private void getTopics(ModelMap model, HttpServletRequest request, Integer groupId) {

		TopicService topicService = new TopicService();
		List<Topic> topics = null;
		String groupParameter = "";
		User user = (User) request.getSession().getAttribute("user");
		model.addAttribute("user", user);
		if (user != null && CoRePlatformConstants.ADMIN.equals(user.getUsername()) == true) {
			model.addAttribute("admin", CoRePlatformConstants.ADMIN);
		}
		String modal = (user == null) ? "notLoggedInModal" : "createTopicModal";

		UserGroup ug = null;
		model.addAttribute("modal", modal);
		if (groupId != null) {
			topics = topicService.getTopicsByGroupId(groupId);
			groupParameter = "/group/" + groupId;
			GroupService gs = new GroupService();
			Group group = gs.getGroupById(groupId);
			boolean isOwner = gs.isOwner(user, group);
			List<UserGroup> groupMembers = gs.getGroupMembers(group);
			ug = gs.getUserGroup(user, group);
			model.addAttribute("isOwner", isOwner);
			model.addAttribute("groupMembers", groupMembers);
		} else {
			topics = topicService.getTopics();
		}
		model.addAttribute("topics", topics);
		model.addAttribute("groupId", groupId);
		model.addAttribute("groupParameter", groupParameter);
		model.addAttribute("usergroup", ug);
		model.addAttribute("projectPath", CoRePlatformConstants.PROJECT_PATH);

	}

	@RequestMapping(value = "/topics", method = RequestMethod.GET)
	public String getPublicTopics(ModelMap model, HttpServletRequest request) {

		this.getTopics(model, request, null);
		return "topics";

	}

	@RequestMapping(value = "/topics/group/{groupId}", method = RequestMethod.GET)
	public String getTopicsByGroupId(ModelMap model, HttpServletRequest request, @PathVariable(value = "groupId") Integer groupId) {

		this.getTopics(model, request, groupId);
		return "topics";

	}

	@RequestMapping(value = "/deleteTopic", method = RequestMethod.POST)
	public String deleteTopic(@RequestParam(value = "topicId", required = false) Integer topicId, @RequestParam(value = "groupId", required = false) Integer groupId) {

		TopicService ts = new TopicService();
		ts.deleteTopic(topicId);
		String groupParameter = groupId != null ? "/group/" + groupId : "";
		
		return "redirect:/topics" + groupParameter;
	}

	@RequestMapping(value = "/insertTopic", method = RequestMethod.POST)
	public @ResponseBody
	String insertTopic(@RequestParam(value = "createTopicTitle", required = false) String topicTitle,
			@RequestParam(value = "createTopicDescription", required = false) String topicDescription, @RequestParam(value = "createTopicCode", required = false) String topicCode,
			@RequestParam(value = "tagId", required = false) Integer tagId, @RequestParam(value = "groupId", required = false) Integer groupId, HttpServletRequest request) {

		TopicService ts = new TopicService();
		GroupService gs = new GroupService();
		Group group = (groupId != null) ? gs.getGroupById(groupId) : null;
		Tag tag = ts.getTagById(tagId);
		User user = (User) request.getSession().getAttribute("user");
		ts.insertTopic(tag, group, user, topicTitle, topicDescription, topicCode);
		
		return "ok";
	}

	@RequestMapping(value = "/updateTopic", method = RequestMethod.POST)
	public @ResponseBody
	String updateTopic(@RequestParam(value = "topicTitle", required = false) String topicTitle,
			@RequestParam(value = "topicDescription", required = false) String topicDescription, @RequestParam(value = "topicCode", required = false) String topicCode,
			@RequestParam(value = "tagId", required = false) Integer tagId, @RequestParam(value = "groupId", required = false) Integer groupId,
			@RequestParam(value = "topicId", required = false) Integer topicId) {

		TopicService ts = new TopicService();
		Tag tag = ts.getTagById(tagId);
		ts.updateTopic(topicId, tag, topicTitle, topicDescription, topicCode);

		return "ok";
	}
}
