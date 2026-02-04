<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="pageTitle" value="Analytics" scope="request"/>
<jsp:include page="../layout/author-header.jsp"/>

<div class="dashboard-header">
    <h1>Analytics</h1>
</div>

<div class="stats-grid">
    <div class="stat-card">
        <i class="fas fa-eye"></i>
        <div class="stat-content">
            <h3>${totalViews}</h3>
            <p>Total Views</p>
        </div>
    </div>
    
    <div class="stat-card">
        <i class="fas fa-comments"></i>
        <div class="stat-content">
            <h3>${totalComments}</h3>
            <p>Total Comments</p>
        </div>
    </div>
    
    <div class="stat-card">
        <i class="fas fa-file-alt"></i>
        <div class="stat-content">
            <h3>${totalPosts}</h3>
            <p>Total Posts</p>
        </div>
    </div>
</div>

<div class="analytics-section">
    <h2>Post Performance</h2>
    <table class="data-table">
        <thead>
            <tr>
                <th>Post Title</th>
                <th>Views</th>
                <th>Comments</th>
                <th>Status</th>
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
                    <td>${post.viewCount}</td>
                    <td>${post.commentCount}</td>
                    <td><span class="status-badge status-${post.status}">${post.status}</span></td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

<jsp:include page="../layout/author-footer.jsp"/>
