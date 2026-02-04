<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="pageTitle" value="Edit User" scope="request"/>
<jsp:include page="../layout/admin-header.jsp"/>

<div class="dashboard-header">
    <h1>Edit User</h1>
</div>

<form action="${pageContext.request.contextPath}/admin/user/update/${user.userId}" method="post" class="admin-form">
    <div class="form-group">
        <label>Username *</label>
        <input type="text" name="username" class="form-control" value="${user.username}" required>
    </div>
    
    <div class="form-group">
        <label>Email *</label>
        <input type="email" name="email" class="form-control" value="${user.email}" required>
    </div>
    
    <div class="form-group">
        <label>Role *</label>
        <select name="role" class="form-control" required>
            <option value="READER" ${user.role == 'READER' ? 'selected' : ''}>Reader</option>
            <option value="AUTHOR" ${user.role == 'AUTHOR' ? 'selected' : ''}>Author</option>
            <option value="ADMIN" ${user.role == 'ADMIN' ? 'selected' : ''}>Admin</option>
        </select>
    </div>
    
    <div class="form-group">
        <label>Status *</label>
        <select name="status" class="form-control" required>
            <option value="ACTIVE" ${user.status == 'ACTIVE' ? 'selected' : ''}>Active</option>
            <option value="INACTIVE" ${user.status == 'INACTIVE' ? 'selected' : ''}>Inactive</option>
            <option value="SUSPENDED" ${user.status == 'SUSPENDED' ? 'selected' : ''}>Suspended</option>
        </select>
    </div>
    
    <div class="form-actions">
        <button type="submit" class="btn btn-primary">
            <i class="fas fa-save"></i> Update User
        </button>
        <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-secondary">Cancel</a>
    </div>
</form>

<jsp:include page="../layout/admin-footer.jsp"/>
