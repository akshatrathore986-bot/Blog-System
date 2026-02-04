package com.bms.controller;

import com.bms.dao.*;
import com.bms.pojo.*;
import com.bms.util.SlugUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Timestamp;
import java.util.*;

@Controller
@RequestMapping("/author")
public class AuthorController {

    @Autowired private UserDAO userDAO;
    @Autowired private AuthorDAO authorDAO;
    @Autowired private PostDAO postDAO;
    @Autowired private CategoryDAO categoryDAO;
    @Autowired private TagDAO tagDAO;
    @Autowired private CommentDAO commentDAO;
    @Autowired private ServletContext servletContext;

    // =================================================
    // AUTHOR DASHBOARD
    // =================================================
    @GetMapping("/dashboard")
    @Transactional
    public String dashboard(HttpSession session, Model model) {

        User user = (User) session.getAttribute("loggedInUser");
        if (user == null || user.getRole() != User.Role.AUTHOR) {
            return "redirect:/auth/login";
        }

        Author author = authorDAO.getAuthorByUserId(user.getUserId());
        List<Post> myPosts = postDAO.getPostsByAuthor(author.getAuthorId());

        model.addAttribute("author", author);
        model.addAttribute("totalPosts", myPosts.size());
        model.addAttribute("publishedPosts",
                myPosts.stream().filter(p -> p.getStatus() == Post.Status.PUBLISHED).count());
        model.addAttribute("draftPosts",
                myPosts.stream().filter(p -> p.getStatus() == Post.Status.DRAFT).count());
        model.addAttribute("recentPosts", myPosts.stream().limit(5).toArray());

        return "author/dashboard";
    }

    // =================================================
    // AUTHOR POSTS
    // =================================================
    @GetMapping("/posts")
    @Transactional
    public String myPosts(HttpSession session, Model model) {

        User user = (User) session.getAttribute("loggedInUser");
        if (user == null || user.getRole() != User.Role.AUTHOR) {
            return "redirect:/auth/login";
        }

        Author author = authorDAO.getAuthorByUserId(user.getUserId());
        model.addAttribute("posts", postDAO.getPostsByAuthor(author.getAuthorId()));

        return "author/posts";
    }

    // =================================================
    // ✅ AUTHOR ANALYTICS  (FIXED)
    // =================================================
    @GetMapping("/analytics")
    @Transactional
    public String analytics(HttpSession session, Model model) {

        User user = (User) session.getAttribute("loggedInUser");
        if (user == null || user.getRole() != User.Role.AUTHOR) {
            return "redirect:/auth/login";
        }

        Author author = authorDAO.getAuthorByUserId(user.getUserId());
        List<Post> posts = postDAO.getPostsByAuthor(author.getAuthorId());

        long totalViews = posts.stream().mapToLong(Post::getViewCount).sum();
        long totalComments = posts.stream().mapToLong(Post::getCommentCount).sum();

        model.addAttribute("totalViews", totalViews);
        model.addAttribute("totalComments", totalComments);
        model.addAttribute("totalPosts", posts.size());
        model.addAttribute("posts", posts);

        return "author/analytics";
    }

    // =================================================
    // ✅ AUTHOR PROFILE PAGE (FIXED)
    // =================================================
    @GetMapping("/profile")
    @Transactional
    public String profile(HttpSession session, Model model) {

        User user = (User) session.getAttribute("loggedInUser");
        if (user == null || user.getRole() != User.Role.AUTHOR) {
            return "redirect:/auth/login";
        }

        Author author = authorDAO.getAuthorByUserId(user.getUserId());
        model.addAttribute("author", author);

        return "author/profile";
    }

    // =================================================
    // CREATE POST PAGE
    // =================================================
    @GetMapping("/post/create")
    @Transactional
    public String createPostPage(HttpSession session, Model model) {

        User user = (User) session.getAttribute("loggedInUser");
        if (user == null || user.getRole() != User.Role.AUTHOR) {
            return "redirect:/auth/login";
        }

        model.addAttribute("categories", categoryDAO.getAllCategories());
        model.addAttribute("tags", tagDAO.getAllTags());

        return "author/create-post";
    }

    // =================================================
    // CREATE POST
    // =================================================
    @PostMapping("/post/create")
    @Transactional
    public String createPost(
            @RequestParam String title,
            @RequestParam String content,
            @RequestParam String excerpt,
            @RequestParam int categoryId,
            @RequestParam(required = false) String[] tagIds,
            @RequestParam(required = false) MultipartFile featuredImage,
            @RequestParam String status,
            HttpSession session,
            RedirectAttributes redirectAttributes) {

        User user = (User) session.getAttribute("loggedInUser");
        if (user == null || user.getRole() != User.Role.AUTHOR) {
            return "redirect:/auth/login";
        }

        Author author = authorDAO.getAuthorByUserId(user.getUserId());
        Category category = categoryDAO.getCategoryById(categoryId);

        Post post = new Post();
        post.setAuthor(author);
        post.setCategory(category);
        post.setTitle(title);
        post.setSlug(SlugUtil.generateSlug(title));
        post.setContent(content);
        post.setExcerpt(excerpt);
        post.setStatus(Post.Status.valueOf(status));
        post.setCreatedAt(new Timestamp(System.currentTimeMillis()));
        post.setUpdatedAt(new Timestamp(System.currentTimeMillis()));

        if ("PUBLISHED".equals(status)) {
            post.setPublishedDate(new Timestamp(System.currentTimeMillis()));
        }

        if (featuredImage != null && !featuredImage.isEmpty()) {
            post.setFeaturedImage(saveImage(featuredImage, "posts"));
        }

        if (tagIds != null) {
            Set<Tag> tags = new HashSet<>();
            for (String id : tagIds) {
                Tag tag = tagDAO.getTagById(Integer.parseInt(id));
                if (tag != null) tags.add(tag);
            }
            post.setTags(tags);
        }

        postDAO.savePost(post);
        redirectAttributes.addFlashAttribute("success", "Post created successfully");

        return "redirect:/author/posts";
    }

    // =================================================
    // UPDATE PROFILE
    // =================================================
    @PostMapping("/profile/update")
    @Transactional
    public String updateProfile(
            @RequestParam String displayName,
            @RequestParam String bio,
            @RequestParam(required = false) MultipartFile profileImage,
            HttpSession session,
            RedirectAttributes redirectAttributes) {

        User user = (User) session.getAttribute("loggedInUser");
        if (user == null || user.getRole() != User.Role.AUTHOR) {
            return "redirect:/auth/login";
        }

        Author author = authorDAO.getAuthorByUserId(user.getUserId());
        author.setDisplayName(displayName);
        author.setBio(bio);

        if (profileImage != null && !profileImage.isEmpty()) {
            author.setProfileImage(saveImage(profileImage, "profiles"));
        }

        authorDAO.updateAuthor(author);
        redirectAttributes.addFlashAttribute("success", "Profile updated successfully");

        return "redirect:/author/profile";
    }

    // =================================================
    // IMAGE UPLOAD UTILITY
    // =================================================
    private String saveImage(MultipartFile file, String folder) {
        try {
            String ext = file.getOriginalFilename()
                    .substring(file.getOriginalFilename().lastIndexOf("."));
            String fileName = UUID.randomUUID() + ext;

            String uploadDir = servletContext.getRealPath("/uploads/" + folder + "/");
            Files.createDirectories(Paths.get(uploadDir));

            Path path = Paths.get(uploadDir, fileName);
            Files.write(path, file.getBytes());

            return fileName;
        } catch (IOException e) {
            return null;
        }
    }
}
