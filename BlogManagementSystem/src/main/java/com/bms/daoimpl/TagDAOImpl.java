package com.bms.daoimpl;

import com.bms.dao.TagDAO;
import com.bms.pojo.Tag;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
@Transactional
public class TagDAOImpl implements TagDAO {
    
    @Autowired
    private SessionFactory sessionFactory;
    private Session getSession() { return sessionFactory.getCurrentSession(); }
    
    @Override
    public void saveTag(Tag tag) {
        getSession().save(tag);   // yahi line kaam kare, aur kuch special mat karo
    }
    
    @Override
    public void updateTag(Tag tag) {
        Session session = sessionFactory.getCurrentSession();
        session.update(tag);
    }
    
    @Override
    public void deleteTag(int tagId) {
        Session session = sessionFactory.getCurrentSession();
        Tag tag = session.get(Tag.class, tagId);
        if (tag != null) {
            session.delete(tag);
        }
    }
    
    @Override
    public Tag getTagById(int tagId) {
        Session session = sessionFactory.getCurrentSession();
        return session.get(Tag.class, tagId);
    }
    
    @Override
    public Tag getTagBySlug(String slug) {
        Session session = sessionFactory.getCurrentSession();
        Query<Tag> query = session.createQuery("FROM Tag WHERE slug = :slug", Tag.class);
        query.setParameter("slug", slug);
        return query.uniqueResult();
    }
    
    @Override
    public List<Tag> getAllTags() {
        Session session = sessionFactory.getCurrentSession();
        return session.createQuery("FROM Tag ORDER BY tagName ASC", Tag.class).list();
    }
    
    @Override
    public List<Tag> getTagsByPostId(int postId) {
        Session session = sessionFactory.getCurrentSession();
        Query<Tag> query = session.createQuery(
            "SELECT t FROM Tag t JOIN t.posts p WHERE p.postId = :postId", Tag.class);
        query.setParameter("postId", postId);
        return query.list();
    }
    
    @Override
    public boolean tagExists(String tagName) {
        Session session = sessionFactory.getCurrentSession();
        Query<Long> query = session.createQuery("SELECT COUNT(*) FROM Tag WHERE tagName = :name", Long.class);
        query.setParameter("name", tagName);
        return query.uniqueResult() > 0;
    }
}
