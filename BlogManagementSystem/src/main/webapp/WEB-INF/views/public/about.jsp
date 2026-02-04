<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<c:set var="pageTitle" value="About Us" scope="request"/>
<jsp:include page="../layout/header.jsp"/>

<section class="page-header">
    <div class="container">
        <h1>About Us</h1>
        <p>Learn more about our blog and mission</p>
    </div>
</section>

<section class="about-content">
    <div class="container">
        <div class="content-wrapper">
            <h2>Welcome to Our Blog</h2>
            <p>We are passionate about sharing knowledge, stories, and insights with our community. Our blog was created to provide a platform for writers and readers to connect and explore diverse topics.</p>
            
            <h3>Our Mission</h3>
            <p>To create a vibrant community where ideas are shared, discussed, and celebrated. We believe in the power of words to inspire, educate, and bring people together.</p>
            
            <h3>What We Offer</h3>
            <ul>
                <li>High-quality, well-researched articles</li>
                <li>Diverse perspectives from talented writers</li>
                <li>Engaging community discussions</li>
                <li>Regular updates across multiple categories</li>
            </ul>
            
            <h3>Join Our Community</h3>
            <p>Whether you're a reader looking for great content or a writer wanting to share your voice, we welcome you to be part of our journey.</p>
            
            <div class="cta-section">
                <a href="${pageContext.request.contextPath}/auth/register" class="btn btn-primary">Join Now</a>
                <a href="${pageContext.request.contextPath}/contact" class="btn btn-outline">Contact Us</a>
            </div>
        </div>
    </div>
</section>

<jsp:include page="../layout/footer.jsp"/>
