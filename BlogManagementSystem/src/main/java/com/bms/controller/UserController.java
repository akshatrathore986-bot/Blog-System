package com.bms.controller;

import com.bms.dao.*;
import com.bms.pojo.*;
import com.bms.util.PasswordUtil;
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
@RequestMapping("/user")
public class UserController {
    
    @Autowired
    private UserDAO userDAO;
    
    @Autowired
    private PostDAO postDAO;
    
    @Autowired
    private CommentDAO commentDAO;
    
    // User dashboard
    @GetMapping("/dashboard")
    @Transactional
    public String dashboard(HttpSession session, Model model) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) {
            return "redirect:/auth/login";
        }
        
        List<Comment> userComments = commentDAO.getCommentsByUser(user.getUserId());
        List<Post> recentPosts = postDAO.getRecentPosts(5);
        
        model.addAttribute("user", user);
        model.addAttribute("userComments", userComments);
        model.addAttribute("recentPosts", recentPosts);
        
        return "user/dashboard";
    }
    
    // User profile
    @GetMapping("/profile")
    @Transactional
    public String profile(HttpSession session, Model model) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) {
            return "redirect:/auth/login";
        }
        
        model.addAttribute("user", user);
        return "user/profile";
    }
    
    // Update profile
    @PostMapping("/profile/update")
    @Transactional
    public String updateProfile(@RequestParam String username,
                               @RequestParam String email,
                               HttpSession session,
                               RedirectAttributes redirectAttributes) {
        
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) {
            return "redirect:/auth/login";
        }
        
        user.setUsername(username);
        user.setEmail(email);
        userDAO.updateUser(user);
        
        session.setAttribute("loggedInUser", user);
        redirectAttributes.addFlashAttribute("success", "Profile updated successfully");
        
        return "redirect:/user/profile";
    }
    
    // Change password
    @GetMapping("/change-password")
    public String changePasswordPage(HttpSession session) {
        if (session.getAttribute("loggedInUser") == null) {
            return "redirect:/auth/login";
        }
        return "user/change-password";
    }
    
    // Update password
    @PostMapping("/change-password")
    @Transactional
    public String changePassword(@RequestParam String currentPassword,
                                @RequestParam String newPassword,
                                @RequestParam String confirmPassword,
                                HttpSession session,
                                RedirectAttributes redirectAttributes) {
        
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) {
            return "redirect:/auth/login";
        }
        
        if (!PasswordUtil.verifyPassword(currentPassword, user.getPasswordHash())) {
            redirectAttributes.addFlashAttribute("error", "Current password is incorrect");
            return "redirect:/user/change-password";
        }
        
        if (!newPassword.equals(confirmPassword)) {
            redirectAttributes.addFlashAttribute("error", "New passwords do not match");
            return "redirect:/user/change-password";
        }
        
        user.setPasswordHash(PasswordUtil.hashPassword(newPassword));
        userDAO.updateUser(user);
        
        redirectAttributes.addFlashAttribute("success", "Password changed successfully");
        return "redirect:/user/profile";
    }
    
    // User comments
    @GetMapping("/comments")
    @Transactional
    public String myComments(HttpSession session, Model model) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) {
            return "redirect:/auth/login";
        }
        
        List<Comment> comments = commentDAO.getCommentsByUser(user.getUserId());
        model.addAttribute("comments", comments);
        
        return "user/comments";
    }
    
    // Add comment
    @PostMapping("/comment/add")
    @Transactional
    public String addComment(@RequestParam int postId,
                            @RequestParam String commentText,
                            HttpSession session,
                            RedirectAttributes redirectAttributes) {
        
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) {
            return "redirect:/auth/login";
        }
        
        Post post = postDAO.getPostById(postId);
        if (post == null) {
            return "redirect:/posts";
        }
        
        Comment comment = new Comment();
        comment.setPost(post);
        comment.setUser(user);
        comment.setCommenterName(user.getUsername());
        comment.setCommenterEmail(user.getEmail());
        comment.setCommentText(commentText);
        comment.setStatus(Comment.Status.PENDING);
        comment.setCreatedAt(new Timestamp(System.currentTimeMillis()));
        
        commentDAO.saveComment(comment);
        
        redirectAttributes.addFlashAttribute("success", "Comment submitted for approval");
        return "redirect:/post/" + post.getSlug();
    }
}
