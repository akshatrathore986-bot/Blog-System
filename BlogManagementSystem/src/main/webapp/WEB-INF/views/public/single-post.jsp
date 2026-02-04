<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="pageTitle" value="${post.title}" scope="request"/>
<jsp:include page="../layout/header.jsp"/>

<article class="single-post">
    <div class="container">
        <div class="post-header">
            <div class="post-meta">
                <a href="${pageContext.request.contextPath}/category/${post.category.slug}" class="category-badge">
                    ${post.category.categoryName}
                </a>
                <span class="post-date">
                    <fmt:formatDate value="${post.publishedDate}" pattern="MMMM dd, yyyy"/>
                </span>
            </div>
            
            <h1 class="post-title">${post.title}</h1>
            
            <div class="post-author">
                <c:if test="${not empty post.author.profileImage}">
                    <img src="${pageContext.request.contextPath}/uploads/profiles/${post.author.profileImage}" alt="${post.author.displayName}">
                </c:if>
                <div class="author-details">
                    <a href="${pageContext.request.contextPath}/author/${post.author.authorId}">
                        ${post.author.displayName}
                    </a>
                    <div class="post-stats">
                        <span><i class="fas fa-eye"></i> ${post.viewCount} views</span>
                        <span><i class="fas fa-comment"></i> ${post.commentCount} comments</span>
                        <span><i class="fas fa-clock"></i> ${post.readingTime} min read</span>
                    </div>
                </div>
            </div>
        </div>
        
        <c:if test="${not empty post.featuredImage}">
            <div class="post-featured-image">
                <img src="${pageContext.request.contextPath}/uploads/posts/${post.featuredImage}" alt="${post.title}">
            </div>
        </c:if>
        
        <div class="post-content">
    ${post.content}
</div>

<!-- NEW TAG LIST (from your snippet) -->
<div class="post-tag-list">
    <h3>Tags:</h3>
    <ul>
        <c:forEach var="tag" items="${post.tags}">
            <li>${tag.tagName}</li>
        </c:forEach>
    </ul>
</div>

        
        <div class="post-tags">
            <c:forEach items="${post.tags}" var="tag">
                <a href="${pageContext.request.contextPath}/tag/${tag.slug}" class="tag-badge">
                    #${tag.tagName}
                </a>
            </c:forEach>
        </div>
    </div>
</article>

<section class="comments-section">
    <div class="container">
        <h2>Comments (${post.commentCount})</h2>
        
        <c:if test="${not empty sessionScope.loggedInUser}">
            <form action="${pageContext.request.contextPath}/user/comment/add" method="post" class="comment-form">
                <input type="hidden" name="postId" value="${post.postId}">
                <textarea name="commentText" placeholder="Write your comment..." required></textarea>
                <button type="submit" class="btn btn-primary">Post Comment</button>
            </form>
        </c:if>
        
        <c:if test="${empty sessionScope.loggedInUser}">
            <div class="login-prompt">
                <p>Please <a href="${pageContext.request.contextPath}/auth/login">login</a> to post a comment.</p>
            </div>
        </c:if>
        
        <div class="comments-list">
            <c:forEach items="${comments}" var="comment">
                <div class="comment-item">
                    <div class="comment-author">
                        <strong>${comment.commenterName}</strong>
                        <span class="comment-date">
                            <fmt:formatDate value="${comment.createdAt}" pattern="MMM dd, yyyy"/>
                        </span>
                    </div>
                    <p class="comment-text">${comment.commentText}</p>
                </div>
            </c:forEach>
            
            <c:if test="${empty comments}">
                <p class="no-comments">No comments yet. Be the first to comment!</p>
            </c:if>
        </div>
    </div>
</section>

<section class="related-posts">
    <div class="container">
        <h2>Related Posts</h2>
        
        <div class="posts-grid">
            <c:forEach items="${relatedPosts}" var="relatedPost" begin="0" end="2">
                <c:if test="${relatedPost.postId != post.postId}">
                    <article class="post-card">
                        <c:if test="${not empty relatedPost.featuredImage}">
                            <img src="${pageContext.request.contextPath}/uploads/posts/${relatedPost.featuredImage}" alt="${relatedPost.title}">
                        </c:if>
                        
                        <div class="post-content">
                            <h3>
                                <a href="${pageContext.request.contextPath}/post/${relatedPost.slug}">
                                    ${relatedPost.title}
                                </a>
                            </h3>
                            <p>${relatedPost.excerpt}</p>
                        </div>
                    </article>
                </c:if>
            </c:forEach>
        </div>
    </div>
</section>

<jsp:include page="../layout/footer.jsp"/>
