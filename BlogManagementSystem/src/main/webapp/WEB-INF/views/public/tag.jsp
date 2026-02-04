<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="pageTitle" value="Tag: ${tag.tagName}" scope="request"/>
<jsp:include page="../layout/header.jsp"/>

<section class="page-header">
    <div class="container">
        <h1><i class="fas fa-tag"></i> #${tag.tagName}</h1>
        <p>Posts tagged with "${tag.tagName}"</p>
    </div>
</section>

<section class="posts-section">
    <div class="container">
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
                        
                        <div class="post-footer">
                            <div class="author-info">
                                <span>By ${post.author.displayName}</span>
                            </div>
                        </div>
                    </div>
                </article>
            </c:forEach>
            
            <c:if test="${empty posts}">
                <div class="no-posts">
                    <i class="fas fa-inbox"></i>
                    <h3>No posts with this tag yet</h3>
                </div>
            </c:if>
        </div>
    </div>
</section>

<jsp:include page="../layout/footer.jsp"/>
