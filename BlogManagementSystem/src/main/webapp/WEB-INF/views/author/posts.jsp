<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="pageTitle" value="My Posts" scope="request"/>
<jsp:include page="../layout/author-header.jsp"/>

<div class="dashboard-header">
    <h1>My Posts</h1>
    <a href="${pageContext.request.contextPath}/author/post/create" class="btn btn-primary">
        <i class="fas fa-plus"></i> Create New Post
    </a>
</div>

<table class="data-table">
    <thead>
        <tr>
            <th>Title</th>
            <th>Category</th>
            <th>Status</th>
            <th>Published Date</th>
            <th>Views</th>
            <th>Comments</th>
            <th>Actions</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach items="${posts}" var="post">
            <tr>
                <td>
                    <a href="${pageContext.request.contextPath}/post/${post.slug}" target="_blank">
                        ${post.title}
                    </a>
                </td>
                <td>${post.category.categoryName}</td>
                <td><span class="status-badge status-${post.status}">${post.status}</span></td>
                <td>
                    <c:if test="${not empty post.publishedDate}">
                        <fmt:formatDate value="${post.publishedDate}" pattern="MMM dd, yyyy"/>
                    </c:if>
                    <c:if test="${empty post.publishedDate}">-</c:if>
                </td>
                <td>${post.viewCount}</td>
                <td>${post.commentCount}</td>
                <td class="actions">
                    <a href="${pageContext.request.contextPath}/author/post/edit/${post.postId}" class="btn-icon" title="Edit">
                        <i class="fas fa-edit"></i>
                    </a>
                    <a href="${pageContext.request.contextPath}/author/post/delete/${post.postId}" class="btn-icon btn-danger" 
                       onclick="return confirm('Are you sure you want to delete this post?')" title="Delete">
                        <i class="fas fa-trash"></i>
                    </a>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>

<c:if test="${empty posts}">
    <div class="empty-state">
        <i class="fas fa-file-alt"></i>
        <h3>No posts yet</h3>
        <p>Start creating your first post!</p>
        <a href="${pageContext.request.contextPath}/author/post/create" class="btn btn-primary">Create Post</a>
    </div>
</c:if>

<jsp:include page="../layout/author-footer.jsp"/>
