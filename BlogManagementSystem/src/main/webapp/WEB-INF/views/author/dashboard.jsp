<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="pageTitle" value="Author Dashboard" scope="request"/>
<jsp:include page="../layout/author-header.jsp"/>

<div class="dashboard-header">
    <h1>Author Dashboard</h1>
    <a href="${pageContext.request.contextPath}/author/post/create" class="btn btn-primary">
        <i class="fas fa-plus"></i> Create New Post
    </a>
</div>

<div class="stats-grid">
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
            <p>Published</p>
        </div>
    </div>
    
    <div class="stat-card">
        <i class="fas fa-edit"></i>
        <div class="stat-content">
            <h3>${draftPosts}</h3>
            <p>Drafts</p>
        </div>
    </div>
    
    <div class="stat-card">
        <i class="fas fa-users"></i>
        <div class="stat-content">
            <h3>${author.followersCount}</h3>
            <p>Followers</p>
        </div>
    </div>
</div>

<div class="recent-posts-section">
    <h2>Recent Posts</h2>
    <table class="data-table">
        <thead>
            <tr>
                <th>Title</th>
                <th>Status</th>
                <th>Views</th>
                <th>Comments</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${recentPosts}" var="post" begin="0" end="4">
                <tr>
                    <td>${post.title}</td>
                    <td><span class="status-badge status-${post.status}">${post.status}</span></td>
                    <td>${post.viewCount}</td>
                    <td>${post.commentCount}</td>
                    <td>
                        <a href="${pageContext.request.contextPath}/author/post/edit/${post.postId}" class="btn-icon">
                            <i class="fas fa-edit"></i>
                        </a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

<jsp:include page="../layout/author-footer.jsp"/>
