<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="pageTitle" value="Manage Tags" scope="request"/>
<jsp:include page="../layout/admin-header.jsp"/>

<div class="dashboard-header">
    <h1>Manage Tags</h1>
</div>

<form action="${pageContext.request.contextPath}/admin/tags/create" method="post" class="inline-form">
    <div>
        <label>Tag Name</label>
        <input type="text" name="tagName" placeholder="New tag name" required>
    </div>

    <div>
        <label>Post</label>
        <select name="postId" required>
            <c:forEach items="${posts}" var="p">
                <option value="${p.postId}">${p.title}</option>
            </c:forEach>
        </select>
    </div>

    <button type="submit" class="btn btn-primary">
        <i class="fas fa-plus"></i> Save Tag
    </button>
</form>

<table class="data-table">
    <thead>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Slug</th>
            <th>Actions</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach items="${tags}" var="tag">
            <tr>
                <td>${tag.tagId}</td>
                <td>${tag.tagName}</td>
                <td>${tag.slug}</td>
                <td class="actions">
                    <a href="${pageContext.request.contextPath}/admin/tag/delete/${tag.tagId}" class="btn-icon btn-danger"
                       onclick="return confirm('Are you sure?')">
                        <i class="fas fa-trash"></i>
                    </a>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>

<jsp:include page="../layout/admin-footer.jsp"/>
