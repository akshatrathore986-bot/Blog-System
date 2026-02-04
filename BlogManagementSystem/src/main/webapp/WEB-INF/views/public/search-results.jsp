<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="pageTitle" value="Search Results" scope="request"/>
<jsp:include page="../layout/header.jsp"/>

<section class="page-header">
    <div class="container">
        <h1><i class="fas fa-search"></i> Search Results</h1>
        <p>Results for: <strong>"${query}"</strong></p>
        <p class="results-count">${results.size()} posts found</p>
    </div>
</section>

<section class="posts-section">
    <div class="container">
        <div class="posts-list">
            <c:forEach items="${results}" var="post">
                <article class="post-item">
                    <c:if test="${not empty post.featuredImage}">
                        <img src="${pageContext.request.contextPath}/uploads/posts/${post.featuredImage}" alt="${post.title}" class="post-thumbnail">
                    </c:if>
                    
                    <div class="post-details">
                        <div class="post-meta">
                            <span class="category-badge">${post.category.categoryName}</span>
                            <span class="post-date">
                                <fmt:formatDate value="${post.publishedDate}" pattern="MMM dd, yyyy"/>
                            </span>
                        </div>
                        
                        <h2 class="post-title">
                            <a href="${pageContext.request.contextPath}/post/${post.slug}">${post.title}</a>
                        </h2>
                        
                        <p class="post-excerpt">${post.excerpt}</p>
                        
                        <div class="post-footer">
                            <div class="author-info">
                                <span>By ${post.author.displayName}</span>
                            </div>
                            
                            <div class="post-stats">
                                <span><i class="fas fa-eye"></i> ${post.viewCount}</span>
                                <span><i class="fas fa-comment"></i> ${post.commentCount}</span>
                            </div>
                        </div>
                    </div>
                </article>
            </c:forEach>
            
            <c:if test="${empty results}">
                <div class="no-posts">
                    <i class="fas fa-search"></i>
                    <h3>No results found</h3>
                    <p>Try different keywords or browse our categories</p>
                    <a href="${pageContext.request.contextPath}/posts" class="btn btn-primary">Browse All Posts</a>
                </div>
            </c:if>
        </div>
    </div>
</section>

<jsp:include page="../layout/footer.jsp"/>
