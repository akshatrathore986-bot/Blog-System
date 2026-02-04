package com.bms.dao;

import com.bms.pojo.Post;
import java.util.List;

public interface PostDAO {
    void savePost(Post post);
    void updatePost(Post post);
    void deletePost(int postId);
    Post getPostById(int postId);
    Post getPostBySlug(String slug);
    List<Post> getAllPosts();
    List<Post> getPublishedPosts();
    List<Post> getPostsByAuthor(int authorId);
    List<Post> getPostsByCategory(int categoryId);
    List<Post> getPostsByTag(int tagId);
    List<Post> getPostsByStatus(Post.Status status);
    List<Post> searchPosts(String keyword);
    List<Post> getRecentPosts(int limit);
    List<Post> getPopularPosts(int limit);
    long getTotalPostsCount();
    long getPublishedPostsCount();
    void incrementViewCount(int postId);
}
