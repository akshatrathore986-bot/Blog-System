<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<c:set var="pageTitle" value="Create User" scope="request"/>
<jsp:include page="../layout/admin-header.jsp"/>

<div class="dashboard-header">
    <h1>Create New User</h1>
</div>

<form action="${pageContext.request.contextPath}/admin/user/create" method="post" class="admin-form">
    <div class="form-group">
        <label>Username *</label>
        <input type="text" name="username" class="form-control" required>
    </div>
    
    <div class="form-group">
        <label>Email *</label>
        <input type="email" name="email" class="form-control" required>
    </div>
    
    <div class="form-group">
        <label>Password *</label>
        <input type="password" name="password" class="form-control" required minlength="6">
    </div>
    
    <div class="form-group">
        <label>Role *</label>
        <select name="role" class="form-control" required>
            <option value="READER">Reader</option>
            <option value="AUTHOR">Author</option>
            <option value="ADMIN">Admin</option>
        </select>
    </div>
    
    <div class="form-actions">
        <button type="submit" class="btn btn-primary">
            <i class="fas fa-save"></i> Create User
        </button>
        <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-secondary">Cancel</a>
    </div>
</form>

<jsp:include page="../layout/admin-footer.jsp"/>
