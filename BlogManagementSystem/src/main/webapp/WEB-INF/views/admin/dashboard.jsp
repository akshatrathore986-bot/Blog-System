<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="pageTitle" value="Admin Dashboard" scope="request"/>
<jsp:include page="../layout/admin-header.jsp"/>

<div class="dashboard-header">
    <h1>Admin Dashboard</h1>
</div>

<div class="stats-grid">
    <div class="stat-card">
        <i class="fas fa-users"></i>
        <div class="stat-content">
            <h3>${totalUsers}</h3>
            <p>Total Users</p>
        </div>
    </div>
    
    <div class="stat-card">
        <i class="fas fa-file-alt"></i>
        <div class="stat-content">
            <h3>${totalPosts}</h3>
            <p>Total Posts</p>
        </div>
    </div>
    
    <div class="stat-card">
        <i class="fas fa-check-circle"></i>
        <div class="stat-content">
            <h3>${publishedPosts}</h3>
            <p>Published Posts</p>
        </div>
    </div>
    
    <div class="stat-card">
        <i class="fas fa-comments"></i>
        <div class="stat-content">
            <h3>${pendingComments}</h3>
            <p>Pending Comments</p>
        </div>
    </div>
</div>

<div class="dashboard-grid">
    <div class="dashboard-section">
        <h2>Recent Posts</h2>
        <table class="data-table">
            <thead>
                <tr>
                    <th>Title</th>
                    <th>Author</th>
                    <th>Status</th>
                    <th>Views</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${recentPosts}" var="post">
                    <tr>
                        <td>${post.title}</td>
                        <td>${post.author.displayName}</td>
                        <td><span class="status-badge status-${post.status}">${post.status}</span></td>
                        <td>${post.viewCount}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
    
    <div class="dashboard-section">
        <h2>Pending Comments</h2>
        <div class="comments-list">
            <c:forEach items="${pendingCommentsList}" var="comment">
                <div class="comment-item">
                    <strong>${comment.commenterName}</strong>
                    <p>${comment.commentText}</p>
                    <div class="comment-actions">
                        <a href="${pageContext.request.contextPath}/admin/comment/approve/${comment.commentId}" class="btn-sm btn-success">Approve</a>
                        <a href="${pageContext.request.contextPath}/admin/comment/reject/${comment.commentId}" class="btn-sm btn-danger">Reject</a>
                    </div>
                </div>
            </c:forEach>
            
            <c:if test="${empty pendingCommentsList}">
                <p>No pending comments</p>
            </c:if>
        </div>
    </div>
</div>

<jsp:include page="../layout/admin-footer.jsp"/>
