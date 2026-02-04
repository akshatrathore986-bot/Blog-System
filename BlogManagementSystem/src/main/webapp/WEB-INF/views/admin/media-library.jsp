<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="pageTitle" value="Media Library" scope="request"/>
<jsp:include page="../layout/admin-header.jsp"/>

<div class="dashboard-header">
    <h1>Media Library</h1>
</div>

<form action="${pageContext.request.contextPath}/media/upload" method="post" enctype="multipart/form-data" class="upload-form">
    <div class="form-row">
        <div class="form-group">
            <input type="file" name="file" required>
        </div>
        <div class="form-group">
            <input type="text" name="altText" placeholder="Alt text (optional)">
        </div>
        <button type="submit" class="btn btn-primary">
            <i class="fas fa-upload"></i> Upload
        </button>
    </div>
</form>

<div class="media-grid">
    <c:forEach items="${mediaList}" var="media">
        <div class="media-item">
            <img src="${pageContext.request.contextPath}/${media.filePath}" alt="${media.altText}">
            <div class="media-info">
                <p>${media.filename}</p>
                <small>${media.fileSize} bytes</small>
                <a href="${pageContext.request.contextPath}/media/delete/${media.mediaId}" class="btn-icon btn-danger" 
                   onclick="return confirm('Delete this file?')">
                    <i class="fas fa-trash"></i>
                </a>
            </div>
        </div>
    </c:forEach>
</div>

<jsp:include page="../layout/admin-footer.jsp"/>
