package com.bms.controller;

import com.bms.dao.*;
import com.bms.pojo.*;
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
@RequestMapping("/comments")
public class CommentController {
    
    @Autowired
    private CommentDAO commentDAO;
    
    @Autowired
    private PostDAO postDAO;
    
    @Autowired
    private UserDAO userDAO;
    
    // Add comment (public)
    @PostMapping("/add")
    @Transactional
    public String addComment(@RequestParam int postId,
                            @RequestParam String commenterName,
                            @RequestParam String commenterEmail,
                            @RequestParam String commentText,
                            HttpSession session,
                            RedirectAttributes redirectAttributes) {
        
        Post post = postDAO.getPostById(postId);
        if (post == null) {
            redirectAttributes.addFlashAttribute("error", "Post not found");
            return "redirect:/posts";
        }
        
        Comment comment = new Comment();
        comment.setPost(post);
        comment.setCommenterName(commenterName);
        comment.setCommenterEmail(commenterEmail);
        comment.setCommentText(commentText);
        comment.setStatus(Comment.Status.PENDING);
        comment.setCreatedAt(new Timestamp(System.currentTimeMillis()));
        
        // If user is logged in, associate comment with user
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser != null) {
            comment.setUser(loggedInUser);
        }
        
        commentDAO.saveComment(comment);
        
        // Update post comment count
        post.setCommentCount(post.getCommentCount() + 1);
        postDAO.updatePost(post);
        
        redirectAttributes.addFlashAttribute("success", "Comment submitted! It will appear after moderation.");
        return "redirect:/post/" + post.getSlug();
    }
    
    // Reply to comment
    @PostMapping("/reply")
    @Transactional
    public String replyToComment(@RequestParam int parentCommentId,
                                @RequestParam int postId,
                                @RequestParam String replyText,
                                HttpSession session,
                                RedirectAttributes redirectAttributes) {
        
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            redirectAttributes.addFlashAttribute("error", "Please login to reply");
            return "redirect:/auth/login";
        }
        
        Comment parentComment = commentDAO.getCommentById(parentCommentId);
        Post post = postDAO.getPostById(postId);
        
        if (parentComment == null || post == null) {
            redirectAttributes.addFlashAttribute("error", "Invalid request");
            return "redirect:/posts";
        }
        
        Comment reply = new Comment();
        reply.setPost(post);
        reply.setUser(loggedInUser);
        reply.setParentComment(parentComment);
        reply.setCommenterName(loggedInUser.getUsername());
        reply.setCommenterEmail(loggedInUser.getEmail());
        reply.setCommentText(replyText);
        reply.setStatus(Comment.Status.PENDING);
        reply.setCreatedAt(new Timestamp(System.currentTimeMillis()));
        
        commentDAO.saveComment(reply);
        
        // Update post comment count
        post.setCommentCount(post.getCommentCount() + 1);
        postDAO.updatePost(post);
        
        redirectAttributes.addFlashAttribute("success", "Reply submitted! It will appear after moderation.");
        return "redirect:/post/" + post.getSlug();
    }
    
    // Like comment
    @PostMapping("/like/{commentId}")
    @Transactional
    public String likeComment(@PathVariable int commentId,
                             @RequestParam int postId,
                             RedirectAttributes redirectAttributes) {
        
        Comment comment = commentDAO.getCommentById(commentId);
        if (comment == null) {
            redirectAttributes.addFlashAttribute("error", "Comment not found");
            return "redirect:/posts";
        }
        
        comment.setLikesCount(comment.getLikesCount() + 1);
        commentDAO.updateComment(comment);
        
        Post post = postDAO.getPostById(postId);
        redirectAttributes.addFlashAttribute("success", "Comment liked!");
        return "redirect:/post/" + post.getSlug();
    }
    
    // Delete comment (only for comment author or admin)
    @GetMapping("/delete/{commentId}")
    @Transactional
    public String deleteComment(@PathVariable int commentId,
                               @RequestParam int postId,
                               HttpSession session,
                               RedirectAttributes redirectAttributes) {
        
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            redirectAttributes.addFlashAttribute("error", "Please login");
            return "redirect:/auth/login";
        }
        
        Comment comment = commentDAO.getCommentById(commentId);
        if (comment == null) {
            redirectAttributes.addFlashAttribute("error", "Comment not found");
            return "redirect:/posts";
        }
        
        // Check if user is comment author or admin
        boolean isAuthor = comment.getUser() != null && comment.getUser().getUserId() == loggedInUser.getUserId();
        boolean isAdmin = loggedInUser.getRole() == User.Role.ADMIN || 
                         loggedInUser.getRole() == User.Role.SUPER_ADMIN;
        
        if (!isAuthor && !isAdmin) {
            redirectAttributes.addFlashAttribute("error", "You cannot delete this comment");
            return "redirect:/post/" + comment.getPost().getSlug();
        }
        
        Post post = comment.getPost();
        post.setCommentCount(Math.max(0, post.getCommentCount() - 1));
        postDAO.updatePost(post);
        
        commentDAO.deleteComment(commentId);
        
        redirectAttributes.addFlashAttribute("success", "Comment deleted successfully");
        return "redirect:/post/" + post.getSlug();
    }
    
    // Edit comment (only for comment author)
    @PostMapping("/edit/{commentId}")
    @Transactional
    public String editComment(@PathVariable int commentId,
                             @RequestParam int postId,
                             @RequestParam String commentText,
                             HttpSession session,
                             RedirectAttributes redirectAttributes) {
        
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            redirectAttributes.addFlashAttribute("error", "Please login");
            return "redirect:/auth/login";
        }
        
        Comment comment = commentDAO.getCommentById(commentId);
        if (comment == null) {
            redirectAttributes.addFlashAttribute("error", "Comment not found");
            return "redirect:/posts";
        }
        
        // Check if user is comment author
        if (comment.getUser() == null || comment.getUser().getUserId() != loggedInUser.getUserId()) {
            redirectAttributes.addFlashAttribute("error", "You can only edit your own comments");
            return "redirect:/post/" + comment.getPost().getSlug();
        }
        
        comment.setCommentText(commentText);
        commentDAO.updateComment(comment);
        
        redirectAttributes.addFlashAttribute("success", "Comment updated successfully");
        return "redirect:/post/" + comment.getPost().getSlug();
    }
    
    // Flag comment as spam
    @PostMapping("/flag/{commentId}")
    @Transactional
    public String flagCommentAsSpam(@PathVariable int commentId,
                                   @RequestParam int postId,
                                   RedirectAttributes redirectAttributes) {
        
        Comment comment = commentDAO.getCommentById(commentId);
        if (comment == null) {
            redirectAttributes.addFlashAttribute("error", "Comment not found");
            return "redirect:/posts";
        }
        
        comment.setStatus(Comment.Status.SPAM);
        commentDAO.updateComment(comment);
        
        Post post = postDAO.getPostById(postId);
        redirectAttributes.addFlashAttribute("success", "Comment flagged as spam");
        return "redirect:/post/" + post.getSlug();
    }
    
    // Get comments for a post (API endpoint)
    @GetMapping("/post/{postId}")
    @Transactional
    public String getPostComments(@PathVariable int postId, Model model) {
        Post post = postDAO.getPostById(postId);
        
        if (post == null) {
            return "error/404";
        }
        
        List<Comment> comments = commentDAO.getApprovedCommentsByPost(postId);
        model.addAttribute("comments", comments);
        model.addAttribute("post", post);
        
        return "fragments/comments-list";
    }
    
    // Admin: Get all pending comments
    @GetMapping("/admin/pending")
    @Transactional
    public String getPendingComments(HttpSession session, Model model) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        
        if (loggedInUser == null || (loggedInUser.getRole() != User.Role.ADMIN && 
            loggedInUser.getRole() != User.Role.SUPER_ADMIN)) {
            return "error/403";
        }
        
        List<Comment> pendingComments = commentDAO.getPendingComments();
        model.addAttribute("comments", pendingComments);
        
        return "admin/pending-comments";
    }
    
    // Admin: Bulk approve comments
    @PostMapping("/admin/approve-bulk")
    @Transactional
    public String bulkApproveComments(@RequestParam int[] commentIds,
                                     HttpSession session,
                                     RedirectAttributes redirectAttributes) {
        
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        
        if (loggedInUser == null || (loggedInUser.getRole() != User.Role.ADMIN && 
            loggedInUser.getRole() != User.Role.SUPER_ADMIN)) {
            redirectAttributes.addFlashAttribute("error", "Unauthorized");
            return "redirect:/";
        }
        
        for (int commentId : commentIds) {
            Comment comment = commentDAO.getCommentById(commentId);
            if (comment != null && comment.getStatus() == Comment.Status.PENDING) {
                comment.setStatus(Comment.Status.APPROVED);
                commentDAO.updateComment(comment);
            }
        }
        
        redirectAttributes.addFlashAttribute("success", "Comments approved successfully");
        return "redirect:/admin/comments";
    }
    
    // Admin: Bulk reject comments
    @PostMapping("/admin/reject-bulk")
    @Transactional
    public String bulkRejectComments(@RequestParam int[] commentIds,
                                    HttpSession session,
                                    RedirectAttributes redirectAttributes) {
        
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        
        if (loggedInUser == null || (loggedInUser.getRole() != User.Role.ADMIN && 
            loggedInUser.getRole() != User.Role.SUPER_ADMIN)) {
            redirectAttributes.addFlashAttribute("error", "Unauthorized");
            return "redirect:/";
        }
        
        for (int commentId : commentIds) {
            Comment comment = commentDAO.getCommentById(commentId);
            if (comment != null && comment.getStatus() == Comment.Status.PENDING) {
                comment.setStatus(Comment.Status.REJECTED);
                commentDAO.updateComment(comment);
            }
        }
        
        redirectAttributes.addFlashAttribute("success", "Comments rejected successfully");
        return "redirect:/admin/comments";
    }
    
    // Get comment statistics
    @GetMapping("/stats")
    @Transactional
    public String getCommentStats(Model model) {
        long totalComments = commentDAO.getTotalCommentsCount();
        long pendingComments = commentDAO.getPendingCommentsCount();
        long approvedComments = totalComments - pendingComments;
        
        model.addAttribute("totalComments", totalComments);
        model.addAttribute("pendingComments", pendingComments);
        model.addAttribute("approvedComments", approvedComments);
        
        return "admin/comment-stats";
    }
}
