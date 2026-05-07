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
    <jsp:include page="includes/sidebar.jsp">
        <jsp:param name="action" value="jobs" />
    </jsp:include>


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
                    <a href="admin?action=addJob" class="btn-sm btn-primary" style="text-decoration: none;">Add New Job +</a>
                </div>
                <div class="table-responsive">
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
                                    <td>${job.companyName}</td>
                                    <td>${job.salary}</td>
                                    <td>
                                        <span class="status-badge" style="background: ${job.status == 'approved' ? '#f0fdf4' : (job.status == 'pending' ? '#fff7ed' : '#fef2f2')}; color: ${job.status == 'approved' ? 'var(--success)' : (job.status == 'pending' ? 'var(--warning)' : 'var(--danger)')};">
                                            ${job.status}
                                        </span>
                                    </td>
                                    <td>
                                        <form action="admin" method="POST" style="display: inline-flex; gap: 5px; justify-content: center;">
                                            <input type="hidden" name="action" value="updateJobStatus">
                                            <input type="hidden" name="jobId" value="${job.id}">
                                            
                                            <c:if test="${job.status != 'approved'}">
                                                <button name="status" value="approved" class="btn-sm btn-outline" style="color: var(--success); padding: 0.4rem 0.6rem;" title="Approve">
                                                    <i class="fas fa-check"></i>
                                                </button>
                                            </c:if>
                                            <c:if test="${job.status != 'rejected'}">
                                                <button name="status" value="rejected" class="btn-sm btn-outline" style="color: var(--danger); padding: 0.4rem 0.6rem;" title="Reject">
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
        </div>
    </main>
</body>
</html>

