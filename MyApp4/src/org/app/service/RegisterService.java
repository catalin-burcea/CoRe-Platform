
package org.app.service;

import org.app.entities.User;
import org.app.util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;

public class RegisterService {
        
    public void register(User user){
	        Session session = HibernateUtil.openSession();       
       
	        Transaction tx = null;        
	        try {
	            tx = session.getTransaction();
	            tx.begin();
	            session.saveOrUpdate(user);            
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
    
    
    
    public boolean validEmail(String email){
        Session session = HibernateUtil.openSession();
        boolean result = false;
        Transaction tx = null;
        try{
            tx = session.getTransaction();
            tx.begin();
            User u = (User) session.createCriteria(User.class)
            		.add(Restrictions.eq("email",email)).uniqueResult();     
            tx.commit();
            if(u!=null) result = true;
        }catch(Exception ex){
            if(tx!=null){
                tx.rollback();
            }
        }finally{
            session.close();
        }
        return result;
    }
    
    public boolean validUsernameLength(String username){
    	if(username.length()<6 || username.length()>20){
    		return false;
    	}
    	return true;
    }
    
    public boolean validPasswordLength(String password){
    	if(password.length()<6 || password.length()>20){
    		return false;
    	}
    	return true;
    }
    
    public boolean passwordsAreEqual(String password, String repeatPassword){
    	if(!password.equals(repeatPassword)){
    		return false;
    	}
    	return true;
    }

}
