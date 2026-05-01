<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sarthak | Job Board</title>
    <link rel="stylesheet" href="css/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <jsp:include page="includes/sidebar.jsp">
        <jsp:param name="action" value="jobBoard" />
    </jsp:include>

    <main class="main-wrapper">
        <header class="top-nav">
            <div class="welcome-msg">
                <h1>Job Board</h1>
                <p>Monitor all incoming job applications</p>
            </div>
            <div class="top-actions">
                <div class="user-profile">
                    <img src="https://ui-avatars.com/api/?name=Admin&background=4f46e5&color=fff" alt="User">
                    <div class="user-info">
                        <span class="name">Admin</span>
                    </div>
                </div>
            </div>
        </header>

        <div class="content-area">
            <div class="content-card animate-fade">
                <div class="card-header">
                    <h3>Recent Applications</h3>
                    <div style="display: flex; gap: 10px;">
                        <button class="btn-sm btn-outline">Export CSV</button>
                    </div>
                </div>
                
                <div class="table-responsive">
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>Candidate</th>
                                <th>Job Applied</th>
                                <th>Date</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="app" items="${applications}">
                                <tr>
                                    <td><div style="font-weight: 600;">${app.candidate}</div></td>
                                    <td><span style="color: var(--primary);">${app.job}</span></td>
                                    <td>${app.date}</td>
                                    <td>
                                        <span class="status-badge" style="background: #fef3c7; color: var(--warning);">
                                            ${app.status}
                                        </span>
                                    </td>
                                    <td>
                                        <button class="btn-sm btn-primary">Review</button>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty applications}">
                                <tr>
                                    <td colspan="5" style="text-align: center; padding: 4rem; color: var(--text-dim);">
                                        No applications found.
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
