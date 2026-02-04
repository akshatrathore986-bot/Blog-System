<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style>
/* ===== FOOTER COLOR SYSTEM (MATCHING SIDE BLOGGER) ===== */
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
}

/* ===== FOOTER ===== */
.footer {
  background: linear-gradient(
    135deg,
    var(--text-dark) 0%,
    var(--text-medium) 100%
  );
  color: var(--white);
  padding: 80px 20px 30px;
  margin-top: 80px;
}

.footer .container {
  max-width: 1200px;
  margin: auto;
}

.footer-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
  gap: 40px;
  margin-bottom: 40px;
}

/* ===== FOOTER COLUMNS ===== */
.footer-col h3,
.footer-col h4 {
  font-family: 'Playfair Display', serif;
  font-size: 1.3rem;
  margin-bottom: 16px;
  color: var(--blush-light);
}

.footer-col p {
  font-size: 0.95rem;
  color: rgba(255, 255, 255, 0.85);
  line-height: 1.7;
}

.footer-col ul {
  list-style: none;
  padding: 0;
}

.footer-col ul li {
  margin-bottom: 10px;
}

.footer-col ul li a {
  color: rgba(255, 255, 255, 0.8);
  text-decoration: none;
  font-size: 0.95rem;
  transition: all 0.3s ease;
}

.footer-col ul li a:hover {
  color: var(--blush-light);
  padding-left: 8px;
}

/* ===== SOCIAL LINKS ===== */
.social-links {
  display: flex;
  gap: 12px;
  margin-top: 16px;
}

.social-links a {
  width: 40px;
  height: 40px;
  background: rgba(255, 255, 255, 0.12);
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  color: var(--white);
  font-size: 1.1rem;
  transition: all 0.3s ease;
}

.social-links a:hover {
  background: var(--accent-primary);
  transform: translateY(-4px);
}

/* ===== NEWSLETTER ===== */
.newsletter-form {
  margin-top: 16px;
  display: flex;
  gap: 10px;
}

.newsletter-form input {
  flex: 1;
  padding: 12px 14px;
  border-radius: var(--radius-md);
  border: none;
  outline: none;
  font-size: 0.9rem;
}

.newsletter-form button {
  padding: 12px 20px;
  border-radius: var(--radius-md);
  border: none;
  background: var(--accent-primary);
  color: var(--white);
  font-weight: 600;
  cursor: pointer;
  transition: all 0.3s ease;
}

.newsletter-form button:hover {
  background: var(--accent-hover);
}

/* ===== FOOTER BOTTOM ===== */
.footer-bottom {
  text-align: center;
  padding-top: 20px;
  border-top: 1px solid rgba(255, 255, 255, 0.15);
  font-size: 0.9rem;
  color: rgba(255, 255, 255, 0.7);
}

/* ===== RESPONSIVE ===== */
@media (max-width: 600px) {
  .newsletter-form {
    flex-direction: column;
  }

  .newsletter-form button {
    width: 100%;
  }
}
</style>

<footer class="footer">
  <div class="container">
    <div class="footer-grid">

      <div class="footer-col">
        <h3><i class="fas fa-blog"></i> BlogMS</h3>
        <p>
          A modern blog management system built with Spring MVC,
          Hibernate, and JSP.
        </p>
        <div class="social-links">
          <a href="#"><i class="fab fa-facebook-f"></i></a>
          <a href="#"><i class="fab fa-twitter"></i></a>
          <a href="#"><i class="fab fa-instagram"></i></a>
          <a href="#"><i class="fab fa-linkedin-in"></i></a>
        </div>
      </div>

      <div class="footer-col">
        <h4>Quick Links</h4>
        <ul>
          <li><a href="${pageContext.request.contextPath}/">Home</a></li>
          <li><a href="${pageContext.request.contextPath}/posts">All Posts</a></li>
          <li><a href="${pageContext.request.contextPath}/categories">Categories</a></li>
          <li><a href="${pageContext.request.contextPath}/authors">Authors</a></li>
        </ul>
      </div>

      <div class="footer-col">
        <h4>Information</h4>
        <ul>
          <li><a href="${pageContext.request.contextPath}/about">About Us</a></li>
          <li><a href="${pageContext.request.contextPath}/contact">Contact</a></li>
          <li><a href="#">Privacy Policy</a></li>
          <li><a href="#">Terms of Service</a></li>
        </ul>
      </div>

      <div class="footer-col">
        <h4>Newsletter</h4>
        <p>Subscribe to get latest updates</p>
        <form class="newsletter-form">
          <input type="email" placeholder="Your email" required>
          <button type="submit">Subscribe</button>
        </form>
      </div>

    </div>

    <div class="footer-bottom">
      <p>&copy; 2024 Blog Management System. All rights reserved.</p>
    </div>
  </div>
</footer>

<script src="${pageContext.request.contextPath}/resources/js/main.js"></script>
</body>
</html>
