package org.coreplatform.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.coreplatform.entity.Comment;
import org.coreplatform.entity.Group;
import org.coreplatform.entity.Review;
import org.coreplatform.entity.Topic;
import org.coreplatform.entity.User;
import org.coreplatform.entity.UserGroup;
import org.coreplatform.entity.UserReviewVote;
import org.coreplatform.entity.UserReviewVoteId;
import org.coreplatform.util.HibernateUtil;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;

public class ViewTopicService {
	
	public void deleteComment(Integer commentId){
        Session session = HibernateUtil.openSession();
        Comment comment=null;
        Transaction tx = null;        
        try {
            tx = session.getTransaction();
            tx.begin();
            comment = (Comment) session.createCriteria(Comment.class)
            		.add(Restrictions.eq("id",commentId )).uniqueResult();  
            session.delete(comment);
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
	
	public boolean isAdmin(Group group, User user){
        Session session = HibernateUtil.openSession();
        UserGroup ug=null;
        Transaction tx = null;        
        try {
            tx = session.getTransaction();
            tx.begin();
            ug = (UserGroup) session.createCriteria(UserGroup.class)
            		.add(Restrictions.eq("group",group ))
            		.add(Restrictions.eq("user",user ))
            		.add(Restrictions.eq("ownership","yes"))
            		.uniqueResult();  
            
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
	
	public void deleteReview(Integer reviewId){
        Session session = HibernateUtil.openSession();
        Review review=null;
        Transaction tx = null;        
        try {
            tx = session.getTransaction();
            tx.begin();
            review = (Review) session.createCriteria(Review.class)
            		.add(Restrictions.eq("id",reviewId )).uniqueResult();  
            session.delete(review);
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
	
	
	public Review getReviewById(Integer reviewId){
		Review review = null;
        Session session = HibernateUtil.openSession();
        Transaction tx = null;        
        try {
            tx = session.getTransaction();
            tx.begin();
            review = (Review) session.createCriteria(Review.class)
            		.add(Restrictions.eq("id",reviewId )).uniqueResult();                        
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                tx.rollback();
            }
            e.printStackTrace();
        } finally {
            session.close();
        }
        return review;
	}
	
	@SuppressWarnings("unchecked")
	public List<Comment> getTopicComments(Topic topic){
		List<Comment> comments =  new ArrayList<Comment>();;
        Session session = HibernateUtil.openSession();
        Transaction tx = null;        
        try {
            tx = session.getTransaction();
            tx.begin();
            Criteria criteria= session.createCriteria(Comment.class);
            criteria.add(Restrictions.eq("topic", topic));
            comments=criteria.list();
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                tx.rollback();
            }
            e.printStackTrace();
        } finally {
            session.close();
        }
        return comments;
	}
	
	@SuppressWarnings("unchecked")
	public List<Comment>  getReviewComments(Review review){
		List<Comment> comments =  new ArrayList<Comment>();;
        Session session = HibernateUtil.openSession();
        Transaction tx = null;        
        try {
            tx = session.getTransaction();
            tx.begin();
            Criteria criteria= session.createCriteria(Comment.class);
            criteria.add(Restrictions.eq("review", review));
            comments=criteria.list();
                     
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                tx.rollback();
            }
            e.printStackTrace();
        } finally {
            session.close();
        }
        return comments;
	}
	
	public boolean insertTopicComment(String content, User user, Topic topic){
	    Session session = HibernateUtil.openSession();
	    Transaction tx = null;        
	    try {
	        tx = session.getTransaction();
	        tx.begin();
	        Comment  comment=new Comment(null,topic,user, content, new Date());
	        session.save(comment);
	        tx.commit();
	    } catch (Exception e) {
	        if (tx != null) {
	            tx.rollback();
	        }
	        e.printStackTrace();
	        return false;
	    } finally {
	        session.close();
	    }
	    return true;
	}
	
	public boolean insertStars(Integer numberOfStars, Review review, User user){
	    Session session = HibernateUtil.openSession();
	    Transaction tx = null;        
	    try {
	        tx = session.getTransaction();
	        tx.begin();
	        UserReviewVote urv = new UserReviewVote(new UserReviewVoteId(user.getId(),review.getId()),
	        		review, user, numberOfStars);
	        session.save(urv);
	        tx.commit();
	    } catch (Exception e) {
	        if (tx != null) {
	            tx.rollback();
	        }
	        e.printStackTrace();
	        return false;
	    } finally {
	        session.close();
	    }
	    return true;
	}
	
	public UserReviewVote getUserReviewVote(Review review, User user){
	    Session session = HibernateUtil.openSession();
	    Transaction tx = null;        
	    UserReviewVote urv = null;
	    try {
	        tx = session.getTransaction();
	        tx.begin();
	        urv =  (UserReviewVote) session.createCriteria(UserReviewVote.class)
	        		.add(Restrictions.eq("review", review))
	        		.add(Restrictions.eq("user", user))
	        		.uniqueResult();
	        tx.commit();
	    } catch (Exception e) {
	        if (tx != null) {
	            tx.rollback();
	        }
	        e.printStackTrace();
	    } finally {
	        session.close();
	    }
	    return urv;
	}
	
	public Double getReviewStars(Review review){
	    Session session = HibernateUtil.openSession();
	    Transaction tx = null;        
	    Double numberOfStars = null;
	    try {
	        tx = session.getTransaction();
	        tx.begin();
	        numberOfStars = (Double)session.createCriteria(UserReviewVote.class)
	        		.add(Restrictions.eq("review", review))
	        	    .setProjection( Projections.avg("stars")).uniqueResult();
	        tx.commit();
	    } catch (Exception e) {
	        if (tx != null) {
	            tx.rollback();
	        }
	        e.printStackTrace();
	    } finally {
	        session.close();
	    }
	    if(numberOfStars == null){
	    	return 0.0;
	    }
	    return numberOfStars;
	}
	
	public boolean insertReviewComment(String content, User user, Review review){
	    Session session = HibernateUtil.openSession();
	    Transaction tx = null;        
	    try {
	        tx = session.getTransaction();
	        tx.begin();
	        Comment  comment=new Comment(review, null,user, content, new Date());
	        session.save(comment);
	        tx.commit();
	    } catch (Exception e) {
	        if (tx != null) {
	            tx.rollback();
	        }
	        e.printStackTrace();
	        return false;
	    } finally {
	        session.close();
	    }
	    return true;
	}
	
	public boolean insertReview(String code, String description, User user, Topic topic){
	    Session session = HibernateUtil.openSession();
	    Transaction tx = null;        
	    try {
	        tx = session.getTransaction();
	        tx.begin();
	        Review review=new Review(topic, user, description, code, new Date(),null,null);
	        session.save(review);
	        tx.commit();
	    } catch (Exception e) {
	        if (tx != null) {
	            tx.rollback();
	        }
	        e.printStackTrace();
	        return false;
	    } finally {
	        session.close();
	    }
	    return true;
	}
}
