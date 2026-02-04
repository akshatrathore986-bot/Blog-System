package com.bms.controller;

import com.bms.dao.*;
import com.bms.pojo.*;
import com.bms.util.PasswordUtil;
import com.bms.util.SlugUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import java.sql.Timestamp;
import java.util.List;

@Controller
@RequestMapping("/admin")
public class AdminController {
    
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
    private MediaDAO mediaDAO;
    
    // Admin dashboard
    @GetMapping("/dashboard")
    @Transactional
    public String dashboard(HttpSession session, Model model) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null || (user.getRole() != User.Role.ADMIN && user.getRole() != User.Role.SUPER_ADMIN)) {
            return "redirect:/auth/login";
        }
        
        long totalUsers = userDAO.getTotalUsersCount();
        long totalPosts = postDAO.getTotalPostsCount();
        long publishedPosts = postDAO.getPublishedPostsCount();
        long pendingComments = commentDAO.getPendingCommentsCount();
        
        List<Post> recentPosts = postDAO.getRecentPosts(5);
        List<Comment> pendingCommentsList = commentDAO.getPendingComments();
        
        model.addAttribute("totalUsers", totalUsers);
        model.addAttribute("totalPosts", totalPosts);
        model.addAttribute("publishedPosts", publishedPosts);
        model.addAttribute("pendingComments", pendingComments);
        model.addAttribute("recentPosts", recentPosts);
        model.addAttribute("pendingCommentsList", pendingCommentsList);
        
        return "admin/dashboard";
    }
    
    // ========== USER MANAGEMENT ==========
    
    @GetMapping("/users")
    @Transactional
    public String users(HttpSession session, Model model) {
        if (!isAdmin(session)) return "redirect:/auth/login";
        
        List<User> users = userDAO.getAllUsers();
        model.addAttribute("users", users);
        return "admin/users";
    }
    
    @GetMapping("/user/create")
    public String createUserPage(HttpSession session) {
        if (!isAdmin(session)) return "redirect:/auth/login";
        return "admin/create-user";
    }
    
    @PostMapping("/user/create")
    @Transactional
    public String createUser(@RequestParam String username,
                            @RequestParam String email,
                            @RequestParam String password,
                            @RequestParam String role,
                            HttpSession session,
                            RedirectAttributes redirectAttributes) {
        
        if (!isAdmin(session)) return "redirect:/auth/login";
        
        User user = new User();
        user.setUsername(username);
        user.setEmail(email);
        user.setPasswordHash(PasswordUtil.hashPassword(password));
        user.setRole(User.Role.valueOf(role));
        user.setStatus(User.Status.ACTIVE);
        user.setCreatedAt(new Timestamp(System.currentTimeMillis()));
        
        userDAO.saveUser(user);
        
        // If author role, create author profile
        if (role.equals("AUTHOR")) {
            Author author = new Author();
            author.setUser(user);
            author.setDisplayName(username);
            author.setCreatedAt(new Timestamp(System.currentTimeMillis()));
            authorDAO.saveAuthor(author);
        }
        
        redirectAttributes.addFlashAttribute("success", "User created successfully");
        return "redirect:/admin/users";
    }
    
    @GetMapping("/user/edit/{id}")
    @Transactional
    public String editUserPage(@PathVariable int id, HttpSession session, Model model) {
        if (!isAdmin(session)) return "redirect:/auth/login";
        
        User user = userDAO.getUserById(id);
        model.addAttribute("user", user);
        return "admin/edit-user";
    }
    
    @PostMapping("/user/update/{id}")
    @Transactional
    public String updateUser(@PathVariable int id,
                            @RequestParam String username,
                            @RequestParam String email,
                            @RequestParam String role,
                            @RequestParam String status,
                            HttpSession session,
                            RedirectAttributes redirectAttributes) {
        
        if (!isAdmin(session)) return "redirect:/auth/login";
        
        User user = userDAO.getUserById(id);
        user.setUsername(username);
        user.setEmail(email);
        user.setRole(User.Role.valueOf(role));
        user.setStatus(User.Status.valueOf(status));
        
        userDAO.updateUser(user);
        
        redirectAttributes.addFlashAttribute("success", "User updated successfully");
        return "redirect:/admin/users";
    }
    
    @GetMapping("/user/delete/{id}")
    @Transactional
    public String deleteUser(@PathVariable int id, HttpSession session, RedirectAttributes redirectAttributes) {
        if (!isAdmin(session)) return "redirect:/auth/login";
        
        userDAO.deleteUser(id);
        redirectAttributes.addFlashAttribute("success", "User deleted successfully");
        return "redirect:/admin/users";
    }
    
    // ========== POST MANAGEMENT ==========
    
    @GetMapping("/posts")
    @Transactional
    public String posts(HttpSession session, Model model) {
        if (!isAdmin(session)) return "redirect:/auth/login";
        
        List<Post> posts = postDAO.getAllPosts();
        model.addAttribute("posts", posts);
        return "admin/posts";
    }
    
    @GetMapping("/post/delete/{id}")
    @Transactional
    public String deletePost(@PathVariable int id, HttpSession session, RedirectAttributes redirectAttributes) {
        if (!isAdmin(session)) return "redirect:/auth/login";
        
        postDAO.deletePost(id);
        redirectAttributes.addFlashAttribute("success", "Post deleted successfully");
        return "redirect:/admin/posts";
    }
    
    // ========== CATEGORY MANAGEMENT ==========
    
    @GetMapping("/categories")
    @Transactional
    public String categories(HttpSession session, Model model) {
        if (!isAdmin(session)) return "redirect:/auth/login";
        
        List<Category> categories = categoryDAO.getAllCategories();
        model.addAttribute("categories", categories);
        return "admin/categories";
    }
    
    @GetMapping("/category/create")
    public String createCategoryPage(HttpSession session) {
        if (!isAdmin(session)) return "redirect:/auth/login";
        return "admin/create-category";
    }
    
    @PostMapping("/category/create")
    @Transactional
    public String createCategory(@RequestParam String categoryName,
                                @RequestParam String description,
                                HttpSession session,
                                RedirectAttributes redirectAttributes) {
        
        if (!isAdmin(session)) return "redirect:/auth/login";
        
        Category category = new Category();
        category.setCategoryName(categoryName);
        category.setSlug(SlugUtil.generateSlug(categoryName));
        category.setDescription(description);
        category.setCreatedAt(new Timestamp(System.currentTimeMillis()));
        
        categoryDAO.saveCategory(category);
        
        redirectAttributes.addFlashAttribute("success", "Category created successfully");
        return "redirect:/admin/categories";
    }
    
    @GetMapping("/category/edit/{id}")
    @Transactional
    public String editCategoryPage(@PathVariable int id, HttpSession session, Model model) {
        if (!isAdmin(session)) return "redirect:/auth/login";
        
        Category category = categoryDAO.getCategoryById(id);
        model.addAttribute("category", category);
        return "admin/edit-category";
    }
    
    @PostMapping("/category/update/{id}")
    @Transactional
    public String updateCategory(@PathVariable int id,
                                @RequestParam String categoryName,
                                @RequestParam String description,
                                HttpSession session,
                                RedirectAttributes redirectAttributes) {
        
        if (!isAdmin(session)) return "redirect:/auth/login";
        
        Category category = categoryDAO.getCategoryById(id);
        category.setCategoryName(categoryName);
        category.setSlug(SlugUtil.generateSlug(categoryName));
        category.setDescription(description);
        
        categoryDAO.updateCategory(category);
        
        redirectAttributes.addFlashAttribute("success", "Category updated successfully");
        return "redirect:/admin/categories";
    }
    
    @GetMapping("/category/delete/{id}")
    @Transactional
    public String deleteCategory(@PathVariable int id, HttpSession session, RedirectAttributes redirectAttributes) {
        if (!isAdmin(session)) return "redirect:/auth/login";
        
        categoryDAO.deleteCategory(id);
        redirectAttributes.addFlashAttribute("success", "Category deleted successfully");
        return "redirect:/admin/categories";
    }
    
    // ========== TAG MANAGEMENT ==========
    
    @GetMapping("/tags")
    @Transactional
    public String tags(HttpSession session, Model model) {
        if (!isAdmin(session)) return "redirect:/auth/login";
        
        List<Tag> tags = tagDAO.getAllTags();
        model.addAttribute("tags", tags);
        return "admin/tags";
    }
    
    @PostMapping("/admin/tags/create")
    @Transactional
    public String createTag(@RequestParam("tagName") String tagName,
                            @RequestParam("postId") int postId,
                            RedirectAttributes redirectAttributes) {

        // 1. Post fetch karo
        Post post = postDAO.getPostById(postId);
        if (post == null) {
            redirectAttributes.addFlashAttribute("error", "Invalid post selected for tag.");
            return "redirect:/admin/tags";
        }

        // 2. Tag object banao
        Tag tag = new Tag();
        tag.setTagName(tagName.trim());
        tag.setSlug(SlugUtil.toSlug(tagName)); // agar tum slug bana rahe ho to
        tag.setPost(post);                    // IMPORTANT: yahi missing tha

        // 3. Save karo
        tagDAO.saveTag(tag);

        redirectAttributes.addFlashAttribute("success", "Tag created successfully.");
        return "redirect:/admin/tags";
    }

    
    @GetMapping("/tag/delete/{id}")
    @Transactional
    public String deleteTag(@PathVariable int id, HttpSession session, RedirectAttributes redirectAttributes) {
        if (!isAdmin(session)) return "redirect:/auth/login";
        
        tagDAO.deleteTag(id);
        redirectAttributes.addFlashAttribute("success", "Tag deleted successfully");
        return "redirect:/admin/tags";
    }
    
    // ========== COMMENT MANAGEMENT ==========
    
    @GetMapping("/comments")
    @Transactional
    public String comments(HttpSession session, Model model) {
        if (!isAdmin(session)) return "redirect:/auth/login";
        
        List<Comment> pendingComments = commentDAO.getPendingComments();
        model.addAttribute("comments", pendingComments);
        return "admin/comments";
    }
    
    @GetMapping("/comment/approve/{id}")
    @Transactional
    public String approveComment(@PathVariable int id, HttpSession session, RedirectAttributes redirectAttributes) {
        if (!isAdmin(session)) return "redirect:/auth/login";
        
        Comment comment = commentDAO.getCommentById(id);
        comment.setStatus(Comment.Status.APPROVED);
        commentDAO.updateComment(comment);
        
        redirectAttributes.addFlashAttribute("success", "Comment approved");
        return "redirect:/admin/comments";
    }
    
    @GetMapping("/comment/reject/{id}")
    @Transactional
    public String rejectComment(@PathVariable int id, HttpSession session, RedirectAttributes redirectAttributes) {
        if (!isAdmin(session)) return "redirect:/auth/login";
        
        Comment comment = commentDAO.getCommentById(id);
        comment.setStatus(Comment.Status.REJECTED);
        commentDAO.updateComment(comment);
        
        redirectAttributes.addFlashAttribute("success", "Comment rejected");
        return "redirect:/admin/comments";
    }
    
    @GetMapping("/comment/delete/{id}")
    @Transactional
    public String deleteComment(@PathVariable int id, HttpSession session, RedirectAttributes redirectAttributes) {
        if (!isAdmin(session)) return "redirect:/auth/login";
        
        commentDAO.deleteComment(id);
        redirectAttributes.addFlashAttribute("success", "Comment deleted");
        return "redirect:/admin/comments";
    }
    
    // Helper method
    private boolean isAdmin(HttpSession session) {
        User user = (User) session.getAttribute("loggedInUser");
        return user != null && (user.getRole() == User.Role.ADMIN || user.getRole() == User.Role.SUPER_ADMIN);
    }
}
