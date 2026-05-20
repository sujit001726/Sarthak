<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Sarthak | Team Management</title>
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

                /* Delete Team Modal Styles */
                .modal-overlay {
                    position: fixed;
                    top: 0;
                    left: 0;
                    right: 0;
                    bottom: 0;
                    background: rgba(0, 0, 0, 0.6);
                    backdrop-filter: blur(4px);
                    z-index: 6000;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    opacity: 0;
                    visibility: hidden;
                    transition: all 0.3s ease;
                }
                .modal-overlay.show {
                    opacity: 1;
                    visibility: visible;
                }
                .modal-content {
                    background: white;
                    padding: 2.5rem;
                    border-radius: 24px;
                    width: 90%;
                    max-width: 420px;
                    text-align: center;
                    box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
                    transform: scale(0.9);
                    transition: transform 0.3s cubic-bezier(0.175, 0.885, 0.32, 1.275);
                }
                .modal-overlay.show .modal-content {
                    transform: scale(1);
                }
                .modal-icon-container {
                    width: 72px;
                    height: 72px;
                    background: #fef2f2;
                    color: #ef4444;
                    border-radius: 50%;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    margin: 0 auto 1.25rem auto;
                    font-size: 2.25rem;
                }
                .modal-title {
                    font-size: 1.5rem;
                    font-weight: 800;
                    color: var(--primary);
                    margin-bottom: 0.5rem;
                    text-transform: uppercase;
                    letter-spacing: -0.025em;
                }
                .modal-desc {
                    font-size: 0.9rem;
                    color: var(--text-dim);
                    margin-bottom: 2rem;
                    font-weight: 500;
                    line-height: 1.5;
                }
                .modal-actions {
                    display: flex;
                    justify-content: center;
                    gap: 12px;
                }
                .btn-cancel {
                    padding: 0.75rem 1.5rem;
                    background: #f1f5f9;
                    color: #64748b;
                    border: none;
                    border-radius: 12px;
                    font-weight: 800;
                    cursor: pointer;
                    transition: all 0.2s;
                    font-size: 0.85rem;
                }
                .btn-cancel:hover { background: #e2e8f0; color: #475569; }
                .btn-delete {
                    padding: 0.75rem 1.5rem;
                    background: #ef4444;
                    color: white;
                    border: none;
                    border-radius: 12px;
                    font-weight: 800;
                    cursor: pointer;
                    transition: all 0.2s;
                    box-shadow: 0 4px 12px rgba(239, 68, 68, 0.2);
                    font-size: 0.85rem;
                }
                .btn-delete:hover {
                    background: #dc2626;
                    transform: translateY(-2px);
                    box-shadow: 0 6px 16px rgba(239, 68, 68, 0.3);
                }
            </style>
        </head>

        <body>
            <jsp:include page="includes/sidebar.jsp">
                <jsp:param name="action" value="users" />
            </jsp:include>

            <main class="main-wrapper">
                <header class="top-nav">
                    <div class="welcome-msg">
                        <h1>Team Management</h1>
                        <p>Manage administrative users and recruiters</p>
                    </div>
                    <div class="top-actions">
                        <div class="search-box">
                            <i class="fas fa-search"></i>
                            <input type="text" placeholder="Search team members...">
                        </div>
                    </div>
                </header>

                <div class="content-area">
                    <div class="content-card animate-fade">
                        <div class="card-header">
                            <h3>Active Team Members</h3>
                            <button class="btn-sm btn-primary">Invite Member +</button>
                        </div>
                        <div class="table-responsive">
                            <table class="data-table">
                                <thead>
                                    <tr>
                                        <th>Name</th>
                                        <th>Email</th>
                                        <th>Role</th>
                                        <th>Status</th>
                                        <th style="text-align: right;">Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="u" items="${users}">
                                        <tr>
                                            <td data-label="User">
                                                <div style="display: flex; align-items: center; gap: 10px;">
                                                    <img src="https://ui-avatars.com/api/?name=<c:out value='${u.fullName}'/>&background=random"
                                                        style="width: 32px; height: 32px; border-radius: 8px;">
                                                    <span style="font-weight: 600;">
                                                        <c:out value="${u.fullName}" />
                                                    </span>
                                                </div>
                                            </td>
                                            <td data-label="Email">
                                                <c:out value="${u.email}" />
                                            </td>
                                            <td data-label="Role">
                                                <span class="status-badge"
                                                    style="background: var(--primary-light); color: var(--primary);">
                                                    <c:out value="${u.userType}" />
                                                </span>
                                            </td>
                                            <td data-label="Status">
                                                <span class="status-badge"
                                                    style="background: ${u.status == 'active' ? '#f0fdf4' : '#fef2f2'}; color: ${u.status == 'active' ? 'var(--success)' : 'var(--danger)'};">
                                                    <c:out value="${u.status}" />
                                                </span>
                                            </td>
                                            <td data-label="Actions" style="display: flex; gap: 5px; justify-content: flex-end;">
                                                <form action="admin" method="POST" style="display: inline;">
                                                    <input type="hidden" name="action" value="updateUserStatus">
                                                    <input type="hidden" name="userId" value="${u.id}">
                                                    <c:choose>
                                                        <c:when test="${u.status == 'active'}">
                                                            <button name="status" value="suspended"
                                                                class="btn-sm btn-outline" style="color: var(--danger)"
                                                                title="Suspend">
                                                                <i class="fas fa-user-slash"></i>
                                                            </button>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <button name="status" value="active"
                                                                class="btn-sm btn-outline" style="color: var(--success)"
                                                                title="Activate">
                                                                <i class="fas fa-user-check"></i>
                                                            </button>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </form>
                                                <button type="button" onclick="confirmDeleteUser(${u.id})" class="btn-sm btn-outline" style="color: #ef4444;" title="Delete">
                                                    <i class="fas fa-trash"></i>
                                                </button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty users}">
                                        <tr>
                                            <td colspan="5"
                                                style="text-align: center; padding: 3rem; color: var(--text-dim);">
                                                No team members found.
                                            </td>
                                        </tr>
                                    </c:if>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </main>

            <!-- Delete User Modal -->
            <div id="deleteModal" class="modal-overlay">
                <div class="modal-content" id="deleteModalContent">
                    <div class="modal-icon-container">
                        <i class="fa-solid fa-triangle-exclamation"></i>
                    </div>
                    <h2 class="modal-title">Delete Team?</h2>
                    <p class="modal-desc">Are you sure you want to permanently delete this team member? This action cannot be undone.</p>
                    <div class="modal-actions">
                        <button type="button" onclick="closeDeleteModal()" class="btn-cancel">Cancel</button>
                        <form action="delete_user.jsp" method="POST" id="deleteUserForm" style="margin: 0;">
                            <input type="hidden" name="action" value="deleteUser">
                            <input type="hidden" name="userId" id="deleteUserId" value="">
                            <button type="submit" class="btn-delete">Yes, Delete</button>
                        </form>
                    </div>
                </div>
            </div>

            <script>
                function confirmDeleteUser(userId) {
                    const modal = document.getElementById('deleteModal');
                    document.getElementById('deleteUserId').value = userId;
                    modal.classList.add('show');
                }

                function closeDeleteModal() {
                    const modal = document.getElementById('deleteModal');
                    modal.classList.remove('show');
                }
            </script>
        </body>

        </html>