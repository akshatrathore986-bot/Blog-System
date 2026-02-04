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

    <!-- Main CSS -->
    <link href="${pageContext.request.contextPath}/resources/css/style.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/home-style.css" rel="stylesheet">
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-light bg-light sticky-top">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/">
            <span style="font-size: 1.8rem; font-weight: 300; font-family: Georgia; letter-spacing: 2px;">Willow</span>
        </a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">

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
                

                <!-- Login/Register block (no c:if, just two versions hidden via style) -->
                <li class="nav-item"
                    style="display: ${empty sessionScope.loggedInUser ? 'block' : 'none'};">
                    <a class="nav-link" href="${pageContext.request.contextPath}/auth/login">Login</a>
                </li>
                <li class="nav-item"
                    style="display: ${empty sessionScope.loggedInUser ? 'block' : 'none'};">
                    <a class="nav-link btn-register" href="${pageContext.request.contextPath}/auth/register">
                        Register
                    </a>
                   
                </li>
                 <li class="nav-item"
                    style="display: ${empty sessionScope.loggedInUser ? 'block' : 'none'};">
                    <a href="${pageContext.request.contextPath}/auth/admin-register">Admin Register</a>
                    
                   
                </li>

                <!-- Logged-in dropdown -->
                <!-- Logged-in dropdown -->
<li class="nav-item dropdown"
    style="display: ${empty sessionScope.loggedInUser ? 'none' : 'block'};">
    <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button"
       data-bs-toggle="dropdown">
        ${sessionScope.loggedInUser.username}
    </a>
    <ul class="dropdown-menu" aria-labelledby="userDropdown">
        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/user/profile">Profile</a></li>
        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/user/posts">My Posts</a></li>
        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin">Dashboard</a></li>
        <li><hr class="dropdown-divider"></li>
        <!-- YE ADD KARO -->
        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/auth/logout">Logout</a></li>
    </ul>
</li>

                

            </ul>
        </div>
    </div>
</nav>
