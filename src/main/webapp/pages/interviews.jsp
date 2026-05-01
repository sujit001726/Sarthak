<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sarthak | Interview Management</title>
    <link rel="stylesheet" href="css/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <jsp:include page="includes/sidebar.jsp">
        <jsp:param name="action" value="interviews" />
    </jsp:include>

    <main class="main-wrapper">
        <header class="top-nav">
            <div class="welcome-msg">
                <h1>Interviews Dashboard</h1>
                <p>Track and manage candidate interviews</p>
            </div>
            <div class="top-actions">
                <div class="search-box">
                    <i class="fas fa-search"></i>
                    <input type="text" placeholder="Search by candidate...">
                </div>
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
                    <div>
                        <h3>Upcoming Interviews</h3>
                        <p style="font-size: 0.8rem; color: var(--text-dim);">Scheduling for the current week</p>
                    </div>
                    <button class="btn-sm btn-primary">Schedule New +</button>
                </div>
                
                <div class="table-responsive">
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>Candidate</th>
                                <th>Date & Time</th>
                                <th>Interviewer</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="interview" items="${interviews}">
                                <tr>
                                    <td>
                                        <div style="font-weight: 600;">${interview.candidate}</div>
                                    </td>
                                    <td>
                                        <div style="font-size: 0.85rem; color: var(--text-main);"><i class="far fa-calendar-alt"></i> ${interview.time}</div>
                                    </td>
                                    <td>
                                        <div style="display: flex; align-items: center; gap: 8px;">
                                            <img src="https://ui-avatars.com/api/?name=${interview.interviewer}&background=f1f5f9" style="width: 24px; height: 24px; border-radius: 50%;">
                                            <span>${interview.interviewer}</span>
                                        </div>
                                    </td>
                                    <td>
                                        <span class="status-badge" style="background: #eff6ff; color: var(--info);">
                                            ${interview.status}
                                        </span>
                                    </td>
                                    <td>
                                        <div style="display: flex; gap: 8px;">
                                            <button class="btn-sm btn-outline" style="color: var(--success)"><i class="fas fa-video"></i> Start</button>
                                            <button class="btn-sm btn-outline"><i class="fas fa-edit"></i></button>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty interviews}">
                                <tr>
                                    <td colspan="5">
                                        <div style="padding: 4rem; text-align: center; color: var(--text-dim);">
                                            <i class="fas fa-calendar-times" style="font-size: 3rem; margin-bottom: 1rem; opacity: 0.2;"></i>
                                            <p>No interviews scheduled for today.</p>
                                        </div>
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
