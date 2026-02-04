<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="../layout/header.jsp"/>

<section class="error-page">
    <div class="container">
        <div class="error-content">
            <i class="fas fa-lock" style="font-size: 80px; color: #e74c3c;"></i>
            <h2>Access Restricted</h2>
            <p>You need to be logged in to access this page.</p>
            <a href="${pageContext.request.contextPath}/auth/login" class="btn btn-primary">Login</a>
        </div>
    </div>
</section>

<jsp:include page="../layout/footer.jsp"/>
