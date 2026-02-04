package com.bms.daoimpl;

import com.bms.dao.CategoryDAO;
import com.bms.pojo.Category;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
@Transactional
public class CategoryDAOImpl implements CategoryDAO {
    
    @Autowired
    private SessionFactory sessionFactory;
    private Session getSession() { return sessionFactory.getCurrentSession(); }
    
    @Override
    public void saveCategory(Category category) {
        Session session = sessionFactory.getCurrentSession();
        session.save(category);
    }
    
    @Override
    public void updateCategory(Category category) {
        Session session = sessionFactory.getCurrentSession();
        session.update(category);
    }
    
    @Override
    public void deleteCategory(int categoryId) {
        Session session = sessionFactory.getCurrentSession();
        Category category = session.get(Category.class, categoryId);
        if (category != null) {
            session.delete(category);
        }
    }
    
    @Override
    public Category getCategoryById(int categoryId) {
        Session session = sessionFactory.getCurrentSession();
        return session.get(Category.class, categoryId);
    }
    
    @Override
    public Category getCategoryBySlug(String slug) {
        Session session = sessionFactory.getCurrentSession();
        Query<Category> query = session.createQuery("FROM Category WHERE slug = :slug", Category.class);
        query.setParameter("slug", slug);
        return query.uniqueResult();
    }
    
    @Override
    public List<Category> getAllCategories() {
        Session session = sessionFactory.getCurrentSession();
        return session.createQuery("FROM Category ORDER BY categoryName ASC", Category.class).list();
    }
    
    @Override
    public List<Category> getPopularCategories(int limit) {
        Session session = sessionFactory.getCurrentSession();
        Query<Category> query = session.createQuery("FROM Category ORDER BY postCount DESC", Category.class);
        query.setMaxResults(limit);
        return query.list();
    }
    
    @Override
    public boolean categoryExists(String categoryName) {
        Session session = sessionFactory.getCurrentSession();
        Query<Long> query = session.createQuery("SELECT COUNT(*) FROM Category WHERE categoryName = :name", Long.class);
        query.setParameter("name", categoryName);
        return query.uniqueResult() > 0;
    }
    
    @Override
    public boolean slugExists(String slug) {
        return getCategoryBySlug(slug) != null;
    }
}
