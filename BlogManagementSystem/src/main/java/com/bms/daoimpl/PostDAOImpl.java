package com.bms.daoimpl;

import com.bms.dao.PostDAO;
import com.bms.pojo.Post;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
@Transactional
public class PostDAOImpl implements PostDAO {

    @Autowired
    private SessionFactory sessionFactory;
    private Session getSession() { return sessionFactory.getCurrentSession(); }

    @Override
    public void savePost(Post post) {
        getSession().save(post);
    }

    @Override
    public void updatePost(Post post) {
        getSession().update(post);
    }

    @Override
    public void deletePost(int postId) {
        Post post = getSession().get(Post.class, postId);
        if (post != null) {
            getSession().delete(post);
        }
    }

    @Override
    public Post getPostById(int postId) {
        return getSession().get(Post.class, postId);
    }

    // ⭐ UPDATED METHOD → FIX LAZY LOADING
    @Override
    public Post getPostBySlug(String slug) {
        String hql = "SELECT p FROM Post p LEFT JOIN FETCH p.tags WHERE p.slug = :slug";
        Query<Post> query = getSession().createQuery(hql, Post.class);
        query.setParameter("slug", slug);
        return query.uniqueResult();
    }

    @Override
    public List<Post> getAllPosts() {
        return getSession()
                .createQuery("FROM Post ORDER BY createdAt DESC", Post.class)
                .list();
    }

    @Override
    public List<Post> getPublishedPosts() {
        Query<Post> query = getSession().createQuery(
                "FROM Post WHERE status = :status ORDER BY publishedDate DESC", Post.class);
        query.setParameter("status", Post.Status.PUBLISHED);
        return query.list();
    }

    @Override
    public List<Post> getPostsByAuthor(int authorId) {
        Query<Post> query = getSession().createQuery(
                "FROM Post WHERE author.authorId = :authorId ORDER BY createdAt DESC", Post.class);
        query.setParameter("authorId", authorId);
        return query.list();
    }

    @Override
    public List<Post> getPostsByCategory(int categoryId) {
        Query<Post> query = getSession().createQuery(
                "FROM Post WHERE category.categoryId = :categoryId AND status = :status ORDER BY publishedDate DESC",
                Post.class);
        query.setParameter("categoryId", categoryId);
        query.setParameter("status", Post.Status.PUBLISHED);
        return query.list();
    }

    @Override
    public List<Post> getPostsByTag(int tagId) {
        Query<Post> query = getSession().createQuery(
                "SELECT p FROM Post p JOIN p.tags t WHERE t.tagId = :tagId AND p.status = :status ORDER BY p.publishedDate DESC",
                Post.class);
        query.setParameter("tagId", tagId);
        query.setParameter("status", Post.Status.PUBLISHED);
        return query.list();
    }

    @Override
    public List<Post> getPostsByStatus(Post.Status status) {
        Query<Post> query = getSession().createQuery(
                "FROM Post WHERE status = :status ORDER BY createdAt DESC", Post.class);
        query.setParameter("status", status);
        return query.list();
    }

    @Override
    public List<Post> searchPosts(String keyword) {
        Query<Post> query = getSession().createQuery(
                "FROM Post WHERE (title LIKE :keyword OR content LIKE :keyword) AND status = :status ORDER BY publishedDate DESC",
                Post.class);
        query.setParameter("keyword", "%" + keyword + "%");
        query.setParameter("status", Post.Status.PUBLISHED);
        return query.list();
    }

    @Override
    public List<Post> getRecentPosts(int limit) {
        Query<Post> query = getSession().createQuery(
                "FROM Post WHERE status = :status ORDER BY publishedDate DESC", Post.class);
        query.setParameter("status", Post.Status.PUBLISHED);
        query.setMaxResults(limit);
        return query.list();
    }

    @Override
    public List<Post> getPopularPosts(int limit) {
        Query<Post> query = getSession().createQuery(
                "FROM Post WHERE status = :status ORDER BY viewCount DESC", Post.class);
        query.setParameter("status", Post.Status.PUBLISHED);
        query.setMaxResults(limit);
        return query.list();
    }

    @Override
    public long getTotalPostsCount() {
        Query<Long> query = getSession().createQuery(
                "SELECT COUNT(*) FROM Post", Long.class);
        return query.uniqueResult();
    }

    @Override
    public long getPublishedPostsCount() {
        Query<Long> query = getSession().createQuery(
                "SELECT COUNT(*) FROM Post WHERE status = :status", Long.class);
        query.setParameter("status", Post.Status.PUBLISHED);
        return query.uniqueResult();
    }

    @Override
    public void incrementViewCount(int postId) {
        Post post = getSession().get(Post.class, postId);
        if (post != null) {
            post.setViewCount(post.getViewCount() + 1);
            getSession().update(post);
        }
    }
}
