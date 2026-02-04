<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle != null ? pageTitle : 'Author Dashboard'} - BlogMS</title>
    <link rel="stylesheet"
      href="${pageContext.request.contextPath}/resources/css/author-common.css">
    

    <!-- Font Awesome -->
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        :root {
            --blush-light: #fdf0f0;
            --blush-medium: #f8e8ea;
            --blush-dark: #f5e6e8;
            --cream: #fefdfb;
            --white: #ffffff;

            --text-dark: #3d3d3d;
            --text-medium: #5a5a5a;
            --text-light: #8a8a8a;

            --accent-primary: #d4a5a5;
            --accent-hover: #c89090;

            --shadow-sm: 0 4px 12px rgba(0,0,0,0.06);
            --shadow-md: 0 12px 24px rgba(212,165,165,0.25);
        }

        body.author-layout {
            margin: 0;
            font-family: 'Montserrat', sans-serif;
            background: var(--cream);
            color: var(--text-dark);
        }

        /* ===== LAYOUT ===== */
        .author-wrapper {
            display: flex;
            min-height: 100vh;
        }

        /* ===== SIDEBAR ===== */
        .author-sidebar {
            width: 260px;
            background: linear-gradient(
                180deg,
                var(--blush-light),
                var(--blush-dark)
            );
            box-shadow: var(--shadow-md);
            padding: 25px 0;
        }

        .sidebar-header {
            text-align: center;
            padding: 10px 20px 25px;
            border-bottom: 1px solid rgba(0,0,0,0.05);
        }

        .sidebar-header h2 {
            font-size: 1.6rem;
            color: var(--accent-primary);
            font-family: 'Playfair Display', serif;
        }

        .sidebar-nav {
            display: flex;
            flex-direction: column;
            padding: 15px;
        }

        .sidebar-nav .nav-item {
            padding: 12px 18px;
            margin-bottom: 8px;
            border-radius: 12px;
            text-decoration: none;
            color: var(--text-medium);
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .sidebar-nav .nav-item i {
            margin-right: 10px;
            color: var(--accent-primary);
        }

        .sidebar-nav .nav-item:hover {
            background: var(--white);
            color: var(--accent-primary);
            transform: translateX(6px);
            box-shadow: var(--shadow-sm);
        }

        .sidebar-nav hr {
            border: none;
            height: 1px;
            background: rgba(0,0,0,0.08);
            margin: 15px 0;
        }

        /* ===== MAIN ===== */
        .author-main {
            flex: 1;
            display: flex;
            flex-direction: column;
        }

        /* ===== HEADER ===== */
        .author-header {
            background: var(--white);
            padding: 14px 24px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: var(--shadow-sm);
        }

        .sidebar-toggle {
            background: none;
            border: none;
            font-size: 1.2rem;
            cursor: pointer;
            color: var(--accent-primary);
        }

        .user-info {
            font-weight: 600;
            color: var(--text-medium);
        }

        .user-info i {
            margin-right: 6px;
            color: var(--accent-primary);
        }

        /* ===== CONTENT ===== */
        .author-content {
            padding: 30px;
        }

        /* ===== ALERTS ===== */
        .alert {
            padding: 14px 20px;
            border-radius: 12px;
            margin-bottom: 20px;
            font-size: 0.95rem;
            box-shadow: var(--shadow-sm);
        }

        .alert-success {
            background: #eef7ee;
            color: #3c763d;
            border-left: 4px solid #a8c9a8;
        }

        .alert-error {
            background: #fdecec;
            color: #a94442;
            border-left: 4px solid #e6a4a4;
        }

        /* ===== RESPONSIVE ===== */
        @media (max-width: 900px) {
            .author-sidebar {
                width: 220px;
            }
        }

        @media (max-width: 768px) {
            .author-wrapper {
                flex-direction: column;
            }

            .author-sidebar {
                width: 100%;
            }
        }
    </style>
</head>

<body class="author-layout">

<div class="author-wrapper">

    <!-- ===== SIDEBAR ===== -->
    <aside class="author-sidebar">
        <div class="sidebar-header">
            <h2><i class="fas fa-pen"></i> Author Panel</h2>
        </div>

        <nav class="sidebar-nav">
            <a href="${pageContext.request.contextPath}/author/dashboard" class="nav-item">
                <i class="fas fa-gauge"></i> Dashboard
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

    <!-- ===== MAIN ===== -->
    <div class="author-main">

        <header class="author-header">
            <button class="sidebar-toggle">
                <i class="fas fa-bars"></i>
            </button>

            <span class="user-info">
                <i class="fas fa-user-circle"></i>
                ${sessionScope.loggedInUser.username}
            </span>
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

            <!-- AUTHOR PAGE CONTENT GOES HERE -->

        </main>
    </div>
</div>

</body>
</html>
