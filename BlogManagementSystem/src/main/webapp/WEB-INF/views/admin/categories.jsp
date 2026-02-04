<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="pageTitle" value="Manage Categories" scope="request"/>
<jsp:include page="../layout/admin-header.jsp"/>

<div class="dashboard-header">
    <h1>Manage Categories</h1>
    <a href="${pageContext.request.contextPath}/admin/category/create" class="btn btn-primary">
        <i class="fas fa-plus"></i> Add Category
    </a>
</div>

<table class="data-table">
    <thead>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Slug</th>
            <th>Post Count</th>
            <th>Actions</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach items="${categories}" var="category">
            <tr>
                <td>${category.categoryId}</td>
                <td>${category.categoryName}</td>
                <td>${category.slug}</td>
                <td>${category.postCount}</td>
                <td class="actions">
                    <a href="${pageContext.request.contextPath}/admin/category/edit/${category.categoryId}" class="btn-icon">
                        <i class="fas fa-edit"></i>
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/category/delete/${category.categoryId}" class="btn-icon btn-danger" 
                       onclick="return confirm('Are you sure?')">
                        <i class="fas fa-trash"></i>
                    </a>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>

<jsp:include page="../layout/admin-footer.jsp"/>
