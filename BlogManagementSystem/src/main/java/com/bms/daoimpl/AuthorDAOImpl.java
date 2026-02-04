package com.bms.daoimpl;

import com.bms.dao.AuthorDAO;
import com.bms.pojo.Author;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
@Transactional
public class AuthorDAOImpl implements AuthorDAO {

    @Autowired
    private SessionFactory sessionFactory;
    

    private Session getSession() {
        // hamesha currentSession, kabhi openSession nahi
        return sessionFactory.getCurrentSession();
    }
    @Override
    public void saveAuthor(Author author) {
        Session session = sessionFactory.getCurrentSession();
        session.save(author);
    }
    
    @Override
    public void updateAuthor(Author author) {
        Session session = sessionFactory.getCurrentSession();
        session.update(author);
    }
    
    @Override
    public void deleteAuthor(int authorId) {
        Session session = sessionFactory.getCurrentSession();
        Author author = session.get(Author.class, authorId);
        if (author != null) {
            session.delete(author);
        }
    }
    
    @Override
    public Author getAuthorById(int authorId) {
        Session session = sessionFactory.getCurrentSession();
        return session.get(Author.class, authorId);
    }
    
    @Override
    public Author getAuthorByUserId(int userId) {
        Session session = sessionFactory.getCurrentSession();
        Query<Author> query = session.createQuery("FROM Author WHERE user.userId = :userId", Author.class);
        query.setParameter("userId", userId);
        return query.uniqueResult();
    }
    
    @Override
    public List<Author> getAllAuthors() {
        Session session = sessionFactory.getCurrentSession();
        return session.createQuery("FROM Author ORDER BY createdAt DESC", Author.class).list();
    }
    
    @Override
    public List<Author> getTopAuthors(int limit) {
        Session session = sessionFactory.getCurrentSession();
        Query<Author> query = session.createQuery("FROM Author ORDER BY followersCount DESC", Author.class);
        query.setMaxResults(limit);
        return query.list();
    }
    
    @Override
    public long getTotalAuthorsCount() {
        Session session = sessionFactory.getCurrentSession();
        Query<Long> query = session.createQuery("SELECT COUNT(*) FROM Author", Long.class);
        return query.uniqueResult();
    }
}
