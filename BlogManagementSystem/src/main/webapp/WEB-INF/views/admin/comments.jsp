<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="pageTitle" value="Manage Comments" scope="request"/>
<jsp:include page="../layout/admin-header.jsp"/>

<div class="dashboard-header">
    <h1>Pending Comments</h1>
</div>

<table class="data-table">
    <thead>
        <tr>
            <th>Post</th>
            <th>Commenter</th>
            <th>Comment</th>
            <th>Date</th>
            <th>Actions</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach items="${comments}" var="comment">
            <tr>
                <td>
                    <a href="${pageContext.request.contextPath}/post/${comment.post.slug}" target="_blank">
                        ${comment.post.title}
                    </a>
                </td>
                <td>${comment.commenterName}</td>
                <td class="comment-text">${comment.commentText}</td>
                <td>
                    <fmt:formatDate value="${comment.createdAt}" pattern="MMM dd, yyyy"/>
                </td>
                <td class="actions">
                    <a href="${pageContext.request.contextPath}/admin/comment/approve/${comment.commentId}" class="btn-sm btn-success">
                        <i class="fas fa-check"></i> Approve
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/comment/reject/${comment.commentId}" class="btn-sm btn-warning">
                        <i class="fas fa-times"></i> Reject
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/comment/delete/${comment.commentId}" class="btn-sm btn-danger" 
                       onclick="return confirm('Are you sure?')">
                        <i class="fas fa-trash"></i> Delete
                    </a>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>

<c:if test="${empty comments}">
    <div class="empty-state">
        <i class="fas fa-comments"></i>
        <h3>No pending comments</h3>
    </div>
</c:if>

<jsp:include page="../layout/admin-footer.jsp"/>
