<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="../layout/header.jsp"/>

<section class="error-page">
    <div class="container">
        <div class="error-content">
            <h1 class="error-code">404</h1>
            <h2>Page Not Found</h2>
            <p>The page you're looking for doesn't exist or has been moved.</p>
            <a href="${pageContext.request.contextPath}/" class="btn btn-primary">Go Home</a>
        </div>
    </div>
</section>

<jsp:include page="../layout/footer.jsp"/>
