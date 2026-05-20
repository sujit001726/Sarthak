<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Sarthak | Candidates Database</title>
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
                }

                .modal-overlay.open {
                    display: flex;
                }

                .modal-box {
                    background: #fff;
                    border-radius: 14px;
                    padding: 28px 32px;
                    width: 100%;
                    max-width: 440px;
                    box-shadow: 0 20px 60px rgba(0, 0, 0, 0.2);
                }

                .profile-avatar {
                    width: 72px;
                    height: 72px;
                    border-radius: 16px;
                    margin-bottom: 12px;
                }

                .profile-row {
                    display: flex;
                    justify-content: space-between;
                    padding: 8px 0;
                    border-bottom: 1px solid #f1f5f9;
                    font-size: 0.88rem;
                }

                .profile-row:last-child {
                    border-bottom: none;
                }

                .profile-label {
                    color: #64748b;
                    font-weight: 600;
                }

                .profile-val {
                    color: #1e293b;
                }
            </style>
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
                            <input type="text" id="searchInput" placeholder="Search by name or email..."
                                oninput="filterTable()">
                        </div>
                        <div class="user-profile">
                            <img src="https://ui-avatars.com/api/?name=Admin&background=4f46e5&color=fff" alt="User">
                            <div class="user-info"><span class="name">Admin</span></div>
                        </div>
                    </div>
                </header>

                <div class="content-area">
                    <div class="content-card animate-fade">
                        <div class="card-header">
                            <div>
                                <h3>Candidate Roster</h3>
                                <p style="font-size:0.8rem;color:var(--text-dim);">Total: ${candidates.size()}
                                    candidates</p>
                            </div>
                            <div style="display:flex;gap:10px;">
                                <button class="btn-sm btn-outline"><i class="fas fa-filter"></i> Filters</button>
                                <a href="admin?action=addCandidate" class="btn-sm btn-primary"
                                    style="text-decoration:none;">Add Candidate +</a>
                            </div>
                        </div>

                        <div class="table-responsive">
                            <table class="data-table" id="candidateTable">
                                <thead>
                                    <tr>
                                        <th>Candidate Info</th>
                                        <th>Experience</th>
                                        <th>Phone</th>
                                        <th>Status</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="c" items="${candidates}">
                                        <tr>
                                            <td data-label="Candidate Info">
                                                <div style="display:flex;align-items:center;gap:12px;">
                                                    <img src="https://ui-avatars.com/api/?name=${c.name}&background=random"
                                                        style="width:40px;height:40px;border-radius:12px;">
                                                    <div style="text-align: left;">
                                                        <div style="font-weight:600;">${c.name}</div>
                                                        <div style="font-size:0.75rem;color:var(--text-dim);">${c.email}</div>
                                                    </div>
                                                </div>
                                            </td>
                                            <td data-label="Experience">
                                                <span class="status-badge"
                                                    style="background:var(--primary-light);color:var(--primary);">
                                                    ${c.experienceLevel}
                                                </span>
                                            </td>
                                            <td data-label="Phone" style="font-size:0.85rem;">${c.phone}</td>
                                            <td data-label="Status">
                                                <span class="status-badge" style="background:${c.status == 'shortlisted' ? '#f0fdf4' : (c.status == 'applied' ? '#eff6ff' : '#fef2f2')};
                                                   color:${c.status == 'shortlisted' ? 'var(--success)' : (c.status == 'applied' ? 'var(--primary)' : 'var(--danger)')};
                                                   font-weight:600;">
                                                    ${c.status}
                                                </span>
                                            </td>
                                            <td data-label="Actions">
                                                <div style="display:flex;gap:8px;">
                                                    <!-- View Profile -->
                                                    <button class="btn-sm btn-outline" title="View Profile"
                                                        onclick="viewProfile('${c.id}','${c.name}','${c.email}','${c.phone}','${c.experienceLevel}','${c.status}')">
                                                        <i class="fas fa-eye"></i>
                                                    </button>

                                                    <!-- Delete -->
                                                    <button class="btn-sm btn-outline" style="color:var(--danger)"
                                                        title="Delete" onclick="confirmDelete(${c.id},'${c.name}')">
                                                        <i class="fas fa-trash"></i>
                                                    </button>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty candidates}">
                                        <tr>
                                            <td colspan="5">
                                                <div style="padding:4rem;text-align:center;color:var(--text-dim);">
                                                    <i class="fas fa-user-slash"
                                                        style="font-size:3rem;margin-bottom:1rem;opacity:0.2;"></i>
                                                    <p>No candidates found.</p>
                                                    <a href="admin?action=addCandidate" class="btn-sm btn-primary"
                                                        style="margin-top:1rem;text-decoration:none;display:inline-block;">Add
                                                        first candidate</a>
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

            <!-- View Profile Modal -->
            <div class="modal-overlay" id="profileModal">
                <div class="modal-box">
                    <div style="display:flex;justify-content:space-between;align-items:flex-start;margin-bottom:16px;">
                        <div style="display:flex;align-items:center;gap:14px;">
                            <img id="pm-avatar" class="profile-avatar" src="" alt="">
                            <div>
                                <div id="pm-name" style="font-size:1.1rem;font-weight:700;color:#1e1b4b;"></div>
                                <div id="pm-email" style="font-size:0.8rem;color:#64748b;"></div>
                            </div>
                        </div>
                        <button onclick="closeProfile()"
                            style="background:none;border:none;font-size:1.3rem;cursor:pointer;color:#94a3b8;">&times;</button>
                    </div>
                    <div class="profile-row"><span class="profile-label">Phone</span><span class="profile-val"
                            id="pm-phone"></span></div>
                    <div class="profile-row"><span class="profile-label">Experience Level</span><span
                            class="profile-val" id="pm-level"></span></div>
                    <div class="profile-row"><span class="profile-label">Status</span><span class="profile-val"
                            id="pm-status"></span></div>
                    <div style="margin-top:18px;display:flex;justify-content:flex-end;">
                        <button class="btn-sm btn-outline" onclick="closeProfile()">Close</button>
                    </div>
                </div>
            </div>

            <!-- Delete Confirm Modal -->
            <div class="modal-overlay" id="deleteModal">
                <div class="modal-box" style="max-width:380px;text-align:center;">
                    <i class="fas fa-exclamation-triangle"
                        style="font-size:2.5rem;color:#ef4444;margin-bottom:12px;"></i>
                    <h3 style="margin:0 0 8px;color:#1e1b4b;">Delete Candidate?</h3>
                    <p id="del-msg" style="font-size:0.88rem;color:#64748b;margin-bottom:20px;"></p>
                    <form id="deleteForm" action="admin" method="POST">
                        <input type="hidden" name="action" value="deleteCandidate">
                        <input type="hidden" name="candidateId" id="del-id">
                        <div style="display:flex;gap:10px;justify-content:center;">
                            <button type="button" class="btn-sm btn-outline" onclick="closeDelete()">Cancel</button>
                            <button type="submit" class="btn-sm btn-primary"
                                style="background:#ef4444;border-color:#ef4444;">Delete</button>
                        </div>
                    </form>
                </div>
            </div>

            <script>
                function viewProfile(id, name, email, phone, level, status) {
                    document.getElementById('pm-avatar').src = 'https://ui-avatars.com/api/?name=' + encodeURIComponent(name) + '&background=random&size=72';
                    document.getElementById('pm-name').textContent = name;
                    document.getElementById('pm-email').textContent = email;
                    document.getElementById('pm-phone').textContent = phone || 'N/A';
                    document.getElementById('pm-level').textContent = level || 'N/A';
                    document.getElementById('pm-status').textContent = status || 'N/A';
                    document.getElementById('profileModal').classList.add('open');
                }
                function closeProfile() { document.getElementById('profileModal').classList.remove('open'); }

                function confirmDelete(id, name) {
                    document.getElementById('del-id').value = id;
                    document.getElementById('del-msg').textContent = 'This will permanently remove "' + name + '".';
                    document.getElementById('deleteModal').classList.add('open');
                }
                function closeDelete() { document.getElementById('deleteModal').classList.remove('open'); }

                // Close modals on backdrop click
                ['profileModal', 'deleteModal'].forEach(id => {
                    document.getElementById(id).addEventListener('click', function (e) {
                        if (e.target === this) this.classList.remove('open');
                    });
                });

                // Live search filter
                function filterTable() {
                    const q = document.getElementById('searchInput').value.toLowerCase();
                    document.querySelectorAll('#candidateTable tbody tr').forEach(row => {
                        row.style.display = row.textContent.toLowerCase().includes(q) ? '' : 'none';
                    });
                }
            </script>
        </body>

        </html>