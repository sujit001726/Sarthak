<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Sarthak | Job Categories</title>
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
            <style>
                .modal-overlay {
                    display: none;
                    position: fixed;
                    inset: 0;
                    background: rgba(0, 0, 0, 0.45);
                    z-index: 1000;
                    align-items: center;
                    justify-content: center;
                    backdrop-filter: blur(4px);
                }

                .modal-overlay.open {
                    display: flex;
                }

                .modal-box {
                    background: #fff;
                    border-radius: 20px;
                    padding: 32px;
                    width: 100%;
                    max-width: 400px;
                    box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
                    text-align: center;
                }
            </style>
        </head>

        <body>
            <jsp:include page="includes/sidebar.jsp">
                <jsp:param name="action" value="categories" />
            </jsp:include>

            <main class="main-wrapper">
                <header class="top-nav">
                    <div class="welcome-msg">
                        <h1>Job Categories</h1>
                        <p>Organize job listings</p>
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
                            <h3>Job Categories Management</h3>
                            <a href="admin?action=addCategory" class="btn-sm btn-primary"
                                style="text-decoration: none;">Create New +</a>
                        </div>


                        <div class="table-responsive">
                            <table class="data-table">
                                <thead>
                                    <tr>
                                        <th>Category Name</th>
                                        <th>Description</th>
                                        <th>Created Date</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="item" items="${categories}">
                                        <tr>
                                            <td data-label="Category Name">
                                                <div style="font-weight: 600;">${item.name}</div>
                                            </td>
                                            <td data-label="Description">${item.description}</td>
                                            <td data-label="Date">${item.date}</td>
                                            <td data-label="Actions">
                                                <button type="button" class="btn-sm btn-outline" 
                                                        style="color:var(--danger); border-color:var(--danger);"
                                                        onclick="openDeleteModal('${item.id}', '${item.name}')">
                                                    <i class="fas fa-trash"></i>
                                                </button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty categories}">
                                        <tr>
                                            <td colspan="4"
                                                style="text-align: center; padding: 4rem; color: var(--text-dim);">
                                                No categories found. Click "Create New" to add one.
                                            </td>
                                        </tr>
                                    </c:if>
                                </tbody>
                            </table>
                        </div>

                    </div>
                </div>
            </main>

            <!-- Delete Confirmation Modal -->
            <div class="modal-overlay" id="deleteCategoryModal">
                <div class="modal-box">
                    <i class="fas fa-exclamation-triangle" style="font-size: 3rem; color: #ef4444; margin-bottom: 20px;"></i>
                    <h3 style="margin-bottom: 8px; color: #111827; font-size: 1.25rem; font-weight: 700;">Delete Category?</h3>
                    <p id="delete-message" style="color: #6b7280; font-size: 0.95rem; margin-bottom: 24px; line-height: 1.5;"></p>
                    
                    <form action="admin" method="POST" id="deleteForm">
                        <input type="hidden" name="action" value="deleteCategory">
                        <input type="hidden" name="categoryId" id="delete-category-id">
                        
                        <div style="display: flex; gap: 12px; justify-content: center;">
                            <button type="button" class="btn-sm btn-outline" onclick="closeDeleteModal()" 
                                    style="padding: 10px 24px; font-weight: 600; min-width: 100px;">Cancel</button>
                            <button type="submit" class="btn-sm btn-primary" 
                                    style="background: #ef4444; border-color: #ef4444; padding: 10px 24px; font-weight: 600; min-width: 100px;">Delete</button>
                        </div>
                    </form>
                </div>
            </div>

            <script>
                function openDeleteModal(id, name) {
                    document.getElementById('delete-category-id').value = id;
                    document.getElementById('delete-message').innerHTML = 'Are you sure you want to delete <strong>' + name + '</strong>? This action cannot be undone.';
                    document.getElementById('deleteCategoryModal').classList.add('open');
                }

                function closeDeleteModal() {
                    document.getElementById('deleteCategoryModal').classList.remove('open');
                }

                // Close on backdrop click
                document.getElementById('deleteCategoryModal').addEventListener('click', function(e) {
                    if (e.target === this) closeDeleteModal();
                });
            </script>
        </body>

        </html>