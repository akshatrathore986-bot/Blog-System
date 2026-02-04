<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:include page="../layout/header.jsp"/>

<style>
/* ===== THE SIDE BLOGGER COLOR SYSTEM ===== */
:root {
  --blush-light: #fdf0f0;
  --blush-medium: #f8e8ea;
  --blush-dark: #f5e6e8;
  --cream: #fefdfb;
  --white: #ffffff;

  --text-dark: #3d3d3d;
  --text-medium: #5a5a5a;
  --text-light: #8a8a8a;

  --accent-primary: #d4a5a5;
  --accent-hover: #c89090;

  --radius-md: 12px;
  --radius-lg: 18px;

  --shadow-sm: 0 4px 12px rgba(0,0,0,0.06);
  --shadow-md: 0 12px 24px rgba(212,165,165,0.18);
}

/* ===== HERO SECTION ===== */
.hero-section {
  background: linear-gradient(
    135deg,
    var(--blush-light) 0%,
    var(--blush-medium) 50%,
    var(--blush-dark) 100%
  );
  padding: 90px 20px;
  text-align: center;
}

.hero-title {
  font-size: 3.2rem;
  font-weight: 700;
  color: var(--text-dark);
  margin-bottom: 12px;
}

.hero-subtitle {
  font-size: 1.2rem;
  color: var(--text-medium);
  margin-bottom: 35px;
}

.btn-hero {
  display: inline-block;
  padding: 14px 42px;
  background: var(--accent-primary);
  color: #fff;
  text-decoration: none;
  border-radius: 50px;
  font-weight: 600;
  transition: all 0.3s ease;
  box-shadow: 0 8px 22px rgba(212,165,165,0.35);
}

.btn-hero:hover {
  background: var(--accent-hover);
  transform: translateY(-3px);
}

/* ===== RECENT POSTS SECTION ===== */
.recent-posts-section {
  background: var(--cream);
  padding: 70px 20px;
}

.container {
  max-width: 1200px;
  margin: auto;
}

.section-header {
  text-align: center;
  margin-bottom: 50px;
}

.section-title {
  font-size: 2.4rem;
  margin-bottom: 10px;
}

.section-subtitle {
  color: var(--text-medium);
}

/* ===== POSTS GRID ===== */
.posts-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 30px;
}

/* ===== POST CARD ===== */
.post-card {
  background: var(--white);
  border-radius: var(--radius-lg);
  overflow: hidden;
  box-shadow: var(--shadow-sm);
  transition: all 0.35s ease;
}

.post-card:hover {
  transform: translateY(-8px);
  box-shadow: var(--shadow-md);
}

.post-image-wrapper {
  height: 220px;
  background: linear-gradient(
    135deg,
    var(--blush-medium),
    var(--blush-dark)
  );
}

.post-image {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.post-image-placeholder {
  height: 100%;
  display: flex;
  align-items: center;
  justify-content: center;
  color: var(--accent-primary);
  font-size: 3rem;
}

/* ===== CARD CONTENT ===== */
.post-card-content {
  padding: 22px;
}

.post-meta {
  display: flex;
  justify-content: space-between;
  margin-bottom: 10px;
  font-size: 0.85rem;
}

.category-badge {
  background: var(--blush-light);
  color: var(--accent-primary);
  padding: 5px 14px;
  border-radius: 50px;
  font-weight: 600;
}

.post-date {
  color: var(--text-light);
}

.post-title a {
  font-size: 1.4rem;
  color: var(--text-dark);
  text-decoration: none;
  transition: color 0.3s ease;
}

.post-title a:hover {
  color: var(--accent-primary);
}

.post-excerpt {
  color: var(--text-medium);
  margin: 12px 0 18px;
  font-size: 0.95rem;
}

/* ===== AUTHOR ===== */
.author-info {
  display: flex;
  align-items: center;
  gap: 12px;
}

.author-avatar,
.author-avatar-placeholder {
  width: 44px;
  height: 44px;
  border-radius: 50%;
  background: var(--blush-medium);
  display: flex;
  align-items: center;
  justify-content: center;
  overflow: hidden;
}

.author-avatar img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.author-name {
  font-weight: 600;
  font-size: 0.9rem;
}

.read-time {
  font-size: 0.8rem;
  color: var(--text-light);
}

/* ===== VIEW ALL BUTTON ===== */
.view-all-container {
  text-align: center;
  margin-top: 50px;
}

.btn-secondary {
  padding: 12px 36px;
  border-radius: 50px;
  border: 2px solid var(--accent-primary);
  color: var(--accent-primary);
  text-decoration: none;
  font-weight: 600;
  transition: all 0.3s ease;
}

.btn-secondary:hover {
  background: var(--accent-primary);
  color: #fff;
}
</style>

<!-- ===== HERO ===== -->
<section class="hero-section">
  <h1 class="hero-title">A Platform for Your Thoughts</h1>
  <p class="hero-subtitle">
    Discover amazing stories, insights, and ideas from our community
  </p>
  <a href="${pageContext.request.contextPath}/posts" class="btn-hero">
    Explore Posts
  </a>
</section>

<%
  java.util.List recent = (java.util.List) request.getAttribute("recentPosts");
%>

<!-- ===== RECENT POSTS ===== -->
<section class="recent-posts-section">
  <div class="container">

    <div class="section-header">
      <h2 style="border: none; border-top: 1px solid #000; opacity: 0.4;" class="section-title">Recent Posts</h2>
      <p class="section-subtitle">Latest stories and insights</p>
    </div>

    <div class="posts-grid">
      <% if (recent != null) {
           for (int i = 0; i < recent.size() && i < 3; i++) {
             com.bms.pojo.Post post = (com.bms.pojo.Post) recent.get(i);
      %>

      <article class="post-card">
        <div class="post-image-wrapper">
          <% if (post.getFeaturedImage() != null && !post.getFeaturedImage().isEmpty()) { %>
            <img class="post-image"
                 src="<%=request.getContextPath()%>/uploads/posts/<%=post.getFeaturedImage()%>">
          <% } else { %>
            <div class="post-image-placeholder">
              <i class="fas fa-image"></i>
            </div>
          <% } %>
        </div>

        <div class="post-card-content">
          <div class="post-meta">
            <span class="category-badge">
              <%=post.getCategory().getCategoryName()%>
            </span>
            <span class="post-date">
              <fmt:formatDate value="<%=post.getPublishedDate()%>" pattern="MMM dd, yyyy"/>
            </span>
          </div>

          <h3 class="post-title">
            <a href="<%=request.getContextPath()%>/post/<%=post.getSlug()%>">
              <%=post.getTitle()%>
            </a>
          </h3>

          <p class="post-excerpt"><%=post.getExcerpt()%></p>

          <div class="author-info">
            <div class="author-avatar-placeholder">
              <i class="fas fa-user"></i>
            </div>
            <div>
              <p class="author-name"><%=post.getAuthor().getDisplayName()%></p>
              <p class="read-time"><%=post.getReadingTime()%> min read</p>
            </div>
          </div>
        </div>
      </article>

      <% } } %>
    </div>

    <div class="view-all-container">
      <a href="${pageContext.request.contextPath}/posts" class="btn-secondary">
        View All Posts
      </a>
    </div>

  </div>
</section>

<jsp:include page="../layout/footer.jsp"/>
