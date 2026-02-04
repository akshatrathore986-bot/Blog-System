<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>

<div class="container auth-page">
    <div class="auth-card">
        <h2>Create Admin Account</h2>
        <p>Register an admin to manage the blog.</p>

        <div style="color:red;">${error}</div>

        <form action="${pageContext.request.contextPath}/auth/admin-register" method="post" autocomplete="off">
            <label>Username *</label><br>
            <input type="text" name="username" value="${param.username}" required><br><br>

            <label>Email *</label><br>
            <input type="email" name="email" value="${param.email}" required><br><br>

            <label>Password *</label><br>
            <input type="password" name="password" required><br><br>

            <label>Confirm Password *</label><br>
            <input type="password" name="confirmPassword" required><br><br>

            <button type="submit">Register Admin</button>
            <a href="${pageContext.request.contextPath}/auth/login">Back to Login</a>
        </form>
    </div>
</div>

<%@ include file="../layout/footer.jsp" %>
