<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="pageTitle" value="Manage Users" scope="request"/>
<jsp:include page="../layout/admin-header.jsp"/>

<div class="dashboard-header">
    <h1>Manage Users</h1>
    <a href="${pageContext.request.contextPath}/admin/user/create" class="btn btn-primary">
        <i class="fas fa-user-plus"></i> Add New User
    </a>
</div>

<table class="data-table">
    <thead>
        <tr>
            <th>ID</th>
            <th>Username</th>
            <th>Email</th>
            <th>Role</th>
            <th>Status</th>
            <th>Created</th>
            <th>Actions</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach items="${users}" var="user">
            <tr>
                <td>${user.userId}</td>
                <td>${user.username}</td>
                <td>${user.email}</td>
                <td><span class="role-badge role-${user.role}">${user.role}</span></td>
                <td><span class="status-badge status-${user.status}">${user.status}</span></td>
                <td>
                    <fmt:formatDate value="${user.createdAt}" pattern="MMM dd, yyyy"/>
                </td>
                <td class="actions">
                    <a href="${pageContext.request.contextPath}/admin/user/edit/${user.userId}" class="btn-icon" title="Edit">
                        <i class="fas fa-edit"></i>
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/user/delete/${user.userId}" class="btn-icon btn-danger" 
                       onclick="return confirm('Are you sure?')" title="Delete">
                        <i class="fas fa-trash"></i>
                    </a>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>

<jsp:include page="../layout/admin-footer.jsp"/>
