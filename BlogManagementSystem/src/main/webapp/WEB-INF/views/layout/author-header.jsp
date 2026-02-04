<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle != null ? pageTitle : 'Author Dashboard'} - BlogMS</title>
    
    <!-- CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/author.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="author-layout">
    <div class="author-wrapper">
        <!-- Sidebar -->
        <aside class="author-sidebar">
            <div class="sidebar-header">
                <h2><i class="fas fa-pen"></i> Author Panel</h2>
            </div>
            
            <nav class="sidebar-nav">
                <a href="${pageContext.request.contextPath}/author/dashboard" class="nav-item">
                    <i class="fas fa-dashboard"></i> Dashboard
                </a>
                <a href="${pageContext.request.contextPath}/author/posts" class="nav-item">
                    <i class="fas fa-file-alt"></i> My Posts
                </a>
                <a href="${pageContext.request.contextPath}/author/post/create" class="nav-item">
                    <i class="fas fa-plus"></i> Create Post
                </a>
                <a href="${pageContext.request.contextPath}/author/comments" class="nav-item">
                    <i class="fas fa-comments"></i> Comments
                </a>
                <a href="${pageContext.request.contextPath}/author/analytics" class="nav-item">
                    <i class="fas fa-chart-line"></i> Analytics
                </a>
                <a href="${pageContext.request.contextPath}/author/profile" class="nav-item">
                    <i class="fas fa-user"></i> Profile
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
        <div class="author-main">
            <header class="author-header">
                <button class="sidebar-toggle">
                    <i class="fas fa-bars"></i>
                </button>
                <div class="header-right">
                    <span class="user-info">
                        <i class="fas fa-user-circle"></i> ${sessionScope.loggedInUser.username}
                    </span>
                </div>
            </header>
            
            <main class="author-content">
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
