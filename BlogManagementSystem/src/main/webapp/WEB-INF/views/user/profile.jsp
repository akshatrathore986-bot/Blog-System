<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="pageTitle" value="My Profile" scope="request"/>
<jsp:include page="../layout/header.jsp"/>

<section class="profile-section">
    <div class="container">
        <h1>My Profile</h1>
        
        <c:if test="${not empty success}">
            <div class="alert alert-success">
                <i class="fas fa-check-circle"></i> ${success}
            </div>
        </c:if>
        
        <div class="profile-card">
            <form action="${pageContext.request.contextPath}/user/profile/update" method="post">
                <div class="form-group">
                    <label>Username</label>
                    <input type="text" name="username" value="${user.username}" required>
                </div>
                
                <div class="form-group">
                    <label>Email</label>
                    <input type="email" name="email" value="${user.email}" required>
                </div>
                
                <div class="form-group">
                    <label>Role</label>
                    <input type="text" value="${user.role}" disabled>
                </div>
                
                <button type="submit" class="btn btn-primary">Update Profile</button>
            </form>
        </div>
    </div>
</section>

<jsp:include page="../layout/footer.jsp"/>
