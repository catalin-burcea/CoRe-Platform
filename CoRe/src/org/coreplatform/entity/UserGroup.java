package org.coreplatform.entity;

// Generated Jun 3, 2014 5:42:39 PM by Hibernate Tools 3.4.0.CR1

import java.util.Date;

import org.springframework.stereotype.Repository;

/**
 * UserGroup generated by hbm2java
 */
@Repository
public class UserGroup implements java.io.Serializable {

	private UserGroupId id;
	private Group group;
	private User user;
	private Date date;
	private String ownership;

	public UserGroup() {
	}

	public UserGroup(UserGroupId id, Group group, User user, Date date,
			String ownership) {
		this.id = id;
		this.group = group;
		this.user = user;
		this.date = date;
		this.ownership = ownership;
	}

	public UserGroupId getId() {
		return this.id;
	}

	public void setId(UserGroupId id) {
		this.id = id;
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

	public Date getDate() {
		return this.date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public String getOwnership() {
		return this.ownership;
	}

	public void setOwnership(String ownership) {
		this.ownership = ownership;
	}

}
