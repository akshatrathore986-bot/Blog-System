<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="pageTitle" value="Register" scope="request"/>
<jsp:include page="../layout/header.jsp"/>

<section class="auth-section">
    <div class="container">
        <div class="auth-wrapper">
            <div class="auth-card">
                <h2><i class="fas fa-user-plus"></i> Create Your Account</h2>
                
                <c:if test="${not empty error}">
                    <div class="alert alert-error">
                        <i class="fas fa-exclamation-circle"></i> ${error}
                    </div>
                </c:if>
                
                <form action="${pageContext.request.contextPath}/auth/register" method="post" class="auth-form">
                    <div class="form-group">
                        <label>Username</label>
                        <input type="text" name="username" placeholder="Choose a username" required>
                    </div>
                    
                    <div class="form-group">
                        <label>Email Address</label>
                        <input type="email" name="email" placeholder="Enter your email" required>
                    </div>
                    
                    <div class="form-group">
                        <label>Password</label>
                        <input type="password" name="password" placeholder="Create a password" required minlength="6">
                    </div>
                    
                    <div class="form-group">
                        <label>Confirm Password</label>
                        <input type="password" name="confirmPassword" placeholder="Confirm your password" required>
                    </div>
                    
                    <div class="form-group">
                        <label class="checkbox">
                            <input type="checkbox" required>
                            <span>I agree to the Terms of Service and Privacy Policy</span>
                        </label>
                    </div>
                    
                    <button type="submit" class="btn btn-primary btn-block">Register</button>
                </form>
                
                <div class="auth-footer">
    <p>Already have an account? 
        <a href="${pageContext.request.contextPath}/auth/login">Login here</a>
    </p>
</div>

<!-- NEW AUTHOR REGISTER LINK ADDED HERE -->
<div class="auth-extra">
    <p>
        Want to publish blogs?
        <a href="${pageContext.request.contextPath}/auth/author-register" class="author-link">
            Register as Author
        </a>
    </p>
</div>

            </div>
        </div>
    </div>
</section>

<jsp:include page="../layout/footer.jsp"/>
