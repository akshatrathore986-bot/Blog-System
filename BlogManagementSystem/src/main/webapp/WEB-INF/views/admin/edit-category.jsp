<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="pageTitle" value="Edit Category" scope="request"/>
<jsp:include page="../layout/admin-header.jsp"/>

<div class="dashboard-header">
    <h1>Edit Category</h1>
</div>

<form action="${pageContext.request.contextPath}/admin/category/update/${category.categoryId}" method="post" class="admin-form">
    <div class="form-group">
        <label>Category Name *</label>
        <input type="text" name="categoryName" class="form-control" value="${category.categoryName}" required>
    </div>
    
    <div class="form-group">
        <label>Description</label>
        <textarea name="description" class="form-control" rows="4">${category.description}</textarea>
    </div>
    
    <div class="form-actions">
        <button type="submit" class="btn btn-primary">
            <i class="fas fa-save"></i> Update Category
        </button>
        <a href="${pageContext.request.contextPath}/admin/categories" class="btn btn-secondary">Cancel</a>
    </div>
</form>

<jsp:include page="../layout/admin-footer.jsp"/>
