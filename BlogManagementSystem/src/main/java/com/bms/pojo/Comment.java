package com.bms.pojo;

import javax.persistence.*;
import java.sql.Timestamp;

@Entity
@Table(name = "comments")
public class Comment {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "comment_id")
    private int commentId;
    
    @ManyToOne
    @JoinColumn(name = "post_id", nullable = false)
    private Post post;
    
    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;
    
    @ManyToOne
    @JoinColumn(name = "parent_comment_id")
    private Comment parentComment;
    
    @Column(name = "commenter_name", length = 100)
    private String commenterName;
    
    @Column(name = "commenter_email", length = 100)
    private String commenterEmail;
    
    @Column(name = "comment_text", columnDefinition = "TEXT", nullable = false)
    private String commentText;
    
    @Enumerated(EnumType.STRING)
    @Column(name = "status")
    private Status status = Status.PENDING;
    
    @Column(name = "likes_count")
    private int likesCount = 0;
    
    @Column(name = "created_at")
    private Timestamp createdAt;
    
    public enum Status {
        PENDING, APPROVED, REJECTED, SPAM
    }
    
    // Constructors
    public Comment() {}
    
    // Getters and Setters
    public int getCommentId() {
        return commentId;
    }
    
    public void setCommentId(int commentId) {
        this.commentId = commentId;
    }
    
    public Post getPost() {
        return post;
    }
    
    public void setPost(Post post) {
        this.post = post;
    }
    
    public User getUser() {
        return user;
    }
    
    public void setUser(User user) {
        this.user = user;
    }
    
    public Comment getParentComment() {
        return parentComment;
    }
    
    public void setParentComment(Comment parentComment) {
        this.parentComment = parentComment;
    }
    
    public String getCommenterName() {
        return commenterName;
    }
    
    public void setCommenterName(String commenterName) {
        this.commenterName = commenterName;
    }
    
    public String getCommenterEmail() {
        return commenterEmail;
    }
    
    public void setCommenterEmail(String commenterEmail) {
        this.commenterEmail = commenterEmail;
    }
    
    public String getCommentText() {
        return commentText;
    }
    
    public void setCommentText(String commentText) {
        this.commentText = commentText;
    }
    
    public Status getStatus() {
        return status;
    }
    
    public void setStatus(Status status) {
        this.status = status;
    }
    
    public int getLikesCount() {
        return likesCount;
    }
    
    public void setLikesCount(int likesCount) {
        this.likesCount = likesCount;
    }
    
    public Timestamp getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
}
