<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sarthak | User Management</title>
    <link rel="stylesheet" href="css/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <aside class="sidebar">
        <div class="logo-container">
            <div class="logo-icon">S</div>
            <span class="logo-text">Sarthak</span>
        </div>

        <nav class="sidebar-nav">
            <div class="nav-section">
                <ul class="nav-list">
                    <li class="nav-item"><a href="admin?action=dashboard" class="nav-link"><i class="fas fa-th-large"></i> Dashboard</a></li>
                    <li class="nav-item"><a href="admin?action=interviews" class="nav-link"><i class="fas fa-video"></i> Interviews</a></li>
                </ul>
            </div>

            <div class="nav-section">
                <h4 class="nav-title">Organizations</h4>
                <ul class="nav-list">
                    <li class="nav-item"><a href="admin?action=jobBoard" class="nav-link"><i class="fas fa-clipboard-list"></i> Job Board</a></li>
                    <li class="nav-item"><a href="admin?action=jobs" class="nav-link"><i class="fas fa-briefcase"></i> Jobs</a></li>
                </ul>
            </div>

            <div class="nav-section">
                <h4 class="nav-title">Users Management</h4>
                <ul class="nav-list">
                    <li class="nav-item active"><a href="admin?action=users" class="nav-link"><i class="fas fa-users"></i> Team</a></li>
                    <li class="nav-item"><a href="admin?action=candidates" class="nav-link"><i class="fas fa-user-graduate"></i> Candidates</a></li>
                </ul>
            </div>
        </nav>

        <div class="nav-section" style="margin-top: auto;">
             <ul class="nav-list">
                <li class="nav-item"><a href="login.jsp" class="nav-link"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
            </ul>
        </div>
    </aside>

    <main class="main-wrapper">
        <header class="top-nav">
            <div class="welcome-msg">
                <h1>User Management</h1>
                <p>Manage all users and their permissions</p>
            </div>
            <div class="top-actions">
                <div class="search-box">
                    <i class="fas fa-search"></i>
                    <input type="text" placeholder="Search users...">
                </div>
            </div>
        </header>

        <div class="content-area">
            <div class="content-card animate-fade">
                <div class="card-header">
                    <h3>All Registered Users</h3>
                    <button class="btn-sm btn-primary">Add New User +</button>
                </div>
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>User Name</th>
                            <th>Email Address</th>
                            <th>Role</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="user" items="${users}">
                            <tr>
                                <td>
                                    <div style="display: flex; align-items: center; gap: 10px;">
                                        <img src="https://ui-avatars.com/api/?name=${user.name}&background=random" style="width: 32px; height: 32px; border-radius: 50%;">
                                        <span style="font-weight: 600;">${user.name}</span>
                                    </div>
                                </td>
                                <td>${user.email}</td>
                                <td><span class="status-badge" style="background: #f1f5f9; color: var(--text-dim);">${user.type}</span></td>
                                <td>
                                    <span class="status-badge" style="background: ${user.status == 'active' ? '#f0fdf4' : '#fef2f2'}; color: ${user.status == 'active' ? 'var(--success)' : 'var(--danger)'};">
                                        ${user.status}
                                    </span>
                                </td>
                                <td>
                                    <form action="admin" method="POST" style="display: inline;">
                                        <input type="hidden" name="action" value="updateUserStatus">
                                        <input type="hidden" name="userId" value="${user.id}">
                                        <c:choose>
                                            <c:when test="${user.status == 'active'}">
                                                <button name="status" value="suspended" class="btn-sm btn-outline" style="color: var(--danger)" title="Suspend">
                                                    <i class="fas fa-user-slash"></i> Suspend
                                                </button>
                                            </c:when>
                                            <c:otherwise>
                                                <button name="status" value="active" class="btn-sm btn-outline" style="color: var(--success)" title="Activate">
                                                    <i class="fas fa-user-check"></i> Activate
                                                </button>
                                            </c:otherwise>
                                        </c:choose>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty users}">
                            <tr>
                                <td colspan="5" style="text-align: center; padding: 3rem; color: var(--text-dim);">
                                    No users found in database.
                                </td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </main>
</body>
</html>

