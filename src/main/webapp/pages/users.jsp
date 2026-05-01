<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sarthak | Team Management</title>
    <link rel="stylesheet" href="css/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <jsp:include page="includes/sidebar.jsp">
        <jsp:param name="action" value="users" />
    </jsp:include>

    <main class="main-wrapper">
        <header class="top-nav">
            <div class="welcome-msg">
                <h1>Team Management</h1>
                <p>Manage administrative users and recruiters</p>
            </div>
            <div class="top-actions">
                <div class="search-box">
                    <i class="fas fa-search"></i>
                    <input type="text" placeholder="Search team members...">
                </div>
            </div>
        </header>

        <div class="content-area">
            <div class="content-card animate-fade">
                <div class="card-header">
                    <h3>Active Team Members</h3>
                    <button class="btn-sm btn-primary">Invite Member +</button>
                </div>
                <div class="table-responsive">
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>Name</th>
                                <th>Email</th>
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
                                            <img src="https://ui-avatars.com/api/?name=${user.name}&background=random" style="width: 32px; height: 32px; border-radius: 8px;">
                                            <span style="font-weight: 600;">${user.name}</span>
                                        </div>
                                    </td>
                                    <td>${user.email}</td>
                                    <td>
                                        <span class="status-badge" style="background: var(--primary-light); color: var(--primary);">
                                            <c:choose>
                                                <c:when test="${user.name == 'Sujit Shah' && user.type == 'admin'}">Admin</c:when>
                                                <c:otherwise>${user.type}</c:otherwise>
                                            </c:choose>
                                        </span>
                                    </td>

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
                                                        <i class="fas fa-user-slash"></i>
                                                    </button>
                                                </c:when>
                                                <c:otherwise>
                                                    <button name="status" value="active" class="btn-sm btn-outline" style="color: var(--success)" title="Activate">
                                                        <i class="fas fa-user-check"></i>
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
                                        No team members found.
                                    </td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </main>
</body>
</html>

