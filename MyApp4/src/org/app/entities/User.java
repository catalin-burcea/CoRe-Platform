package org.app.entities;

// Generated Jun 3, 2014 5:42:39 PM by Hibernate Tools 3.4.0.CR1

import java.util.HashSet;
import java.util.Set;

/**
 * User generated by hbm2java
 */
public class User implements java.io.Serializable {

	private Integer id;
	private String firstName;
	private String lastName;
	private String username;
	private String email;
	private String password;
	private Set<UserGroup> userGroups = new HashSet<UserGroup>(0);
	private Set<Comment> comments = new HashSet<Comment>(0);
	private Set<Review> reviews = new HashSet<Review>(0);
	private Set<Topic> topics = new HashSet<Topic>(0);
	private Set<UserReviewVote> userReviewVotes = new HashSet<UserReviewVote>(0);

	public User() {
	}

	public User(String username, String password) {
		this.username = username;
		this.password = password;
	}

	public User(String firstName, String lastName, String username,
			String email, String password, Set<UserGroup> userGroups,
			Set<Comment> comments, Set<Review> reviews, Set<Topic> topics,
			Set<UserReviewVote> userReviewVotes) {
		this.firstName = firstName;
		this.lastName = lastName;
		this.username = username;
		this.email = email;
		this.password = password;
		this.userGroups = userGroups;
		this.comments = comments;
		this.reviews = reviews;
		this.topics = topics;
		this.userReviewVotes = userReviewVotes;
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getFirstName() {
		return this.firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return this.lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getUsername() {
		return this.username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getEmail() {
		return this.email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return this.password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public Set<UserGroup> getUserGroups() {
		return this.userGroups;
	}

	public void setUserGroups(Set<UserGroup> userGroups) {
		this.userGroups = userGroups;
	}

	public Set<Comment> getComments() {
		return this.comments;
	}

	public void setComments(Set<Comment> comments) {
		this.comments = comments;
	}

	public Set<Review> getReviews() {
		return this.reviews;
	}

	public void setReviews(Set<Review> reviews) {
		this.reviews = reviews;
	}

	public Set<Topic> getTopics() {
		return this.topics;
	}

	public void setTopics(Set<Topic> topics) {
		this.topics = topics;
	}

	public Set<UserReviewVote> getUserReviewVotes() {
		return this.userReviewVotes;
	}

	public void setUserReviewVotes(Set<UserReviewVote> userReviewVotes) {
		this.userReviewVotes = userReviewVotes;
	}

}
