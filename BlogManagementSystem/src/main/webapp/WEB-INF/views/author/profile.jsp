<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="pageTitle" value="Author Profile" scope="request"/>
<jsp:include page="../layout/author-header.jsp"/>

<div class="dashboard-header">
    <h1>Author Profile</h1>
</div>

<form action="${pageContext.request.contextPath}/author/profile/update" method="post" enctype="multipart/form-data" class="profile-form">
    <div class="form-row">
        <div class="form-group col-md-6">
            <label>Display Name *</label>
            <input type="text" name="displayName" class="form-control" value="${author.displayName}" required>
        </div>
        
        <div class="form-group col-md-6">
            <label>Profile Image</label>
            <input type="file" name="profileImage" class="form-control" accept="image/*">
            <c:if test="${not empty author.profileImage}">
                <img src="${pageContext.request.contextPath}/uploads/profiles/${author.profileImage}" 
                     alt="Profile" class="profile-preview">
            </c:if>
        </div>
    </div>
    
    <div class="form-group">
        <label>Bio</label>
        <textarea name="bio" class="form-control" rows="4">${author.bio}</textarea>
    </div>
    
    <div class="form-group">
        <label>Website URL</label>
        <input type="url" name="websiteUrl" class="form-control" value="${author.websiteUrl}">
    </div>
    
    <h3>Social Media</h3>
    
    <div class="form-row">
        <div class="form-group col-md-4">
            <label>Twitter Username</label>
            <input type="text" name="socialTwitter" class="form-control" value="${author.socialTwitter}" placeholder="username">
        </div>
        
        <div class="form-group col-md-4">
            <label>LinkedIn Username</label>
            <input type="text" name="socialLinkedin" class="form-control" value="${author.socialLinkedin}" placeholder="username">
        </div>
        
        <div class="form-group col-md-4">
            <label>Instagram Username</label>
            <input type="text" name="socialInstagram" class="form-control" value="${author.socialInstagram}" placeholder="username">
        </div>
    </div>
    
    <div class="form-actions">
        <button type="submit" class="btn btn-primary">
            <i class="fas fa-save"></i> Update Profile
        </button>
    </div>
</form>

<jsp:include page="../layout/author-footer.jsp"/>
