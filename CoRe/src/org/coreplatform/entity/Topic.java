package org.coreplatform.entity;

// Generated Jun 3, 2014 5:42:39 PM by Hibernate Tools 3.4.0.CR1

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import org.springframework.stereotype.Repository;

/**
 * Topic generated by hbm2java
 */
@Repository
public class Topic implements java.io.Serializable {

	private Integer id;
	private Tag tag;
	private Group group;
	private User user;
	private String title;
	private String description;
	private String code;
	private Date date;
	private Set<Review> reviews = new HashSet<Review>(0);
	private Set<Comment> comments = new HashSet<Comment>(0);

	public Topic() {
	}

	public Topic(String title, String description, String code, Date date) {
		this.title = title;
		this.description = description;
		this.code = code;
		this.date = date;
	}

	public Topic(Tag tag, Group group, User user, String title,
			String description, String code, Date date, Set<Review> reviews,
			Set<Comment> comments) {
		this.tag = tag;
		this.group = group;
		this.user = user;
		this.title = title;
		this.description = description;
		this.code = code;
		this.date = date;
		this.reviews = reviews;
		this.comments = comments;
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Tag getTag() {
		return this.tag;
	}

	public void setTag(Tag tag) {
		this.tag = tag;
	}

	public Group getGroup() {
		return this.group;
	}

	public void setGroup(Group group) {
		this.group = group;
	}

	public User getUser() {
		return this.user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public String getTitle() {
		return this.title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getCode() {
		return this.code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public Date getDate() {
		return this.date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public Set<Review> getReviews() {
		return this.reviews;
	}

	public void setReviews(Set<Review> reviews) {
		this.reviews = reviews;
	}

	public Set<Comment> getComments() {
		return this.comments;
	}

	public void setComments(Set<Comment> comments) {
		this.comments = comments;
	}

}
