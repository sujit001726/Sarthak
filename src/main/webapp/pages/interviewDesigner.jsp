<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sarthak | Interview Designer</title>
    <link rel="stylesheet" href="css/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <jsp:include page="includes/sidebar.jsp">
        <jsp:param name="action" value="interviewDesigner" />
    </jsp:include>

    <main class="main-wrapper">
        <header class="top-nav">
            <div class="welcome-msg">
                <h1>Interview Designer</h1>
                <p>Structure your interview process</p>
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
                    <h3>Interview Designer Management</h3>
                    <a href="admin?action=addInterviewTemplate" class="btn-sm btn-primary" style="text-decoration: none;">Create New +</a>
                </div>
                
                <div class="table-responsive">
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>Template Name</th>
                                <th>Stages</th>
                                <th>Created Date</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="item" items="${interviewTemplates}">
                                <tr>
                                    <td><div style="font-weight: 600;">${item.name}</div></td>
                                    <td>${item.stages}</td>
                                    <td>${item.date}</td>
                                    <td>
                                        <button class="btn-sm btn-outline"><i class="fas fa-trash"></i></button>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty interviewTemplates}">
                                <tr>
                                    <td colspan="4" style="text-align: center; padding: 4rem; color: var(--text-dim);">
                                        No interview templates found. Click "Create New" to add one.
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
