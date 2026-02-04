<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle}</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">

    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Dancing+Script:wght@400;700&family=Playfair+Display:wght@400;600;700&family=Montserrat:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <!-- Main CSS -->
    <link href="${pageContext.request.contextPath}/resources/css/style.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/home-style.css" rel="stylesheet">

    <style>
        :root {
            --blush-light: #fdf0f0;
            --blush-medium: #f8e8ea;
            --blush-dark: #f5e6e8;
            --cream: #fefdfb;
            --white: #ffffff;

            --text-dark: #3d3d3d;
            --text-medium: #5a5a5a;

            --accent-primary: #d4a5a5;
            --accent-hover: #c89090;
        }

        body {
            font-family: 'Montserrat', sans-serif;
            background: var(--cream);
        }

        /* ===== NAVBAR ===== */
        .navbar {
            background: linear-gradient(
                135deg,
                var(--white) 0%,
                var(--blush-light) 100%
            ) !important;
            box-shadow: 0 2px 12px rgba(0,0,0,0.08);
        }

        .navbar-brand span {
            font-family: 'Dancing Script', cursive;
            font-size: 2.2rem;
            font-weight: 700;
            color: var(--accent-primary);
            letter-spacing: 2px;
        }

        .nav-link {
            color: var(--text-medium) !important;
            font-weight: 500;
            margin-left: 10px;
            position: relative;
            transition: all 0.3s ease;
        }

        .nav-link::after {
            content: '';
            position: absolute;
            left: 0;
            bottom: -4px;
            width: 0;
            height: 2px;
            background: var(--accent-primary);
            transition: width 0.3s ease;
        }

        .nav-link:hover {
            color: var(--accent-primary) !important;
        }

        .nav-link:hover::after {
            width: 100%;
        }

        /* ===== REGISTER BUTTON ===== */
        .btn-register {
            background: var(--accent-primary);
            color: var(--white) !important;
            padding: 6px 18px;
            border-radius: 30px;
            font-weight: 600;
            margin-left: 10px;
            transition: all 0.3s ease;
        }

        .btn-register:hover {
            background: var(--accent-hover);
            transform: translateY(-2px);
        }

        /* ===== DROPDOWN ===== */
        .dropdown-menu {
            border-radius: 12px;
            border: none;
            box-shadow: 0 8px 20px rgba(0,0,0,0.12);
        }

        .dropdown-item {
            font-size: 0.95rem;
            transition: background 0.3s ease;
        }

        .dropdown-item:hover {
            background: var(--blush-light);
            color: var(--accent-primary);
        }

        /* ===== LOGOUT LINK ===== */
        .nav-link.text-danger {
            color: #e57373 !important;
            font-weight: 600;
        }

        /* ===== ADMIN REGISTER ===== */
        .nav-item a[href*="admin-register"] {
            color: var(--accent-primary);
            font-weight: 500;
            margin-left: 10px;
            font-size: 0.9rem;
        }

        @media (max-width: 768px) {
            .nav-link {
                margin-left: 0;
            }
            .btn-register {
                margin-top: 8px;
                display: inline-block;
            }
        }
    </style>
</head>

<body>

<nav class="navbar navbar-expand-lg sticky-top">
    <div class="container">

        <a class="navbar-brand" href="${pageContext.request.contextPath}/">
            <span>Write.as</span>
        </a>

        <button class="navbar-toggler" type="button"
                data-bs-toggle="collapse"
                data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto align-items-lg-center">

                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/">Home</a>
                </li>

                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/posts">Posts</a>
                </li>

                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/categories">Categories</a>
                </li>

                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/about">About</a>
                </li>

                <c:if test="${not empty sessionScope.loggedInUser}">
                    <li class="nav-item">
                        <a class="nav-link text-danger"
                           href="${pageContext.request.contextPath}/auth/logout">
                            Logout
                        </a>
                    </li>
                </c:if>

                <!-- Login / Register -->
                <li class="nav-item"
                    style="display: ${empty sessionScope.loggedInUser ? 'block' : 'none'};">
                    <a class="nav-link" href="${pageContext.request.contextPath}/auth/login">Login</a>
                </li>

                <li class="nav-item"
                    style="display: ${empty sessionScope.loggedInUser ? 'block' : 'none'};">
                    <a class="nav-link btn-register"
                       href="${pageContext.request.contextPath}/auth/register">
                        Register
                    </a>
                </li>

                <li class="nav-item"
                    style="display: ${empty sessionScope.loggedInUser ? 'block' : 'none'};">
                    <a class="nav-link"
                       href="${pageContext.request.contextPath}/auth/admin-register">
                        Admin Register
                    </a>
                </li>

                <!-- Logged-in Dropdown -->
                <li class="nav-item dropdown"
                    style="display: ${empty sessionScope.loggedInUser ? 'none' : 'block'};">
                    <a class="nav-link dropdown-toggle"
                       href="#"
                       id="userDropdown"
                       role="button"
                       data-bs-toggle="dropdown">
                        ${sessionScope.loggedInUser.username}
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end">
                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/user/profile">Profile</a></li>
                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/user/posts">My Posts</a></li>
                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin">Dashboard</a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li>
                            <a class="dropdown-item"
                               href="${pageContext.request.contextPath}/auth/logout">
                                Logout
                            </a>
                        </li>
                    </ul>
                </li>

            </ul>
        </div>
    </div>
</nav>
