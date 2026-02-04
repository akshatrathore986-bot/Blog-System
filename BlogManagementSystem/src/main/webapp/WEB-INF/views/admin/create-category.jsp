<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<c:set var="pageTitle" value="Create Category" scope="request"/>
<jsp:include page="../layout/admin-header.jsp"/>

<div class="dashboard-header">
    <h1>Create New Category</h1>
</div>

<form action="${pageContext.request.contextPath}/admin/category/create" method="post" class="admin-form">
    <div class="form-group">
        <label>Category Name *</label>
        <input type="text" name="categoryName" class="form-control" required>
    </div>
    
    <div class="form-group">
        <label>Description</label>
        <textarea name="description" class="form-control" rows="4"></textarea>
    </div>
    
    <div class="form-actions">
        <button type="submit" class="btn btn-primary">
            <i class="fas fa-save"></i> Create Category
        </button>
        <a href="${pageContext.request.contextPath}/admin/categories" class="btn btn-secondary">Cancel</a>
    </div>
</form>

<jsp:include page="../layout/admin-footer.jsp"/>
