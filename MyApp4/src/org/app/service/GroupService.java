package org.app.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.app.entities.Group;
import org.app.entities.User;
import org.app.entities.UserGroup;
import org.app.entities.UserGroupId;
import org.app.entities.UserReviewVote;
import org.app.util.HibernateUtil;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.json.JSONArray;
import org.json.JSONObject;

public class GroupService {
	
	public void deleteGroup(Integer groupId){
        Session session = HibernateUtil.openSession();
        Group group=null;
        Transaction tx = null;        
        try {
            tx = session.getTransaction();
            tx.begin();
            group = (Group) session.createCriteria(Group.class)
            		.add(Restrictions.eq("id",groupId )).uniqueResult();  
            session.delete(group);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                tx.rollback();
            }
            e.printStackTrace();
        } finally {
            session.close();
        }
    }
	
	public void updateGroup(Integer groupId, String name){
        Session session = HibernateUtil.openSession();
        Group group=null;
        Transaction tx = null;        
        try {
            tx = session.getTransaction();
            tx.begin();
            group = (Group) session.createCriteria(Group.class)
            		.add(Restrictions.eq("id",groupId )).uniqueResult();  
            group.setName(name);
            session.update(group);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                tx.rollback();
            }
            e.printStackTrace();
        } finally {
            session.close();
        }
    }
	
	public void removeUserFromGroup(User user, Group group){
        Session session = HibernateUtil.openSession();
        UserGroup ug=null;
        Transaction tx = null;        
        try {
            tx = session.getTransaction();
            tx.begin();
            ug = (UserGroup) session.createCriteria(UserGroup.class)
            		.add(Restrictions.eq("group",group ))
            		.add(Restrictions.eq("user",user ))
            		.uniqueResult();  
            session.delete(ug);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                tx.rollback();
            }
            e.printStackTrace();
        } finally {
            session.close();
        }
    }
	
	@SuppressWarnings("unchecked")
	public List<UserGroup> getOwnerGroups(User user){
		 List<UserGroup> list = new ArrayList<UserGroup>();
	        Session session = HibernateUtil.openSession();
	        Transaction tx = null;        
	        try {
	            tx = session.getTransaction();
	            tx.begin();
	            Criteria criteria= session.createCriteria(UserGroup.class);
	            criteria.add(Restrictions.eq("user", user));
	            criteria.add(Restrictions.eq("ownership", "yes"));
	            criteria.addOrder(Order.desc("date"));
	            list=criteria.list();
	            tx.commit();
	        } catch (Exception e) {
	            if (tx != null) {
	                tx.rollback();
	            }
	            e.printStackTrace();
	        } finally {
	            session.close();
	        }
	        return list;
	}
	
	public boolean isOwner(User user, Group group){
		 	UserGroup ug= new UserGroup();
	        Session session = HibernateUtil.openSession();
	        Transaction tx = null;        
	        try {
	            tx = session.getTransaction();
	            tx.begin();
	            Criteria criteria= session.createCriteria(UserGroup.class)
	            		.add(Restrictions.eq("user", user))
	            		.add(Restrictions.eq("group", group))
	            		.add(Restrictions.eq("ownership", "yes"));
	            ug=(UserGroup) criteria.uniqueResult();
	            tx.commit();
	        } catch (Exception e) {
	            if (tx != null) {
	                tx.rollback();
	            }
	            e.printStackTrace();
	        } finally {
	            session.close();
	        }
            if(ug==null){
            	return false;
            }
            return true;
	}
	
	@SuppressWarnings("unchecked")
	public List<Group> getAllGroups(){
		 List<Group> list = new ArrayList<Group>();
	        Session session = HibernateUtil.openSession();
	        Transaction tx = null;        
	        try {
	            tx = session.getTransaction();
	            tx.begin();
	            Criteria criteria= session.createCriteria(Group.class);
	            list=criteria.list();
	            tx.commit();
	        } catch (Exception e) {
	            if (tx != null) {
	                tx.rollback();
	            }
	            e.printStackTrace();
	        } finally {
	            session.close();
	        }
	        return list;
	}
	
	
	
	
	@SuppressWarnings("unchecked")
	public List<UserGroup> getMemberGroups(User user){
		 List<UserGroup> list = new ArrayList<UserGroup>();
	        Session session = HibernateUtil.openSession();
	        Transaction tx = null;        
	        try {
	            tx = session.getTransaction();
	            tx.begin();
	            Criteria criteria= session.createCriteria(UserGroup.class);
	            criteria.add(Restrictions.eq("user", user));
	            criteria.add(Restrictions.eq("ownership", "no"));
	            criteria.addOrder(Order.desc("date"));
	            list=criteria.list();
	            tx.commit();
	        } catch (Exception e) {
	            if (tx != null) {
	                tx.rollback();
	            }
	            e.printStackTrace();
	        } finally {
	            session.close();
	        }
	        return list;
	}
	
	@SuppressWarnings("unchecked")
	public List<User> getUsers(User user){
		 List<User> list = new ArrayList<User>();
	        Session session = HibernateUtil.openSession();
	        Transaction tx = null;        
	        try {
	            tx = session.getTransaction();
	            tx.begin();
	            Criteria criteria= session.createCriteria(User.class);
	            criteria.add(Restrictions.ne("id", user.getId()));
	            criteria.addOrder(Order.asc("username"));
	            list=criteria.list();
	            tx.commit();
	        } catch (Exception e) {
	            if (tx != null) {
	                tx.rollback();
	            }
	            e.printStackTrace();
	        } finally {
	            session.close();
	        }
	        return list;
	}
	
	@SuppressWarnings("unchecked")
	public List<User> getUsers(){
		 List<User> list = new ArrayList<User>();
	        Session session = HibernateUtil.openSession();
	        Transaction tx = null;        
	        try {
	            tx = session.getTransaction();
	            tx.begin();
	            Criteria criteria= session.createCriteria(User.class);
	            criteria.addOrder(Order.asc("username"));
	            list=criteria.list();
	            tx.commit();
	        } catch (Exception e) {
	            if (tx != null) {
	                tx.rollback();
	            }
	            e.printStackTrace();
	        } finally {
	            session.close();
	        }
	        return list;
	}
	
	public Long getStars(User user){
			Long stars=0l;
	        Session session = HibernateUtil.openSession();
	        Transaction tx = null;        
	        try {
	            tx = session.getTransaction();
	            tx.begin();
	            Criteria criteria= session.createCriteria(UserReviewVote.class)
	            			.add(Restrictions.eq("user", user))
	            			.setProjection( Projections.sum("stars"));
	            stars=(Long) criteria.uniqueResult();
	            tx.commit();
	        } catch (Exception e) {
	            if (tx != null) {
	                tx.rollback();
	            }
	            e.printStackTrace();
	        } finally {
	            session.close();
	        }
	        if(stars==null) return 0l;
	        return stars;
	}
	
	public User getUserById(Integer userId){
		 	User user = null; 
	        Session session = HibernateUtil.openSession();
	        Transaction tx = null;        
	        try {
	            tx = session.getTransaction();
	            tx.begin();
	            Criteria criteria= session.createCriteria(User.class);
	            criteria.add(Restrictions.eq("id", userId));
	            user = (User) criteria.uniqueResult();
	            tx.commit();
	        } catch (Exception e) {
	            if (tx != null) {
	                tx.rollback();
	            }
	            e.printStackTrace();
	        } finally {
	            session.close();
	        }
	        return user;
	}
	
	@SuppressWarnings("unchecked")
	public List<UserGroup> getGroupMembers(Group group){
		 List<UserGroup> list = new ArrayList<UserGroup>();
	        Session session = HibernateUtil.openSession();
	        Transaction tx = null;        
	        try {
	            tx = session.getTransaction();
	            tx.begin();
	            Criteria criteria= session.createCriteria(UserGroup.class);
	            criteria.add(Restrictions.eq("group", group));
	            criteria.addOrder(Order.desc("ownership"));
	            list=criteria.list();
	            tx.commit();
	        } catch (Exception e) {
	            if (tx != null) {
	                tx.rollback();
	            }
	            e.printStackTrace();
	        } finally {
	            session.close();
	        }
	        return list;
	}
	
	public Group getGroupById(Integer groupId){
		Group group =  null;
        Session session = HibernateUtil.openSession();
        Transaction tx = null;        
        try {
            tx = session.getTransaction();
            tx.begin();
            Criteria criteria= session.createCriteria(Group.class);
            criteria.add(Restrictions.eq("id", groupId));
            group = (Group) criteria.uniqueResult();
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                tx.rollback();
            }
            e.printStackTrace();
        } finally {
            session.close();
        }
        return group;
	}
	
	
	public Group createGroup(User user, String data){
	        Session session = HibernateUtil.openSession();
	        Transaction tx = null;     
	        Group group=null;
	        try {
	            tx = session.getTransaction();
	            tx.begin();
	            JSONObject obj = new JSONObject(data);
	            String name = obj.getString("name");
	            group = new Group(name);
	            session.save(group);
	            UserGroup ug = new UserGroup(new UserGroupId(user.getId(),group.getId()),group,user,new Date(),"yes");
	            session.save(ug);
	    		JSONArray ja = new JSONArray(obj.get("memberIds").toString());
	    		for(int i=0;i<ja.length();i++){
	    	 		JSONObject aux = new JSONObject(ja.get(i).toString());
	    	 		Integer userId = (Integer) aux.getInt("memberId");
	    	 		Criteria criteria= session.createCriteria(User.class);
	    	 		criteria.add(Restrictions.eq("id", userId));
	    	 		User currentUser = (User) criteria.list().get(0);
	    	 		ug = new UserGroup(new UserGroupId(currentUser.getId(),group.getId()),group,currentUser,new Date(),"no");
	    	 		session.save(ug);
	    		}
	   
	            tx.commit();
	        } catch (Exception e) {
	            if (tx != null) {
	                tx.rollback();
	            }
	            e.printStackTrace();
	        } finally {
	            session.close();
	        }
	        return group;
	}
	
	public UserGroup getUserGroup(User user, Group group){
        Session session = HibernateUtil.openSession();
        Transaction tx = null;
        UserGroup ug= null;
        try {
            tx = session.getTransaction();
            tx.begin();
            Criteria criteria= session.createCriteria(UserGroup.class);
            criteria.add(Restrictions.eq("user", user));
            criteria.add(Restrictions.eq("group", group));
            ug=(UserGroup) criteria.uniqueResult();
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                tx.rollback();
            }
            e.printStackTrace();
        } finally {
            session.close();
        }
        return ug;
	}

	
}
