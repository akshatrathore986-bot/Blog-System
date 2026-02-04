package com.bms.controller;

import com.bms.dao.*;
import com.bms.pojo.*;
import com.bms.util.SlugUtil;
import com.bms.util.FileUploadUtil;
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
    
    @Autowired
    private UserDAO userDAO;

    @Autowired
    private AuthorDAO authorDAO;

    @Autowired
    private PostDAO postDAO;

    @Autowired
    private CategoryDAO categoryDAO;

    @Autowired
    private TagDAO tagDAO;

    @Autowired
    private CommentDAO commentDAO;

    @Autowired
    private ServletContext servletContext;   // ⬅️ ADDED (REQUIRED FOR saveImage())

    // -------------------------------------
    // AUTHOR DASHBOARD
    // -------------------------------------
    @GetMapping("/dashboard")
    @Transactional
    public String dashboard(HttpSession session, Model model) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null || user.getRole() != User.Role.AUTHOR) {
            return "redirect:/auth/login";
        }

        Author author = authorDAO.getAuthorByUserId(user.getUserId());
        List<Post> myPosts = postDAO.getPostsByAuthor(author.getAuthorId());

        long totalPosts = myPosts.size();
        long publishedPosts = myPosts.stream().filter(p -> p.getStatus() == Post.Status.PUBLISHED).count();
        long draftPosts = myPosts.stream().filter(p -> p.getStatus() == Post.Status.DRAFT).count();

        model.addAttribute("author", author);
        model.addAttribute("totalPosts", totalPosts);
        model.addAttribute("publishedPosts", publishedPosts);
        model.addAttribute("draftPosts", draftPosts);
        model.addAttribute("recentPosts", myPosts.stream().limit(5).toArray());

        return "author/dashboard";
    }

    // -------------------------------------
    // ALL POSTS OF AUTHOR
    // -------------------------------------
    @GetMapping("/posts")
    @Transactional
    public String myPosts(HttpSession session, Model model) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null || user.getRole() != User.Role.AUTHOR) {
            return "redirect:/auth/login";
        }

        Author author = authorDAO.getAuthorByUserId(user.getUserId());
        List<Post> posts = postDAO.getPostsByAuthor(author.getAuthorId());

        model.addAttribute("posts", posts);
        return "author/posts";
    }

    // -------------------------------------
    // CREATE POST PAGE
    // -------------------------------------
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

    // -------------------------------------
    // CREATE POST
    // -------------------------------------
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

        if (status.equals("PUBLISHED")) {
            post.setPublishedDate(new Timestamp(System.currentTimeMillis()));
        }

        // Featured image
        if (featuredImage != null && !featuredImage.isEmpty()) {
            try {
                String fileName = saveImage(featuredImage, "posts");  // ⬅️ saveImage USED
                post.setFeaturedImage(fileName);
            } catch (Exception ignored) {}
        }

        // Tags
        if (tagIds != null) {
            Set<Tag> tags = new HashSet<>();
            for (String tagId : tagIds) {
                Tag tag = tagDAO.getTagById(Integer.parseInt(tagId));
                if (tag != null) tags.add(tag);
            }
            post.setTags(tags);
        }

        postDAO.savePost(post);
        redirectAttributes.addFlashAttribute("success", "Post created successfully");

        return "redirect:/author/posts";
    }

    // -------------------------------------
    // UPDATE AUTHOR PROFILE
    // -------------------------------------
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

        // PROFILE IMAGE UPLOAD
        if (profileImage != null && !profileImage.isEmpty()) {
            String fileName = saveImage(profileImage, "profiles");  // ⬅️ saveImage USED
            author.setProfileImage(fileName);
        }

        authorDAO.updateAuthor(author);
        redirectAttributes.addFlashAttribute("success", "Profile updated successfully");

        return "redirect:/author/profile";
    }

    // ================================================================
    //  ⭐ PRIVATE IMAGE UPLOAD METHOD (ADDED AS YOU ASKED)
    // ================================================================
    private String saveImage(MultipartFile file, String folder) {
        try {
            String originalName = file.getOriginalFilename();
            String extension = originalName.substring(originalName.lastIndexOf("."));
            String fileName = UUID.randomUUID().toString() + extension;

            String uploadDir = servletContext.getRealPath("/uploads/" + folder + "/");

            Files.createDirectories(Paths.get(uploadDir));

            Path filePath = Paths.get(uploadDir, fileName);
            Files.write(filePath, file.getBytes());

            return fileName;

        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }
    }
}
