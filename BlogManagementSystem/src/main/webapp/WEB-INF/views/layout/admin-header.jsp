<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle != null ? pageTitle : 'Admin Dashboard'} - BlogMS</title>
    
    <!-- CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="admin-layout">
    <div class="admin-wrapper">
        <!-- Sidebar -->
        <aside class="admin-sidebar">
            <div class="sidebar-header">
                <h2><i class="fas fa-blog"></i> BlogMS Admin</h2>
            </div>
            
            <nav class="sidebar-nav">
                <a href="${pageContext.request.contextPath}/admin/dashboard" class="nav-item">
                    <i class="fas fa-dashboard"></i> Dashboard
                </a>
                <a href="${pageContext.request.contextPath}/admin/posts" class="nav-item">
                    <i class="fas fa-file-alt"></i> Posts
                </a>
                <a href="${pageContext.request.contextPath}/admin/categories" class="nav-item">
                    <i class="fas fa-folder"></i> Categories
                </a>
                <a href="${pageContext.request.contextPath}/admin/tags" class="nav-item">
                    <i class="fas fa-tags"></i> Tags
                </a>
                <a href="${pageContext.request.contextPath}/admin/comments" class="nav-item">
                    <i class="fas fa-comments"></i> Comments
                </a>
                <a href="${pageContext.request.contextPath}/admin/users" class="nav-item">
                    <i class="fas fa-users"></i> Users
                </a>
                <a href="${pageContext.request.contextPath}/media/library" class="nav-item">
                    <i class="fas fa-images"></i> Media Library
                </a>
                <hr>
                <a href="${pageContext.request.contextPath}/" class="nav-item">
                    <i class="fas fa-home"></i> View Site
                </a>
                <a href="${pageContext.request.contextPath}/auth/logout" class="nav-item">
                    <i class="fas fa-sign-out-alt"></i> Logout
                </a>
            </nav>
        </aside>
        
        <!-- Main Content -->
        <div class="admin-main">
            <header class="admin-header">
                <button class="sidebar-toggle">
                    <i class="fas fa-bars"></i>
                </button>
                <div class="header-right">
                    <span class="user-info">
                        <i class="fas fa-user-circle"></i> ${sessionScope.loggedInUser.username}
                    </span>
                </div>
            </header>
            
            <main class="admin-content">
                <c:if test="${not empty success}">
                    <div class="alert alert-success">
                        <i class="fas fa-check-circle"></i> ${success}
                    </div>
                </c:if>
                
                <c:if test="${not empty error}">
                    <div class="alert alert-error">
                        <i class="fas fa-exclamation-circle"></i> ${error}
                    </div>
                </c:if>
