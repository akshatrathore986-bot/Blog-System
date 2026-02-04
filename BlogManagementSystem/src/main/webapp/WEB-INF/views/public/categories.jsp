<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="pageTitle" value="Categories" scope="request"/>
<jsp:include page="../layout/header.jsp"/>

<section class="page-header">
    <div class="container">
        <h1><i class="fas fa-folder-open"></i> All Categories</h1>
        <p>Browse posts by category</p>
    </div>
</section>

<section class="categories-page">
    <div class="container">
        <div class="categories-grid">
            <c:forEach items="${categories}" var="category">
                <a href="${pageContext.request.contextPath}/category/${category.slug}" class="category-card-large">
                    <c:if test="${not empty category.imageUrl}">
                        <img src="${pageContext.request.contextPath}${category.imageUrl}" alt="${category.categoryName}">
                    </c:if>
                    <div class="category-content">
                        <h2>${category.categoryName}</h2>
                        <p>${category.description}</p>
                        <span class="post-count">${category.postCount} posts</span>
                    </div>
                </a>
            </c:forEach>
        </div>
        
        <c:if test="${empty categories}">
            <div class="no-categories">
                <i class="fas fa-folder"></i>
                <h3>No categories available</h3>
            </div>
        </c:if>
    </div>
</section>

<jsp:include page="../layout/footer.jsp"/>
