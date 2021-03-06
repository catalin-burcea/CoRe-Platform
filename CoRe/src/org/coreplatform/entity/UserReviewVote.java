package org.coreplatform.entity;

import org.springframework.stereotype.Repository;

// Generated Jun 3, 2014 5:42:39 PM by Hibernate Tools 3.4.0.CR1

/**
 * UserReviewVote generated by hbm2java
 */
@Repository
public class UserReviewVote implements java.io.Serializable {

	private UserReviewVoteId id;
	private Review review;
	private User user;
	private int stars;

	public UserReviewVote() {
	}

	public UserReviewVote(UserReviewVoteId id, Review review, User user,
			int stars) {
		this.id = id;
		this.review = review;
		this.user = user;
		this.stars = stars;
	}

	public UserReviewVoteId getId() {
		return this.id;
	}

	public void setId(UserReviewVoteId id) {
		this.id = id;
	}

	public Review getReview() {
		return this.review;
	}

	public void setReview(Review review) {
		this.review = review;
	}

	public User getUser() {
		return this.user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public int getStars() {
		return this.stars;
	}

	public void setStars(int stars) {
		this.stars = stars;
	}

}
