package org.app.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.app.entities.Group;
import org.app.entities.Tag;
import org.app.entities.Topic;
import org.app.entities.User;
import org.app.util.HibernateUtil;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;

public class TopicService {
	
	public Topic getTopicById(Integer topicId){
        Session session = HibernateUtil.openSession();
        Topic topic=null;
        Transaction tx = null;        
        try {
            tx = session.getTransaction();
            tx.begin();
            topic = (Topic) session.createCriteria(Topic.class)
            		.add(Restrictions.eq("id",topicId )).list().get(0);  
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                tx.rollback();
            }
            e.printStackTrace();
        } finally {
            session.close();
        }
        return topic;
    }
	
	public void deleteTopic(Integer topicId){
        Session session = HibernateUtil.openSession();
        Topic topic=null;
        Transaction tx = null;        
        try {
            tx = session.getTransaction();
            tx.begin();
            topic = (Topic) session.createCriteria(Topic.class)
            		.add(Restrictions.eq("id",topicId )).uniqueResult();  
            session.delete(topic);
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
	public List<Topic> getTopics(){
		 List<Topic> list = new ArrayList<Topic>();
	        Session session = HibernateUtil.openSession();
	        Transaction tx = null;        
	        try {
	            tx = session.getTransaction();
	            tx.begin();
	            Criteria criteria= session.createCriteria(Topic.class)
	            		.add(Restrictions.isNull("group"))
	            		.addOrder(Order.desc("date"));
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
	public List<Topic> getTopicsByGroupId(Integer groupId){
		 List<Topic> list = new ArrayList<Topic>();
	        Session session = HibernateUtil.openSession();
	        Transaction tx = null;        
	        try {
	            tx = session.getTransaction();
	            tx.begin();
	            GroupService gs = new GroupService();
	            Group group = gs.getGroupById(groupId);
	            Criteria criteria= session.createCriteria(Topic.class);
	            criteria.add(Restrictions.eq("group", group));
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
	public List<Tag> getTags(){
		 List<Tag> list = new ArrayList<Tag>();
	        Session session = HibernateUtil.openSession();
	        Transaction tx = null;        
	        try {
	            tx = session.getTransaction();
	            tx.begin();
	            Criteria criteria= session.createCriteria(Tag.class);
	            criteria.addOrder(Order.asc("title"));
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
	
	public Tag getTagById(Integer tagId){
			Tag tag =  null;
	        Session session = HibernateUtil.openSession();
	        Transaction tx = null;        
	        try {
	            tx = session.getTransaction();
	            tx.begin();
	            Criteria criteria= session.createCriteria(Tag.class);
	            criteria.add(Restrictions.eq("id", tagId));
	            tag = (Tag) criteria.uniqueResult();
	            tx.commit();
	        } catch (Exception e) {
	            if (tx != null) {
	                tx.rollback();
	            }
	            e.printStackTrace();
	        } finally {
	            session.close();
	        }
	        return tag;
	}
	
	
	public void insertTopic(Tag tag, Group group, User user, String title, String description, String code){
	        Session session = HibernateUtil.openSession();
	        Transaction tx = null;        
	        try {
	            tx = session.getTransaction();
	            tx.begin();

	            Topic topic = new Topic(tag, group, user, title, description, code, new Date(),null,null);
	            session.save(topic);
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
	
	public void updateTopic(Integer topicId,Tag tag, String title, String description, String code){
        Session session = HibernateUtil.openSession();
        Transaction tx = null;        
        try {
            tx = session.getTransaction();
            tx.begin();
            Criteria criteria= session.createCriteria(Topic.class);
            criteria.add(Restrictions.eq("id", topicId));
            Topic topic = (Topic) criteria.uniqueResult();
            topic.setCode(code);
            topic.setDescription(description);
            topic.setTitle(title);
            topic.setTag(tag);
            session.update(topic);
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
}
