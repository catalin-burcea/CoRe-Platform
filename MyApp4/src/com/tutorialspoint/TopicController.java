package com.tutorialspoint;

import org.app.entities.Group;
import org.app.entities.Tag;
import org.app.entities.Topic;
import org.app.entities.User;
import org.app.entities.UserGroup;
import org.app.service.GroupService;
import org.app.service.TopicService;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
 
@Controller
public class TopicController {

	private String admin="burceacatalin";
	
	@RequestMapping(value = "/app/getTags", method = RequestMethod.GET)
	public @ResponseBody
	String getTags() throws JSONException {

		JSONObject obj = null;
		JSONArray ja = new JSONArray();
		TopicService ts = new TopicService();
		List<Tag> tags = ts.getTags();
		for(Tag tag: tags){
			obj = new JSONObject();
			obj.put("id", tag.getId());
			obj.put("title", tag.getTitle());
			ja.put(obj);
		}
		return ja.toString();

	}
	
	@RequestMapping(value = "/app/topics", method = RequestMethod.GET)
	public String getTopics(ModelMap model, HttpServletRequest request){

		TopicService topicService = new TopicService();
		List<Topic> topics = null;
		String groupParameter="";
		User user = (User)request.getSession().getAttribute("user");
		model.addAttribute("user",user);
        if(user!=null && admin.equals(user.getUsername())==true){
     	   model.addAttribute("admin",admin);
        }
		String modal="createTopicModal";
		if(user==null){
			modal="notLoggedInModal";
		}
		UserGroup ug = null;
		model.addAttribute("modal", modal);
		if(request.getParameter("groupId")!=null){
			Integer groupId  = Integer.parseInt(request.getParameter("groupId"));
			topics  = topicService.getTopicsByGroupId(groupId);
			groupParameter="&groupId="+groupId;
			GroupService gs = new GroupService();
			Group group = gs.getGroupById(groupId);
			ug = gs.getUserGroup(user, group);
		}else{
			topics = topicService.getTopics();
		}
		model.addAttribute("usergroup", ug);
		model.addAttribute("topics", topics);
		model.addAttribute("groupParameter", groupParameter);
		model.addAttribute("groupId",request.getParameter("groupId"));
		
		return "topics";

	}
	
	@RequestMapping(value = "/app/deleteTopic", method = RequestMethod.POST)
	public
	String deleteTopic(@RequestParam(value="topicId", required = false) Integer topicId,
			@RequestParam(value="groupId", required = false) Integer groupId){
		
		 TopicService ts = new TopicService();
		 ts.deleteTopic(topicId);
		 String groupParameter="";
		 if(groupId!=null){
			 groupParameter="?groupId="+groupId;
		 }
		 return "redirect:/app/topics"+groupParameter;

	}
	
	@RequestMapping(value = "/app/insertTopic", method = RequestMethod.POST)
	public @ResponseBody
	String insertTopic(@RequestParam(value = "createTopicTitle", required = false) String topicTitle,
			@RequestParam(value = "createTopicDescription", required = false) String topicDescription,
			@RequestParam(value = "createTopicCode", required = false) String topicCode,
			@RequestParam(value = "tagId", required = false) Integer tagId,
			@RequestParam(value = "groupId", required = false) Integer groupId,
			HttpServletRequest request) {
		TopicService ts =  new TopicService();
		GroupService gs =  new GroupService();
		Group group = null;
		if(groupId!=null){
			group = gs.getGroupById(groupId);
		}

		Tag tag = ts.getTagById(tagId);
		User user=(User) request.getSession().getAttribute("user");
		ts.insertTopic(tag, group, user, topicTitle, topicDescription, topicCode);
		return "ok";
	}
	
	@RequestMapping(value = "/app/updateTopic", method = RequestMethod.POST)
	public @ResponseBody
	String updateTopic(@RequestParam(value = "topicTitle", required = false) String topicTitle,
			@RequestParam(value = "topicDescription", required = false) String topicDescription,
			@RequestParam(value = "topicCode", required = false) String topicCode,
			@RequestParam(value = "tagId", required = false) Integer tagId,
			@RequestParam(value = "groupId", required = false) Integer groupId,
			@RequestParam(value = "topicId", required = false) Integer topicId) {
		
		TopicService ts =  new TopicService();
		GroupService gs =  new GroupService();
		Tag tag = ts.getTagById(tagId);
		ts.updateTopic(topicId, tag, topicTitle, topicDescription, topicCode);
		
		return "ok";
	}
}
