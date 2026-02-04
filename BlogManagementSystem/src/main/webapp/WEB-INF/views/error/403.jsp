<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="../layout/header.jsp"/>

<section class="error-page">
    <div class="container">
        <div class="error-content">
            <h1 class="error-code">403</h1>
            <h2>Access Denied</h2>
            <p>You don't have permission to access this page.</p>
            <a href="${pageContext.request.contextPath}/" class="btn btn-primary">Go Home</a>
        </div>
    </div>
</section>

<jsp:include page="../layout/footer.jsp"/>
