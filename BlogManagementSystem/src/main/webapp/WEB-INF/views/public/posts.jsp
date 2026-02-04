<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="pageTitle" value="All Posts" scope="request"/>
<jsp:include page="../layout/header.jsp"/>

<section class="page-header">
    <div class="container">
        <h1>All Blog Posts</h1>
        <p>Explore our collection of articles</p>
    </div>
</section>

<section class="posts-section">
    <div class="container">
        <div class="main-content-wrapper">
            <div class="posts-list">
                <c:forEach items="${posts}" var="post">
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
                
                <c:if test="${empty posts}">
                    <div class="no-posts">
                        <i class="fas fa-inbox"></i>
                        <h3>No posts found</h3>
                        <p>Check back later for new content!</p>
                    </div>
                </c:if>
            </div>
            
            <aside class="sidebar">
                <div class="sidebar-widget">
                    <h3>Search</h3>
                    <form action="${pageContext.request.contextPath}/search" method="get" class="search-form">
                        <input type="text" name="q" placeholder="Search posts..." required>
                        <button type="submit"><i class="fas fa-search"></i></button>
                    </form>
                </div>
                
                <div class="sidebar-widget">
                    <h3>Categories</h3>
                    <ul class="category-list">
                        <c:forEach items="${categories}" var="category">
                            <li>
                                <a href="${pageContext.request.contextPath}/category/${category.slug}">
                                    ${category.categoryName} <span>(${category.postCount})</span>
                                </a>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </aside>
        </div>
    </div>
</section>

<jsp:include page="../layout/footer.jsp"/>
