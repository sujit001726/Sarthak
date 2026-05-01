<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sarthak | System Logs</title>
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
                </ul>
            </div>

            <div class="nav-section">
                <h4 class="nav-title">System</h4>
                <ul class="nav-list">
                    <li class="nav-item active"><a href="admin?action=logs" class="nav-link"><i class="fas fa-history"></i> System Logs</a></li>
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
                <h1>System Audit Logs</h1>
                <p>Monitor all administrative actions and system events</p>
            </div>
        </header>

        <div class="content-area">
            <div class="content-card animate-fade">
                <div class="card-header">
                    <h3>Recent Activity Logs</h3>
                    <button class="btn-sm btn-outline">Export Logs</button>
                </div>
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>Action Details</th>
                            <th>Performed By</th>
                            <th>Date & Time</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="log" items="${logs}">
                            <tr>
                                <td>
                                    <div style="display: flex; align-items: center; gap: 10px;">
                                        <div style="width: 8px; height: 8px; background: var(--primary); border-radius: 50%;"></div>
                                        <span>${log.action}</span>
                                    </div>
                                </td>
                                <td><span class="status-badge" style="background: #e0e7ff; color: var(--primary);">${log.user}</span></td>
                                <td style="color: var(--text-dim); font-size: 0.8rem;">${log.time}</td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty logs}">
                            <tr>
                                <td colspan="3" style="text-align: center; padding: 3rem; color: var(--text-dim);">
                                    No activity logs found.
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

