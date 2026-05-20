<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Sarthak | Job Board</title>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
            <style>
                @media (max-width: 1024px) {
                    /* Sidebar & Overlay */
                    .sidebar {
                        position: fixed !important;
                        left: -280px !important;
                        top: 0 !important;
                        bottom: 0 !important;
                        width: 280px !important;
                        z-index: 5000 !important;
                        transform: translateX(0) !important;
                        transition: transform 0.3s ease !important;
                        display: flex !important;
                    }
                    body.sidebar-open .sidebar {
                        transform: translateX(280px) !important;
                    }
                    body.sidebar-open::after {
                        content: '';
                        position: fixed;
                        inset: 0;
                        background: rgba(0,0,0,0.6);
                        z-index: 4500;
                        backdrop-filter: blur(4px);
                    }

                    /* Header Optimization */
                    .top-nav {
                        padding: 0 10px !important;
                        height: 80px !important;
                        flex-direction: column !important;
                        align-items: flex-start !important;
                        justify-content: center !important;
                        gap: 0 !important;
                    }
                    .mobile-menu-toggle {
                        position: absolute !important;
                        left: 10px !important;
                        top: 20px !important;
                    }
                    .welcome-msg {
                        margin-left: 45px !important;
                        padding-top: 5px !important;
                    }
                    .welcome-msg h1 { font-size: 1.1rem !important; margin: 0 !important; }
                    .welcome-msg p { display: block !important; font-size: 0.75rem !important; margin-top: 2px !important; }
                    .top-actions {
                        position: absolute !important;
                        right: 10px !important;
                        top: 15px !important;
                    }
                    .search-box { display: none !important; }

                    /* Table to Card Transformation */
                    .data-table, .data-table thead, .data-table tbody, .data-table th, .data-table td, .data-table tr {
                        display: block !important;
                    }
                    .data-table thead { display: none !important; }
                    .data-table tr {
                        margin-bottom: 15px !important;
                        border: 1px solid rgba(29, 62, 53, 0.1) !important;
                        border-radius: 12px !important;
                        padding: 12px !important;
                        background: #fff !important;
                        box-shadow: 0 4px 12px rgba(0,0,0,0.05) !important;
                    }
                    .data-table td {
                        padding: 8px 0 !important;
                        border-bottom: 1px solid #f1f5f9 !important;
                        display: flex !important;
                        justify-content: space-between !important;
                        align-items: center !important;
                        text-align: right !important;
                        white-space: normal !important;
                    }
                    .data-table td:last-child { border-bottom: none !important; }
                    
                    .data-table td::before {
                        content: attr(data-label) !important;
                        font-weight: 700 !important;
                        color: var(--primary) !important;
                        font-size: 0.75rem !important;
                        text-transform: uppercase !important;
                        margin-right: 10px !important;
                        text-align: left !important;
                    }

                    .main-wrapper {
                        margin-left: 0 !important;
                        width: 100% !important;
                        min-width: 100% !important;
                        padding: 0 !important;
                    }
                    .content-area { padding: 10px !important; }
                    .content-card { padding: 12px !important; }
                    .card-header h3 { font-size: 1rem !important; }
                }
            </style>
        </head>

        <body>
            <jsp:include page="includes/sidebar.jsp">
                <jsp:param name="action" value="jobBoard" />
            </jsp:include>

            <jsp:include page="includes/header.jsp">
                <jsp:param name="title" value="Job Board" />
                <jsp:param name="subtitle" value="Monitor all incoming job applications" />
            </jsp:include>

            <main class="main-wrapper">
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
                                        <th style="width: 20%">Candidate</th>
                                        <th style="width: 25%">Job Applied</th>
                                        <th style="width: 20%">Company</th>
                                        <th style="width: 15%">Date</th>
                                        <th style="width: 10%">Status</th>
                                        <th style="width: 10%">Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="a" items="${applications}">
                                        <tr>
                                            <td data-label="Candidate">
                                                <div style="font-weight: 600;">
                                                    <c:out value="${a.candidateName}" />
                                                </div>
                                            </td>
                                            <td data-label="Job Applied">
                                                <span style="color: var(--primary); font-weight: 700;">
                                                    <c:out value="${a.jobTitle}" />
                                                </span>
                                            </td>
                                            <td data-label="Company">
                                                <c:out value="${a.companyName}" />
                                            </td>
                                            <td data-label="Date" style="font-size: 0.75rem; color: var(--text-dim);">
                                                <c:out value="${a.appliedAt}" />
                                            </td>
                                            <td data-label="Status">
                                                <span class="status-badge"
                                                    style="background: #E8F5F1; color: var(--primary); font-size: 0.7rem;">
                                                    <c:out value="${a.status}" />
                                                </span>
                                            </td>
                                            <td data-label="Actions">
                                                <button class="btn-sm btn-primary" style="padding: 0.5rem 1rem;">Review</button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty applications}">
                                        <tr>
                                            <td colspan="6"
                                                style="text-align: center; padding: 4rem; color: var(--text-dim);">
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