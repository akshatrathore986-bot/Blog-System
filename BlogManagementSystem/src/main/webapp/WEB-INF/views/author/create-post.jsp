<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="pageTitle" value="Create Post" scope="request"/>
<jsp:include page="../layout/author-header.jsp"/>

<div class="dashboard-header">
    <h1>Create New Post</h1>
</div>

<form action="${pageContext.request.contextPath}/author/post/create" method="post" enctype="multipart/form-data" class="post-form">
    <div class="form-row">
        <div class="form-group col-md-8">
            <label>Post Title *</label>
            <input type="text" name="title" class="form-control" placeholder="Enter post title" required>
        </div>
        
        <div class="form-group col-md-4">
            <label>Category *</label>
            <select name="categoryId" class="form-control" required>
                <option value="">Select Category</option>
                <c:forEach items="${categories}" var="category">
                    <option value="${category.categoryId}">${category.categoryName}</option>
                </c:forEach>
            </select>
        </div>
    </div>
    
    <div class="form-group">
        <label>Excerpt</label>
        <textarea name="excerpt" class="form-control" rows="3" placeholder="Brief description of the post"></textarea>
    </div>
    
    <div class="form-group">
        <label>Content *</label>
        <textarea name="content" class="form-control editor" rows="15" placeholder="Write your post content here..." required></textarea>
    </div>
    
    <div class="form-row">
        <div class="form-group col-md-6">
            <label>Featured Image</label>
            <input type="file" name="featuredImage" class="form-control" accept="image/*">
        </div>
        
        <div class="form-group col-md-6">
            <label>Tags</label>
            <select name="tagIds" class="form-control" multiple>
                <c:forEach items="${tags}" var="tag">
                    <option value="${tag.tagId}">${tag.tagName}</option>
                </c:forEach>
            </select>
            <small>Hold Ctrl/Cmd to select multiple tags</small>
        </div>
    </div>
    
    <div class="form-group">
        <label>Status *</label>
        <select name="status" class="form-control" required>
            <option value="DRAFT">Draft</option>
            <option value="PUBLISHED">Publish Immediately</option>
            <option value="SCHEDULED">Schedule for Later</option>
        </select>
    </div>
    
    <div class="form-actions">
        <button type="submit" class="btn btn-primary">
            <i class="fas fa-save"></i> Create Post
        </button>
        <a href="${pageContext.request.contextPath}/author/posts" class="btn btn-secondary">Cancel</a>
    </div>
</form>

<jsp:include page="../layout/author-footer.jsp"/>
