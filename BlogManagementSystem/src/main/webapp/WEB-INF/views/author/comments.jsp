<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="pageTitle" value="Comments" scope="request"/>
<jsp:include page="../layout/author-header.jsp"/>

<div class="dashboard-header">
    <h1>Comments on My Posts</h1>
</div>

<table class="data-table">
    <thead>
        <tr>
            <th>Post</th>
            <th>Commenter</th>
            <th>Comment</th>
            <th>Status</th>
            <th>Date</th>
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
                <td><span class="status-badge status-${comment.status}">${comment.status}</span></td>
                <td>
                    <fmt:formatDate value="${comment.createdAt}" pattern="MMM dd, yyyy"/>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>

<c:if test="${empty comments}">
    <div class="empty-state">
        <i class="fas fa-comments"></i>
        <h3>No comments yet</h3>
    </div>
</c:if>

<jsp:include page="../layout/author-footer.jsp"/>
