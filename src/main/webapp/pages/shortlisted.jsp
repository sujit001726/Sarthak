<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sarthak | Shortlisted</title>
    <link rel="stylesheet" href="css/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <jsp:include page="includes/sidebar.jsp">
        <jsp:param name="action" value="shortlisted" />
    </jsp:include>

    <main class="main-wrapper">
        <header class="top-nav">
            <div class="welcome-msg">
                <h1>Shortlisted Candidates</h1>
                <p>Review the top picks for your open positions</p>
            </div>
        </header>

        <div class="content-area">
            <div class="content-card animate-fade">
                <div class="card-header">
                    <h3>Shortlisted Roster</h3>
                </div>
                
                <div class="table-responsive">
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>Candidate</th>
                                <th>Email</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="item" items="${shortlisted}">
                                <tr>
                                    <td><div style="font-weight: 600;">${item.name}</div></td>
                                    <td>${item.email}</td>
                                    <td>
                                        <span class="status-badge" style="background: var(--primary-light); color: var(--primary);">
                                            ${item.status}
                                        </span>
                                    </td>
                                    <td>
                                        <button class="btn-sm btn-primary">Proceed to Offer</button>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty shortlisted}">
                                <tr>
                                    <td colspan="4" style="text-align: center; padding: 4rem; color: var(--text-dim);">
                                        No shortlisted candidates yet.
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
