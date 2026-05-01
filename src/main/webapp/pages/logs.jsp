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
    <jsp:include page="includes/sidebar.jsp">
        <jsp:param name="action" value="logs" />
    </jsp:include>

    <main class="main-wrapper">
        <header class="top-nav">
            <div class="welcome-msg">
                <h1>System Logs</h1>
                <p>Audit trail of all administrative actions</p>
            </div>
            <div class="top-actions">
                <button class="btn-sm btn-outline"><i class="fas fa-download"></i> Export Logs</button>
            </div>
        </header>

        <div class="content-area">
            <div class="content-card animate-fade">
                <div class="card-header">
                    <h3>Recent Activity</h3>
                </div>
                <div class="table-responsive">
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>Timestamp</th>
                                <th>Performed By</th>
                                <th>Action Details</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="log" items="${logs}">
                                <tr>
                                    <td style="white-space: nowrap; color: var(--text-dim); font-size: 0.8rem;">
                                        <i class="far fa-clock"></i> ${log.time}
                                    </td>
                                    <td>
                                        <div style="display: flex; align-items: center; gap: 8px;">
                                            <div style="width: 24px; height: 24px; border-radius: 50%; background: var(--primary-light); color: var(--primary); display: flex; align-items: center; justify-content: center; font-size: 0.7rem; font-weight: 700;">
                                                ${log.user.substring(0,1).toUpperCase()}
                                            </div>
                                            <span style="font-weight: 500;">${log.user}</span>
                                        </div>
                                    </td>
                                    <td style="color: var(--text-main); font-weight: 500;">${log.action}</td>
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
        </div>
    </main>
</body>
</html>
