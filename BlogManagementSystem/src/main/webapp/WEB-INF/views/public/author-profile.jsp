<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="pageTitle" value="${author.displayName}" scope="request"/>
<jsp:include page="../layout/header.jsp"/>

<!-- Check if logged-in user is same author -->
<%
    Object obj = session.getAttribute("loggedInUser");
    boolean isOwnProfile = false;
    if (obj != null && request.getAttribute("author") != null) {
        // You can add ID comparison here if needed
        isOwnProfile = true;
    }
%>

<!-- Agar apna hi profile hai to dashboard button dikhao -->
<div style="display: ${loggedInUser.authorId == author.authorId ? 'block' : 'none'}; margin:20px;">
    <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-primary">
        <i class="fas fa-arrow-left"></i> Back to Dashboard
    </a>
</div>

<section class="author-profile-header">
    <div class="container">
        <div class="author-profile-card">
            <c:if test="${not empty author.profileImage}">
                <img src="${pageContext.request.contextPath}/uploads/profiles/${author.profileImage}" alt="${author.displayName}" class="author-avatar">
            </c:if>
            
            <div class="author-info">
                <h1>${author.displayName}</h1>
                <p class="author-bio">${author.bio}</p>
                
                <div class="author-stats">
                    <span><i class="fas fa-users"></i> ${author.followersCount} followers</span>
                    <span><i class="fas fa-file-alt"></i> ${posts.size()} posts</span>
                </div>
                
                <div class="author-social">
                    <c:if test="${not empty author.websiteUrl}">
                        <a href="${author.websiteUrl}" target="_blank"><i class="fas fa-globe"></i></a>
                    </c:if>
                    <c:if test="${not empty author.socialTwitter}">
                        <a href="https://twitter.com/${author.socialTwitter}" target="_blank"><i class="fab fa-twitter"></i></a>
                    </c:if>
                    <c:if test="${not empty author.socialLinkedin}">
                        <a href="https://linkedin.com/in/${author.socialLinkedin}" target="_blank"><i class="fab fa-linkedin"></i></a>
                    </c:if>
                    <c:if test="${not empty author.socialInstagram}">
                        <a href="https://instagram.com/${author.socialInstagram}" target="_blank"><i class="fab fa-instagram"></i></a>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</section>

<section class="author-posts">
    <div class="container">
        <h2>Posts by ${author.displayName}</h2>
        
        <div class="posts-grid">
            <c:forEach items="${posts}" var="post">
                <article class="post-card">
                    <c:if test="${not empty post.featuredImage}">
                        <img src="${pageContext.request.contextPath}/uploads/posts/${post.featuredImage}" alt="${post.title}" class="post-image">
                    </c:if>
                    
                    <div class="post-content">
                        <div class="post-meta">
                            <span class="category-badge">${post.category.categoryName}</span>
                            <span class="post-date">
                                <fmt:formatDate value="${post.publishedDate}" pattern="MMM dd, yyyy"/>
                            </span>
                        </div>
                        
                        <h3 class="post-title">
                            <a href="${pageContext.request.contextPath}/post/${post.slug}">${post.title}</a>
                        </h3>
                        
                        <p class="post-excerpt">${post.excerpt}</p>
                        
                        <div class="post-stats">
                            <span><i class="fas fa-eye"></i> ${post.viewCount}</span>
                            <span><i class="fas fa-comment"></i> ${post.commentCount}</span>
                        </div>
                    </div>
                </article>
            </c:forEach>
            
            <c:if test="${empty posts}">
                <div class="no-posts">
                    <i class="fas fa-inbox"></i>
                    <h3>No posts yet</h3>
                </div>
            </c:if>
        </div>
    </div>
</section>

<jsp:include page="../layout/footer.jsp"/>
