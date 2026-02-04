<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
:set var="pageTitle" value="Home - Willow Blog" scope="request"/>
<jsp:include page="../layout/header.jsp"/>

<section class="hero-section">
    <div class="hero-background">
        <div class="hero-content">
            <h1 class="hero-title">Welcome to Willow</h1>
            <p class="hero-subtitle">Discover amazing stories, insights, and ideas from our community</p>
            <a href="${pageContext.request.contextPath}/posts" class="btn-hero">Explore Posts</a>
        </div>
    </div>
</section>

<!-- Yahan sirf 3 recent posts dikha rahe hain bina forEach ke -->
<%
    java.util.List recent = (java.util.List) request.getAttribute("recentPosts");
%>

<section class="recent-posts-section">
    <div class="container">
        <div class="section-header">
            <h2 class="section-title">Recent Posts</h2>
            <p class="section-subtitle">Latest stories and insights from our writers</p>
        </div>

        <div class="posts-grid">
            <% if (recent != null && recent.size() > 0) {
                   for (int i = 0; i < recent.size() && i < 3; i++) {
                       com.bms.pojo.Post post = (com.bms.pojo.Post) recent.get(i);
            %>
            <article class="post-card">
                <div class="post-image-wrapper">
                    <% if (post.getFeaturedImage() != null && !post.getFeaturedImage().isEmpty()) { %>
                        <img src="<%=request.getContextPath()%>/uploads/posts/<%=post.getFeaturedImage()%>"
                             alt="<%=post.getTitle()%>" class="post-image">
                    <% } else { %>
                        <div class="post-image-placeholder">
                            <i class="fas fa-image"></i>
                        </div>
                    <% } %>
                </div>

                <div class="post-card-content">
                    <div class="post-meta">
                        <span class="category-badge"><%=post.getCategory().getCategoryName()%></span>
                        <span class="post-date">
                            <fmt:formatDate value="<%=post.getPublishedDate()%>" pattern="MMM dd, yyyy"/>
                        </span>
                    </div>

                    <h3 class="post-title">
                        <a href="<%=request.getContextPath()%>/post/<%=post.getSlug()%>"><%=post.getTitle()%></a>
                    </h3>

                    <p class="post-excerpt"><%=post.getExcerpt()%></p>

                    <div class="post-footer">
                        <div class="author-info">
                            <% if (post.getAuthor() != null && post.getAuthor().getProfileImage() != null 
                                   && !post.getAuthor().getProfileImage().isEmpty()) { %>
                                <img src="<%=request.getContextPath()%>/uploads/profiles/<%=post.getAuthor().getProfileImage()%>"
                                     alt="<%=post.getAuthor().getDisplayName()%>" class="author-avatar">
                            <% } else { %>
                                <div class="author-avatar-placeholder">
                                    <i class="fas fa-user"></i>
                                </div>
                            <% } %>
                            <div class="author-meta">
                                <p class="author-name"><%=post.getAuthor().getDisplayName()%></p>
                                <p class="read-time"><%=post.getReadingTime()%> min read</p>
                            </div>
                        </div>
                    </div>
                </div>
            </article>
            <%   } // for
               } // if
            %>
        </div>

        <div class="view-all-container">
            <a href="${pageContext.request.contextPath}/posts" class="btn-secondary">View All Posts</a>
        </div>
    </div>
</section>

<!-- Categories ko bhi scriptlet se render kar sakte ho agar chaho -->

<jsp:include page="../layout/footer.jsp"/>
