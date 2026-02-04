<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="pageTitle" value="My Comments" scope="request"/>
<jsp:include page="../layout/header.jsp"/>

<section class="comments-management">
    <div class="container">
        <h1>My Comments</h1>
        
        <div class="comments-list">
            <c:forEach items="${comments}" var="comment">
                <div class="comment-card">
                    <div class="comment-header">
                        <span class="comment-post">
                            On: <a href="${pageContext.request.contextPath}/post/${comment.post.slug}">
                                ${comment.post.title}
                            </a>
                        </span>
                        <span class="comment-date">
                            <fmt:formatDate value="${comment.createdAt}" pattern="MMM dd, yyyy"/>
                        </span>
                    </div>
                    
                    <p class="comment-text">${comment.commentText}</p>
                    
                    <div class="comment-status">
                        <span class="status-badge status-${comment.status}">${comment.status}</span>
                    </div>
                </div>
            </c:forEach>
            
            <c:if test="${empty comments}">
                <div class="no-comments">
                    <i class="fas fa-comment"></i>
                    <h3>No comments yet</h3>
                    <p>Start engaging with posts!</p>
                </div>
            </c:if>
        </div>
    </div>
</section>

<jsp:include page="../layout/footer.jsp"/>
