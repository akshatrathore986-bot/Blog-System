<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>

<div class="container auth-page">
    <div class="auth-card">
        <h2>Author Registration</h2>
        <p>Register as an author to publish blogs.</p>

        <!-- Error message simple div me show karo -->
        <div style="color: red;">
            ${error}
        </div>

        <form action="${pageContext.request.contextPath}/auth/author-register" method="post" autocomplete="off">
            <label>Username *</label><br>
            <input type="text" name="username" value="${param.username}" required><br><br>

            <label>Email *</label><br>
            <input type="email" name="email" value="${param.email}" required><br><br>

            <label>Display Name</label><br>
            <input type="text" name="displayName" value="${param.displayName}"><br><br>

            <label>Password *</label><br>
            <input type="password" name="password" required><br><br>

            <label>Confirm Password *</label><br>
            <input type="password" name="confirmPassword" required><br><br>

            <button type="submit">Register</button>
            <a href="${pageContext.request.contextPath}/auth/login">Back to Login</a>
        </form>
    </div>
</div>

<%@ include file="../layout/footer.jsp" %>
