package com.bms.daoimpl;

import com.bms.dao.CommentDAO;
import com.bms.pojo.Comment;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
@Transactional
public class CommentDAOImpl implements CommentDAO {
    
    @Autowired
    private SessionFactory sessionFactory;
    private Session getSession() { return sessionFactory.getCurrentSession(); }
    
    @Override
    public void saveComment(Comment comment) {
        Session session = sessionFactory.getCurrentSession();
        session.save(comment);
    }
    
    @Override
    public void updateComment(Comment comment) {
        Session session = sessionFactory.getCurrentSession();
        session.update(comment);
    }
    
    @Override
    public void deleteComment(int commentId) {
        Session session = sessionFactory.getCurrentSession();
        Comment comment = session.get(Comment.class, commentId);
        if (comment != null) {
            session.delete(comment);
        }
    }
    
    @Override
    public Comment getCommentById(int commentId) {
        Session session = sessionFactory.getCurrentSession();
        return session.get(Comment.class, commentId);
    }
    
    @Override
    public List<Comment> getCommentsByPost(int postId) {
        Session session = sessionFactory.getCurrentSession();
        Query<Comment> query = session.createQuery("FROM Comment WHERE post.postId = :postId ORDER BY createdAt DESC", Comment.class);
        query.setParameter("postId", postId);
        return query.list();
    }
    
    @Override
    public List<Comment> getCommentsByUser(int userId) {
        Session session = sessionFactory.getCurrentSession();
        Query<Comment> query = session.createQuery("FROM Comment WHERE user.userId = :userId ORDER BY createdAt DESC", Comment.class);
        query.setParameter("userId", userId);
        return query.list();
    }
    
    @Override
    public List<Comment> getCommentsByStatus(Comment.Status status) {
        Session session = sessionFactory.getCurrentSession();
        Query<Comment> query = session.createQuery("FROM Comment WHERE status = :status ORDER BY createdAt DESC", Comment.class);
        query.setParameter("status", status);
        return query.list();
    }
    
    @Override
    public List<Comment> getPendingComments() {
        return getCommentsByStatus(Comment.Status.PENDING);
    }
    
    @Override
    public List<Comment> getApprovedCommentsByPost(int postId) {
        Session session = sessionFactory.getCurrentSession();
        Query<Comment> query = session.createQuery("FROM Comment WHERE post.postId = :postId AND status = :status ORDER BY createdAt DESC", Comment.class);
        query.setParameter("postId", postId);
        query.setParameter("status", Comment.Status.APPROVED);
        return query.list();
    }
    
    @Override
    public long getTotalCommentsCount() {
        Session session = sessionFactory.getCurrentSession();
        Query<Long> query = session.createQuery("SELECT COUNT(*) FROM Comment", Long.class);
        return query.uniqueResult();
    }
    
    @Override
    public long getPendingCommentsCount() {
        Session session = sessionFactory.getCurrentSession();
        Query<Long> query = session.createQuery("SELECT COUNT(*) FROM Comment WHERE status = :status", Long.class);
        query.setParameter("status", Comment.Status.PENDING);
        return query.uniqueResult();
    }
}
