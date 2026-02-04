<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="pageTitle" value="User Dashboard" scope="request"/>
<jsp:include page="../layout/header.jsp"/>

<section class="user-dashboard">
    <div class="container">
        <h1>Welcome, ${user.username}!</h1>
        
        <div class="dashboard-grid">
            <div class="dashboard-card">
                <i class="fas fa-comments"></i>
                <h3>My Comments</h3>
                <p class="stat-number">${userComments.size()}</p>
                <a href="${pageContext.request.contextPath}/user/comments" class="btn btn-sm">View All</a>
            </div>
            
            <div class="dashboard-card">
                <i class="fas fa-user"></i>
                <h3>Profile</h3>
                <p>Manage your account settings</p>
                <a href="${pageContext.request.contextPath}/user/profile" class="btn btn-sm">Edit Profile</a>
            </div>
            
            <div class="dashboard-card">
                <i class="fas fa-lock"></i>
                <h3>Security</h3>
                <p>Change your password</p>
                <a href="${pageContext.request.contextPath}/user/change-password" class="btn btn-sm">Change Password</a>
            </div>
        </div>
        
        <div class="recent-activity">
            <h2>Recent Posts</h2>
            <div class="posts-list">
                <c:forEach items="${recentPosts}" var="post">
                    <div class="post-item-compact">
                        <h4><a href="${pageContext.request.contextPath}/post/${post.slug}">${post.title}</a></h4>
                        <p>${post.excerpt}</p>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</section>

<jsp:include page="../layout/footer.jsp"/>
