<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="pageTitle" value="Authors" scope="request"/>
<jsp:include page="../layout/header.jsp"/>

<section class="page-header">
    <div class="container">
        <h1><i class="fas fa-users"></i> Our Authors</h1>
        <p>Meet the talented writers behind our content</p>
    </div>
</section>

<section class="authors-page">
    <div class="container">
        <div class="authors-grid">
            <c:forEach items="${authors}" var="author">
                <a href="${pageContext.request.contextPath}/author/${author.authorId}" class="author-card">
                    <c:if test="${not empty author.profileImage}">
                        <img src="${pageContext.request.contextPath}/uploads/profiles/${author.profileImage}" alt="${author.displayName}" class="author-avatar">
                    </c:if>
                    
                    <h3>${author.displayName}</h3>
                    <p class="author-bio">${author.bio}</p>
                    
                    <div class="author-stats">
                        <span><i class="fas fa-users"></i> ${author.followersCount}</span>
                    </div>
                </a>
            </c:forEach>
        </div>
        
        <c:if test="${empty authors}">
            <div class="no-authors">
                <i class="fas fa-user"></i>
                <h3>No authors found</h3>
            </div>
        </c:if>
    </div>
</section>

<jsp:include page="../layout/footer.jsp"/>
