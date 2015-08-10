package org.coreplatform.service;

import org.coreplatform.entity.User;
import org.coreplatform.util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;

public class LoginService {

    public boolean authenticate(String username, String password) {
		if (username != null && password != null) {
			password = CryptWithMD5.cryptWithMD5(password);
			User user = getUser(username, password);
			if (user != null) {
				return true;
			}
		}
		return false;
    }
    
    public User getUser(String username, String password) {
        Session session = HibernateUtil.openSession();
        Transaction tx = null;
        User user = null;
        try {
            tx = session.getTransaction();
            tx.begin();
            user = (User)session.createCriteria(User.class)
            		.add(Restrictions.eq("username",username ))
            		.add(Restrictions.eq("password",password)).uniqueResult();    
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

    public User getUser(String username) {
        Session session = HibernateUtil.openSession();
        Transaction tx = null;
        User user = null;
        try {
            tx = session.getTransaction();
            tx.begin();
            user = (User)session.createCriteria(User.class)
            		.add(Restrictions.eq("username",username )).uniqueResult();    
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
}
