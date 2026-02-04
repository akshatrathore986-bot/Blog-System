package com.bms.controller;

import com.bms.dao.*;
import com.bms.pojo.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
public class PublicController {
    
    @Autowired
    private PostDAO postDAO;
    
    @Autowired
    private CategoryDAO categoryDAO;
    
    @Autowired
    private TagDAO tagDAO;
    
    @Autowired
    private AuthorDAO authorDAO;
    
    @Autowired
    private CommentDAO commentDAO;
    
    @GetMapping("/")
    public String home(Model model) {
        List<Post> recentPosts = postDAO.getRecentPosts(6);
        List<Post> popularPosts = postDAO.getPopularPosts(3);
        List<Category> categories = categoryDAO.getAllCategories();
        
        model.addAttribute("recentPosts", recentPosts);
        model.addAttribute("popularPosts", popularPosts);
        model.addAttribute("categories", categories);
        
        return "public/home";
    }

 
    
    @GetMapping("/posts")
    public String allPosts(Model model) {
        List<Post> posts = postDAO.getPublishedPosts();
        List<Category> categories = categoryDAO.getAllCategories();
        
        model.addAttribute("posts", posts);
        model.addAttribute("categories", categories);
        
        return "public/posts";
    }
    
    @GetMapping("/post/{slug}")
    @Transactional
    public String viewPost(@PathVariable String slug, Model model) {

        // ⭐ Updated method — tags eagerly loaded inside DAO
        Post post = postDAO.getPostBySlug(slug);

        if (post == null || post.getStatus() != Post.Status.PUBLISHED) {
            return "error/404";
        }

        // increment view count
        postDAO.incrementViewCount(post.getPostId());

        // fetch comments
        List<Comment> comments = commentDAO.getApprovedCommentsByPost(post.getPostId());

        // fetch related posts (same category)
        List<Post> relatedPosts = postDAO.getPostsByCategory(post.getCategory().getCategoryId());

        // pass data to JSP
        model.addAttribute("post", post);
        model.addAttribute("comments", comments);
        model.addAttribute("relatedPosts", relatedPosts);

        return "public/single-post";
    }

    
    // Category page
    @GetMapping("/category/{slug}")
    @Transactional
    public String categoryPosts(@PathVariable String slug, Model model) {
        Category category = categoryDAO.getCategoryBySlug(slug);
        
        if (category == null) {
            return "error/404";
        }
        
        List<Post> posts = postDAO.getPostsByCategory(category.getCategoryId());
        
        model.addAttribute("category", category);
        model.addAttribute("posts", posts);
        
        return "public/category";
    }
    
    // Tag page
    @GetMapping("/tag/{slug}")
    @Transactional
    public String tagPosts(@PathVariable String slug, Model model) {
        Tag tag = tagDAO.getTagBySlug(slug);
        
        if (tag == null) {
            return "error/404";
        }
        
        List<Post> posts = postDAO.getPostsByTag(tag.getTagId());
        
        model.addAttribute("tag", tag);
        model.addAttribute("posts", posts);
        
        return "public/tag";
    }
    
    // Author profile
    @GetMapping("/author/{id}")
    @Transactional
    public String authorProfile(@PathVariable int id, Model model) {
        Author author = authorDAO.getAuthorById(id);
        
        if (author == null) {
            return "error/404";
        }
        
        List<Post> posts = postDAO.getPostsByAuthor(id);
        
        model.addAttribute("author", author);
        model.addAttribute("posts", posts);
        
        return "public/author-profile";
    }
    
    // Search
    @GetMapping("/search")
    @Transactional
    public String search(@RequestParam String q, Model model) {
        List<Post> searchResults = postDAO.searchPosts(q);
        
        model.addAttribute("query", q);
        model.addAttribute("results", searchResults);
        
        return "public/search-results";
    }
    
    // About page
    @GetMapping("/about")
    public String about() {
        return "public/about";
    }
    
    // Contact page
    @GetMapping("/contact")
    public String contact() {
        return "public/contact";
    }
    
    // All categories
    @GetMapping("/categories")
    @Transactional
    public String allCategories(Model model) {
        List<Category> categories = categoryDAO.getAllCategories();
        model.addAttribute("categories", categories);
        return "public/categories";
    }
    
    // All authors
    @GetMapping("/authors")
    @Transactional
    public String allAuthors(Model model) {
        List<Author> authors = authorDAO.getAllAuthors();
        model.addAttribute("authors", authors);
        return "public/authors";
    }
}
