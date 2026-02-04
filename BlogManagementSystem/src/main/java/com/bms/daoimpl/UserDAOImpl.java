package com.bms.daoimpl;

import com.bms.dao.UserDAO;
import com.bms.pojo.User;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
@Transactional
public class UserDAOImpl implements UserDAO {
    @Autowired
    private SessionFactory sessionFactory;
    private Session getSession() { return sessionFactory.getCurrentSession(); }
    
    @Override
    public void saveUser(User user) {
        Session session = sessionFactory.getCurrentSession();
        session.save(user);
    }
    
    @Override
    public void updateUser(User user) {
        Session session = sessionFactory.getCurrentSession();
        session.update(user);
    }
    
    @Override
    public void deleteUser(int userId) {
        Session session = sessionFactory.getCurrentSession();
        User user = session.get(User.class, userId);
        if (user != null) {
            session.delete(user);
        }
    }
    
    @Override
    public User getUserById(int userId) {
        Session session = sessionFactory.getCurrentSession();
        return session.get(User.class, userId);
    }
    
    @Override
    public User getUserByEmail(String email) {
        Session session = sessionFactory.getCurrentSession();
        Query<User> query = session.createQuery("FROM User WHERE email = :email", User.class);
        query.setParameter("email", email);
        return query.uniqueResult();
    }
    
    @Override
    public User getUserByUsername(String username) {
        Session session = sessionFactory.getCurrentSession();
        Query<User> query = session.createQuery("FROM User WHERE username = :username", User.class);
        query.setParameter("username", username);
        return query.uniqueResult();
    }
    
    @Override
    public List<User> getAllUsers() {
        Session session = sessionFactory.getCurrentSession();
        return session.createQuery("FROM User ORDER BY createdAt DESC", User.class).list();
    }
    
    @Override
    public List<User> getUsersByRole(User.Role role) {
        Session session = sessionFactory.getCurrentSession();
        Query<User> query = session.createQuery("FROM User WHERE role = :role", User.class);
        query.setParameter("role", role);
        return query.list();
    }
    
    @Override
    public List<User> getUsersByStatus(User.Status status) {
        Session session = sessionFactory.getCurrentSession();
        Query<User> query = session.createQuery("FROM User WHERE status = :status", User.class);
        query.setParameter("status", status);
        return query.list();
    }
    
    @Override
    public long getTotalUsersCount() {
        Session session = sessionFactory.getCurrentSession();
        Query<Long> query = session.createQuery("SELECT COUNT(*) FROM User", Long.class);
        return query.uniqueResult();
    }
    
    @Override
    public boolean emailExists(String email) {
        return getUserByEmail(email) != null;
    }
    
    @Override
    public boolean usernameExists(String username) {
        return getUserByUsername(username) != null;
    }
}
