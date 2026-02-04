package com.bms.dao;

import com.bms.pojo.Comment;
import java.util.List;

public interface CommentDAO {
    void saveComment(Comment comment);
    void updateComment(Comment comment);
    void deleteComment(int commentId);
    Comment getCommentById(int commentId);
    List<Comment> getCommentsByPost(int postId);
    List<Comment> getCommentsByUser(int userId);
    List<Comment> getCommentsByStatus(Comment.Status status);
    List<Comment> getPendingComments();
    List<Comment> getApprovedCommentsByPost(int postId);
    long getTotalCommentsCount();
    long getPendingCommentsCount();
}
