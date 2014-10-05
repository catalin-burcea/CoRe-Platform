package com.tutorialspoint;

import com.google.gson.Gson;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.app.entities.Comment;
import org.app.entities.Group;
import org.app.entities.Review;
import org.app.entities.Topic;
import org.app.entities.User;
import org.app.entities.UserGroup;
import org.app.entities.UserReviewVote;
import org.app.service.GroupService;
import org.app.service.TopicService;
import org.app.service.ViewTopicService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.ui.ModelMap;


@Controller
public class ViewTopicController {

	private String admin="burceacatalin";
	
	@RequestMapping(value = "/app/viewTopic", method = RequestMethod.GET)
	public String getViewTopicData(@RequestParam(value = "topicId", required = false) Integer topicId,
			@RequestParam(value = "groupId", required = false) Integer groupId,
			ModelMap model,
			HttpServletRequest request) {
		
		User user = (User)request.getSession().getAttribute("user");
		String modal="reviewModal";
		if(user==null){
			modal="notLoggedInModal";
		}
		model.addAttribute("modal",modal);
		model.addAttribute("groupId",groupId);
		model.addAttribute("user",user);
		GroupService gs = new GroupService();
		Group group = gs.getGroupById(groupId);
		UserGroup ug = gs.getUserGroup(user, group);
		model.addAttribute("usergroup", ug);

		return "viewTopic";
	}


	@RequestMapping(value = "/app/getTopicById", method = RequestMethod.GET)
	public @ResponseBody
	String getTopicById(@RequestParam(value = "topicId") Integer topicId)
			throws JSONException {
		JSONObject obj=null;
		String json=null;
		if (topicId != null) {
			TopicService ts = new TopicService();
			Topic topic = ts.getTopicById(topicId);
			obj = new JSONObject();
			obj.put("code", topic.getCode());
			obj.put("title", topic.getTitle());
			obj.put("description", topic.getDescription());
			obj.put("date", topic.getDate().toString());
			obj.put("language", topic.getTag().getTitle());
			obj.put("username", topic.getUser().getUsername());
			if(topic.getGroup()!=null){
				obj.put("groupId", topic.getGroup().getId());
			}
			List<Integer> listOfReviewIds = new ArrayList<Integer>();
			for(Review a:topic.getReviews()){
				listOfReviewIds.add(a.getId());
			}
			json = new Gson().toJson(listOfReviewIds);
			obj.put("ids", json.toString());
		}

		return obj.toString();
	}
	
	@RequestMapping(value = "/app/getReviewById", method = RequestMethod.GET)
	public @ResponseBody
	String getReviewById(@RequestParam(value = "reviewId") Integer reviewId) throws JSONException {
		JSONObject obj=null;
		ViewTopicService vts=new ViewTopicService();
		Review review=vts.getReviewById(reviewId);		
		obj = new JSONObject();
		obj.put("id", review.getId());
		obj.put("code", review.getCode());
		obj.put("description", review.getDescription());
		obj.put("date", review.getDate().toString());
		obj.put("username", review.getUser().getUsername());
		return obj.toString();
	}
	
	@RequestMapping(value = "/app/getReviewStars", method = RequestMethod.GET)
	public @ResponseBody
	String getReviewStars(@RequestParam(value = "reviewId") Integer reviewId) {
		ViewTopicService vts=new ViewTopicService();
		Review review=vts.getReviewById(reviewId);	
		Double stars = vts.getReviewStars(review);
	    DecimalFormat f = new DecimalFormat("0.00");
		return f.format(stars);
	}
	
	@RequestMapping(value = "/app/getTopicComments", method = RequestMethod.GET)
	public @ResponseBody
	String getTopicComments(@RequestParam(value = "topicId") Integer topicId,
			HttpServletRequest request) 
			throws JSONException {
		
		JSONObject obj = null;
		JSONArray ja = new JSONArray();
		if (topicId != null) {
			ViewTopicService vts=new ViewTopicService();
			TopicService ts = new TopicService();
			Topic topic = ts.getTopicById(topicId);
			List<Comment> comments = vts.getTopicComments(topic);
			for(Comment comment: comments){
				obj = new JSONObject();
				obj.put("id", comment.getId());
				obj.put("content", comment.getContent());
				obj.put("date", comment.getDate());
				obj.put("username", comment.getUser().getUsername());
				obj.put("name", comment.getUser().getFirstName()+" "+comment.getUser().getLastName());
				ja.put(obj);
			}

		}
		
		return ja.toString();
	}
	
	@RequestMapping(value = "/app/getAdmin", method = RequestMethod.GET)
	public @ResponseBody
	String getAdmin(@RequestParam(value = "groupId", required=false) String groupId,
			HttpServletRequest request) 
			throws JSONException {
		
		JSONObject obj = new JSONObject();
		User user = (User)request.getSession().getAttribute("user");
        if(user!=null && admin.equals(user.getUsername())==true){
			obj.put("admin", admin);
        }
        if(!groupId.equals("null")){
            ViewTopicService vts = new ViewTopicService();
            GroupService gs = new GroupService();
            Group group = gs.getGroupById(Integer.parseInt(groupId));
            boolean isAdmin = vts.isAdmin(group, user);
            if(isAdmin==true){
            	obj.put("groupAdmin", user);
            }
        }

		return obj.toString();
	}
	
	@RequestMapping(value = "/app/deleteComment", method = RequestMethod.POST)
	public String deleteGroup(@RequestParam(value="commentId", required = false) Integer commentId,
			@RequestParam(value="topicId", required = false) Integer topicId,
			@RequestParam(value="groupId", required = false) String groupId){

		ViewTopicService vts = new ViewTopicService();
		vts.deleteComment(commentId);
		String groupParameter="";
		if(!groupId.equals("null")){
			groupParameter="&groupId="+groupId;
		}
		return "redirect:/app/viewTopic?topicId="+topicId+groupParameter;
		
	}
	
	@RequestMapping(value = "/app/deleteReview", method = RequestMethod.POST)
	public String deleteReview(@RequestParam(value="reviewId", required = false) Integer reviewId,
			@RequestParam(value="topicId", required = false) Integer topicId,
			@RequestParam(value="groupId", required = false) String groupId){

		ViewTopicService vts = new ViewTopicService();
		vts.deleteReview(reviewId);
		String groupParameter="";
		if(!groupId.equals("null")){
			groupParameter="&groupId="+groupId;
		}
		return "redirect:/app/viewTopic?topicId="+topicId+groupParameter;

	}
	
	@RequestMapping(value = "/app/getReviewComments", method = RequestMethod.GET)
	public @ResponseBody
	String getReviewComments(@RequestParam(value = "reviewId") Integer reviewId) 
			throws JSONException {
		
		JSONObject obj = null;
		JSONArray ja = new JSONArray();
		if (reviewId != null) {
			ViewTopicService vts=new ViewTopicService();
			Review review = vts.getReviewById(reviewId);
			List<Comment> comments = vts.getReviewComments(review);
			for(Comment comment: comments){
				obj = new JSONObject();
				obj.put("id", comment.getId());
				obj.put("content", comment.getContent());
				obj.put("date", comment.getDate());
				obj.put("username", comment.getUser().getUsername());
				obj.put("name", comment.getUser().getFirstName()+" "+comment.getUser().getLastName());
				ja.put(obj);
			}
		}
		
		return ja.toString();
	}

	@RequestMapping(value = "/app/insertTopicComment", method = RequestMethod.POST)
	public @ResponseBody String insertTopicComment(
			@RequestParam(value = "postTopicComment", required = false) String topicComment,
			@RequestParam(value = "topicId", required = false) Integer topicId,
			HttpServletRequest request) {
		
		User user=(User) request.getSession().getAttribute("user");
		TopicService t = new TopicService();
		Topic topic = t.getTopicById(topicId);
		ViewTopicService vts = new ViewTopicService();
		vts.insertTopicComment(topicComment, user, topic);
		return "ok";
	}
	
	@RequestMapping(value = "/app/insertReviewComment", method = RequestMethod.POST)
	public @ResponseBody String insertReviewComment(
			@RequestParam(value = "postReviewComment", required = false) String reviewComment,
			@RequestParam(value = "reviewId", required = false) Integer reviewId,
			HttpServletRequest request) {
		
		User user=(User) request.getSession().getAttribute("user");
		ViewTopicService vts = new ViewTopicService();
		Review review = vts.getReviewById(reviewId);
		vts.insertReviewComment(reviewComment, user, review);
		return "ok";
	}
	
	
	@RequestMapping(value = "/app/addStars", method = RequestMethod.POST)
	public @ResponseBody
	String addStars(@RequestParam(value = "numberOfStars") Integer numberOfStars,
			@RequestParam(value = "reviewId") Integer reviewId,
			HttpServletRequest request)
			throws JSONException {
		
		User user=(User) request.getSession().getAttribute("user");
		ViewTopicService vts = new ViewTopicService();
		Review review = vts.getReviewById(reviewId);
		vts.insertStars(numberOfStars, review, user);
		
		return "ok";
	}
	
	@RequestMapping(value = "/app/getUserReviewStars", method = RequestMethod.GET)
	public @ResponseBody
	String getUserReviewStars(@RequestParam(value = "reviewId") Integer reviewId,
			HttpServletRequest request){

		User user=(User) request.getSession().getAttribute("user");
		ViewTopicService vts = new ViewTopicService();
		Review review = vts.getReviewById(reviewId);
		UserReviewVote urv = vts.getUserReviewVote(review, user);
		if(urv==null){
			return "0";
		}
		return urv.getStars()+"";
	}
	
	@RequestMapping(value = "/app/insertReview", method = RequestMethod.POST)
	public @ResponseBody String insertReview(@RequestParam(value = "reviewCode", required = false) String reviewCode,
			@RequestParam(value = "reviewDescription", required = false) String reviewDescription,
			@RequestParam(value = "topicId", required = false) Integer topicId,
			HttpServletRequest request) {
		User user=(User) request.getSession().getAttribute("user");
		TopicService ts = new TopicService();
		Topic topic = ts.getTopicById(topicId);
		ViewTopicService vts = new ViewTopicService();
		vts.insertReview(reviewCode, reviewDescription, user, topic);
		return "ok";
	}
}
