<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="pageTitle" value="Manage Posts" scope="request"/>
<jsp:include page="../layout/admin-header.jsp"/>

<div class="dashboard-header">
    <h1>Manage Posts</h1>
</div>

<table class="data-table">
    <thead>
        <tr>
            <th>ID</th>
            <th>Title</th>
            <th>Author</th>
            <th>Category</th>
            <th>Status</th>
            <th>Views</th>
            <th>Published</th>
            <th>Actions</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach items="${posts}" var="post">
            <tr>
                <td>${post.postId}</td>
                <td>
                    <a href="${pageContext.request.contextPath}/post/${post.slug}" target="_blank">
                        ${post.title}
                    </a>
                </td>
                <td>${post.author.displayName}</td>
                <td>${post.category.categoryName}</td>
                <td><span class="status-badge status-${post.status}">${post.status}</span></td>
                <td>${post.viewCount}</td>
                <td>
                    <c:if test="${not empty post.publishedDate}">
                        <fmt:formatDate value="${post.publishedDate}" pattern="MMM dd, yyyy"/>
                    </c:if>
                    <c:if test="${empty post.publishedDate}">-</c:if>
                </td>
                <td class="actions">
                    <a href="${pageContext.request.contextPath}/admin/post/delete/${post.postId}" class="btn-icon btn-danger" 
                       onclick="return confirm('Are you sure?')" title="Delete">
                        <i class="fas fa-trash"></i>
                    </a>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>

<jsp:include page="../layout/admin-footer.jsp"/>
