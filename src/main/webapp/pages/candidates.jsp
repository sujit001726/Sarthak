<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sarthak | Candidates Database</title>
    <link rel="stylesheet" href="css/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <jsp:include page="includes/sidebar.jsp">
        <jsp:param name="action" value="candidates" />
    </jsp:include>

    <main class="main-wrapper">
        <header class="top-nav">
            <div class="welcome-msg">
                <h1>Candidates Database</h1>
                <p>Manage and track potential hires</p>
            </div>
            <div class="top-actions">
                <div class="search-box">
                    <i class="fas fa-search"></i>
                    <input type="text" placeholder="Search by name or email...">
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
                        <h3>Candidate Roster</h3>
                        <p style="font-size: 0.8rem; color: var(--text-dim);">A total of ${candidates.size()} candidates found</p>
                    </div>
                    <div style="display: flex; gap: 10px;">
                        <button class="btn-sm btn-outline"><i class="fas fa-filter"></i> Filters</button>
                        <a href="admin?action=addCandidate" class="btn-sm btn-primary" style="text-decoration: none;">Add Candidate +</a>
                    </div>
                </div>
                
                <div class="table-responsive">
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>Candidate Info</th>
                                <th>Experience</th>
                                <th>Stage</th>
                                <th>Hiring Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="candidate" items="${candidates}">
                                <tr>
                                    <td>
                                        <div style="display: flex; align-items: center; gap: 12px;">
                                            <img src="https://ui-avatars.com/api/?name=${candidate.name}&background=random" style="width: 40px; height: 40px; border-radius: 12px;">
                                            <div>
                                                <div style="font-weight: 600;">${candidate.name}</div>
                                                <div style="font-size: 0.75rem; color: var(--text-dim);">${candidate.email}</div>
                                            </div>
                                        </div>
                                    </td>
                                    <td>
                                        <span class="status-badge" style="background: var(--primary-light); color: var(--primary);">
                                            ${candidate.level}
                                        </span>
                                    </td>
                                    <td>
                                        <div style="display: flex; align-items: center; gap: 5px;">
                                            <div style="width: 8px; height: 8px; border-radius: 50%; background: var(--success);"></div>
                                            <span>Technical Round</span>
                                        </div>
                                    </td>
                                    <td>
                                        <span class="status-badge" style="background: #f0fdf4; color: var(--success); font-weight: 600;">
                                            ${candidate.status}
                                        </span>
                                    </td>
                                    <td>
                                        <div style="display: flex; gap: 8px;">
                                            <button class="btn-sm btn-outline" title="View Profile"><i class="fas fa-eye"></i></button>
                                            <button class="btn-sm btn-outline" title="Download Resume"><i class="fas fa-download"></i></button>
                                            <button class="btn-sm btn-outline" style="color: var(--danger)" title="Remove"><i class="fas fa-trash"></i></button>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty candidates}">
                                <tr>
                                    <td colspan="5">
                                        <div style="padding: 4rem; text-align: center; color: var(--text-dim);">
                                            <i class="fas fa-user-slash" style="font-size: 3rem; margin-bottom: 1rem; opacity: 0.2;"></i>
                                            <p>No candidates found in the database.</p>
                                            <button class="btn-sm btn-primary" style="margin-top: 1rem;">Add your first candidate</button>
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
