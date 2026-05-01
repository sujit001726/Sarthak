<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sarthak | Job Moderation</title>
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
                    <li class="nav-item active"><a href="admin?action=jobs" class="nav-link"><i class="fas fa-briefcase"></i> Jobs</a></li>
                </ul>
            </div>

            <div class="nav-section">
                <h4 class="nav-title">Users Management</h4>
                <ul class="nav-list">
                    <li class="nav-item"><a href="admin?action=users" class="nav-link"><i class="fas fa-users"></i> Team</a></li>
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
                <h1>Job Moderation</h1>
                <p>Approve or reject job postings on the platform</p>
            </div>
            <div class="top-actions">
                <div class="search-box">
                    <i class="fas fa-search"></i>
                    <input type="text" placeholder="Search jobs...">
                </div>
            </div>
        </header>

        <div class="content-area">
            <div class="content-card animate-fade">
                <div class="card-header">
                    <h3>Recent Job Postings</h3>
                    <button class="btn-sm btn-primary">Bulk Actions</button>
                </div>
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>Job Title</th>
                            <th>Company</th>
                            <th>Salary Range</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="job" items="${jobs}">
                            <tr>
                                <td><span style="font-weight: 600; color: var(--primary);">${job.title}</span></td>
                                <td>${job.company}</td>
                                <td>${job.salary}</td>
                                <td>
                                    <span class="status-badge" style="background: ${job.status == 'approved' ? '#f0fdf4' : (job.status == 'pending' ? '#fff7ed' : '#fef2f2')}; color: ${job.status == 'approved' ? 'var(--success)' : (job.status == 'pending' ? 'var(--warning)' : 'var(--danger)')};">
                                        ${job.status}
                                    </span>
                                </td>
                                <td>
                                    <form action="admin" method="POST" style="display: inline-flex; gap: 5px;">
                                        <input type="hidden" name="action" value="updateJobStatus">
                                        <input type="hidden" name="jobId" value="${job.id}">
                                        
                                        <c:if test="${job.status != 'approved'}">
                                            <button name="status" value="approved" class="btn-sm btn-outline" style="color: var(--success)" title="Approve">
                                                <i class="fas fa-check"></i>
                                            </button>
                                        </c:if>
                                        <c:if test="${job.status != 'rejected'}">
                                            <button name="status" value="rejected" class="btn-sm btn-outline" style="color: var(--danger)" title="Reject">
                                                <i class="fas fa-times"></i>
                                            </button>
                                        </c:if>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty jobs}">
                            <tr>
                                <td colspan="5" style="text-align: center; padding: 3rem; color: var(--text-dim);">
                                    No job postings found.
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

