package com.bms.daoimpl;

import com.bms.dao.MediaDAO;
import com.bms.pojo.Media;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
@Transactional
public class MediaDAOImpl implements MediaDAO {
    
    @Autowired
    private SessionFactory sessionFactory;
    private Session getSession() { return sessionFactory.getCurrentSession(); }
    
    @Override
    public void saveMedia(Media media) {
        Session session = sessionFactory.getCurrentSession();
        session.save(media);
    }
    
    @Override
    public void updateMedia(Media media) {
        Session session = sessionFactory.getCurrentSession();
        session.update(media);
    }
    
    @Override
    public void deleteMedia(int mediaId) {
        Session session = sessionFactory.getCurrentSession();
        Media media = session.get(Media.class, mediaId);
        if (media != null) {
            session.delete(media);
        }
    }
    
    @Override
    public Media getMediaById(int mediaId) {
        Session session = sessionFactory.getCurrentSession();
        return session.get(Media.class, mediaId);
    }
    
    @Override
    public List<Media> getMediaByUploader(int uploaderId) {
        Session session = sessionFactory.getCurrentSession();
        Query<Media> query = session.createQuery("FROM Media WHERE uploader.userId = :uploaderId ORDER BY uploadedDate DESC", Media.class);
        query.setParameter("uploaderId", uploaderId);
        return query.list();
    }
    
    @Override
    public List<Media> getAllMedia() {
        Session session = sessionFactory.getCurrentSession();
        return session.createQuery("FROM Media ORDER BY uploadedDate DESC", Media.class).list();
    }
    
    @Override
    public long getTotalMediaCount() {
        Session session = sessionFactory.getCurrentSession();
        Query<Long> query = session.createQuery("SELECT COUNT(*) FROM Media", Long.class);
        return query.uniqueResult();
    }
}
